# ALU Project

## Overview
This project implements an Arithmetic Logic Unit (ALU) designed to perform various arithmetic operations such as addition, subtraction, and other logic functions based on control signals. The ALU is modular and can be easily integrated into larger digital systems.

## Project Structure
The project is organized into the following directories and files:

- **src/**: Contains the source files for the ALU implementation.
  - **alu.sv**: Implementation of the ALU functionality.
  - **alu_if.sv**: Interface definition for the ALU.
  - **types/**: Contains custom types and constants used in the ALU design.
    - **alu_types.sv**: Definitions of enumerations and data structures.

- **testbench/**: Contains the testbench files for verifying the ALU functionality.
  - **alu_tb.sv**: Testbench for the ALU, applying test vectors.
  - **alu_test_pkg.sv**: Package with utility functions and tasks for testing.

- **docs/**: Documentation for the project.
  - **README.md**: Detailed documentation about the ALU design and usage.

## Setup Instructions
1. Clone the repository to your local machine.
2. Navigate to the project directory.
3. Ensure you have a SystemVerilog simulator installed.
4. Compile the source files and the testbench.
5. Run the testbench to verify the ALU functionality.

## Features
- Supports basic arithmetic operations: addition, subtraction, etc.
- Modular design for easy integration.
- Comprehensive testbench for validation.

## Running Simulations
To run simulations, use the following command in your terminal (replace `<simulator>` with your simulator command):

```
<simulator> -f <path_to_compile_file>
```

Ensure that all source and testbench files are included in the compilation command.