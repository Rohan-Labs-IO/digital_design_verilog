# Asynchronous FIFO (Dual Clock FIFO)

## Overview

This project implements an **Asynchronous FIFO** in Verilog, enabling reliable data transfer between independent write and read clock domains. The design uses **Gray code pointers** and **two-stage synchronizers** to safely handle clock domain crossing (CDC), along with full and empty flag generation.

A SystemVerilog self-checking testbench is included to verify FIFO functionality under different operating scenarios.

## Features

* Parameterizable data and address widths
* Independent write and read clock domains
* Gray code read/write pointers
* Two-stage pointer synchronizers for CDC
* Full and empty flag generation
* Dual-port memory implementation
* Self-checking SystemVerilog testbench with randomized stimulus and scoreboard

## Verification Status

The following scenarios have been verified successfully:

* Sequential write followed by sequential read
* Data integrity using a queue-based scoreboard
* Independent write and read clocks
* Basic full and empty flag operation

## Known Issue / TODO

The overflow boundary verification test (`DEPTH + 2` writes) is currently under investigation. The present testbench structure exposes a corner case around full-condition handling and subsequent empty-flag verification after draining the FIFO. The FIFO RTL functions correctly for normal operation, but the boundary testbench requires further refinement to accurately verify overflow behavior and synchronization latency.

### Planned Improvements

* Refine overflow boundary verification
* Improve write/read driver timing
* Add assertions for full and empty flag behavior
* Add constrained-random stress testing
* Improve coverage of CDC corner cases

## Learning Objectives

This project demonstrates:

* Clock Domain Crossing (CDC)
* Gray code pointer implementation
* Asynchronous FIFO architecture
* Dual-clock synchronization techniques
* Self-checking SystemVerilog testbench development
