# Moore FSM in Verilog

A simple Moore Finite State Machine (FSM) designed in Verilog HDL with a complete testbench for simulation and verification.
This project demonstrates state transition logic, output logic, and active-low reset behavior in a clean modular structure ⚙️

## 📌 Features

* Moore FSM implementation
* Three encoded states:

  * `STATE_IDLE`
  * `STATE_A`
  * `STATE_B`
* Active-low asynchronous reset
* Separate:

  * State Register Logic
  * Next State Logic
  * Output Logic
* Self-checking style simulation flow using a Verilog testbench

## 🧠 FSM Behavior

| Current State | Input (`in_bit`) | Next State | Output (`out_bit`) |
| ------------- | ---------------- | ---------- | ------------------ |
| IDLE          | 0                | IDLE       | 00                 |
| IDLE          | 1                | A          | 00                 |
| A             | 0                | IDLE       | 01                 |
| A             | 1                | B          | 01                 |
| B             | 0                | IDLE       | 10                 |
| B             | 1                | B          | 10                 |

## 📂 Files

* `Moore_fsm.v` → Moore FSM design module
* `Moore_fsm_tb.v` → Testbench for simulation

## ▶️ Simulation

The testbench:

* Generates a 10ns clock
* Applies reset
* Tests state transitions
* Verifies reset during operation

You can simulate using tools like:

* Vivado
* ModelSim
* Icarus Verilog
* EDA Playground

## 🚀 Learning Goals

This project is useful for understanding:

* Moore vs Mealy FSMs
* Sequential circuit design
* State encoding
* Verilog simulation workflow
* Clocked digital logic design