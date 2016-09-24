
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name adatio-x4 -dir "/media/psf/Home/Documents/KiCAD/projekte/freeDSP/freeDSPx-ADAT-IO-x4/SOURCES/VHDL/xilinx/xc6slx9/planAhead_run_2" -part xc6slx9tqg144-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/media/psf/Home/Documents/KiCAD/projekte/freeDSP/freeDSPx-ADAT-IO-x4/SOURCES/VHDL/xilinx/xc6slx9/adatiox4.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/media/psf/Home/Documents/KiCAD/projekte/freeDSP/freeDSPx-ADAT-IO-x4/SOURCES/VHDL/xilinx/xc6slx9} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "adatiox4.ucf" [current_fileset -constrset]
add_files [list {adatiox4.ucf}] -fileset [get_property constrset [current_run]]
link_design
