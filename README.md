# Digital Design using Verilog

This repository contains implementations of fundamental digital design components using Verilog HDL.
It focuses on building a strong foundation in both **combinational** and **sequential** logic using a structured, modular, and integration-oriented approach.

The repository gradually moves from individual hardware blocks toward complete datapath-level system design.

---

# 📂 Repository Structure

## 🔹 ALU (4-bit)

Implementation of a 4-bit Arithmetic Logic Unit with multiple operations.

### Supported Operations

### Arithmetic

* ADD
* SUB
* Multiplication
* Comparison

### Logical

* AND
* OR
* XOR
* NOR

### Features

* Modular architecture
* Separate arithmetic and logic handling
* Flag generation:

  * Carry
  * Zero
  * Sign
  * Overflow
* Dedicated testbench for verification

---

## 🔹 Registers

Collection of commonly used shift registers.

### Included Modules

* **PISO (Parallel-In Serial-Out)**
* **SIPO (Serial-In Parallel-Out)**
* **SISO (Serial-In Serial-Out)**
* **Universal Shift Register**

  * Shift Left
  * Shift Right
  * Parallel Load
  * Hold

Each module includes:

* Verilog source code
* Individual testbench
* Simulation-ready implementation

---

## 🔹 ALU + Register Datapath Integration

A simple integrated datapath architecture demonstrating how registers and ALUs interact in a digital system.

### Datapath Structure

```text id="12mz9f"
Register → ALU → Register
```

### Supported ALU Operations

* Addition
* Subtraction
* Multiplication
* Comparison
* XOR
* NAND
* OR
* AND

### Concepts Demonstrated

* Register-transfer level (RTL) datapath design
* ALU control signal selection
* Synchronous register operation
* Modular subsystem integration
* Data movement between processing stages

Tiny silicon assembly line running at clock-edge tempo ⚡

---

# ⚙️ Tools & Technologies

* Verilog HDL
* Vivado Simulator
* Icarus Verilog

---

# 🧠 Concepts Covered

## Combinational Logic

* Logic Gates
* Multiplexers
* Arithmetic Circuits
* Comparators

## Sequential Logic

* Shift Registers
* PIPO Registers
* Clocked Circuits

## RTL & System Design

* ALU Design
* Datapath Integration
* Control Signal Handling
* Modular Hardware Architecture
* Testbench Development and Simulation

---

# 🎯 Objective

The goal of this repository is to:

* Build strong digital design fundamentals
* Practice modular RTL development
* Understand datapath-level integration
* Improve Verilog coding and simulation skills
* Prepare for advanced hardware design topics

Including:

* Register Files
* FSM-based Control Units
* Processor Datapaths
* Pipelining
* Basic CPU Architecture

---

# 🚀 Future Enhancements

Planned additions:

* Register File with read/write support
* FSM-controlled datapath
* Accumulator architecture
* Status flag registers
* Memory integration
* Pipelined datapath stages
* Simple processor implementation

---

# 📌 Notes

* All designs are written in a modular and readable format
* Each component is verified using dedicated testbenches
* Repository structure is organized for scalability and learning
* Focused on practical RTL implementation and hardware understanding
* Suitable for academic practice, interview preparation, and portfolio projects

