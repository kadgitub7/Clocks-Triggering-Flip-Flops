# Intro to Clocks in Digital Electronics

> A foundational concept in sequential logic design — understanding how clock signals synchronize digital circuits.

---

## Table of Contents

- [What is a Clock?](#what-is-a-clock)
- [Clock Properties](#clock-properties)
  - [Time Period](#time-period)
  - [Frequency](#frequency)
  - [Duty Cycle](#duty-cycle)
- [Clock in Sequential Circuits](#clock-in-sequential-circuits)
  - [Clock as an Input](#clock-as-an-input)
  - [Edge-Triggered Design](#edge-triggered-design)
- [Clock Signal Diagram](#clock-signal-diagram)
- [Summary Table](#summary-table)
- [Key Takeaways](#key-takeaways)

---

## What is a Clock?

A **clock** is a periodic digital signal that continuously alternates between a **low (0)** and **high (1)** state. It is the heartbeat of any sequential digital circuit, providing a consistent timing reference that ensures all components operate in synchronization.

```
High |‾‾‾|   |‾‾‾|   |‾‾‾|
     |   |   |   |   |   |
Low  |   |___|   |___|   |___
      <---T--->
```

- The signal transitions: **Low → High → Low → High → ...**
- The time spent **low** equals the time spent **high** (for a 50% duty cycle clock)

---

## Clock Properties

### Time Period

The **time period** (`T`) is the total time for one complete cycle of the clock signal — from the start of one low-to-high transition to the start of the next.

```
T = t_high + t_low
```

| Symbol   | Meaning                          |
|----------|----------------------------------|
| `T`      | Total time period of one cycle   |
| `t_high` | Duration the signal is HIGH      |
| `t_low`  | Duration the signal is LOW       |

> **Analogy:** Just like the period of a wave in physics, the clock period measures the time for one full oscillation.

---

### Frequency

**Frequency** (`f`) is the number of complete clock cycles per second. It is the inverse of the time period:

```
f = 1 / T
```

| Unit       | Description                          |
|------------|--------------------------------------|
| Hz         | Cycles per second                    |
| kHz        | 10³ cycles per second                |
| MHz        | 10⁶ cycles per second (common in ICs)|
| GHz        | 10⁹ cycles per second (modern CPUs)  |

>  **Example:** A clock with a period of `10 ns` has a frequency of `1 / 10×10⁻⁹ = 100 MHz`.

---

### Duty Cycle

The **duty cycle** expresses the proportion of time the clock signal is in the HIGH state relative to the total period:

```
Duty Cycle = t_high / T  ×  100%
```

| Duty Cycle | Behavior                                      |
|------------|-----------------------------------------------|
| 50%        | Signal is HIGH and LOW for equal durations    |
| > 50%      | Signal spends more time HIGH than LOW         |
| < 50%      | Signal spends more time LOW than HIGH         |

>  **Note:** Most digital systems use a **50% duty cycle** clock for simplicity, but other ratios are used in specific applications such as PWM (Pulse Width Modulation).

---

## Clock in Sequential Circuits

Unlike **combinational circuits** (which respond immediately to inputs), **sequential circuits** have memory — their outputs depend on both current inputs *and* past state. The clock is essential for controlling *when* these state changes occur.

### Clock as an Input

The clock signal can be passed directly as an input to a module. The circuit then only updates or evaluates its logic **when the clock is HIGH (1)**:
![Clock input Diagram](/ClockInputDiagram.png)

### Edge-Triggered Design

Rather than being active for the entire HIGH phase, circuits can be designed to respond only at a specific **transition** of the clock:

| Trigger Type        | Activates On...                          |
|---------------------|------------------------------------------|
| **Rising Edge**     | Clock transitions from LOW → HIGH        |
| **Falling Edge**    | Clock transitions from HIGH → LOW        |
| **Level-Triggered** | Active while clock is HIGH (or LOW)      |

Edge-triggered designs are preferred in most modern sequential circuits because they provide **precise, instantaneous synchronization** — reducing the risk of timing errors or glitches caused by signal instability.

```
Rising Edge:          Falling Edge:
     ↑                      ↓
 ____|‾‾‾‾           ‾‾‾‾|____
```

---

## Clock Signal Diagram

Below is a complete annotated diagram of a clock signal illustrating all key properties:

```
Voltage
  |
1 |    |‾‾‾‾‾‾|      |‾‾‾‾‾‾|      |‾‾‾‾‾‾|
  |    |      |      |      |      |      |
0 |____|      |______|      |______|      |______> Time
       <----->        
       t_high  t_low
       <----------T--------->
       (One full period)

  ↑             ↑
Rising        Falling
 Edge          Edge
```

- **`T`** = Full period = `t_high + t_low`
- **`f`** = `1 / T`
- **Duty Cycle** = `t_high / T × 100%`

![ClockDiagram](/ClockSignalDiagram.png)
---

## Summary Table

| Property    | Formula                        | Description                                    |
|-------------|--------------------------------|------------------------------------------------|
| Time Period  | `T = t_high + t_low`           | Duration of one full clock cycle               |
| Frequency   | `f = 1 / T`                    | Number of cycles per second                    |
| Duty Cycle  | `D = (t_high / T) × 100%`      | Percentage of time the signal is HIGH          |
| Rising Edge | `0 → 1` transition             | Common trigger point for sequential logic      |
| Falling Edge| `1 → 0` transition             | Alternative trigger point for sequential logic |

---

## Key Takeaways

- A clock is a **periodic signal** cycling between LOW and HIGH states.
- **Period** and **frequency** are inversely related: `f = 1/T`.
- **Duty cycle** measures the fraction of time the signal is HIGH.
- Clocks **synchronize** sequential circuits, controlling when state updates occur.
- Circuits can be **level-triggered** (active while HIGH/LOW) or **edge-triggered** (active at a transition).
- **Edge-triggered** designs are more precise and widely used in modern digital systems.

---

> **Next Steps:** Learn about flip-flops, registers, and finite state machines (FSMs) — all of which rely on clock signals for synchronized operation.


# Triggering Methods in Flip-Flops

> How clock signals activate memory elements in sequential circuits.

---

## Table of Contents

- [Overview](#overview)
- [Sequential Circuit Structure](#sequential-circuit-structure)
- [The Clock as a Control Input](#the-clock-as-a-control-input)
- [Triggering Methods](#triggering-methods)
  - [Level Triggering](#level-triggering)
  - [Edge Triggering](#edge-triggering)
    - [Rising Edge (Positive Edge)](#rising-edge-positive-edge)
    - [Falling Edge (Negative Edge)](#falling-edge-negative-edge)
- [Comparison Table](#comparison-table)
- [Key Takeaways](#key-takeaways)

---

## Overview

In sequential circuits, a **memory element** (either a latch or a flip-flop) stores the output of a combinational circuit. To control *when* this stored value is updated, the memory element receives a **clock pulse** as its control input. The process of defining exactly when the clock pulse activates the memory element is called **triggering**.

---

## Sequential Circuit Structure

A sequential circuit consists of two main parts:

1. **Combinational Logic** — processes current inputs and produces an output.
2. **Memory Element (Latch or Flip-Flop)** — stores that output and feeds it back as state.

```
         ┌──────────────────┐        ┌──────────────────┐
Inputs ──►  Combinational   ├───────►  Memory Element   ├──► Outputs
         │     Circuit      │        │ (Latch/Flip-Flop)│
         └──────────────────┘        └────────┬─────────┘
                  ▲                           │
                  └───────────────────────────┘
                          (State feedback)
                                   ▲
                              Clock Pulse
```

![Clock Trigger Diagram](/ClockTriggeringDiagram.png)

The **clock pulse** acts as the control input to the memory element, determining when it reads and stores new data.

---

## The Clock as a Control Input

A clock signal is a periodic waveform alternating between LOW (0) and HIGH (1). To use it as a control signal, specific points on this waveform are identified as **trigger points** — the moments at which the memory element is activated and allowed to latch new data.

```
        ___         ___         ___
       |   |       |   |       |   |
_______|   |_______|   |_______|   |_______

        ↑   ↓       ↑   ↓       ↑   ↓
      Rising Falling  (trigger points)
       Edge  Edge
```

There are two broad categories of triggering: **level triggering** and **edge triggering**.

---

## Triggering Methods

### Level Triggering

In **level triggering**, the memory element is activated and remains **transparent** (continuously accepting new data) for as long as the clock signal stays in the HIGH state.

```
Clock:   ___________             ___________
        |           |           |           |
________|           |___________|           |________

        ←  ACTIVE  →            ←  ACTIVE  →
        (latch is transparent while HIGH)
```

- The memory element updates **continuously** while the clock is HIGH.
- This can cause unintended state changes if the input data changes during the active window — a problem known as a **transparency hazard**.
- Latches are the most common level-triggered memory elements.

> **Use case:** Simpler circuits where continuous data flow during the HIGH phase is acceptable.

---

### Edge Triggering

In **edge triggering**, the memory element is activated only at the **instant** the clock signal transitions between states — not for the entire duration it is HIGH or LOW. This gives much more precise control over when data is captured.

There are two types of edge triggering:

#### Rising Edge (Positive Edge)

The memory element is triggered at the **LOW → HIGH** transition of the clock.

```
        ___         ___
       |   |       |   |
_______|   |_______|   |_______

       ↑               ↑
  Triggered         Triggered
  (data captured at this exact moment)
```

- Also called **positive-edge triggering**.
- The circuit captures data at the rising edge and ignores all other changes until the next rising edge.

#### Falling Edge (Negative Edge)

The memory element is triggered at the **HIGH → LOW** transition of the clock.

```
        ___         ___
       |   |       |   |
_______|   |_______|   |_______

           ↓               ↓
      Triggered         Triggered
      (data captured at this exact moment)
```

- Also called **negative-edge triggering**.
- Behaves the same as rising-edge triggering, but activates on the opposite transition.

> **Why edge triggering is preferred:** Because activation happens at a single precise instant rather than over an entire phase, edge-triggered designs are far less susceptible to timing errors and glitches. This makes them the dominant choice in modern flip-flop and register designs.

---

## Comparison Table

| Property            | Level Triggering                      | Rising Edge Triggering         | Falling Edge Triggering        |
|---------------------|---------------------------------------|--------------------------------|--------------------------------|
| **Activated when**  | Clock is HIGH                         | Clock transitions LOW → HIGH   | Clock transitions HIGH → LOW   |
| **Active duration** | Entire HIGH phase                     | Instantaneous                  | Instantaneous                  |
| **Memory element**  | Latch                                 | Flip-Flop                      | Flip-Flop                      |
| **Risk of glitch**  | Higher (transparency hazard)          | Low                            | Low                            |
| **Common use**      | Simpler/asynchronous designs          | Most modern digital systems    | Specific synchronization needs |

---

## Key Takeaways

- Sequential circuits use a **clock pulse** as a control input to the memory element (latch or flip-flop).
- **Trigger points** define the exact moments the clock activates the memory element.
- **Level triggering** activates the memory element for the entire HIGH phase — used in latches.
- **Edge triggering** activates at a specific transition (rising or falling) — used in flip-flops.
- **Edge-triggered** designs offer more precise synchronization and are preferred in modern digital systems.

---

> **Next Steps:** Explore specific flip-flop types (SR, D, JK, T) and how each responds to rising and falling edge triggers.
