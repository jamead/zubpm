##################################################################
# CHECK VIVADO VERSION
##################################################################

set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
  catch {common::send_msg_id "IPS_TCL-100" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_ip_tcl to create an updated script."}
  return 1
}

##################################################################
# START
##################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source adc_fco_phaseshift.tcl
# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
  create_project vivado vivado -part xczu6eg-ffvb1156-1-e
  set_property target_language VHDL [current_project]
  set_property simulator_language Mixed [current_project]
}

##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:clk_wiz:6.0 }
  set list_ips_missing ""
  common::send_msg_id "IPS_TCL-1001" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

  foreach ip_vlnv $list_check_ips {
  set ip_obj [get_ipdefs -all $ip_vlnv]
  if { $ip_obj eq "" } {
    lappend list_ips_missing $ip_vlnv
    }
  }

  if { $list_ips_missing ne "" } {
    catch {common::send_msg_id "IPS_TCL-105" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
    set bCheckIPsPassed 0
  }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "IPS_TCL-102" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 1
}

##################################################################
# CREATE IP adc_fco_phaseshift
##################################################################

set adc_fco_phaseshift [create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name adc_fco_phaseshift]

# User Parameters
set_property -dict [list \
  CONFIG.CLKIN1_JITTER_PS {85.47} \
  CONFIG.CLKOUT1_DRIVES {Buffer} \
  CONFIG.CLKOUT1_JITTER {112.436} \
  CONFIG.CLKOUT1_PHASE_ERROR {87.674} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {117} \
  CONFIG.CLKOUT2_DRIVES {Buffer} \
  CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {117} \
  CONFIG.CLKOUT3_DRIVES {Buffer} \
  CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {117} \
  CONFIG.CLKOUT4_DRIVES {Buffer} \
  CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {117} \
  CONFIG.CLKOUT5_DRIVES {Buffer} \
  CONFIG.CLKOUT5_REQUESTED_OUT_FREQ {117} \
  CONFIG.CLKOUT6_DRIVES {Buffer} \
  CONFIG.CLKOUT6_REQUESTED_OUT_FREQ {117} \
  CONFIG.CLKOUT7_DRIVES {Buffer} \
  CONFIG.CLKOUT7_REQUESTED_OUT_FREQ {117} \
  CONFIG.CLK_OUT1_USE_FINE_PS_GUI {true} \
  CONFIG.ENABLE_CLOCK_MONITOR {false} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {10.000} \
  CONFIG.MMCM_CLKIN1_PERIOD {8.547} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {10.000} \
  CONFIG.MMCM_CLKOUT0_USE_FINE_PS {true} \
  CONFIG.PRIMITIVE {MMCM} \
  CONFIG.PRIM_IN_FREQ {117} \
  CONFIG.PRIM_SOURCE {Global_buffer} \
  CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
  CONFIG.USE_DYN_PHASE_SHIFT {true} \
  CONFIG.USE_FREQ_SYNTH {false} \
  CONFIG.USE_PHASE_ALIGNMENT {false} \
] [get_ips adc_fco_phaseshift]

# Runtime Parameters
set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $adc_fco_phaseshift

##################################################################

