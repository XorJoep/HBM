export
CXX      := g++
CXXFLAGS := -pedantic-errors -Wall -Wextra -Werror -std=c++11
LDFLAGS  := -L/usr/lib -lstdc++ -lm -lsnappy -lpthread
BUILD    := $(PWD)/build
OBJ_DIR  := $(BUILD)/objects
APP_DIR  := $(BUILD)/apps
TARGET   := snappy-bm
INCLUDE  := -Iinclude/
SRC      := $(wildcard src/*.cpp)

OBJECTS  := $(SRC:%.cpp=$(OBJ_DIR)/%.o)
DEPENDENCIES := $(OBJECTS:.o=.d)

EXECUTABLE := $(APP_DIR)/$(TARGET)

#########################################################################
PWD := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHARED_DIR = $(PWD)/../_shared_files
#########################################################################

# SHARED SCRIPTS CONFIG
SHARED_SCRIPTS = $(SHARED_DIR)/scripts
EMAIL_SCRIPT = $(SHARED_SCRIPTS)/email.py
EMAIL_KEYFILE = $(SHARED_SCRIPTS)/sendgrid.env
SNAPPY_SCRIPT = $(SHARED_SCRIPTS)/snap.py

# BENCHMARK SCRIPTS
BM_SCRIPT_FOLDER = scripts
BENCHMARK_SCRIPT = benchmark.sh
PYTHON_PARSE_SCRIPT = parse.py
PYTHON_PLOT_SCRIPT = plot.py
PYTHON_MULTIPLOT_SCRIPT = multiplot.py

# BENCHMARK FOLDER CONFIG
SILESIA_BM_FOLDER = $(PWD)/bm_silesia
RANDOM_BM_FOLDER = $(PWD)/bm_random
CYCLIC_BM_FOLDER = $(PWD)/bm_cyclic

SILESIA_FILES = $(SHARED_DIR)/silesia

# RESULTS FOLDER CONFIG
RESULTS_FOLDER = results
RESULT_FILE_NAME = results.csv

# GENERATED DATA FOLDER
GENERATED_DATA_FOLDER = gen_data


all: build $(APP_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -MMD -o $@

$(APP_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $(APP_DIR)/$(TARGET) $^ $(LDFLAGS)

-include $(DEPENDENCIES)

.PHONY: all build clean debug release info

build:
	@mkdir -p $(APP_DIR)
	@mkdir -p $(OBJ_DIR)

debug: CXXFLAGS += -DDEBUG -g
debug: all

release: CXXFLAGS += -O2
release: all

clean:
	-@rm -rvf $(OBJ_DIR)/*
	-@rm -rvf $(APP_DIR)/*

####################

random: release
	$(MAKE) -C $(RANDOM_BM_FOLDER) all

random-plot:
	$(MAKE) -C $(RANDOM_BM_FOLDER) plot

cyclic: release
	$(MAKE) -C $(CYCLIC_BM_FOLDER) all

cyclic-plot:
	$(MAKE) -C $(CYCLIC_BM_FOLDER) plot

silesia: release
	$(MAKE) -C $(SILESIA_BM_FOLDER) all

silesia-plot:
	$(MAKE) -C $(SILESIA_BM_FOLDER) plot

silesia-multiplot:
	$(MAKE) -C $(SILESIA_BM_FOLDER) multiplot