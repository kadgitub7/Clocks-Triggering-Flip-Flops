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
