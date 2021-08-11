set core_src_dir [glob ./../../../rtl/core/*.vhd]
  foreach core_src_file $core_src_dir {
    add_file -type vhdl $core_src_file
    set_file_prop $core_src_file -lib {neorv32}
  }

add_file -type vhdl "./../../../rtl/templates/processor/neorv32_ProcessorTop_Test.vhd"

set_device GW1N-LV9EQ144C6/I5 -name GW1N-9
set_option -synthesis_tool gowinsynthesis
set_option -output_base_name gowin
set_option -top_module neorv32_ProcessorTop_Test

run syn
