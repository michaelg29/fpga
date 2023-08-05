
vlib libs/adder
vcom -work libs/adder ../../hdl/adder/adder.vhd
vlib libs/tb_adder
vlog -work libs/tb_adder -sv ../../hdl/tb_adder/test_pkg.sv
vlog -work libs/tb_adder -sv ../../hdl/tb_adder/tb_top.sv
