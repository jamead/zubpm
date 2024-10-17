/********************************************************************
*  Mem-Map
*  8-17-2016
*  Tony Caracappa
*  This program reads the shared memory space
********************************************************************/
#include "xil_printf.h"
#include <sleep.h>
#include "../inc/pl_regs.h"



void ltc2195_init(unsigned int *fpgabase)
{

   int i, regAddr, regVal;

   xil_printf("Programming LTC2195 (ADC)...    ");

   //Initialize SPI registers on LTC2195
   // SPI port on LTC2195 mapped to register 14
   //set 2's complement
   regAddr = 1;
   regVal = 0x20;
   fpgabase[ADC_SPI_REG] = regAddr<<8 | regVal;
   usleep(1000);

   //set 4 lane output
   regAddr = 2;
   regVal = 1;
   fpgabase[ADC_SPI_REG] = regAddr<<8 | regVal;
   usleep(1000);

   //set idly value for sdata bits
   fpgabase[ADC_IDLYVAL_REG] = 200;
   //strobe the idly value into all 16 idly registers
   fpgabase[ADC_IDLYSTR_REG] = 0xFFFF;
   fpgabase[ADC_IDLYSTR_REG] = 0;

   //read and print 20 ADC samples
   for (i=0;i<10;i++) {
      xil_printf("%d\t%d\t%d\t%d\r\n",fpgabase[ADC_RAWCHA_REG],fpgabase[ADC_RAWCHB_REG],
    		                          fpgabase[ADC_RAWCHC_REG],fpgabase[ADC_RAWCHD_REG]);
      usleep(100000);
   }

   for (i=0;i<10;i++) {
      xil_printf("%d\t%d\t%d\t%d\r\n",fpgabase[SA_CHA_REG],fpgabase[SA_CHB_REG],
    		                          fpgabase[SA_CHC_REG],fpgabase[SA_CHD_REG]);
      usleep(100000);
   }


   xil_printf("Programming Complete\r\n");

   return;

}
