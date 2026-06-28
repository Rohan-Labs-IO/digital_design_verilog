# Binary to Gray Code Converter

A parameterized combinational circuit that converts binary numbers into Gray code. The implementation uses a simple bitwise XOR operation, making it compact, synthesizable, and scalable for different bus widths.

## Features

* Parameterized data width (default: 4 bits)
* Pure combinational logic with no clock or reset
* Efficient implementation using `Binary ^ (Binary >> 1)`
* Alternative loop-based implementation included for educational reference
* Exhaustive testbench covering all possible input combinations

## Files

* `binary_to_gray_top.v` – RTL implementation of the Binary to Gray converter
* `binary_to_gray_tb.sv` – Testbench that verifies every possible binary input for the selected width

## Notes

* The converter implements the standard Gray code equation:

  ```
  Gray = Binary ^ (Binary >> 1)
  ```
* Gray code ensures that only **one bit changes between consecutive values**, making it useful in applications such as asynchronous FIFOs, rotary encoders, and clock domain crossing (CDC) pointer synchronization.
* The design can be scaled by changing the `WIDTH` parameter without modifying the conversion logic.
