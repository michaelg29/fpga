
vlib libs/adder
vcom -work libs/adder ../../hdl/adder/adder.vhd
vlib libs/tb_adder
REM vlog -work libs/tb_adder -sv %UVM_HOME%/src/uvm_pkg.sv ../../hdl/tb_adder/test_pkg.sv ../../hdl/tb_adder/tb_top.sv +incdir+%UVM_HOME%/src
vlog -work libs/tb_adder -sv ../../hdl/tb_adder/test_pkg.sv ../../hdl/tb_adder/tb_top.sv
