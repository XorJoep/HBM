# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "LONG_CHUNKS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RAM_STYLE" -parent ${Page_0}


}

proc update_PARAM_VALUE.LONG_CHUNKS { PARAM_VALUE.LONG_CHUNKS } {
	# Procedure called to update LONG_CHUNKS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LONG_CHUNKS { PARAM_VALUE.LONG_CHUNKS } {
	# Procedure called to validate LONG_CHUNKS
	return true
}

proc update_PARAM_VALUE.RAM_STYLE { PARAM_VALUE.RAM_STYLE } {
	# Procedure called to update RAM_STYLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_STYLE { PARAM_VALUE.RAM_STYLE } {
	# Procedure called to validate RAM_STYLE
	return true
}


proc update_MODELPARAM_VALUE.LONG_CHUNKS { MODELPARAM_VALUE.LONG_CHUNKS PARAM_VALUE.LONG_CHUNKS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LONG_CHUNKS}] ${MODELPARAM_VALUE.LONG_CHUNKS}
}

proc update_MODELPARAM_VALUE.RAM_STYLE { MODELPARAM_VALUE.RAM_STYLE PARAM_VALUE.RAM_STYLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_STYLE}] ${MODELPARAM_VALUE.RAM_STYLE}
}

