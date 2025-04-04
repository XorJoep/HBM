# Introduction
This repository contains part of the files used to perform measurements on the High Bandwidth Memory of the Alveo U280. An implementation is used that allows a processing engine to be used in parallel in combination with a MicroBlaze softcore.  
<img src="https://raw.githubusercontent.com/XorJoep/HBM/master/hbm-Toplevel.png" width="400" height="400">

# HBM design files


* `/vitis/` contains source files used to program MicroBlaze used within design
* `/vivado/` contains results of exporting RTL kernel within Vivado
* `/builds/` contains makefile + other scripts to setup and perform measurements
* `/ip_repo/` contains IPs used in the designs

# Building and executing a kernel
## Requirements
* Have access to an Alveo U280 accelerator card.
* Have Vivado/Vitis/XRT variables set ([link](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/settingupvitisenvironment.html "Setting Up the Vitis Environment"))
* * On QCE server this is done with: `module load vitis` and `source /opt/xilinx/setup.sh`
* Make sure [this example](https://github.com/Xilinx/Vitis_Accel_Examples/tree/master/host/hbm_simple "HBM Simple example") works

## Building the kernel
* `cd builds`
* `make build`
* This might take 2-3 hours to complete. Once done an .xclbin will be within a folder named `xclbin_build`.

## Executing the kernel
* `cd builds`
* `make random` or one of the other recipes specified in the makefile

This will execute `benchmark.sh` from the folder associated with the recipe. Within this file are the configurations for the specific benchmark, such as amount of activated parallel components. This script will use those configurations to repeatingly create compressed data and run the executable build from `host.cpp`.
Once the script completes all results from each measurement will be in a `results` folder, the parsed contents of this folder are in a file named `results.csv` which is used to create a plot from the results.

# Editing the kernel
Only the 16 decompressors kernel is available for editing.

* Start Vivado and start some project
* Within Vivado in the tcl console `cd` to `/vivado/snappy_16_unzippers`
* run `source snappy_16_unzippers.tcl`
* This will create a new project with a block design using the 16 decompressors. 
* Through the `generate RTL kernel` button on the left a synthesis will be started (if not performed yet) and a `.xo` file will be generated from the `kernel.xml` and `package_kernel.tcl` files.

# Editing the MicroBlaze code
* Once you have the Vivado block diagram, go to `file->export->export hardware` and click next twice. Make note of where the `.xsa` will be written to.
* Start Vitis (In Vivado top bar `Tools->Start Vitis IDE`)
* Within Vitis `File->new->application project`
* Select the tab `Create a new platform from hardware (XSA)` and select the previously made `.xsa`
* Give your app a name
* select empty application after a few nexts
* Copy the contents of `/vitis/snappy_16_unzippers_app/src` into the src folder of your app.
* Running build will generate a `.elf`
* Within Vivado navigate to `Tools->associate ELF Files` and add/select the new `.elf` as a design source.
