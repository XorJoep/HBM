export
.PHONY: help
help::
	$(ECHO) "Makefile Usage:"
	$(ECHO) "  make build DEVICE=<FPGA platform> "
	$(ECHO) "      Command to build xclbin application."
	$(ECHO) ""

# GENERAL
KERNEL_NAME = snappy_16_unzippers

# BUILDING PARAMETERS
VIVADO_BUILD_FOLDER = $(VIVADO_FOLDER)/snappy_16_unzippers/
DEVICE ?= xilinx_u280_xdma_201920_3

XILINX_OBJECT = $(VIVADO_BUILD_FOLDER)/exports/$(KERNEL_NAME).xo

BUILD_DIR = $(PWD)/xclbin_build
XCLBIN_OUT = $(BUILD_DIR)/$(KERNEL_NAME).xclbin

LINKER_CONFIG = $(PWD)/bank_config.ini

# SHARED SCRIPTS CONFIG
SHARED_SCRIPTS = $(SHARED_DIR)/scripts
EMAIL_KEYFILE = $(SHARED_SCRIPTS)/sendgrid.env
SNAPPY_SCRIPT = $(SHARED_SCRIPTS)/snap.py

# HOST CODE
HOST_DIR = $(PWD)/host_src
HOST_SRCS += $(HOST_DIR)/host.cpp 
HOST_OUT = $(HOST_DIR)/host.bin
HOST_SILESIA_SRCS += $(HOST_DIR)/host-silesia.cpp 
HOST_SILESIA_OUT = $(HOST_DIR)/host-silesia.bin

# BENCHMARK SCRIPTS
BM_SCRIPT_FOLDER = scripts
BENCHMARK_SCRIPT = benchmark.sh
PYTHON_PARSE_SCRIPT = parse.py
PYTHON_PLOT_SCRIPT = plot.py
PYTHON_MULTIPLOT_SCRIPT = multiplot.py

# BENCHMARK FOLDER CONFIG
SILESIA_BM_FOLDER = $(PWD)/bm_silesia
RAND_CS_BM_FOLDER = $(PWD)/bm_rand_cs_silesia
RANDOM_BM_FOLDER = $(PWD)/bm_random
CYCLIC_BM_FOLDER = $(PWD)/bm_cyclic

SILESIA_FILES = $(SHARED_DIR)/silesia

# RESULTS FOLDER CONFIG
RESULTS_FOLDER = results
RESULT_FILE_NAME = results.csv

# GENERATED DATA FOLDER
GENERATED_DATA_FOLDER = gen_data

#################################

PWD := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

ROOT_FOLDER = $(PWD)/../../
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
LDCLFLAGS += --xp prop:solution.kernel_compiler_margin=25
LDCLFLAGS += --kernel_frequency 250

##################################

# all:

build: xclbin

# Building kernel
xclbin: $(XCLBIN_OUT)
$(XCLBIN_OUT): $(XILINX_OBJECT)
	mkdir -p $(BUILD_DIR)
	mkdir -p $(LOG_DIR)
	$(VPP) $(CLFLAGS) --temp_dir $(BUILD_DIR) --log_dir $(LOG_DIR) -l $(LDCLFLAGS) -o $(XCLBIN_OUT) $(XILINX_OBJECT)
	mv xrc.log $(LOG_DIR) 
	mv xcd.log $(LOG_DIR)

# Building Host
host: $(HOST_OUT)
$(HOST_OUT): $(HOST_SRCS)
	$(CXX) $(CXXFLAGS) $(HOST_SRCS) $(HOST_HDRS) -o $(HOST_OUT) $(LDFLAGS)

# Building Host
host-silesia: $(HOST_SILESIA_OUT) 
$(HOST_SILESIA_OUT): $(HOST_SILESIA_SRCS) 
	$(CXX) $(CXXFLAGS) $(HOST_SILESIA_SRCS) $(HOST_HDRS) -o $(HOST_SILESIA_OUT) $(LDFLAGS)

silesia: host
	$(MAKE) -C $(SILESIA_BM_FOLDER) all

silesia-plot:
	$(MAKE) -C $(SILESIA_BM_FOLDER) plot

silesia-multiplot:
	$(MAKE) -C $(SILESIA_BM_FOLDER) multiplot

cyclic: host
	$(MAKE) -C $(CYCLIC_BM_FOLDER) all

cyclic-plot:
	$(MAKE) -C $(CYCLIC_BM_FOLDER) plot

rand_cs: host
	$(MAKE) -C $(RAND_CS_BM_FOLDER) all

rand_cs-plot:
	$(MAKE) -C $(RAND_CS_BM_FOLDER) plot

random: host
	$(MAKE) -C $(RANDOM_BM_FOLDER) all

random-plot:
	$(MAKE) -C $(RANDOM_BM_FOLDER) plot
	
# Cleaning stuff
clean-build:
	-$(RMDIR) $(BUILD_DIR)
clean-results:
	-$(RMDIR) $(RESULTS_FOLDER)
	rm ./*.pdf

clean: clean-build clean-results
	rm host

