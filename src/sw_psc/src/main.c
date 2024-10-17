
#include <sleep.h>
#include "netif/xadapter.h"
//#include "platform_config.h"
#include "xil_printf.h"
#include "lwip/init.h"
#include "lwip/inet.h"
#include "FreeRTOS.h"

#include "xparameters.h"
#include "xsysmonpsu.h"
#include "xiicps.h"


/* Hardware support includes */
#include "../inc/zubpm_defs.h"
#include "../inc/pl_regs.h"
#include "../inc/psc_msg.h"




#define PLATFORM_EMAC_BASEADDR XPAR_XEMACPS_0_BASEADDR
#define SYSMON_DEVICE_ID XPAR_XSYSMONPSU_0_DEVICE_ID


#define PLATFORM_ZYNQMP

#define DEFAULT_IP_ADDRESS "10.0.142.10"
#define DEFAULT_IP_MASK "255.255.255.0"
#define DEFAULT_GW_ADDRESS "10.0.142.1"

#define DELAY_100_MS            100UL
#define DELAY_1_SECOND          (10*DELAY_100_MS)



static sys_thread_t main_thread_handle;



#define THREAD_STACKSIZE 2048

struct netif server_netif;

//global buffers
char msgid30_buf[1024];
char msgid31_buf[1024];
char msgid32_buf[1024];

char msgid51_buf[MSGID51LEN];
char msgid52_buf[MSGID52LEN];
char msgid53_buf[MSGID53LEN];
char msgid54_buf[MSGID54LEN];
char msgid55_buf[MSGID55LEN];


XIicPs IicPsInstance;	    // Instance of the IIC Device
XSysMonPsu SysMonInstance;  // Instance of the Sysmon Device


TimerHandle_t xUptimeTimer;  // Timer handle
u32 UptimeCounter = 0;  // Uptime counter


// Timer callback function
void vUptimeTimerCallback(TimerHandle_t xTimer) {
    UptimeCounter++;  // Increment uptime counter
}


static void print_ip(char *msg, ip_addr_t *ip)
{
	xil_printf(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip),
				ip4_addr3(ip), ip4_addr4(ip));
}

static void print_ip_settings(ip_addr_t *ip, ip_addr_t *mask, ip_addr_t *gw)
{
	print_ip("Board IP:       ", ip);
	print_ip("Netmask :       ", mask);
	print_ip("Gateway :       ", gw);
}

static void assign_default_ip(ip_addr_t *ip, ip_addr_t *mask, ip_addr_t *gw)
{
	int err;

	xil_printf("Configuring default IP %s \r\n", DEFAULT_IP_ADDRESS);
	err = inet_aton(DEFAULT_IP_ADDRESS, ip);
	if(!err)
		xil_printf("Invalid default IP address: %d\r\n", err);
	err = inet_aton(DEFAULT_IP_MASK, mask);
	if(!err)
		xil_printf("Invalid default IP MASK: %d\r\n", err);
	err = inet_aton(DEFAULT_GW_ADDRESS, gw);
	if(!err)
		xil_printf("Invalid default gateway address: %d\r\n", err);
}






void main_thread(void *p)
{

	//const TickType_t x1second = pdMS_TO_TICKS(DELAY_1_SECOND);
	/* the mac address of the board. this should be unique per board */
	u8_t mac_ethernet_address[] = { 0x00, 0x0a, 0x35, 0x00, 0x01, 0x02 };


	/* initialize lwIP before calling sys_thread_new */
	lwip_init();

	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(&server_netif, NULL, NULL, NULL, mac_ethernet_address,
		PLATFORM_EMAC_BASEADDR)) {
		xil_printf("Error adding N/W interface\r\n");
		return;
	}


	netif_set_default(&server_netif);

	/* specify that the network if is up */
	netif_set_up(&server_netif);

	/* start packet receive thread - required for lwIP operation */
	sys_thread_new("xemacif_input_thread",
			(void(*)(void*))xemacif_input_thread, &server_netif,
			THREAD_STACKSIZE, DEFAULT_THREAD_PRIO);


	assign_default_ip(&(server_netif.ip_addr), &(server_netif.netmask),
				&(server_netif.gw));

	print_ip_settings(&(server_netif.ip_addr), &(server_netif.netmask),
				&(server_netif.gw));


    //Delay for 100ms
	vTaskDelay(pdMS_TO_TICKS(100));

    // Start the PSC Status Thread.  Handles incoming commands from IOC
    xil_printf("\r\n");
    sys_thread_new("psc_status_thread", psc_status_thread, 0,
		THREAD_STACKSIZE,
		DEFAULT_THREAD_PRIO);


    // Delay for 100ms
    vTaskDelay(pdMS_TO_TICKS(100));
    // Start the PSC Waveform Thread.  Handles incoming commands from IOC
    xil_printf("\r\n");
    sys_thread_new("psc_wvfm_thread", psc_wvfm_thread, 0,
		THREAD_STACKSIZE,
		DEFAULT_THREAD_PRIO);


    // Delay for 100 ms
    vTaskDelay(pdMS_TO_TICKS(100));
    // Start the PSC Control Thread.  Handles incoming commands from IOC
    xil_printf("\r\n");
    sys_thread_new("psc_cntrl_thread", psc_control_thread, 0,
		THREAD_STACKSIZE,
		DEFAULT_THREAD_PRIO);

	//setup an Uptime Timer
	xUptimeTimer = xTimerCreate("UptimeTimer", pdMS_TO_TICKS(1000), pdTRUE, (void *)0, vUptimeTimerCallback);
	// Check if the timer was created successfully
	if (xUptimeTimer == NULL)
	    // Handle error (e.g., log, assert, etc.)
	    printf("Failed to create uptime timer.\n");
	else
	    // Start the timer with a block time of 0 (non-blocking)
	    if (xTimerStart(xUptimeTimer, 0) != pdPASS)
	       // Handle error (e.g., log, assert, etc.)
	       printf("Failed to start uptime timer.\n");



	vTaskDelete(NULL);
	return;
}




s32 init_sysmon() {

	s32 Status;
    XSysMonPsu_Config *SysMonConfig;

	// Initialize the SYSMON driver
	SysMonConfig = XSysMonPsu_LookupConfig(SYSMON_DEVICE_ID);
	if (SysMonConfig == NULL) {
		return XST_FAILURE;
	}

	Status = XSysMonPsu_CfgInitialize(&SysMonInstance, SysMonConfig, SysMonConfig->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	// Self-Test the System Monitor/ADC device
	Status = XSysMonPsu_SelfTest(&SysMonInstance);
	if (Status != XST_SUCCESS) {
		xil_printf("SysMonPsu self-test failed.\n");
		return XST_FAILURE;
	}

    return XST_SUCCESS;
}





int main()
{
	unsigned int *fpgabase;

	xil_printf("zuBPM ...\r\n");

	fpgabase = (unsigned int *) IOBUS_BASEADDR;

    xil_printf("FPGA version: %d\r\n",fpgabase[100]);

    xil_printf("Setting to Internal Mode (no EVR)\r\n");
    fpgabase[7] = 0;


	prog_ad9510(fpgabase);
	ltc2195_init(fpgabase);
	init_i2c();
	init_sysmon();


	main_thread_handle = sys_thread_new("main_thread", main_thread, 0,
			THREAD_STACKSIZE, DEFAULT_THREAD_PRIO);

	vTaskStartScheduler();

	while(1);

	return 0;
}
