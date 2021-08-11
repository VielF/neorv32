set board "zed"

# Create and clear output directory
set outputdir work
file mkdir $outputdir

set files [glob -nocomplain "$outputdir/*"]
if {[llength $files] != 0} {
    puts "deleting contents of $outputdir"
    file delete -force {*}[glob -directory $outputdir *]; # clear folder contents
} else {
    puts "$outputdir is empty"
}

switch $board {
  "zed" {
    set zedpart "xc7z020clg484-1"
    set zedprj ${board}-test-setup
  }
}

# Create project
create_project -part $zedpart $zedprj $outputdir

set_property board_part em.avnet.com:${board}:part0:1.4 [current_project]
set_property target_language VHDL [current_project]

# Define filesets

## Core: NEORV32
set fileset_neorv32 [glob ./../../../rtl/core/*.vhd]

## Design: processor subsystem template, and (optionally) BoardTop and/or other additional sources
set fileset_design ./../../../rtl/templates/processor/neorv32_ProcessorTop_Test.vhd

## Constraints
# set fileset_constraints [glob ./*.xdc]

## Simulation-only sources
set fileset_sim [list ./../../../sim/neorv32_tb.simple.vhd ./../../../sim/uart_rx.simple.vhd]

# Add source files

## Core
add_files $fileset_neorv32
set_property library neorv32 [get_files $fileset_neorv32]

## Design
add_files $fileset_design

## Constraints
# add_files -fileset constrs_1 $fileset_constraints

## Simulation-only
add_files -fileset sim_1 $fileset_sim

# Run synthesis, implementation and bitstream generation
# launch_runs impl_1 -to_step write_bitstream -jobs 4
# wait_on_run impl_1
