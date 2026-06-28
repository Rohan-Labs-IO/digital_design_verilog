# Digital Design using Verilog

A collection of synthesizable **Verilog and SystemVerilog** projects developed while learning digital design and RTL development. This repository progresses from fundamental combinational circuits to sequential systems, finite state machines, datapath integration, clock domain crossing techniques, and hardware communication building blocks.

The goal is to build a strong foundation in digital hardware design through modular implementations, simulation-driven verification, and scalable RTL design practices.

---

# ✨ Key Focus Areas

- Modular RTL Design
- Combinational & Sequential Logic
- Finite State Machines (FSM)
- Datapath Integration
- Hardware Accelerators
- Clock Domain Crossing (CDC)
- FIFO Design
- Simulation & Verification
- Hardware-Oriented Design Thinking

---

# 📂 Repository Structure

```text
Digital_Design_Verilog/
│
├── 01_ALU_4bit/
├── 02_Registers/
├── 03_Datapath_Integration/
├── 04_Finite_State_Machines/
│   ├── Moore_FSM/
│   └── Mealy_FSM/
├── 05_GCD_Accelerator_Project/
├── 06_Traffic_Light_Controller/
├── 07_Clock_Domain_Crossing/
│   ├── Gray_Code/
│   │   ├── Binary_to_Gray/
│   │   └── Gray_to_Binary/
│   ├── Synchronizers/
│   │   ├── Two_FF_Synchronizer/
│   │   └── Pulse_Synchronizer/
│   └── FIFOs/
│       ├── Sync_FIFO/
│       └── Async_FIFO/
└── README.md
```

---

# 📚 Projects

## 01. 4-bit ALU

A modular Arithmetic Logic Unit implementing common arithmetic and logical operations.

### Supported Operations

**Arithmetic**

- Addition
- Subtraction
- Multiplication
- Comparison

**Logical**

- AND
- OR
- XOR
- NOR

### Features

- Modular architecture
- Arithmetic and logic separation
- Carry, Zero, Sign and Overflow flag generation
- Dedicated simulation testbench

---

## 02. Registers

Collection of commonly used register architectures used in sequential digital systems.

### Included Designs

- SISO Register
- SIPO Register
- PISO Register
- Universal Shift Register

### Universal Register Modes

- Shift Left
- Shift Right
- Parallel Load
- Hold

### Highlights

- Modular Verilog implementations
- Separate simulation testbenches
- Clock-driven sequential behavior
- Register Transfer Level (RTL) design

---

## 03. Datapath Integration

A simple RTL datapath demonstrating interaction between registers and an ALU.

### Datapath

```text
Register → ALU → Register
```

### Supported Operations

- Addition
- Subtraction
- Multiplication
- Comparison
- XOR
- NAND
- OR
- AND

### Highlights

- Register Transfer Level (RTL) design
- ALU control signal handling
- Synchronous data movement
- Modular subsystem integration

---

## 04. Finite State Machines

Implementation of both Moore and Mealy finite state machines.

### Moore FSM

- Output depends only on the current state
- Multi-state transition verification
- Active-low reset

### Mealy FSM

- Output depends on both state and input
- Faster output response
- Dynamic output behavior

### Concepts Covered

- State encoding
- Next-state logic
- Output logic
- FSM verification
- Sequential controllers

---

## 05. GCD Accelerator

Hardware implementation of the subtraction-based Euclidean Algorithm using a controller and datapath architecture.

### Architecture

- Register File
- FSM Controller
- Comparator
- Arithmetic Datapath
- Control Signal Routing

### FSM Operation

```text
LOAD
  ↓
COMPARE
  ↓
SUBTRACT
  ↓
REPEAT
  ↓
DONE
```

### Features

- 16-bit computation
- Start/Done handshake
- Modular controller/datapath separation
- Iterative hardware implementation

---

## 06. Traffic Light Controller

A multi-state traffic controller coordinating multiple traffic phases using configurable timing intervals and safe all-red transitions.

### Features

- Moore FSM implementation
- Parameterized Green, Yellow and Red timings
- One-second clock divider
- Active-low reset
- Modular timer and state-transition logic
- Simulation monitoring

---

## 07. Clock Domain Crossing (CDC)

A collection of fundamental Clock Domain Crossing (CDC) building blocks commonly used in modern digital systems.

### Gray Code

#### Binary to Gray Converter

- Parameterized implementation
- Synthesizable combinational logic

#### Gray to Binary Converter

- Parameterized implementation
- Recursive XOR conversion logic

### Synchronizers

#### Two Flip-Flop Synchronizer

Safely transfers single-bit control signals between asynchronous clock domains while minimizing metastability.

#### Pulse Synchronizer

Transfers single-cycle pulses across clock domains by converting them into synchronized events.

### FIFOs

#### Synchronous FIFO

- Parameterized width and depth
- Circular buffer implementation
- Full and Empty flag generation
- Single-clock operation

#### Asynchronous FIFO *(Work in Progress)*

Current implementation includes:

- Dual-clock architecture
- Gray-coded read/write pointers
- Pointer synchronizers
- Dual-port memory
- Independent read/write clock domains

**Current Status**

The design is under active development. Remaining work focuses on validating Full/Empty flag generation, debugging corner cases, and completing asynchronous verification.

---

# 🛠 Tools

- Verilog HDL
- Vivado
- ModelSim / QuestaSim
- Icarus Verilog
- EDA Playground

---

# 🧠 Concepts Covered

## Combinational Logic

- Logic Gates
- Multiplexers
- Comparators
- Arithmetic Circuits
- ALU Design

## Sequential Logic

- Registers
- Shift Registers
- Counters
- Timers
- Finite State Machines
- Register Files

## RTL & System Design

- Register Transfer Level (RTL)
- Datapath Integration
- Controller + Datapath Architecture
- Hardware Accelerators
- Clock Domain Crossing
- Gray Code
- Synchronizers
- FIFO Design

## Verification

- Functional Simulation
- Testbench Development
- Waveform Analysis
- RTL Debugging

---

# 🎯 Objectives

This repository is maintained to:

- Strengthen digital design fundamentals
- Practice modular RTL development
- Understand sequential hardware systems
- Learn scalable hardware architecture
- Improve simulation and debugging skills
- Build reusable RTL components
- Develop a structured RTL design portfolio

---

# 🚀 Roadmap

Planned additions include:

- UART
- SPI Controller
- Memory Modules
- Register File Enhancements
- Bus Interfaces
- Hazard Detection Logic
- Instruction Decoder
- Cache Basics
- Simple Processor Datapath
- Mini RISC CPU

The long-term objective is to evolve from individual RTL components into a cohesive processor-oriented digital system, with each project building upon the previous one.

---

# 📌 Notes

- All RTL is written in synthesizable Verilog HDL.
- Every completed project includes dedicated simulation testbenches.
- Designs emphasize readability, modularity, and incremental learning.
- Projects are developed with scalability and hardware implementation in mind.

---

## 🎓 Suitable For

- Digital Design Learning
- FPGA Practice
- RTL Development
- Interview Preparation
- Hardware Architecture Revision
- Verilog HDL Portfolio