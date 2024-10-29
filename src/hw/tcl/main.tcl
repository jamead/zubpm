################################################################################
# Main tcl for the module
################################################################################

# ==============================================================================
proc init {} {
  ::fwfwk::printCBM "In ./hw/src/main.tcl init()..."



}

# ==============================================================================
proc setSources {} {
  ::fwfwk::printCBM "In ./hw/src/main.tcl setSources()..."

  variable Sources 
  lappend Sources {"../hdl/top.vhd" "VHDL 2008"} 
  lappend Sources {"../hdl/bpm_package.vhd" "VHDL 2008"} 
  lappend Sources {"../hdl/adc_ltc2195.vhd" "VHDL 2008"} 
  lappend Sources {"../hdl/adc_s2p.vhd" "VHDL 2008"} 
  lappend Sources {"../hdl/ltc2195_spi.vhd" "VHDL 2008"} 
  lappend Sources {"../hdl/spi_ad9510.vhd" "VHDL 2008"} 

  lappend Sources {"../cstr/pins.xdc"  "XDC"}
  lappend Sources {"../cstr/afepins.xdc"  "XDC"}
  lappend Sources {"../cstr/timing.xdc"  "XDC"} 

}

# ==============================================================================
proc setAddressSpace {} {
   ::fwfwk::printCBM "In ./hw/src/main.tcl setAddressSpace()..."
  variable AddressSpace
  
  addAddressSpace AddressSpace "pl_regs"   RDL  {} ../rdl/pl_regs.rdl

}


# ==============================================================================
proc doOnCreate {} {
  # variable Vhdl
  variable TclPath
      
  ::fwfwk::printCBM "In ./hw/src/main.tcl doOnCreate()"
  set_property part             xczu6eg-ffvb1156-1-e         [current_project]
  set_property target_language  VHDL                         [current_project]
  set_property default_lib      xil_defaultlib               [current_project]
   
  source ${TclPath}/system.tcl
  source ${TclPath}/adc_fco_phaseshift.tcl

  addSources "Sources" 

}

# ==============================================================================
proc doOnBuild {} {
  ::fwfwk::printCBM "In ./hw/src/main.tcl doOnBuild()"



}




# ==============================================================================
proc setSim {} {
}
