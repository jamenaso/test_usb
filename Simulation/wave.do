onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_usb/clk
add wave -noupdate /testbench_usb/rst
add wave -noupdate /testbench_usb/load
add wave -noupdate /testbench_usb/counter
add wave -noupdate /testbench_usb/busy
add wave -noupdate /testbench_usb/tx
add wave -noupdate /testbench_usb/rdy
add wave -noupdate /testbench_usb/rx
add wave -noupdate /testbench_usb/dout
add wave -noupdate /testbench_usb/err
add wave -noupdate /testbench_usb/en
add wave -noupdate /testbench_usb/u1en
add wave -noupdate /testbench_usb/u1rx
add wave -noupdate /testbench_usb/u2en
add wave -noupdate /testbench_usb/u2tx
add wave -noupdate /testbench_usb/u2rx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 197
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {14782020750 ps}
