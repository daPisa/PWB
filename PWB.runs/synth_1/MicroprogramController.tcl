# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a12ticsg325-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {/zhome/5f/5/155462/MCU project/PWB/PWB.cache/wt} [current_project]
set_property parent.project_path {/zhome/5f/5/155462/MCU project/PWB/PWB.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo {/zhome/5f/5/155462/MCU project/PWB/PWB.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {/zhome/5f/5/155462/MCU project/PWB/PWB.srcs/sources_1/new/InstructionDecoderController.vhd}
  {/zhome/5f/5/155462/MCU project/PWB/PWB.srcs/sources_1/new/InstructionRegister.vhd}
  {/zhome/5f/5/155462/MCU project/PWB/PWB.srcs/sources_1/new/ProgramCounter.vhd}
  {/zhome/5f/5/155462/MCU project/PWB/PWB.srcs/sources_1/new/SignExtender.vhd}
  {/zhome/5f/5/155462/MCU project/PWB/PWB.srcs/sources_1/new/ZeroFiller.vhd}
  {/zhome/5f/5/155462/MCU project/PWB/PWB.srcs/sources_1/new/MicroprogramController.vhd}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top MicroprogramController -part xc7a12ticsg325-1L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef MicroprogramController.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file MicroprogramController_utilization_synth.rpt -pb MicroprogramController_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
