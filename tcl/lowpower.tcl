set_db / .lp_insert_discrete_clock_gating_logic true
#Controls whether to generate clock-gating logic by using basic
#libcells if no usable integrated clock-gating cells are available in the library

set_db / .lp_clock_gating_infer_enable true
#When clock-gating insertion is enabled, enabling this attribute
#will invoke an advanced algorithm that identifies additional clock-gating opportunities—even
#in the absence of a feedback loop—that cannot be identified using the basic algorithm
#set_db / .lp_insert_clock_gating true

set_db / .lp_clock_gating_exceptions_aware true
#Specifies whether to take timing exceptions set on flop instances
#or on their clock, enable, and reset pins into account during clock gating

set_db / .lp_clock_gating_prefix "PREFIX_lp_clock_gating"
#Specifies the prefix to be added to all clock-gating modules,
#observability flip-flops, generated clock nets, and the ports created by clock-gating insertion

set_db / .design_power_effort high
#Enables and controls power optimization, together with the
#opt_leakage_to_dynamic_ratio attribute. When performing power optimization, the
#tool will make a trade off between power, delay, area, and runtime.
#high - Performs the best power optimization with a higher trade-off on delay, area, and
#runtime. In this case, the runtime can be significantly higher.

set_db / .opt_leakage_to_dynamic_ratio 0.3
#Controls the weight factors to be used when optimizing leakage
#power and dynamic power simultaneously during mapping and incremental optimization. 
