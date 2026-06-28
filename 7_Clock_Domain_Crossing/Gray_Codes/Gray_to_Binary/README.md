# Gray to Binary Code Converter

A parameterized combinational circuit that converts Gray code into its equivalent binary representation. The design reconstructs each binary bit by propagating XOR operations from the most significant bit (MSB) to the least significant bit (LSB).

## Features

* Parameterized data width (default: 4 bits)
* Pure combinational logic with no clock or reset
* Efficient iterative XOR-based conversion
* Synthesizable and scalable for wider data buses
* Exhaustive testbench covering all possible input combinations

## Files

* `gray_to_binary_top.v` – RTL implementation of the Gray to Binary converter
* `gray_to_binary_tb.sv` – Testbench that verifies every possible input value for the selected width

## Notes

* The conversion is performed using the following relationship:

  * **MSB:** `Binary[MSB] = Gray[MSB]`
  * **Remaining bits:** `Binary[i] = Gray[i] ^ Binary[i+1]`
* Unlike Binary-to-Gray conversion, Gray-to-Binary cannot be implemented using a single XOR expression. Each binary bit depends on the previously reconstructed higher-order bit.
* Gray-to-Binary conversion is commonly used alongside Binary-to-Gray conversion in applications such as asynchronous FIFOs, rotary encoders, and clock domain crossing (CDC) pointer synchronization.
