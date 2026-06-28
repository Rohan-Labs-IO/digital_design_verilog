# Synchronous FIFO using Verilog

## Overview

This project implements a parameterized **Synchronous FIFO (First-In First-Out)** memory in Verilog along with a self-checking testbench.

The FIFO uses a single clock for both read and write operations and maintains **full** and **empty** status flags using extended read and write pointers.

## Features

* Parameterized data width, address width, and depth
* Active-low asynchronous reset
* Independent read and write enable signals
* Full and Empty flag generation
* Circular buffer implementation using pointer wrap-around
* Self-checking testbench for functional verification

## Module Parameters

| Parameter    | Description             | Default |
| ------------ | ----------------------- | ------- |
| `DATA_WIDTH` | Width of each data word | 8       |
| `ADDR_WIDTH` | Address width of FIFO   | 4       |
| `DEPTH`      | Number of FIFO entries  | 16      |

## FIFO Interface

### Inputs

* `clk` : System clock
* `rst_n` : Active-low reset
* `wr_en` : Write enable
* `wr_data` : Data input
* `rd_en` : Read enable

### Outputs

* `rd_data` : Data output
* `full` : Indicates FIFO is full
* `empty` : Indicates FIFO is empty

## Design

The FIFO consists of:

* A memory array (`fifo_mem`)
* A write pointer (`wr_ptr`)
* A read pointer (`rd_ptr`)

Both pointers contain one extra MSB to distinguish between the **full** and **empty** conditions.

### Empty Condition

```
rd_ptr == wr_ptr
```

### Full Condition

```
MSB(wr_ptr) != MSB(rd_ptr)
AND
Lower bits of wr_ptr == Lower bits of rd_ptr
```

This technique allows reliable detection of pointer wrap-around without requiring an additional counter.

## Testbench

The included testbench performs the following verification sequence:

1. Apply reset
2. Verify FIFO starts in the empty state
3. Fill the FIFO completely
4. Verify the full flag
5. Attempt an overflow write
6. Read back all stored data
7. Verify output data and ordering
8. Confirm FIFO returns to the empty state

## Expected Behavior

* Data is read in the same order it is written (FIFO behavior).
* Writes are ignored when `full` is asserted.
* Reads are ignored when `empty` is asserted.
* Status flags update automatically based on pointer positions.

## Project Structure

```
sync_fifo.v       // FIFO RTL implementation
sync_fifo_tb.v    // Testbench
README.md         // Project documentation
```

## Concepts Practiced

* Verilog RTL design
* Sequential logic
* Parameterized modules
* Memory arrays
* Circular buffer implementation
* Pointer-based FIFO architecture
* Status flag generation
* Hardware verification using testbenches

This project serves as a fundamental building block for larger digital systems such as UARTs, DMA controllers, processors, and communication interfaces.
