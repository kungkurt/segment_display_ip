create_driver segment_displays_driver
set_sw_property hw_class_name segment_displays
set_sw_property version 1
set_sw_property min_compatible_hw_version 1.0
add_sw_property bsp_subdirectory drivers
add_sw_property include_source HAL/inc/segment_driver.h
add_sw_property c_source HAL/src/segment_driver.c
add_sw_property supported_bsp_type HAL