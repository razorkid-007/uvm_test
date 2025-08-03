# ALU Project Documentation

## Overview
The Arithmetic Logic Unit (ALU) project is designed to implement a versatile ALU capable of performing various arithmetic and logic operations. This project includes the necessary files for both the ALU implementation and its corresponding testbench.

## Project Structure
The project is organized into the following directories:

- **src/**: Contains the source files for the ALU implementation.
  - **alu.sv**: Implements the ALU functionality, including addition, subtraction, and other operations based on control signals.
  - **alu_if.sv**: Defines the interface for the ALU, specifying inputs, outputs, and control signals.
  - **types/**: Contains custom types and constants used in the ALU design.
    - **alu_types.sv**: Defines enumerations for operation types and other relevant data structures.

- **testbench/**: Contains the testbench files for verifying the ALU functionality.
  - **alu_tb.sv**: Instantiates the ALU module and applies test vectors.
  - **alu_test_pkg.sv**: Includes utility functions and tasks for testing the ALU.

- **docs/**: Contains documentation files.
  - **README.md**: Provides an overview of the ALU design and usage instructions.

## Usage Instructions
1. **Setup**: Ensure you have a SystemVerilog simulator installed.
2. **Compile**: Compile the source files and the testbench files.
3. **Run Tests**: Execute the testbench to verify the functionality of the ALU.

## Features
- Supports basic arithmetic operations: addition, subtraction, etc.
- Configurable operation selection through control signals.
- Comprehensive testbench for validation.

## Additional Information
For more detailed information on each component of the project, please refer to the respective source files and the testbench documentation.