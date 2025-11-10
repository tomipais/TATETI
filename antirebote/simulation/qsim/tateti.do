onerror {quit -f}
vlib work
vlog -work work tateti.vo
vlog -work work tateti.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.tateti_vlg_vec_tst
vcd file -direction tateti.msim.vcd
vcd add -internal tateti_vlg_vec_tst/*
vcd add -internal tateti_vlg_vec_tst/i1/*
add wave /*
run -all
