# FPGA Traffic Light Controller with Timer and 7-Segment Display

This project implements a digital traffic light controller on an FPGA (tested on Nexys4 DDR) using Verilog. The system features a finite state machine (FSM) for traffic light sequencing, a parameterized timer, a clock divider, and a two-digit 7-segment display for countdown visualization.

---

## Features

- **Traffic Light FSM:** Controls North-South and East-West traffic lights with green, yellow, and red phases.
- **Pedestrian Request (optional):** FSM can be extended to handle pedestrian crossing requests.
- **Configurable Timer:** Parameterized timer for flexible phase durations.
- **Clock Divider:** Converts 100MHz board clock to 1Hz for human-readable timing.
- **7-Segment Display:** Shows the countdown timer for the current light phase.
- **Testbenches:** Provided for all major modules.

---

## Module Overview

### 1. `clk_divider.v`
Divides the 100MHz FPGA clock down to 1Hz (or any desired frequency via the `DIV` parameter).

### 2. `timer.v`
A parameterized countdown timer. Loads a value on `load`, decrements on each clock when `enable` is high, and asserts `done` when it reaches zero.

### 3. `Traffic_light_controller_FSM.v`
Finite State Machine for sequencing the traffic lights. Generates `load` and `load_value` for the timer, and outputs the current light states.

### 4. `two_digit_display.v`
Drives a two-digit 7-segment display to show the current timer value.

### 5. `Top_module.v`
Top-level integration of all modules. Connects the clock divider, FSM, timer, and display.

---

## Simulation

Testbenches are provided for all modules.  
**Note:** For simulation, the clock divider's `DIV` parameter is set to a small value (e.g., 10) for faster results.

- Run `Top_module_tb.v` for full system simulation.
- Run individual testbenches for unit testing of each module.

---

## Synthesis & Implementation

- Use the provided `Nexys4DDR_Master.xdc` constraints file for pin mapping on the Nexys4 DDR board.
- Make sure to set the correct clock pin and output pins for LEDs and 7-segment display.

---

## Usage

1. **Clone the repository.**
2. **Open the project in your FPGA tool (Vivado, etc.).**
3. **Add all Verilog source files and the XDC constraints file.**
4. **Synthesize, implement, and program your FPGA board.**
5. **Observe the traffic light LEDs and countdown on the 7-segment display.**

---

## Authors

- Khaled Gamal

---

## Notes

- For real hardware, set the clock divider `DIV` parameter to match your board's clock (e.g., 50_000_000 for 100MHz to 1Hz).
- For simulation, use a much smaller `DIV` (e.g., 10).
- The FSM and timer are robust to reset and ensure correct sequencing after power
