# Traffic Light Controller (Verilog)

A finite state machine (FSM) based traffic light controller designed in Verilog HDL. The controller manages multiple traffic movements with configurable green, yellow, and all-red intervals while ensuring safe and conflict-free signal transitions.

## Features

* Finite State Machine (FSM) implementation
* Parameterized timing for easy hardware and simulation configuration
* Dedicated 1-second clock divider
* Configurable green, yellow, and all-red durations
* Separate state register, next-state logic, timer, and output logic
* Self-checking testbench with human-readable light status monitoring

## State Sequence

```
All Red
   ↓
N, S, NE, SW  → Green → Yellow
   ↓
All Red
   ↓
N, NW         → Green → Yellow
   ↓
All Red
   ↓
S, SE         → Green → Yellow
   ↓
All Red
   ↓
E, W, ES, WN  → Green → Yellow
   ↓
All Red
   ↓
E, EN         → Green → Yellow
   ↓
All Red
   ↓
W, WS         → Green → Yellow
   ↓
Repeat
```

## Design Highlights

* Modular FSM architecture with clearly separated control and output logic
* Parameter override support for fast simulation without modifying the design
* Safe default behavior where all traffic lights remain RED unless explicitly enabled
* Active-low asynchronous reset

## Simulation

The provided testbench:

* Generates a 50 MHz clock
* Overrides the 1-second counter for accelerated simulation
* Monitors and displays the status of all traffic lights in a readable format

## Files

* `traffic_light_controller_top.v` : RTL implementation
* `traffic_light_controller_tb.v` : Testbench

## Skills Demonstrated

* Verilog HDL
* Finite State Machine (FSM) Design
* Sequential and Combinational Logic
* Parameterization
* Clock Division and Timing Control
* RTL Verification and Testbench Development
