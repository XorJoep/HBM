# HBM design files
This repository contains part of the files used to perform measurements on the High Bandwidth Memory of the Alveo U280. 

* `/vitis/` contains source files used to program MicroBlaze used within design
* `/vivado/` contains results of exporting RTL kernel within Vivado
* `/builds/` contains makefile + other scripts to setup and perform measurements

## Requirements
* Have access to an Alveo U280 accelerator card.
* Have Vivado/Vitis/XRT variables set ([link](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/settingupvitisenvironment.html "Setting Up the Vitis Environment"))
* * On QCE server this is done with: `module load vitis` and `source /opt/xilinx/setup.sh`

## Building the .xclbin (kernel on FPGA)
* Go into a configuration on within the `/builds/` folder
* Run `make build`

## 
