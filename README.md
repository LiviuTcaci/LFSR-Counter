# Linear Feedback Shift Register (LFSR) Counter

A VHDL implementation of customizable 4-bit and 5-bit Linear Feedback Shift Register (LFSR) counters for Basys3 FPGA board.

## Overview

This project implements LFSR counter schemes as described in "Proiectarea sistemelor numerice folosind tehnologia FPGA" by S. Nedevschi, Z. Baruch, and O. Creț. The system allows users to:
- Select between 4-bit or 5-bit LFSR counter variants
- Configure the loop length (modulo count)
- Visualize the counting sequence on a 7-segment display

## Theory

Linear Feedback Shift Registers (LFSRs) are efficient counters that generate pseudo-random sequences with specific cycle lengths. Unlike conventional binary counters, LFSRs achieve:
- Faster operation due to simpler feedback paths
- Efficient FPGA implementation using fewer resources
- Customizable sequence lengths without excessive logic

The implementation uses lookup tables for different modulo counts, with special feedback signal decoding for various loop lengths:
- 4-bit LFSR: Configurable from modulo-2 to modulo-16
- 5-bit LFSR: Configurable from modulo-2 to modulo-32

## System Architecture

The system is divided into two main units:
1. **Control Unit (CU)** - Manages the system's state transitions:
   - State A: Initial state, waiting for input parameters
   - State B: Loading the LFSR values
   - State C: Running the counter
   - State D: Resetting the LFSR for next operation

2. **Execution Unit (EU)** - Contains the LFSR implementation and peripheral components:
   - LFSR counter core with 4/5-bit configuration
   - Feedback path selection based on modulo count
   - Display management for visualization
   - Input handling for parameter selection

## Features

- Selectable 4-bit or 5-bit LFSR counter modes
- Configurable loop length (2-15 for 4-bit, 2-31 for 5-bit)
- Real-time display of counter values on 7-segment display
- Button interface for parameter input
- Automatic detection of cycle completion

## Components

- **MainDesignLFSR**: Top-level entity connecting all components
- **ControlUnit**: State machine for controlling system operation
- **LFSR**: Core implementation of the shift register with feedback
- **ButtonHandler**: Manages button inputs for loop length configuration
- **SELECTIONS**: Selects feedback connections based on counter parameters
- **C_gate**: Implements additional feedback logic based on lookup tables
- **Display**: Manages 7-segment display output
- **Frequency Dividers**: Generate appropriate clock signals from the master clock

## Setup and Usage

### Hardware Requirements
- Basys3 FPGA board
- Mini-USB cable for programming

### Configuration
1. Connect the Basys3 board to your computer
2. Program the FPGA with the compiled bitstream

### Operation
1. Use the MODE switch to select between 4-bit (OFF) or 5-bit (ON) LFSR mode
2. Press the LENLOOP button to set the desired loop length
   - For 4-bit mode: values 2-15
   - For 5-bit mode: values 2-31
3. Press the START button to begin the counting sequence
4. The 7-segment display will show the current count value
5. The counter will automatically stop after completing the cycle

## Development Environment

- Xilinx Vivado Design Suite (for synthesis and implementation)
- VHDL language for RTL design
- Basys3 constraint files for pin mapping

## References

1. Nedevschi, S., Baruch, Z., & Creț, O. "Proiectarea sistemelor numerice folosind tehnologia FPGA"
2. Xilinx documentation for Basys3 board
