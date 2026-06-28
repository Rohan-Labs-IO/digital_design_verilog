# Pulse Synchronizer

A pulse synchronizer for safely transferring a **single-cycle pulse** between two asynchronous clock domains. The design converts the input pulse into a toggle in the source domain, synchronizes the toggle using a two flip-flop synchronizer, and reconstructs a single-cycle pulse in the destination domain using XOR edge detection.

## Features

* Safe single-bit pulse transfer across asynchronous clock domains
* Toggle-based synchronization to prevent missed short pulses
* Two flip-flop CDC synchronizer for metastability mitigation
* Independent active-low resets for source and destination domains
* Testbench with configurable clock ratios and multiple pulse scenarios

## Files

* `pulse_synchronizer.v` – RTL implementation of the pulse synchronizer
* `pulse_synchronizer_tb.sv` – Testbench with independent clocks, reset sequencing, and randomized pulse generation

## Notes

* Designed for **single-cycle control pulses**, not multi-bit data transfers.
* The source pulse is converted into a toggle, synchronized into the destination clock domain, and converted back into a one-cycle pulse using XOR edge detection.
* The testbench allows different source-to-destination clock ratios by modifying the clock period parameters, making it useful for validating CDC behavior under various timing conditions.
