.PHONY: help
help::
	$(ECHO) "Makefile Usage:"
	$(ECHO) "  make build DEVICE=<FPGA platform> "
	$(ECHO) "      Command to build xclbin application."
	$(ECHO) ""

VIVADO_BUILD_FOLDER = $(VIVADO_FOLDER)/baseline_64bit/

KERNEL_NAME = HBM_Multi_Measurements
DEVICE ?= xilinx_u280_xdma_201920_3

# BUILDING PARAMETERS
XILINX_OBJECT = $(VIVADO_BUILD_FOLDER)/exports/$(KERNEL_NAME).xo

BUILD_DIR := ./xclbin_build
XCLBIN_OUT = $(BUILD_DIR)/$(KERNEL_NAME).xclbin

LINKER_CONFIG = ./bank_config.ini

# HOST CODE
HOST_SRCS += ./host_src/host.cpp 

# BENCHMARK SCRIPTS
BENCHMARK_SCRIPT_FOLDER = ./benchmark_scripts

BENCHMARK_SCRIPT = $(BENCHMARK_SCRIPT_FOLDER)/benchmark.sh
PYTHON_SNAP_SCRIPT = $(BENCHMARK_SCRIPT_FOLDER)/snap.py
PYTHON_PARSE_SCRIPT = $(BENCHMARK_SCRIPT_FOLDER)/parse.py
PYTHON_PLOT_SCRIPT = $(BENCHMARK_SCRIPT_FOLDER)/plot.py
PYTHON_MULTIPLOT_SCRIPT = $(BENCHMARK_SCRIPT_FOLDER)/multiplot.py

# RESULTS FOLDER CONFIG
RESULTS_FOLDER = ./results/mode_$(MODE)
RESULT_FILE_NAME = results.csv
#################################

PWD := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ROOT_FOLDER = $(PWD)/../../../

BUILDS_FOLDER = $(ROOT_FOLDER)/builds
VIVADO_FOLDER = $(ROOT_FOLDER)/vivado
VITIS_FOLDER = $(ROOT_FOLDER)/vitis
SHARED_DIR = $(BUILDS_FOLDER)/_shared_files

COMMON_REPO = $(SHARED_DIR)
ABS_COMMON_REPO = $(SHARED_DIR)

TARGET := hw
HOST_ARCH := x86
include $(ABS_COMMON_REPO)/common/utils.mk

XSA := $(DEVICE)
TEMP_DIR := $(BUILD_DIR)/_x.$(TARGET).$(XSA)
LOG_DIR := $(BUILD_DIR)/logs
VPP := v++

#Include Libraries
include $(ABS_COMMON_REPO)/common/includes/opencl/opencl.mk
include $(ABS_COMMON_REPO)/common/includes/xcl2/xcl2.mk

CXXFLAGS += $(xcl2_CXXFLAGS)
LDFLAGS += $(xcl2_LDFLAGS)
HOST_SRCS += $(xcl2_SRCS)
HOST_SILESIA_SRCS += $(xcl2_SRCS)


CXXFLAGS += $(opencl_CXXFLAGS) -Wall -O0 -g -std=c++11
LDFLAGS += $(opencl_LDFLAGS)

# Host compiler global settings
CXXFLAGS += -fmessage-length=0
LDFLAGS += -lrt #-lstdc++ 

# Kernel compiler global settings
CLFLAGS += -t $(TARGET) --platform $(DEVICE)

# Kernel linker flags
LDCLFLAGS += --config $(LINKER_CONFIG)

EXECUTABLE = host


# TARGETS
all: $(EXECUTABLE)

.PHONY: build
build: xclbin
# Building kernel
xclbin: $(XILINX_OBJECT)
	mkdir -p $(BUILD_DIR)
	mkdir -p $(LOG_DIR)
	$(VPP) $(CLFLAGS) --temp_dir $(BUILD_DIR) --log_dir $(LOG_DIR) -l $(LDCLFLAGS) -o $(XCLBIN_OUT) $(XILINX_OBJECT)
	mv xrc.log $(LOG_DIR) 
	mv xcd.log $(LOG_DIR)

# Building Host
$(EXECUTABLE): check-xrt $(HOST_SRCS) $(HOST_HDRS)
	$(CXX) $(CXXFLAGS) $(HOST_SRCS) $(HOST_HDRS) -o '$@' $(LDFLAGS)

# Benchmarking stuff
.PHONY: benchmark
benchmark: host
	mkdir -p $(RESULTS_FOLDER)
	-$(RMDIR) $(RESULTS_FOLDER)/*
	$(BENCHMARK_SCRIPT) ./$(EXECUTABLE) $(XCLBIN_OUT) $(KERNEL_NAME) $(RESULTS_FOLDER) $(MODE)

# Parsing benchmark
parse: 
	python3 $(PYTHON_PARSE_SCRIPT) $(RESULTS_FOLDER) $(RESULT_FILE_NAME)

plot: parse
	python3 $(PYTHON_PLOT_SCRIPT) $(RESULTS_FOLDER)/$(RESULT_FILE_NAME) $(MODE)

multiplot:
	python3 $(PYTHON_MULTIPLOT_SCRIPT) $(RESULTS_FOLDER)2/$(RESULT_FILE_NAME) $(RESULTS_FOLDER)3/$(RESULT_FILE_NAME)


# Cleaning stuff
clean-build:
	-$(RMDIR) $(BUILD_DIR)
clean-results:
	-$(RMDIR) $(RESULTS_FOLDER)
	rm ./*.pdf

clean: clean-build clean-results
	rm host

