# Mealy FSM in Verilog

A simple Mealy Finite State Machine (FSM) implemented in Verilog HDL along with a dedicated testbench for simulation and verification.
This project demonstrates how outputs in a Mealy machine depend on both the **current state** and the **current input** ⚡

## 📌 Features

* Mealy FSM implementation in Verilog
* Three encoded states:

  * `STATE_IDLE`
  * `STATE_A`
  * `STATE_B`
* Active-low asynchronous reset
* Separate:

  * State Register Logic
  * Next State Logic
  * Output Logic
* Testbench covering:

  * State transitions
  * Dynamic output changes
  * Mid-operation reset behavior

## 🧠 FSM Behavior

### State Transitions

| Current State | Input (`in_bit`) | Next State |
| ------------- | ---------------- | ---------- |
| IDLE          | `01`             | A          |
| IDLE          | `10`             | B          |
| IDLE          | others           | IDLE       |
| A             | `10`             | B          |
| A             | `11`             | A          |
| A             | others           | IDLE       |
| B             | `01`             | A          |
| B             | `11`             | B          |
| B             | others           | IDLE       |

---

### Output Behavior

| Current State | Input (`in_bit`) | Output (`out_bit`) |
| ------------- | ---------------- | ------------------ |
| IDLE          | any              | `00`               |
| A             | `11`             | `11`               |
| A             | others           | `01`               |
| B             | `11`             | `11`               |
| B             | others           | `10`               |

Because this is a **Mealy FSM**, the output changes immediately with input variations without waiting for a state transition clock edge. Tiny lightning reflexes inside silicon 🌩️

## 📂 Files

* `Mealy_fsm.v` → Mealy FSM design module
* `Mealy_fsm_tb.v` → Testbench for simulation

## ▶️ Simulation

The testbench performs:

* Clock generation (10ns period)
* Reset verification
* Multiple state transition checks
* Dynamic output testing
* Mid-execution reset validation

You can simulate the design using:

* Vivado
* ModelSim
* Icarus Verilog
* EDA Playground

## 🚀 Learning Goals

This project helps in understanding:

* Mealy FSM architecture
* State transition design
* Input-dependent outputs
* Combinational vs sequential logic
* Verilog simulation workflow
* Digital system modeling

A compact little state machine where outputs can pivot mid-step like a chess knight on espresso ♞⚙️
