# ALU + Register Datapath Integration

This module implements a simple 4-bit datapath architecture by integrating registers with an Arithmetic Logic Unit (ALU).

The design demonstrates how data flows through hardware blocks in a digital system using a basic:

```text
Register → ALU → Register
````

architecture.

It is intended as a step forward from standalone combinational and sequential circuits toward complete RTL datapath design.

---

## 📂 Folder Structure

```text
ALU_Register_Datapath/
│
├── src/
│   ├── datapath_top.v     // Top-level datapath integration
│   ├── alu.v              // 4-bit ALU
│   └── PIPO.v             // PIPO register
│
├── tb/
│   └── datapath_tb.v      // Testbench
│
└── README.md
```

---

## ⚙️ Components Used

### 🔹 ALU

Performs arithmetic and logical operations.

Supported operations:

* Addition
* Subtraction
* Multiplication
* Comparison
* XOR
* NAND
* OR
* AND

---

### 🔹 PIPO Register

Parallel-In Parallel-Out register used for:

* Input data storage
* Output result storage
* Synchronous data transfer

---

### 🔹 Datapath Top Module

Integrates:

* Input register
* ALU
* Output register

Controls the movement and processing of data across the datapath.

---

## 🧠 Concepts Demonstrated

* Register Transfer Level (RTL) Design
* Datapath Architecture
* ALU Control Signal Selection
* Synchronous Sequential Logic
* Modular Hardware Integration
* Data Flow Between Registers and Processing Units

Tiny digital conveyor belt powered by clock pulses ⚡

---

## ▶️ Simulation

The included testbench verifies:

* Arithmetic operations
* Logical operations
* Register loading
* ALU output transfer
* Clock-based synchronization

---

## 🎯 Objective

This project is designed to help understand:

* How ALUs interact with registers
* Basic datapath organization
* Hardware integration techniques
* System-level RTL design

It also serves as preparation for:

* Register Files
* FSM-controlled datapaths
* Processor architecture
* Pipeline design

```
```
