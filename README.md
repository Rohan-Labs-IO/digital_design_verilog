# Digital Design using Verilog

This repository contains implementations of fundamental and intermediate digital design components using Verilog HDL.
The project is structured as a gradual journey from basic combinational circuits to sequential systems, FSM-based control logic, and datapath-level hardware accelerators.

The focus is on:

* Modular RTL design
* Hardware-oriented thinking
* Clean Verilog coding practices
* Simulation and verification
* Scalable digital system architecture

From tiny logic blocks to coordinated datapaths ticking in clock-synchronized harmony ⚙️

---

# 📂 Repository Structure

```text id="3l3y3u"
Digital_Design_Verilog/
│
├── 01_ALU_4bit/
├── 02_Registers/
├── 03_Datapath_Integration/
├── 04_Finite_State_Machines/
│   ├── Moore_FSM/
│   └── Mealy_FSM/
│
└── 05_GCD_Accelerator_Project/
```

---

# 🔹 01. ALU_4bit

Implementation of a 4-bit Arithmetic Logic Unit supporting arithmetic and logical operations.

## Supported Operations

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

## Features

* Modular architecture
* Arithmetic and logic separation
* Status flag generation:

  * Carry
  * Zero
  * Sign
  * Overflow
* Dedicated testbench verification

---

# 🔹 02. Registers

Collection of commonly used shift-register architectures.

## Included Modules

* PISO (Parallel-In Serial-Out)
* SIPO (Serial-In Parallel-Out)
* SISO (Serial-In Serial-Out)
* Universal Shift Register

  * Shift Left
  * Shift Right
  * Parallel Load
  * Hold

## Features

* Individual Verilog implementations
* Separate simulation testbenches
* Clock-driven sequential behavior
* RTL-focused modular design

---

# 🔹 03. Datapath Integration

A simple datapath integration project demonstrating interaction between registers and ALUs.

## Datapath Structure

```text id="f7bg6g"
Register → ALU → Register
```

## Supported Operations

* Addition
* Subtraction
* Multiplication
* Comparison
* XOR
* NAND
* OR
* AND

## Concepts Demonstrated

* Register-transfer level (RTL) design
* ALU control signal handling
* Synchronous data movement
* Subsystem integration
* Datapath-oriented architecture

---

# 🔹 04. Finite State Machines (FSM)

Implementation of both Moore and Mealy finite state machines.

## Included Designs

### Moore FSM

* Output depends only on current state
* Multi-state transition verification
* Active-low reset handling

### Mealy FSM

* Output depends on current state and input
* Dynamic output behavior
* Faster output response characteristics

## Concepts Covered

* State encoding
* Next-state logic
* Output logic design
* Sequential control systems
* FSM simulation methodology

Small digital decision-makers quietly hopping between states like silicon traffic lights 🚦

---

# 🔹 05. GCD Accelerator

A datapath + controller-based hardware accelerator for computing the Greatest Common Divisor (GCD) using the subtraction-based Euclidean Algorithm.

## Architecture Includes

* Register File
* FSM Controller
* Comparator Logic
* Arithmetic Datapath
* Control Signal Routing

## Features

* 16-bit computation support
* Start/Done handshake mechanism
* Modular datapath-control separation
* Hardware iterative computation

## FSM-Controlled Operation

```text id="9kp97d"
LOAD → COMPARE → SUBTRACT → REPEAT → DONE
```

## Concepts Demonstrated

* Controller/datapath co-design
* Register file usage
* Hardware algorithm implementation
* Sequential computation architecture
* RTL integration techniques

A tiny arithmetic engine repeatedly subtracting numbers until mathematics finally nods in agreement 🧮

---

# ⚙️ Tools & Technologies

* Verilog HDL
* Vivado
* Icarus Verilog
* ModelSim
* EDA Playground

---

# 🧠 Concepts Covered

## Combinational Logic

* Logic Gates
* Multiplexers
* Arithmetic Circuits
* Comparators
* ALU Design

## Sequential Logic

* Shift Registers
* Clocked Circuits
* FSM Design
* State Transitions
* Register Files

## RTL & System Design

* Datapath Integration
* Control Signal Handling
* Controller + Datapath Architecture
* Hardware Accelerators
* Modular RTL Design
* Testbench Development
* Simulation & Verification

---

# 🎯 Objective

The goal of this repository is to:

* Build strong digital design fundamentals
* Practice modular RTL development
* Understand sequential hardware systems
* Learn datapath-level integration
* Improve Verilog simulation and debugging skills
* Develop scalable hardware design practices

This repository is designed as both:

* A structured learning archive
* A growing RTL design portfolio

---

# 🚀 Future Enhancements

Planned additions include:

* FIFO Buffers
* UART Communication
* Memory Modules
* Pipelined Datapaths
* Hazard Detection Logic
* Simple Processor Datapath
* Instruction Decoder
* Cache Basics
* Mini RISC CPU Architecture

The long-term roadmap slowly drifts from isolated circuits toward a complete tiny processor universe 🌌

---

# 📌 Notes

* All modules are written in synthesizable Verilog HDL
* Every design includes dedicated simulation testbenches
* Repository structure is organized for scalability
* Focused on practical RTL implementation and hardware understanding
* Suitable for:

  * Academic learning
  * Interview preparation
  * FPGA practice
  * RTL portfolio development
  * Digital design revision and experimentation