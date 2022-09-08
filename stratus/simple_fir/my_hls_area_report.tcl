#!/bin/ksh 
#\
exec bdw_shell "$0" "$@"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# This script is retrieve the dfg and cfg of a scheduled HLS code.
# Only works for the top thread 
# Author: Sayandip De
# Email: sayandip.de@tue.nl
#
#  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Package inclusions
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
package require cmdline
source "[get_install_path]/share/stratus/tcl/Messaging.tcl"

namespace eval hls_area {
	namespace export main

	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	#
	# Variable declarations
	#
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	variable progName    
	variable debug
    variable m_min
    variable m_max
    variable m_funcName
    variable m_fileName
    variable m_areabdl
    variable m_snapshot
    variable m_config
    variable m_module
    variable m_rows
	variable m_verbose
}


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# printHelp
#   Print out some information about how to use this script (and what it does).
#
#   Accepts:
#     nothing
#   Returns:
#     void
#   Side effects:
#     Writes to stdout
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

proc hls_area::printHelp {} {
    variable progName
    puts "USE: bdw_shell $progName.tcl \[options\]"
    puts "This script prints a report on the resources used in a scheduled design."
	puts "Only works for the top thread."
    puts "  -(d)ebug:    Prints debug information"
    puts "  -func:       Only includes ops with call stacks that have a function matching the given pattern, e.g., FirThread"
    puts "  -(p)roject:  Include the project file. Default: project.tcl"
    puts "  -(c)onfig:   Pass the name of the HLS config."
	puts "  -stage:      Pass the hls synthesis stage. Options are elab, optim and rtl. Default: rtl"
	puts "  -(v)erbose:  Also prints the ops implemented on each resource"
	puts "  -csv:		 Saves results as csv in reports folder of HLS Config"
	puts "  -top:		 Pass the name of {top}_rtl.v"
}

# reporting total operations per state.
proc hls_area::report_area {{min -1} {max -1} {module ""} args } {
    variable debug
	variable debug_inner 

    variable m_snapshot
    variable m_config
    variable m_module
    variable m_log
    variable m_verbose 
    variable m_min
    variable m_max
    variable m_moduleName
	variable m_fileName
	variable m_areabdl
	variable m_resources_seq
	variable m_resources_mux
	variable m_seqTotal
	variable m_muxTotal
	variable m_reg_resource
	variable m_mux_resource
	variable m_log
	variable m_outcsv
	variable m_printcsv

    #set m_verbose $verbose
    set m_min $min
    set m_max $max
    set m_moduleName $module

    set orig_vdir [vpwd]
	set m_resources_seq {}
	set m_resources_mux {}
	set m_seqTotal [list 0 0 0 0]
	set m_muxTotal 0

    # We expect one hls_config or snapshot object.
    # Load if necessary, which will place our current directory in a snapshot.
    #set m_config [lindex $args 0]
	
    # if { ![hls_area::report_load_config $m_config] } {
        # vcd $orig_vdir
        # return "Results not available for config \'[get_attr name $m_config]\'"
    # }
	
    set m_snapshot [vpwd]
    set m_config [get_attr parent $m_snapshot]
    set name [get_attr name $m_snapshot]
    set module [get_attr parent $m_config]
    #set m_log ""
    #catch {set m_log [[[new_CNSNodeIdHelper $m_config] getCynthConfig] cynthHLLog]}

    set ss_name [get_attr name $m_snapshot]
    if {$ss_name != "rtl"} {
        return "The resources report can only be generated for an \'rtl\' snapshot."
    }
	
	
	if { $debug == 1 } {
		puts "\n-------------- output report_area -----------------"
		puts "m_snapshot: $m_snapshot"
		puts "m_config: $m_config"
		puts "name: $name"
		puts "module: $module"
		puts "m_log: $m_log"
		puts "\n-------------- end report_area -----------------"
	}


    puts "\n*** Resources report for module \'[get_attr name $module]\' hls_config \'[get_attr name $m_config]\' ***\n"
	
    collect_comb
	collect_mux_reg_data
	collect_seq
	collect_mux
	
	if { $m_printcsv == 1 } {
		save_csv
	} else {
		print_table
	}
	

    # Restore the orignal vdir.
    vcd $orig_vdir

    return ""

}

# Adds entries to m_resources.  The index is a module, and each value is a list of instances.
# Also populates m_ops with all the ops on all instances for each module.
# Enforces min/max
# only collects rtl_instances [TODO: add rtl_processes, rtl_signals]
proc hls_area::collect_comb {} {
	variable debug
	
    variable m_verbose
    variable m_snapshot
    variable m_config
    variable m_log
    variable m_moduleName
    variable m_min
    variable m_max
    variable m_resources
    variable m_ops
	variable m_module_is
	variable m_module_os

    clear_array m_resources
    clear_array m_ops
	clear_array m_module_is
	clear_array m_module_os

    # Sort instances into m_resources array by module.  Filter out names we don't want.
    foreach inst [find -rtl_instance] {
        set mod [get_attr module $inst]
        if {$mod == "unset" || $mod == ""} continue
        if {[get_attr type $mod] != "lib_module"} continue

        set kind [get_attr kind $mod]
        if {$kind == "buffer"} continue;

        if {($m_moduleName != "") && ![string match $m_moduleName [get_attr name $mod]]} continue

        lappend m_resources($mod) $inst

        # Collect the ops.
        set newOps [get_attr operations $inst]
        if {($newOps != "unset") && ([llength $newOps] > 0)} {
            set oldOps {}
            if { [info exists m_ops($mod)] } {
                set oldOps $m_ops($mod)
            } 
            set m_ops($mod) [concat $oldOps $newOps]
        }
    }

	# find input module ios for each module
	foreach io [find -lib_module_io] {
		set mod [get_attr parent $io]
		if {[get_attr direction $io] == "input"} {
			lappend m_module_is($mod) $io
		}
		if {[get_attr direction $io] == "output"} {
			lappend m_module_os($mod) $io
		}
	}

    # Remove any that do not have a total area of m_min
    if {$m_min > 0.0} {
        set mods [array names m_resources]
        foreach mod $mods {
            set nInsts [llength $m_resources($mod)]
            set modArea [mod_area $mod total_area]
            set resArea [expr $modArea * $nInsts]
            if { ($m_min >= 0.0) && ($resArea < $m_min)} {
                array unset m_resources $mod
            }
        }
    }

    # Retain only the top N.
    if {$m_max > 0.0} {
        set mods [lsort -command sort_by_area [array names m_resources]]
        set nmods [llength $mods]
        if {$nmods > $m_max} {
            for {set imod $m_max} {$imod < $nmods} {incr imod} {
                array unset m_resources [lindex $mods $imod]
            }
        }
    }
	
	if { $debug == 1 } {
		puts "\n-------------- output collect_resources -----------------"
		variable m_resources
		set x 0
		puts "\nm_resources: "
		foreach {key value} [array get m_resources] {
			puts "$x $key => $value"
			incr x
		}
		
		puts "\nm_ops: "
		variable m_ops
		set x 0
		foreach {key value} [array get m_ops] {
			puts "$x $key => $value"
			incr x
		}
		
		puts "\nm_module_is: "
		variable m_module_is
		set x 0
		foreach {key value} [array get m_module_is] {
			puts "$x $key => $value"
			incr x
		}
		
		puts "\nm_module_os: "
		variable m_module_os
		set x 0
		foreach {key value} [array get m_module_os] {
			puts "$x $key => $value"
			incr x
		}
		puts "\n-------------- end collect_resources -----------------"
	}


}

# only collects rtl_processes
proc hls_area::collect_seq {} {
	variable debug
	
    variable m_resources_seq
	variable m_fileName
	variable m_areabdl
	variable m_seqTotal
	variable m_reg_resource
	
	set seqAll 0.0
    set seqSeq 0.0
    set seqComb 0.0
    set seqBits 0

    # Sort instances into m_resources array by module.  Filter out names we don't want.
    foreach inst [find -rtl_process] {
        set signal [get_attr signal_written $inst]
        if {[get_attr is_register $signal]} {
			set input_no [llength [get_fanin $signal]]
			set inputw [get_attr width $signal]
			set outputw $inputw
			set process [get_attr name $inst]
			#set func "find_resource"
			#set out [exec python /home/sayandipde/approx_hls/stratus_hls/my_scripts/my_hls_area_utils.py $func $process $m_fileName]
			set out [lindex $m_reg_resource($process) 0]
			set out [split $out '\;']
			set kind [lindex $out 0]
			set ff_no [lindex $out 1]
			set out [exec bdw_ls $m_areabdl $kind -l | grep combArea]
			set comb_area [lindex $out 1]
			set out [exec bdw_ls $m_areabdl $kind -l | grep seqArea]
			set seq_area [lindex $out 1]
			set total_area [expr $comb_area + $seq_area]
			set all 0.0
			if {$total_area != "?"} {
				set all [expr $ff_no * $total_area]
				set all [ffmt $all]
			}
			set allcombArea 0.0
			if {$comb_area != "?"} {
				set allcombArea [expr $ff_no * $comb_area]
				set allcombArea [ffmt $allcombArea]
			}
			set allseqArea 0.0
			if {$seq_area != "?"} {
				set allseqArea [expr $ff_no * $seq_area]
				set allseqArea [ffmt $allseqArea]
			}
			set seqStr ""
			if {$seq_area != 0.0} {
				set seqStr "$allseqArea\($ff_no\)"
			}
			lappend m_resources_seq [list [get_attr name $signal] $kind $input_no $inputw $outputw "" "" $seqStr $allcombArea $all ""]
			
			set seqAll [expr $seqAll + $all]
			set seqSeq [expr $seqSeq + $allseqArea]
			set seqComb [expr $seqComb + $allcombArea]
			set seqBits [expr $seqBits + $ff_no]
			set m_seqTotal "$seqAll $seqSeq $seqComb $seqBits"
		}
	}
}

# collects mux, reg data from rtl file
proc hls_area::collect_mux {} {
	variable debug
	
	variable m_mux_resource
	variable m_resources_mux
	variable m_muxTotal
	
	set m_muxTotal 0.0
	
	if { $debug == 1 } {
		puts "\n-------------- output collect_mux -----------------"
	}
	
	foreach {key value} [array get m_mux_resource] {
		if { $key != "" && $key != "cntrl"} {
			set value [lindex $value 0]
			set value [split $value '\;']
			set kind [lindex $value 0]
			set input_no [lindex $value 1]
			set inputw [lindex $value 2]
			set outputw $inputw
			set area [ffmt [lindex $value 3]]
			lappend m_resources_mux [list $key $kind $input_no $inputw $outputw "1" "" "" $area $area ""]
			
			if { $debug == 1 } {
				puts "$key, $kind, $input_no, $inputw, $area"
			}
			set m_muxTotal [expr $m_muxTotal + $area]
		}
		if { $key == "cntrl"} {
			set area [lindex $value 0]
			lappend m_resources_mux [list $key $key "" "" "" "" "" "" $area $area ""]
			set m_muxTotal [expr $m_muxTotal + $area]
		}
	}
	
	if { $debug == 1 } {
		puts "\n-------------- ------------------------------- -----------------"
	}
}

# collects mux, reg data from rtl file
proc hls_area::collect_mux_reg_data {} {
	variable debug
	
	variable m_fileName
	variable m_log
	variable m_reg_resource
	variable m_mux_resource
	variable m_config
	
	clear_array m_reg_resource
    clear_array m_mux_resource
	
	set func "extract_resource_csv"
	set csv "temp_[get_attr name $m_config].csv"
	exec python my_hls_area_utils.py $func $m_fileName $csv $m_log
	
	set fh [open $csv r]
	set file_data [read $fh]
	close $fh
	
	set data [split $file_data "\n"]
	
	if { $debug == 1 } {
		puts "\n-------------- output collect_mux_reg_data -----------------"
	}
	
	# Your data appears to be actually tab-separated, not comma-separated...
	foreach line $data {
		set row [split $line ","]
		set key [lindex $row 0]
		set reg [lindex $row 1]
		set mux [lindex $row 2]
		if { $debug == 1 } {
			puts "$key, $reg, $mux"
		}
		lappend m_reg_resource($key) $reg
		
		if { $mux != "unset" } {
			lappend m_mux_resource($key) $mux
		}
	}
	
	if { $debug == 1 } {
		puts "\n-------------- ------------------------------- -----------------"
	}
	
	exec rm $csv
}


# Prints a table of resource, optionally with ops.
proc hls_area::print_table {} {

    variable m_rows
    variable m_resources
    variable m_ops
    variable m_verbose
	variable m_module_is
	variable m_module_os
	variable m_resources_seq
	variable m_resources_mux
	variable m_seqTotal
	variable m_muxTotal

    set m_rows {}

    set totAll 0.0
    set totSeq 0.0
    set totComb 0.0
    set totBits 0
    set totOps 0

    if {$m_verbose} {
        set last1 "Source"
        set last2 "------"
    } else {
        set last1 ""
        set last2 ""
    }
    lappend m_rows [list ""         ""      ""      ""      ""    ""  ""      "Area/Instance"      ""   "" ""]
    lappend m_rows [list ""         ""      ""      ""      ""    ""  ""      "--------------------" ""   "" ""]
    lappend m_rows [list "Resource" "Kind" 	"#Inputs" "InWidth"  "OutWidth"  "Count" "#Words"  "     Seq(#FF)"  "    Comb" "   Total" $last1]
    lappend m_rows [list "--------" "-----" "-----" "------------"  "-----" "----"  "------------"  "--------" "--------" $last2]
    set fmt        [list "%%0s"     "%15s"   "%10s"  "%10s"  "%10s" "%5s"   "%8s"   "%12s"          "%8s"     "%8s" "%s"]
    
    set mods [lsort -command sort_by_area [array names m_resources]]
    
    foreach mod $mods {
        set insts $m_resources($mod)
		set kind [get_attr function $mod]
		if {[llength $kind] > 1} {
			set kind [get_attr kind [lindex $insts 0]]
		}
        set nInsts [llength $insts]
        set bits 0
        set totalArea [ffmt [mod_area $mod total_area]]
        set seqArea [ffmt [mod_area $mod seq_area]]
        set combArea [ffmt [mod_area $mod comb_area]]
        set all 0.0
        if {$totalArea != "?"} {
            set all [expr $nInsts * $totalArea]
        }
		set allcombArea 0.0
        if {$combArea != "?"} {
            set allcombArea [expr $nInsts * $combArea]
        }
		set allseqArea 0.0
        if {$seqArea != "?"} {
            set allseqArea [expr $nInsts * $seqArea]
        }
        set seqStr ""
        if {$seqArea != 0.0} {
            set seqStr "$allseqArea\($bits\)"
        }
        set ops {}
        if { [info exists m_ops($mod)] } {
            set ops $m_ops($mod)
        }
        #set nOps [llength $ops]
		set nOps ""
		
		# get in/out details
        if { ![info exists m_module_is($mod)] } {
            # approx library modules which are not in added in m_module_is
            if { $kind == "mul" } {
                set input_no "2"
                set var [get_attr bits $mod]
                set inputw "$var,$var"
                set outputw [ expr 2 * $var ]
            } elseif { $kind == "add" } {
                set input_no "2"
                set var [get_attr bits $mod]
                set inputw "$var,$var"
                set outputw [ expr 1 + $var ]
            } else {
                set input_no ""
                set inputw ""
                set outputw ""
            }
        } else {
            # extract input_no., inputw and outputw from m_module_is
            if { $kind == "mux" } {
                set input_no [expr [llength $m_module_is($mod)] - 1]
                set inputw [get_attr width [lindex $m_module_is($mod) 0]]
                set outputw $inputw
            } elseif { [string match RAM* $kind] } {
                set input_no ""
                set kind [get_attr name $mod]
                set nOps [regexp -inline {\d+} [get_attr name $mod]]
                set inputw ""
                set outputw [regexp -inline {\d+$} [get_attr name $mod]]
                set mod $insts
            } else {
                set input_no [llength $m_module_is($mod)]
                set inputw ""
                set outputw ""
                foreach input $m_module_is($mod) {
                    if {$inputw != ""} {
                        append inputw "," [get_attr width $input]
                    } else {
                        append inputw [get_attr width $input]
                    }
                }
                
                foreach output $m_module_os($mod) {
                    if {$outputw != ""} {
                        append outputw "," [get_attr width $output]
                    } else {
                        append outputw [get_attr width $output]
                    }
                }
            }
        }

        lappend m_rows [list [get_attr name $mod] $kind $input_no $inputw $outputw $nInsts $nOps $seqStr $allcombArea $all ""]

        if {$m_verbose} {
            # Print the ops.  Merge those with the same trimmed srcloc.
            clear_array countedOps
            foreach op $ops {
                set src [use_link $op]
                set tsrc [trim_paths $src]
                lappend countedOps($tsrc) $op
            }
            foreach tsrc [lsort [array names countedOps]] {
                set ops $countedOps($tsrc)
                set op [lindex $ops 0]
                #lappend m_rows [list [make_link -object $op [get_attr name $op]] "" [llength $ops] "" "" "" [make_link -source [use_link $op] $tsrc]]
                lappend m_rows [list [get_attr name $op] "" ""  ""  ""  "" [llength $ops] "" "" "" [use_link $op] $tsrc]
            }
        }

        set totAll [expr $totAll + $all]
        set totSeq [expr $totSeq + $allseqArea]
        set totComb [expr $totComb + $allcombArea]
        set totBits [expr $totBits + $bits]
        #set totOps [expr $totOps + $nOps]
        set totOps ""
    }
	
	foreach seq_row $m_resources_seq {
		lappend m_rows $seq_row
	}
	
	foreach mux_row $m_resources_mux {
		lappend m_rows $mux_row
	}
	
	set totAll [expr $totAll + [lindex $m_seqTotal 0] + $m_muxTotal]
	set totSeq [expr $totSeq + [lindex $m_seqTotal 1]]
	set totComb [expr $totComb + [lindex $m_seqTotal 2] + $m_muxTotal]
	set totBits [expr $totBits + [lindex $m_seqTotal 3]]
	
    set totSeqStr ""
    if {$totSeq != 0.0} {
        set totSeqStr "$totSeq\($totBits\)"
    }
    lappend m_rows [list "-------------" "-----" "-----"  "-----"  "-----" "-----"  "----" "------------" "--------"       "--------" $last2]
    lappend m_rows [list "All Resources" ""	"" "" ""  ""  $totOps $totSeqStr     [ffmt $totComb] [ffmt $totAll] ""]

    hls_area::report_print_table $fmt $m_rows
    set m_rows {}
}


# Prints a table of resource, optionally with ops.
proc hls_area::save_csv {} {

    variable m_rows
    variable m_resources
    variable m_ops
    variable m_verbose
	variable m_module_is
	variable m_module_os
	variable m_resources_seq
	variable m_resources_mux
	variable m_seqTotal
	variable m_muxTotal
	
	variable m_outcsv
	
    set m_rows {}
	set fileId [open $m_outcsv "w"]

    set totAll 0.0
    set totSeq 0.0
    set totComb 0.0
    set totBits 0
    set totOps 0
   
    lappend m_rows "Resource;Kind;#Inputs;InWidth;OutWidth;Count;#Words;Seq(#FF);Comb;Total"

    set mods [lsort -command sort_by_area [array names m_resources]]
    foreach mod $mods {
        set insts $m_resources($mod)
		set kind [get_attr function $mod]
		if {[llength $kind] > 1} {
			set kind [get_attr kind [lindex $insts 0]]
		}
        set nInsts [llength $insts]
        set bits 0
        set totalArea [ffmt [mod_area $mod total_area]]
        set seqArea [ffmt [mod_area $mod seq_area]]
        set combArea [ffmt [mod_area $mod comb_area]]
        set all 0.0
        if {$totalArea != "?"} {
            set all [expr $nInsts * $totalArea]
        }
		set allcombArea 0.0
        if {$combArea != "?"} {
            set allcombArea [expr $nInsts * $combArea]
        }
		set allseqArea 0.0
        if {$seqArea != "?"} {
            set allseqArea [expr $nInsts * $seqArea]
        }
        set seqStr ""
        if {$seqArea != 0.0} {
            set seqStr "$allseqArea\($bits\)"
        }
        set ops {}
        if { [info exists m_ops($mod)] } {
            set ops $m_ops($mod)
        }
		#set nOps [llength $ops]
		set nOps ""
		
        # get in/out details
        if { ![info exists m_module_is($mod)] } {
            # approx library modules which are not in added in m_module_is
            if { $kind == "mul" } {
                set input_no "2"
                set var [get_attr bits $mod]
                set inputw "$var,$var"
                set outputw [ expr 2 * $var ]
            } elseif { $kind == "add" } {
                set input_no "2"
                set var [get_attr bits $mod]
                set inputw "$var,$var"
                set outputw [ expr 1 + $var ]
            } else {
                set input_no ""
                set inputw ""
                set outputw ""
            }
        } else {
            # extract input_no., inputw and outputw from m_module_is
            if { $kind == "mux" } {
                set input_no [expr [llength $m_module_is($mod)] - 1]
                set inputw [get_attr width [lindex $m_module_is($mod) 0]]
                set outputw $inputw
            } elseif { [string match RAM* $kind] } {
                set input_no ""
                set kind [get_attr name $mod]
                set nOps [regexp -inline {\d+} [get_attr name $mod]]
                set inputw ""
                set outputw [regexp -inline {\d+$} [get_attr name $mod]]
                set mod $insts
            } else {
                set input_no [llength $m_module_is($mod)]
                set inputw ""
                set outputw ""
                foreach input $m_module_is($mod) {
                    if {$inputw != ""} {
                        append inputw "," [get_attr width $input]
                    } else {
                        append inputw [get_attr width $input]
                    }
                }
                
                foreach output $m_module_os($mod) {
                    if {$outputw != ""} {
                        append outputw "," [get_attr width $output]
                    } else {
                        append outputw [get_attr width $output]
                    }
                }
            }
        }

        lappend m_rows "[get_attr name $mod];$kind;$input_no;$inputw;$outputw;$nInsts;$nOps;$seqStr;$allcombArea;$all"

        set totAll [expr $totAll + $all]
        set totSeq [expr $totSeq + $allseqArea]
        set totComb [expr $totComb + $allcombArea]
        set totBits [expr $totBits + $bits]
		#set totOps [expr $totOps + $nOps]
        set totOps ""
    }
	
	foreach seq_row $m_resources_seq {
		lappend m_rows "[lindex $seq_row 0];[lindex $seq_row 1];[lindex $seq_row 2];[lindex $seq_row 3];[lindex $seq_row 4];[lindex $seq_row 5];[lindex $seq_row 6];[lindex $seq_row 7];[lindex $seq_row 8];[lindex $seq_row 9]"
	}
	
	foreach mux_row $m_resources_mux {
		lappend m_rows "[lindex $mux_row 0];[lindex $mux_row 1];[lindex $mux_row 2];[lindex $mux_row 3];[lindex $mux_row 4];[lindex $mux_row 5];[lindex $mux_row 6];[lindex $mux_row 7];[lindex $mux_row 8];[lindex $mux_row 9]"
	}
	
	set totAll [expr $totAll + [lindex $m_seqTotal 0] + $m_muxTotal]
	set totSeq [expr $totSeq + [lindex $m_seqTotal 1]]
	set totComb [expr $totComb + [lindex $m_seqTotal 2] + $m_muxTotal]
	set totBits [expr $totBits + [lindex $m_seqTotal 3]]
	
    set totSeqStr ""
    if {$totSeq != 0.0} {
        set totSeqStr "$totSeq\($totBits\)"
    }
    
	lappend m_rows "All Resources;;;;;;$totOps;$totSeqStr;[ffmt $totComb];[ffmt $totAll]"

    foreach line $m_rows {
		puts $fileId $line
	}
    set m_rows {}
	
	close $fileId
}

# Unsets all of the elements of the given array, and creates it if it doesn't exist.
proc hls_area::clear_array {arr_in} {
    upvar $arr_in arr
    array unset arr
    array set arr {}
}

# Utility to return an area attribute of a module that may be unset.
proc hls_area::mod_area {mod attr} {
    set modArea unset
    catch {set modArea [get_attr $attr $mod]}
    if {$modArea == "unset"} {set modArea 0.0}
    return $modArea
}

proc hls_area::sort_by_area {modA modB} {

    variable m_resources

    if {$modA == $modB} {
        return 0
    }
    if {$modA == "unset"} {
        return 1
    }
    if {$modB == "unset"} {
        return -1
    }
    set modAreaA [mod_area $modA total_area]
    set nInstsA [llength $m_resources($modA)]
    set resAreaA [expr $modAreaA * $nInstsA]

    set modAreaB [mod_area $modB total_area]
    set nInstsB [llength $m_resources($modB)]
    set resAreaB [expr $modAreaB * $nInstsB]

    if {$resAreaA < $resAreaB} {
        return 1
    } elseif {$resAreaA > $resAreaB} {
        return -1
    } else {
        return 0
    }
}

proc hls_area::ffmt {num} {
    if {$num == "unset"} {
        return " "
    } else {
        return [format %.1f $num]
    }
}

proc hls_area::use_link {obj} {
    set node [lindex [get_stacks -single -no_ip $obj] end]
    return [join [lrange [split $node ,] 1 end] :]
}


#
# Reporting utilities
#

#
# Print a formatted table with columns as wide as the widest text given
# The 'formats' param is a list containing one format encoding per column.
# The format for formats is: '%[-][%Nd]<F> where:
#   - An optional leading - indicates left justticiation
#   - An optional %Nd says calculate the max col width, but make it at least N.
#   - <F> is a format code letter: s, d, f.
#
# The 'data' list contains rows of data.  Each row is a list containing one cell.
#
# The max width is calcualted for each column that has a double-% in its format.,
# and these are used to format the table.
#
# Rows may contain <bdw> annotations.  Columns are justified presuming the annotations
# are stripped off.
#
proc hls_area::report_print_table {formats data} {
    # Find which indexes need longest widths found.
    set nformats [llength $formats]
    set lefts [list]
    set calcs [list]
    set fmts [list]
    set needCalc 0
    array set longest {}
    for {set icol 0} {$icol < $nformats} {incr icol} {
        set left ""
        set calc "" 
        set len ""
        set fmt ""
        regexp {%(-?)(%?)([0-9]*)(.*)$} [lindex $formats $icol] dummy left calc len fmt]
        lappend lefts $left
        lappend calcs $calc
        if {$len != ""} {
            set longest($icol) $len
        }
        lappend fmts $fmt
        if {$calc != ""} {
            set needCalc 1
        }
    }
    # Calculate longest widths
    # We strip annotations when calculating column widths.
    if {$needCalc} {
        foreach d $data {
            for {set icol 0} {($icol < [llength $d]) && ($icol < $nformats)} {incr icol} {
                if { [lindex $calcs $icol] != ""} {
                    set str [::hls::un_link [lindex $d $icol]]
                    set slen [string length $str]
                    if {$slen > $longest($icol)} {
                        set longest($icol) $slen
                    }
                }
            }
        }
    }

    # Print each row.
    # We print one column at a time, buffering with spaces as required.
    # This is done rather than using [format] because we may print strings with annotations, and
    # we need to pad based on the un-annotated string.
    # Print the data
    foreach d $data {
        set icol 0
        set line ""
        foreach str $d {
            set pad ""
            if { [info exists longest($icol)] } {
                set ulen [string length [::hls::un_link $str]]
                set mlen $longest($icol)
                if {$ulen < $mlen} {
                    set pad [string repeat " " [expr $mlen - $ulen]]
                }
            }
            if {[lindex $lefts $icol] == ""} {
                append line $pad
            }
            set fmt [lindex $fmts $icol]
            if {$fmt != ""} {
                append line [format $fmt $str]
            } else {
                append line $str
            }

            if {[lindex $lefts $icol] != ""} {
                append line $pad
            }

            append line " "

            incr icol
        }
        puts $line
    }
}

# If the given object is an hls_config and its not loaded, load it.
# If it has not been run, just return without trying to load to avoid an error.
# Leaves the directory as either the given snapshot, or if a config, the last
# snapshot.
proc hls_area::report_load_config {obj} {
    set origDir [vpwd]

    # If given a lower-level object, its snapshot is by definition loaded.
    # Set the directory to the snapshot.
    set ss $obj
    while { ($ss != "unset") && ([get_attr type $ss] != "snapshot") } {
        set ss [get_attr parent $ss]
    }
    if { ($ss != "unset") && ($ss != $obj) } {
        # A child of a snapshot was given, so it is clearly loaded.
        # Move there and return.
        vcd $ss
        return 1
    }

    if { ([get_attr type $obj] == "hls_config") && ([get_attr last_phase $obj] == "unset") } {
        # No results available, so return unsuccessfully.
        return 0
    }
    if { ![get_attr is_loaded $obj] } {
        if { [catch {load_results $obj} rslt] } {
            vcd $origDir
            return 0
        }
    }
    vcd $obj
    if {[get_attr type [vpwd]] == "hls_config"} {
        set lastSS [get_attr last_phase [vpwd]]
        if {[decodeExecState $lastSS] > [decodeExecState "rtl"]} {
            set lastSS "rtl"
        }
        vcd $lastSS
    }
    return 1
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Main
#   Get things started.
#
#   Accepts:
#     nothing
#   Accesses:
#     argv
#   Returns:
#     yes, it does
#   Side effects:
#     Yes, many.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

proc hls_area::main {} {
    global argv argc argv0

    variable progName
	variable debug
	variable debug_inner 
    variable m_funcName
	variable configName
	variable m_min
    variable m_max
    variable m_fileName
    variable m_areabdl
	variable m_verbose
	variable m_log
	variable m_outcsv
	variable m_printcsv
	
	# Set default values
    set configName ""
    set progName [regsub -all {(^.*/|\.tcl$)} $argv0 {}]
	set debug 0
    set projectFile "project.tcl"
    set stage "rtl"
	set m_funcName ""
	set m_min -1
	set m_max -1
	set m_fileName ""
	set m_areabdl ""
	set m_log ""
	set m_verbose 0
	set m_printcsv 0
	set m_outcsv ""
	set m_top ""
	
    # Process command line options
    set options {
    c.arg config.arg h help d debug p.arg project.arg stage.arg func.arg v verbose csv top.arg
	}
    while {0 < [set ok [cmdline::getopt argv $options FLAG VALUE]]} {
	switch -exact -- $FLAG {
        h    -
        help {
			printHelp
			exit 0
            }
		d -
		debug {
			set debug 1
			}
        p    -
        project {
			set projectFile $VALUE
            }
        stage {
			set stage $VALUE
            }
		c -
		config {
			set configName $VALUE
		}
		v -
		verbose {
			set m_verbose 1
		}
		csv {
			set m_printcsv 1
		}
		func {
			set m_funcName $VALUE
		}
        top {
			set m_top $VALUE
		}
        default {
			puts "default"
			message MSG_UNKNOWN_OPTION $VALUE
			printHelp
			exit 1
            }
	}
    }
    if { 0 < [llength $argv] } {
		message MSG_UNKNOWN_OPTION [lindex $argv 0]
		printHelp
		exit 1
    }
	
	if { $debug == 1 } {
		puts " ########## Inside Main ########### "
	}

	if { $debug ==  1 } {
		#puts "$argv0, $argv, $argc"
		puts "outputFile: $configName"
		puts "projectFile: $projectFile"
		puts "stage: $stage"
		puts "HLS Config: $configName"
	}
	
	set debug_inner 0
	set want_inner_debug 0
	if { $debug && $want_inner_debug } {
		set debug_inner 1
	}
	
	# Open the project
	open_project $projectFile
	
	if { $m_funcName !=  "" } {
		vcd [find -hls_module $m_funcName]
	}
	
	# Load the elab snapshot
	load_results [find -hls_config $configName] -snapshot $stage
	
	set curr_dir [pwd]
    set top [get_attr name [get_attr parent [get_attr parent [vpwd]]]]

    if { $m_top ==  "" } {
		set m_top $top
    }

	set m_fileName "$curr_dir/bdw_work/modules/${top}/$configName/${m_top}_rtl.v"
	set m_areabdl "$curr_dir/bdw_work/modules/${top}/$configName/stratus_hls.bdl"
	set m_log "$curr_dir/bdw_work/modules/${top}/$configName/stratus_hls.log"
	set m_outcsv "$curr_dir/bdw_work/modules/${top}/$configName/reports/detailed_resources.csv"
 	
	
	# main report
	report_area
}
# end of proc main

hls_area::main