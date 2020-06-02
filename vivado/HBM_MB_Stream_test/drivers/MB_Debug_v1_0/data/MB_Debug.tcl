

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "MB_Debug" "NUM_INSTANCES" "DEVICE_ID"  "C_S00_AXI_input_BASEADDR" "C_S00_AXI_input_HIGHADDR"
}
