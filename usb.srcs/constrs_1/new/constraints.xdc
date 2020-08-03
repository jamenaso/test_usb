## Clock Signal
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports {clk}]

## Reset
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {rst}]

## UART1 pinout
set_property -dict {PACKAGE_PIN G21 IOSTANDARD LVCMOS33} [get_ports uart1_ren_o]  
set_property -dict {PACKAGE_PIN B22 IOSTANDARD LVCMOS33} [get_ports uart1_rx_i]
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports uart1_tx_o] 

## UART2 pinout
set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports uart2_ren_o]  
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports uart2_rx_i]
set_property -dict {PACKAGE_PIN D22 IOSTANDARD LVCMOS33} [get_ports uart2_tx_o] 

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]