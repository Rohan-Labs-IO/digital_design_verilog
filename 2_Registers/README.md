# Registers (Verilog)

This directory contains implementations of different types of shift registers using Verilog HDL. These are fundamental sequential circuits used for data storage, transfer, and manipulation in digital systems.

---

## 📂 Structure

- **PISO (Parallel-In Serial-Out)**
  - Loads parallel data and shifts it out serially.

- **SIPO (Serial-In Parallel-Out)**
  - Accepts serial data and converts it into parallel output.

- **SISO (Serial-In Serial-Out)**
  - Shifts data serially from input to output.

- **Universal Shift Register**
  - Supports multiple operations:
    - Shift Left
    - Shift Right
    - Parallel Load
    - Hold (No Operation)

Each module contains:
- `src/` → Verilog design files  
- `tb/` → Testbench files for simulation  

---

## ⚙️ Concepts Covered

- Sequential Logic Design  
- Flip-Flop Based Circuits  
- Data Shifting Mechanisms  
- Clocked Operations  
- Control Signals (Load, Shift, Enable)

---

## 🧪 Simulation

Each register has an associated testbench to verify:
- Correct data shifting behavior  
- Proper loading of inputs  
- Edge-triggered operation using clock  

Simulate using tools like:
- ModelSim  
- Vivado Simulator  
- Icarus Verilog  

---

## 🎯 Purpose

This module is part of a larger digital design repository aimed at building a strong foundation in:
- Register design  
- Data path elements  
- Integration with ALU and future processor components  

---

## 🚀 Next Steps

- Design a **Register File** (multiple registers with read/write control)  
- Integrate registers with ALU for a simple datapath  
- Add waveform screenshots for better visualization  
