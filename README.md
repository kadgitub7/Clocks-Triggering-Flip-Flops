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

# Latch vs Flip-Flop: Differences and Triggering

> Understanding how latches and flip-flops differ in structure and when each one responds to its control input.

---

## Table of Contents

- [Overview](#overview)
- [Shared Structure](#shared-structure)
- [What Makes Them Different?](#what-makes-them-different)
- [Latch — Level Triggering](#latch--level-triggering)
- [Flip-Flop — Edge Triggering](#flip-flop--edge-triggering)
- [Comparison Table](#comparison-table)
- [Key Takeaways](#key-takeaways)

---

## Overview

Both latches and flip-flops are **memory elements** used in sequential digital circuits. They store a single bit of state and feed it back into the combinational logic of a circuit. Despite their similar purpose, the key distinction lies in **when** they update their stored value — which is controlled by a shared middle input connected to both NAND gates in the circuit.

---

## Shared Structure

A latch and a flip-flop share the same fundamental circuit structure. At the core, both use **two NAND gates** with a shared middle control input. This middle input is the single structural element that defines whether the circuit behaves as a latch or a flip-flop.

```
         ┌─────────────┐
  S ────►│             │
         │  NAND Gate  ├──────► Q
  ──────►│             │
         └─────────────┘
              ▲
         [Middle Input]       ← This determines Latch vs Flip-Flop
              ▼
         ┌─────────────┐
  ──────►│             │
         │  NAND Gate  ├──────► Q'
  R ────►│             │
         └─────────────┘
```
![Middle Input Diagram](/LatchCircuitDiagram.png)

> The middle input, shared between both NAND gates, is either an **Enable** signal (latch) or a **Clock** signal (flip-flop).

---

## Latch — Level Triggering

When the middle input is an **Enable** signal, the circuit operates as a **latch**. Latches use **level triggering**, meaning the circuit is active and transparent for as long as the enable signal is in a particular state.

### How it works

- The latch is **activated when the Enable signal is LOW (0)**.
- While the enable is LOW, the latch continuously accepts and reflects new input data — it is said to be **transparent**.
- When the enable returns HIGH, the latch **holds** its last captured value.

```
Enable:   ‾‾‾‾‾‾|___________|‾‾‾‾‾‾
                 ← ACTIVE  →
                 (Latch is transparent; data flows through)
```

> **Risk:** Because the latch remains open for the entire active phase, any change in input data during that window is immediately reflected in the output. This can lead to unintended state changes — known as a **transparency hazard**.

---

## Flip-Flop — Edge Triggering

When the middle input is replaced by a **Clock** signal, the circuit becomes a **flip-flop**. Flip-flops use **edge triggering**, meaning they only respond at the precise instant the clock transitions between states.

### How it works

- The flip-flop captures input data at a specific **clock edge** — either rising or falling.
- Outside of that brief transition moment, the flip-flop **ignores** any changes to the input.
- This provides far more precise and predictable control over when state updates occur.

#### Rising Edge (Positive Edge)

The flip-flop shifts at the **LOW → HIGH** transition of the clock.

```
        ___         ___
       |   |       |   |
_______|   |_______|   |_______

       ↑               ↑
  Data captured     Data captured
  (rising edge)     (rising edge)
```

#### Falling Edge (Negative Edge)

The flip-flop shifts at the **HIGH → LOW** transition of the clock.

```
        ___         ___
       |   |       |   |
_______|   |_______|   |_______

           ↓               ↓
      Data captured     Data captured
      (falling edge)    (falling edge)
```

> **Why this is preferred:** Edge triggering activates at a single, instantaneous moment rather than over an entire phase. This makes flip-flops far less susceptible to timing errors and glitches, and is the dominant design choice in modern sequential circuits.

---

## Comparison Table

| Property              | Latch                              | Flip-Flop                            |
|-----------------------|------------------------------------|--------------------------------------|
| **Middle input**      | Enable signal                      | Clock signal                         |
| **Triggering method** | Level triggering                   | Edge triggering                      |
| **Active when**       | Enable is LOW                      | Clock transitions (rising or falling)|
| **Active duration**   | Entire LOW phase of Enable         | Instantaneous (at edge only)         |
| **Transparency**      | Transparent while Enable is LOW    | Not transparent — captures at edge   |
| **Risk**              | Transparency hazard                | Low — precise activation             |
| **Common use**        | Simpler or asynchronous designs    | Modern synchronous digital systems   |

---

## Key Takeaways

- Latches and flip-flops share the **same NAND gate structure** — the middle shared input is what sets them apart.
- A **latch** uses an **Enable** signal and is **level-triggered**: active while the enable is LOW, transparent throughout that window.
- A **flip-flop** uses a **Clock** signal and is **edge-triggered**: it captures data only at the moment of a clock transition (rising or falling edge).
- Edge triggering makes flip-flops **more precise and reliable** than latches in synchronous designs.
- Modern digital systems overwhelmingly prefer **flip-flops** due to their immunity to transparency hazards and their compatibility with clocked, synchronous design methodologies.

---

> **Next Steps:** Explore specific flip-flop types — SR, D, JK, and T — and how each one responds to clock edges in a sequential circuit.

# Introduction to SR Flip-Flop

> A foundational memory element in sequential logic — understanding how the SR flip-flop stores and controls state using a clock signal.

---

## Table of Contents

- [Overview](#overview)
- [Circuit Diagram](#circuit-diagram)
- [Relationship to the SR NAND Latch](#relationship-to-the-sr-nand-latch)
- [Internal Signal Derivation](#internal-signal-derivation)
- [Truth Tables](#truth-tables)
  - [SR NAND Latch Truth Table](#sr-nand-latch-truth-table)
  - [SR Flip-Flop Truth Table](#sr-flip-flop-truth-table)
- [Key Takeaways](#key-takeaways)

---

## Overview

The **SR Flip-Flop** is a clocked memory element built upon the SR NAND latch. Like all flip-flops, it is **edge-triggered** — it captures and stores state only at a specific transition of the clock signal, rather than remaining continuously transparent like a latch.

The SR flip-flop introduces a **clock input (Clk)** that gates the S and R signals before they reach the underlying NAND latch structure. This ensures that state changes only occur when the clock is active, making the circuit suitable for use in synchronous digital systems.

---

## Circuit Diagram

![SR Flip Flop Diagram](/SRFlipFlopDiagram.png)

> The SR flip-flop circuit extends the SR NAND latch by adding two input NAND gates — one for S and one for R — both controlled by the clock signal.

---

## Relationship to the SR NAND Latch

The internal storage component of the SR flip-flop is **identical in structure to the SR NAND latch**. The key difference is that the flip-flop wraps the latch with clock-gating logic, so the latch only sees new data at the appropriate clock moment.

| Property              | SR NAND Latch              | SR Flip-Flop                       |
|-----------------------|----------------------------|------------------------------------|
| **Middle input**      | Enable signal              | Clock signal                       |
| **Triggering method** | Level triggering           | Edge triggering                    |
| **Active when**       | Enable is LOW              | Clock transitions (rising/falling) |
| **Transparency risk** | Yes                        | No                                 |
| **Core structure**    | Two cross-coupled NANDs    | Same — plus clock-gating NANDs     |

---

## Internal Signal Derivation

The SR flip-flop generates two intermediate signals — **S\*** and **R\*** — by ANDing each input with the clock, then inverting (i.e., a NAND operation):

```
S* = (S & Clk)' = S' + Clk'
R* = (R & Clk)' = R' + Clk'
```

These intermediate signals are fed directly into the SR NAND latch. When `Clk = 0`, both S\* and R\* are forced HIGH regardless of S and R, which holds the latch in its **memory state**. When `Clk = 1`, the values of S and R propagate through and control the latch normally.

---

## Truth Tables

### SR NAND Latch Truth Table

This is the truth table for the underlying SR NAND latch, driven by S\* and R\*:

| S\* | R\* | Q        | Q'       |
|-----|-----|----------|----------|
| 0   | 0   | Not used | Not used |
| 0   | 1   | 1        | 0        |
| 1   | 0   | 0        | 1        |
| 1   | 1   | Memory   | Memory   |

> **Note:** The `S* = 0, R* = 0` condition is **forbidden** — it drives both Q and Q' HIGH simultaneously, violating the complementary output requirement.

---

### SR Flip-Flop Truth Table

By substituting the derived expressions for S\* and R\* back through the latch truth table, the full behaviour of the SR flip-flop (in terms of Clk, S, and R) is:

| Clk | S | R | Q        | Q'       |
|-----|---|---|----------|----------|
| 0   | X | X | Memory   | Memory   |
| 1   | 0 | 0 | Memory   | Memory   |
| 1   | 0 | 1 | 0        | 1        |
| 1   | 1 | 0 | 1        | 0        |
| 1   | 1 | 1 | Not used | Not used |

**Behaviour summary:**
- `Clk = 0` — The flip-flop is **inactive**; inputs S and R are ignored (X = don't care) and the previous output is held.
- `Clk = 1, S = 0, R = 0` — **No change**; the flip-flop retains its current state.
- `Clk = 1, S = 0, R = 1` — **Reset**; Q is driven LOW.
- `Clk = 1, S = 1, R = 0` — **Set**; Q is driven HIGH.
- `Clk = 1, S = 1, R = 1` — **Forbidden**; this state is not used.

---

## Key Takeaways

- The SR flip-flop is built on the **same NAND gate structure** as the SR NAND latch, extended with clock-gating inputs.
- A **clock input** controls when S and R are allowed to affect the output, replacing the direct enable of a latch.
- When `Clk = 0`, the flip-flop **holds its state** regardless of S and R.
- When `Clk = 1`, the flip-flop **behaves like the SR NAND latch** — Set, Reset, Memory, or forbidden.
- The `S = 1, R = 1` condition remains **forbidden**, as it produces an undefined output state.
- The use of a clock signal makes the SR flip-flop suitable for **synchronous sequential circuit design**.

---

> **Next Steps:** Explore the **D Flip-Flop**, which eliminates the forbidden state by tying R to the complement of S, simplifying the SR flip-flop into a single-input memory element.

# SR Flip-Flop: Truth Table, Characteristic Table & Excitation Table

> A complete reference for the SR Flip-Flop covering all three standard representations used in sequential logic analysis and design.

---

## Table of Contents

- [Overview](#overview)
- [Truth Table](#truth-table)
- [Characteristic Table](#characteristic-table)
- [Excitation Table](#excitation-table)
- [Karnaugh Map (K-Map)](#karnaugh-map-k-map)
- [Key Takeaways](#key-takeaways)

---

## Overview

The **SR Flip-Flop** is a clocked, edge-triggered memory element that stores a single bit of state. It has two inputs — **S (Set)** and **R (Reset)** — along with a **clock (Clk)** input that gates when state changes are allowed to occur.

Three table formats are used to fully describe a flip-flop's behaviour:

| Table Type            | Purpose                                                                 |
|-----------------------|-------------------------------------------------------------------------|
| **Truth Table**       | Shows the next state given all possible input combinations, including Clk |
| **Characteristic Table** | Describes next state from current state and inputs (assumes Clk = HIGH) |
| **Excitation Table**  | Determines what inputs are required to achieve a desired state transition |

---

## Truth Table

The **truth table** captures the full behaviour of the SR flip-flop across all possible combinations of Clk, S, and R.

- **Qn** = Present state
- **Qn+1** = Next state
- **X** = Don't care (input has no effect)

| Clk | S | R | Qn+1    |
|-----|---|---|---------|
| 0   | X | X | Qn      |
| 1   | 0 | 0 | Qn      |
| 1   | 0 | 1 | 0       |
| 1   | 1 | 0 | 1       |
| 1   | 1 | 1 | Invalid |

**Behaviour summary:**
- `Clk = 0` — Flip-flop is **inactive**; S and R are ignored and the previous state is held.
- `Clk = 1, S = 0, R = 0` — **No change**; flip-flop retains current state.
- `Clk = 1, S = 0, R = 1` — **Reset**; Q is driven LOW.
- `Clk = 1, S = 1, R = 0` — **Set**; Q is driven HIGH.
- `Clk = 1, S = 1, R = 1` — **Forbidden**; produces an undefined output state.

---

## Characteristic Table

The **characteristic table** describes what the next state will be, given the present state and inputs. It is used to analyse a flip-flop's logical behaviour and is derived from the truth table **assuming Clk is HIGH** for all cases.

| Qn | S | R | Qn+1    |
|----|---|---|---------|
| 0  | 0 | 0 | 0       |
| 0  | 0 | 1 | 0       |
| 0  | 1 | 0 | 1       |
| 0  | 1 | 1 | Invalid |
| 1  | 0 | 0 | 1       |
| 1  | 0 | 1 | 0       |
| 1  | 1 | 0 | 1       |
| 1  | 1 | 1 | Invalid |

> **Note:** The `S = 1, R = 1` condition is **forbidden** regardless of present state, as it drives both Q and Q' HIGH simultaneously, violating the complementary output requirement.

---

## Excitation Table

The **excitation table** is the inverse of the characteristic table. Instead of asking *"what is the next state given the inputs?"*, it answers *"what inputs are required to achieve a specific state transition?"*

This is particularly useful in the **design phase** of sequential circuits, where a desired sequence of states is known and the required flip-flop inputs must be determined.

| Qn | Qn+1 | S | R |
|----|------|---|---|
| 0  | 0    | 0 | X |
| 0  | 1    | 1 | 0 |
| 1  | 0    | 0 | 1 |
| 1  | 1    | X | 0 |

**Interpretation:**
- **0 → 0**: S must be 0 (no set); R is a don't care since Q is already LOW.
- **0 → 1**: S must be 1 to set the output; R must be 0 to avoid conflict.
- **1 → 0**: R must be 1 to reset the output; S must be 0 to avoid conflict.
- **1 → 1**: R must be 0 (no reset); S is a don't care since Q is already HIGH.

---

## Karnaugh Map (K-Map)

Using the excitation table, a **K-Map** can be constructed to derive a simplified Boolean expression for Qn+1 in terms of S, R, and Qn.

### K-Map for Qn+1

| Qn \ SR | 00 | 01 | 11 | 10 |
|---------|----|----|-----|-----|
| **0**   | 0  | 0  | X  | 1  |
| **1**   | 1  | 0  | X  | 1  |

### Groupings

Two groups can be identified from the K-Map:

- **Group 1 (size 4):** Cells covering SR = `11` (don't cares) and SR = `10` for both Qn = 0 and Qn = 1 → simplifies to **S**
- **Group 2 (size 2):** Cells covering Qn = 1 with SR = `00` and SR = `10` → simplifies to **Qn · R'**

### Resulting Expression

```
Qn+1 = S + (Qn · R')
```

This is the **characteristic equation** of the SR flip-flop. It confirms:
- Setting S forces Q HIGH.
- Q remains HIGH if it was already HIGH and R is not asserted.
- Asserting R drives Q LOW regardless of its current state.

---

## Key Takeaways

- The **truth table** captures the full input/output behaviour of the SR flip-flop, including the effect of the clock.
- The **characteristic table** (Clk assumed HIGH) describes next-state logic from current state and inputs — used for analysis.
- The **excitation table** inverts the characteristic table to determine required inputs for a target state transition — used for design.
- The **K-Map** derived from the excitation table yields the characteristic equation: `Qn+1 = S + (Qn · R')`.
- The condition `S = 1, R = 1` is **always forbidden** and must be avoided in circuit design.

---

> **Next Steps:** Explore the **D Flip-Flop**, which eliminates the forbidden state by tying R to the complement of S, and the **JK Flip-Flop**, which resolves the forbidden state by defining `J = K = 1` as a toggle operation.
