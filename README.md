# 4-bit ALU Design in Verilog

## 📌 Overview

This project implements a **4-bit Arithmetic Logic Unit (ALU)** using Verilog HDL. The design is modular, with each operation implemented as a separate module and integrated at the top level.

The ALU performs a set of arithmetic and logical operations based on a control signal.

---

## ⚙️ Features

The ALU supports the following operations:

| Control Code | Operation |
| ------------ | --------- |
| 0            | OR        |
| 1            | AND       |
| 2            | XOR       |
| 3            | NOR       |
| 4            | ADD       |
| 5            | SUBTRACT  |
| 6            | MULTIPLY  |
| 7            | COMPARE   |

---

## 🧩 Project Structure

```
ALU_4bit/
│
├── src/
│   ├── main_source.v        // Top-level ALU module
│   ├── logic_unit.v         // Logical operations (AND, OR, XOR, NOR)
│   ├── add_sub.v            // Adder and subtractor
│   ├── multiplier.v         // 4-bit multiplier
│   ├── comparator.v         // Comparator module
│
├── tb/
│   └── alu_tb.v             // Testbench for simulation
│
└── README.md
```

---

## 🧠 Design Approach

* Modular design for better readability and scalability
* Each functional unit is implemented independently
* Multiplexing logic is used within modules to select operations
* Flags such as carry, overflow, zero, and sign are generated where applicable

---

## 🧪 Simulation

* Testbench written to verify all ALU operations
* Simulated using tools like **Xilinx Vivado**
* Waveforms used to validate correctness of outputs

---

## 🚧 Current Status

* Core ALU functionality implemented
* All major modules are functional
* Project is under active development and improvements

---

## 🔮 Future Improvements

* Refactor control logic into a centralized unit
* Add division operation
* Improve flag handling and standardization
* Optimize design for synthesis

---

## 🛠️ Tools Used

* Verilog HDL
* Xilinx Vivado (Simulation and synthesis)

---

## 📚 Learning Outcome

This project helps in understanding:

* Digital design using HDL
* Modular hardware architecture
* Arithmetic and logic circuit implementation
* Simulation and debugging of hardware designs

---

## 📎 Notes

This is a learning project and is being continuously improved as concepts are explored further.
