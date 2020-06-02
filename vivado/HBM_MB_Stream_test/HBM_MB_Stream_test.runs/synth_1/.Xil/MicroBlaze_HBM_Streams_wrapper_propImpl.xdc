set_property SRC_FILE_INFO {cfile:/work/jdumont/workspaces/vivado/HBM_MB_Stream_test/HBM_MB_Stream_test.srcs/sources_1/bd/MicroBlaze_HBM_Streams/ip/MicroBlaze_HBM_Streams_axi_dma_0_1/MicroBlaze_HBM_Streams_axi_dma_0_1.xdc rfile:../../../HBM_MB_Stream_test.srcs/sources_1/bd/MicroBlaze_HBM_Streams/ip/MicroBlaze_HBM_Streams_axi_dma_0_1/MicroBlaze_HBM_Streams_axi_dma_0_1.xdc id:1 order:EARLY scoped_inst:MicroBlaze_HBM_Streams_i/axi_dma_0/U0} [current_design]
set_property SRC_FILE_INFO {cfile:/work/jdumont/workspaces/vivado/HBM_MB_Stream_test/HBM_MB_Stream_test.srcs/sources_1/bd/MicroBlaze_HBM_Streams/ip/MicroBlaze_HBM_Streams_microblaze_0_2/MicroBlaze_HBM_Streams_microblaze_0_2.xdc rfile:../../../HBM_MB_Stream_test.srcs/sources_1/bd/MicroBlaze_HBM_Streams/ip/MicroBlaze_HBM_Streams_microblaze_0_2/MicroBlaze_HBM_Streams_microblaze_0_2.xdc id:2 order:EARLY scoped_inst:MicroBlaze_HBM_Streams_i/microblaze_0/U0} [current_design]
set_property SRC_FILE_INFO {cfile:/work/jdumont/workspaces/vivado/HBM_MB_Stream_test/HBM_MB_Stream_test.srcs/sources_1/bd/MicroBlaze_HBM_Streams/ip/MicroBlaze_HBM_Streams_clk_wiz_0_0/MicroBlaze_HBM_Streams_clk_wiz_0_0.xdc rfile:../../../HBM_MB_Stream_test.srcs/sources_1/bd/MicroBlaze_HBM_Streams/ip/MicroBlaze_HBM_Streams_clk_wiz_0_0/MicroBlaze_HBM_Streams_clk_wiz_0_0.xdc id:3 order:EARLY scoped_inst:MicroBlaze_HBM_Streams_i/clk_wiz_0/inst} [current_design]
current_instance MicroBlaze_HBM_Streams_i/axi_dma_0/U0
set_property src_info {type:SCOPED_XDC file:1 line:52 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -scope -type CDC -id {CDC-1} -user "axi_dma" -tags "9601" -desc "The CDC-1 warning is waived as it is safe in the context of AXI DMA. The Address and Data value does not change until AXI transaction is complete." -to [get_pins -hier -quiet -filter {NAME =~*I_AXI_DMA_REG_MODULE/GEN_AXI_LITE_IF.AXI_LITE_IF_I/GEN_ASYNC_WRITE.REG_WADDR_TO_IPCLK/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[*].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to/D}]
set_property src_info {type:SCOPED_XDC file:1 line:56 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -scope -type CDC -id {CDC-1} -user "axi_dma" -tags "9601" -desc "The CDC-1 warning is waived as it is safe in the context of AXI DMA. The Address and Data value does not change until AXI transaction is complete." -to [get_pins -hier -quiet -filter {NAME =~*I_AXI_DMA_REG_MODULE/GEN_AXI_LITE_IF.AXI_LITE_IF_I/GEN_ASYNC_WRITE.REG_WADDR_TO_IPCLK1/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_IN_cdc_to[*].CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to/D}]
set_property src_info {type:SCOPED_XDC file:1 line:61 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -scope -type CDC -id {CDC-1} -user "axi_dma" -tags "9601" -desc "The CDC-1 warning is waived as it is safe in the context of AXI DMA. In multi channel mode, it is safe to ignore this." -from [get_pins -hier -quiet -filter {NAME =~*MM2S_SPLIT.I_COMMAND_MM2S_SPLITTER/vsize_data_int_reg[*]/C}]
current_instance
current_instance MicroBlaze_HBM_Streams_i/microblaze_0/U0
set_property src_info {type:SCOPED_XDC file:2 line:2 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -user microblaze -tags 12436 -type CDC -id CDC-26 -description "Invalid LUTRAM collision warning" -to [get_pins -quiet "LOCKSTEP_Out_reg\[*\]/R"]
set_property src_info {type:SCOPED_XDC file:2 line:4 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -user microblaze -tags 12436 -type CDC -id CDC-26 -description "Invalid LUTRAM collision warning" -to [get_pins -quiet "MicroBlaze_Core_I/*Interrupt_DFF/Single_Synchronize.use_sync_reset.sync_reg/D"]
current_instance
current_instance MicroBlaze_HBM_Streams_i/clk_wiz_0/inst
set_property src_info {type:SCOPED_XDC file:3 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1_p]] 0.1
