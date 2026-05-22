# GCD Accelerator in Verilog

A hardware-based GCD (Greatest Common Divisor) Accelerator implemented in Verilog HDL using a datapath + control unit architecture.
This project demonstrates how finite state machines, register files, and arithmetic operations can work together to build a small computation accelerator ⚙️🧮

The design computes the GCD of two 16-bit numbers using the subtraction-based Euclidean Algorithm.

---

## 📌 Features

* Modular datapath and control-path design
* 16-bit GCD computation
* Register file with:

  * 8 registers
  * asynchronous read
  * synchronous write
* FSM-based controller
* Comparator and subtractor datapath
* Start/Done handshake mechanism
* Fully testbench verified

---

## 🧠 Architecture Overview

### Modules Included

| Module                 | Description                              |
| ---------------------- | ---------------------------------------- |
| `register_files.v`     | Stores operands and intermediate values  |
| `gcd_control.v`        | FSM controller for sequencing operations |
| `gcd_accelerator.v`    | Top-level integration module             |
| `gcd_accelerator_tb.v` | Simulation testbench                     |

---

## ⚙️ Working Principle

The accelerator follows the subtraction-based Euclidean algorithm:

```text
If A > B → A = A - B
If B > A → B = B - A
Repeat until A == B
GCD = A
```

The controller FSM manages:

* Loading inputs into registers
* Comparing values
* Selecting subtraction paths
* Writing updated values back
* Signaling completion

Tiny arithmetic duel. Two numbers enter. One divisor leaves 🥊

---

## 🧩 FSM States

| State      | Purpose                 |
| ---------- | ----------------------- |
| `S_IDLE`   | Wait for start signal   |
| `S_LOAD_A` | Load input A            |
| `S_LOAD_B` | Load input B            |
| `S_CHECK`  | Compare register values |
| `S_SUB_A`  | Compute A = A - B       |
| `S_SUB_B`  | Compute B = B - A       |
| `S_DONE`   | Assert done signal      |

---

## 📂 File Structure

```text
GCD_Accelerator_Project/
│
├── register_files.v
├── gcd_control.v
├── gcd_accelerator.v
└── gcd_accelerator_tb.v
```

---

## ▶️ Simulation

The provided testbench:

* Generates a clock signal
* Applies reset
* Loads test inputs
* Pulses the `start` signal
* Waits for computation completion
* Verifies output correctness

### Example Test Case

```text
Input A = 48
Input B = 18

Expected GCD = 6
```

Simulation output:

```text
SUCCESS: GCD is 6
```

---

## 🛠️ Tools Supported

You can simulate and test this project using:

* Vivado
* ModelSim
* Icarus Verilog
* EDA Playground

---

## 🚀 Learning Goals

This project helps in understanding:

* Datapath and controller separation
* FSM-based hardware control
* Register file design
* Hardware arithmetic operations
* Euclidean Algorithm implementation in hardware
* Sequential digital system design
* RTL simulation and verification

A compact little arithmetic engine quietly subtracting its way toward mathematical truth, one clock edge at a time ⏱️
