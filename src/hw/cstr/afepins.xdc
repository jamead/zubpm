
#ADC clock from AD9510
set_property PACKAGE_PIN Y4 [get_ports adc_clk_p]
set_property IOSTANDARD LVDS [get_ports adc_clk_p]
set_property IOSTANDARD LVDS [get_ports adc_clk_n]
set_property DIFF_TERM TRUE [get_ports adc_clk_p]
set_property DIFF_TERM TRUE [get_ports adc_clk_n]

#TbT clock from AFE
set_property PACKAGE_PIN AA11 [get_ports tbt_clk_p]
set_property IOSTANDARD LVDS [get_ports tbt_clk_p]
set_property IOSTANDARD LVDS [get_ports tbt_clk_n]
set_property DIFF_TERM TRUE [get_ports tbt_clk_p]
set_property DIFF_TERM TRUE [get_ports tbt_clk_n]



#afe power management
set_property PACKAGE_PIN E14 [get_ports afe_pwrenb]
set_property IOSTANDARD LVCMOS33 [get_ports afe_pwrenb]
set_property DRIVE 12 [get_ports afe_pwrenb]
set_property SLEW SLOW [get_ports afe_pwrenb]
set_property PACKAGE_PIN B12 [get_ports afe_pwrflt]
set_property IOSTANDARD LVCMOS33 [get_ports afe_pwrflt]

#RFFE interface (Bank 12 - HR 3.3v)
set_property PACKAGE_PIN A13 [get_ports afe_sw_rffe_p]
set_property IOSTANDARD LVCMOS33 [get_ports afe_sw_rffe_p]
set_property PACKAGE_PIN B15 [get_ports afe_sw_rffe_n]
set_property IOSTANDARD LVCMOS33 [get_ports afe_sw_rffe_n]



# Digital Attenuators  (Bank 13 - 1.8v)
set_property PACKAGE_PIN E15 [get_ports dsa0_clk]
set_property IOSTANDARD LVCMOS33 [get_ports dsa0_clk]
set_property PACKAGE_PIN B13 [get_ports dsa0_sdata]
set_property IOSTANDARD LVCMOS33 [get_ports dsa0_sdata]
set_property PACKAGE_PIN A12 [get_ports dsa0_latch]
set_property IOSTANDARD LVCMOS33 [get_ports dsa0_latch]

# Thermistor Readback  LTC2986
set_property PACKAGE_PIN A15 [get_ports therm_sclk]
set_property IOSTANDARD LVCMOS33 [get_ports therm_sclk]
set_property PACKAGE_PIN A16 [get_ports therm_sdo]
set_property IOSTANDARD LVCMOS33 [get_ports therm_sdo]
set_property PACKAGE_PIN D10 [get_ports therm_sdi]
set_property IOSTANDARD LVCMOS33 [get_ports therm_sdi]
set_property PACKAGE_PIN D11 [get_ports therm_rstn]
set_property IOSTANDARD LVCMOS33 [get_ports therm_rstn]
set_property PACKAGE_PIN C14 [get_ports {therm_csn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {therm_csn[0]}]
set_property PACKAGE_PIN F13 [get_ports {therm_csn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {therm_csn[1]}]
set_property PACKAGE_PIN D12 [get_ports {therm_csn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {therm_csn[2]}]


# Heat Control DAC
set_property PACKAGE_PIN V4 [get_ports {heatdac_syncn[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {heatdac_syncn[0]}]
set_property DRIVE 12 [get_ports {heatdac_syncn[0]}]
set_property SLEW SLOW [get_ports {heatdac_syncn[0]}]
set_property PACKAGE_PIN W6 [get_ports {heatdac_syncn[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {heatdac_syncn[1]}]
set_property DRIVE 12 [get_ports {heatdac_syncn[1]}]
set_property SLEW SLOW [get_ports {heatdac_syncn[1]}]
set_property PACKAGE_PIN Y9 [get_ports {heatdac_sclk[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {heatdac_sclk[0]}]
set_property DRIVE 12 [get_ports {heatdac_sclk[0]}]
set_property SLEW SLOW [get_ports {heatdac_sclk[0]}]
set_property PACKAGE_PIN W7 [get_ports {heatdac_sclk[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {heatdac_sclk[1]}]
set_property DRIVE 12 [get_ports {heatdac_sclk[1]}]
set_property SLEW SLOW [get_ports {heatdac_sclk[1]}]
set_property PACKAGE_PIN W2 [get_ports {heatdac_sdin[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {heatdac_sdin[0]}]
set_property DRIVE 12 [get_ports {heatdac_sdin[0]}]
set_property SLEW SLOW [get_ports {heatdac_sdin[0]}]
set_property PACKAGE_PIN V1 [get_ports {heatdac_sdin[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {heatdac_sdin[1]}]
set_property DRIVE 12 [get_ports {heatdac_sdin[1]}]
set_property SLEW SLOW [get_ports {heatdac_sdin[1]}]
set_property PACKAGE_PIN V3 [get_ports {heatdac_ldacn[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {heatdac_ldacn[0]}]
set_property DRIVE 12 [get_ports {heatdac_ldacn[0]}]
set_property SLEW SLOW [get_ports {heatdac_ldacn[0]}]
set_property PACKAGE_PIN Y10 [get_ports {heatdac_ldacn[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {heatdac_ldacn[1]}]
set_property DRIVE 12 [get_ports {heatdac_ldacn[1]}]
set_property SLEW SLOW [get_ports {heatdac_ldacn[1]}]
set_property PACKAGE_PIN W1 [get_ports heatdac_clrn]
set_property IOSTANDARD LVCMOS18 [get_ports heatdac_clrn]
set_property DRIVE 12 [get_ports heatdac_clrn]
set_property SLEW SLOW [get_ports heatdac_clrn]
set_property PACKAGE_PIN V2 [get_ports heatdac_bin2s]
set_property IOSTANDARD LVCMOS18 [get_ports heatdac_bin2s]
set_property DRIVE 12 [get_ports heatdac_bin2s]
set_property SLEW SLOW [get_ports heatdac_bin2s]




# AD9510 PLL  (Bank 12 - HR 3.3v)
set_property PACKAGE_PIN B16 [get_ports ad9510_sclk]
set_property IOSTANDARD LVCMOS33 [get_ports ad9510_sclk]
set_property PACKAGE_PIN H12 [get_ports ad9510_status]
set_property IOSTANDARD LVCMOS33 [get_ports ad9510_status]
set_property PACKAGE_PIN G13 [get_ports ad9510_sdata]
set_property IOSTANDARD LVCMOS33 [get_ports ad9510_sdata]
set_property PACKAGE_PIN J16 [get_ports ad9510_sdo]
set_property IOSTANDARD LVCMOS33 [get_ports ad9510_sdo]
set_property PACKAGE_PIN E12 [get_ports ad9510_lat]
set_property IOSTANDARD LVCMOS33 [get_ports ad9510_lat]
set_property PACKAGE_PIN G11 [get_ports ad9510_func]
set_property IOSTANDARD LVCMOS33 [get_ports ad9510_func]


set_property PACKAGE_PIN AD4 [get_ports {adc_csb[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {adc_csb[0]}]
set_property DRIVE 12 [get_ports {adc_csb[0]}]
set_property SLEW SLOW [get_ports {adc_csb[0]}]

set_property PACKAGE_PIN AE4 [get_ports {adc_sdi[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {adc_sdi[0]}]
set_property DRIVE 12 [get_ports {adc_sdi[0]}]
set_property SLEW SLOW [get_ports {adc_sdi[0]}]

set_property PACKAGE_PIN AD7 [get_ports {adc_sclk[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {adc_sclk[0]}]
set_property DRIVE 12 [get_ports {adc_sclk[0]}]
set_property SLEW SLOW [get_ports {adc_sclk[0]}]

set_property PACKAGE_PIN AD6 [get_ports {adc_sdo[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {adc_sdo[0]}]


set_property PACKAGE_PIN AD2 [get_ports {adc_csb[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {adc_csb[1]}]
set_property DRIVE 12 [get_ports {adc_csb[1]}]
set_property SLEW SLOW [get_ports {adc_csb[1]}]

set_property PACKAGE_PIN AD1 [get_ports {adc_sdi[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {adc_sdi[1]}]
set_property DRIVE 12 [get_ports {adc_sdi[1]}]
set_property SLEW SLOW [get_ports {adc_sdi[1]}]

set_property PACKAGE_PIN AE3 [get_ports {adc_sclk[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {adc_sclk[1]}]
set_property DRIVE 12 [get_ports {adc_sclk[1]}]
set_property SLEW SLOW [get_ports {adc_sclk[1]}]

set_property PACKAGE_PIN AF3 [get_ports {adc_sdo[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {adc_sdo[1]}]


set_property PACKAGE_PIN AG5 [get_ports {adc_fco_p[0]}]
set_property IOSTANDARD LVDS [get_ports {adc_fco_p[0]}]
set_property IOSTANDARD LVDS [get_ports {adc_fco_n[0]}]
set_property DIFF_TERM TRUE [get_ports {adc_fco_p[0]}]
set_property DIFF_TERM TRUE [get_ports {adc_fco_n[0]}]

set_property PACKAGE_PIN Y5 [get_ports {adc_fco_p[1]}]
set_property IOSTANDARD LVDS [get_ports {adc_fco_p[1]}]
set_property IOSTANDARD LVDS [get_ports {adc_fco_n[1]}]
set_property DIFF_TERM TRUE [get_ports {adc_fco_p[1]}]
set_property DIFF_TERM TRUE [get_ports {adc_fco_n[1]}]


set_property PACKAGE_PIN AE7 [get_ports {adc_dco_p[0]}]
set_property IOSTANDARD LVDS [get_ports {adc_dco_p[0]}]
set_property IOSTANDARD LVDS [get_ports {adc_dco_n[0]}]
set_property DIFF_TERM TRUE [get_ports {adc_dco_p[0]}]
set_property DIFF_TERM TRUE [get_ports {adc_dco_n[0]}]

set_property PACKAGE_PIN AA7 [get_ports {adc_dco_p[1]}]
set_property IOSTANDARD LVDS [get_ports {adc_dco_p[1]}]
set_property IOSTANDARD LVDS [get_ports {adc_dco_n[1]}]
set_property DIFF_TERM TRUE [get_ports {adc_dco_p[1]}]
set_property DIFF_TERM TRUE [get_ports {adc_dco_n[1]}]





set_property PACKAGE_PIN AF6 [get_ports {adc_sdata_p[0]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[0]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[0]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[0]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[0]}]

set_property PACKAGE_PIN AE8 [get_ports {adc_sdata_p[1]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[1]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[1]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[1]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[1]}]

set_property PACKAGE_PIN AE10 [get_ports {adc_sdata_p[2]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[2]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[2]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[2]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[2]}]

set_property PACKAGE_PIN AH1 [get_ports {adc_sdata_p[3]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[3]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[3]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[3]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[3]}]

set_property PACKAGE_PIN AH2 [get_ports {adc_sdata_p[4]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[4]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[4]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[4]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[4]}]

set_property PACKAGE_PIN AH4 [get_ports {adc_sdata_p[5]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[5]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[5]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[5]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[5]}]

set_property PACKAGE_PIN AJ6 [get_ports {adc_sdata_p[6]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[6]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[6]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[6]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[6]}]

set_property PACKAGE_PIN AH7 [get_ports {adc_sdata_p[7]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[7]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[7]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[7]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[7]}]

set_property PACKAGE_PIN Y8 [get_ports {adc_sdata_p[8]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[8]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[8]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[8]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[8]}]

set_property PACKAGE_PIN AB6 [get_ports {adc_sdata_p[9]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[9]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[9]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[9]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[9]}]

set_property PACKAGE_PIN AC12 [get_ports {adc_sdata_p[10]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[10]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[10]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[10]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[10]}]

set_property PACKAGE_PIN AB4 [get_ports {adc_sdata_p[11]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[11]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[11]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[11]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[11]}]

set_property PACKAGE_PIN W5 [get_ports {adc_sdata_p[12]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[12]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[12]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[12]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[12]}]

set_property PACKAGE_PIN AC2 [get_ports {adc_sdata_p[13]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[13]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[13]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[13]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[13]}]

set_property PACKAGE_PIN Y2 [get_ports {adc_sdata_p[14]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[14]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[14]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[14]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[14]}]

set_property PACKAGE_PIN AC7 [get_ports {adc_sdata_p[15]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_p[15]}]
set_property IOSTANDARD LVDS [get_ports {adc_sdata_n[15]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_p[15]}]
set_property DIFF_TERM TRUE [get_ports {adc_sdata_n[15]}]






