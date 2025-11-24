onerror {quit -f}
vlib work
vlog -work work matrizbotones.vo
vlog -work work matrizbotones.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Block1_vlg_vec_tst
vcd file -direction matrizbotones.msim.vcd
vcd add -internal Block1_vlg_vec_tst/*
vcd add -internal Block1_vlg_vec_tst/i1/*
add wave /*
run -all
