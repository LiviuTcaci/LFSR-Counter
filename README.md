# LFSR-Based Counter

This project implements LFSR (Linear Feedback Shift Register) counter schemes based on the designs described in Chapter 4 of *"Proiectarea sistemelor numerice folosind tehnologia FPGA"* by S. Nedevschi, Z. Baruch, and O. Creţ. The system accepts a user-specified counting loop length and a mode selection that configures the counter to operate as either a 4-bit or a 5-bit variant.

## Overview

- **LFSR Counter Implementation:**  
  The design includes separate VHDL modules for both 4-bit and 5-bit LFSR counters. A mode input selects which variant to use.

- **User Inputs:**  
  The system receives the desired loop length (via a button handler) and a mode selection signal that determines the counter width.

- **Supporting Modules:**  
  The project is composed of multiple VHDL components including:
  - Frequency dividers (for clock generation)
  - A control unit to manage state transitions and loading of the LFSR
  - A button handler for capturing the loop length input
  - Conversion blocks (e.g., Binary-to-BCD, Seven-segment display controllers) for visual output
  - Auxiliary components such as multiplexers and decoders

- **Simulation and Synthesis:**  
  The repository includes Logisim circuit files (`*.circ`) for simulation and a complete set of VHDL source files (in the `LFSR_materials/hdl_export` directory) for synthesis on FPGA platforms.

## Project Structure
```
.
├── DocumentatieLFSR_TLv2.docx       # Project documentation and design rationale
├── LFSR.circ                        # Logisim simulation file for the LFSR counter
└── LFSR_materials
├── LFSRv0.1.circ                # Early simulation version
├── LFSRv0.2.circ                # Updated simulation version
├── LFSRv0.circ                  # Initial simulation file
└── hdl_export                   # VHDL source files for FPGA synthesis
├── BIN_BCD.vhd
├── ButtonHandler.vhd
├── C_gate.vhd
├── ControlUnit.vhd
├── DECODER_2x4.vhd
├── D_7SEG.vhd
├── Display.vhd
├── LFSR.vhd
├── MUX_4x1.vhd
├── MainDesignLFSR.vhd
├── SELECTIONS.vhd
├── divisor_frecv100hz.vhd
└── divisor_frecv1Mhz.vhd
```

## Build & Simulation

1. **Synthesis:**  
   Use your preferred FPGA synthesis tool (e.g., Xilinx Vivado or Intel Quartus) to compile the VHDL files located in the `hdl_export` folder. The top-level design is `MainDesignLFSR.vhd`.

2. **Simulation:**  
   You can simulate the design using ModelSim or any other VHDL simulator. The provided `.circ` files can be used with Logisim-evolution for a visual simulation of the counter.

## Future Improvements

- **Dynamic Feedback Polynomial Selection:**  
  Future work may include adding a mechanism to dynamically select the feedback polynomial.
- **Enhanced User Interface:**  
  Improvements in user input handling and display features could further refine the system.
