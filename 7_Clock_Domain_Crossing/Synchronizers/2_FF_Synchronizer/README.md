# Two Flip-Flop Synchronizer

A two flip-flop (2FF) synchronizer used for safe clock domain crossing (CDC) of a single-bit control signal. The design reduces the probability of metastability by passing an asynchronous input through two sequential flip-flops clocked by the destination clock.

## Features

* Single-bit clock domain synchronization
* Active-low asynchronous reset
* Independent source and destination clocks in the testbench
* Randomized asynchronous stimulus to emulate real CDC behavior

## Files

* `ff2_synchronizer.v` – RTL implementation of the 2FF synchronizer
* `ff2_synchronizer_tb.sv` – Testbench with asynchronous clock generation and randomized input transitions

## Notes

* This design is intended for **single-bit control signals only**. Multi-bit data transfers require dedicated CDC techniques such as asynchronous FIFOs or handshake-based synchronizers.
* The testbench demonstrates asynchronous behavior using unrelated source and destination clocks. While digital simulation cannot model true metastability, it verifies the functional operation of the synchronizer under asynchronous timing conditions.
