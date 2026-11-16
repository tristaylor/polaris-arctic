# POLARIS bench prototype · $500–$750 planning build

This is a supervised, room-temperature bench demonstrator for two water draws. It is not a field-ready or Arctic-rated instrument. Prices are planning allowances in USD, not vendor quotes. Check current prices and electrical/fluid compatibility before ordering. Reuse a lab tank, scale, bench power supply and hand tools where available. If those must be purchased, the budget will exceed this range.

## Parts list

| Part | Qty | Allowance | Notes |
|---|---:|---:|---|
| ESP32 development board and USB cable | 1 | $20–35 | Local controller and serial logging |
| Turbidity probe with compatible interface | 1 | $35–70 | Confirm output voltage and interface before wiring |
| Waterproof temperature probe and interface | 1 | $10–20 | Optional in first functional draw test |
| 12 V peristaltic pump | 1 | $25–45 | Select compatible tubing and expected flow |
| Two-way pinch valve or manual clamp set | 1 | $20–45 | Route flow to one of two sample lines |
| Tubing, barbed fittings, inlet strainer | 1 lot | $25–45 | Use compatible, replaceable wetted tubing |
| Two reusable holders and sample vials | 2 | $20–40 | Label slots A and B; use clean vials |
| MOSFET driver, flyback diode, fuse, switch, wiring | 1 lot | $20–35 | Pump supply is separate from controller USB |
| Breadboard or perfboard, terminal blocks, enclosure | 1 lot | $25–45 | Keep wet and electrical areas separated |
| USB power bank or protected 12 V supply | 1 | $20–35 | Supervised bench power only; do not leave unattended |
| Scale access and containers | borrowed | $0 | Needed for gravimetric volume check |
| Contingency and shipping | — | $40–80 | Prices fluctuate; avoid ordering until interfaces are checked |
| **Estimated total** | | **$260–495** | Before labor, tax, borrowed equipment, or optional upgrades |

The lower estimate leaves room for unpriced items and substitution. A $500–$750 cash cap can include a purchased scale, spare tubing, better enclosure and extra valves. Obtain itemized quotes before treating this as a grant budget. Avoid buying both a flow sensor and a scale for the first demonstrator. Use the scale as the reference and add flow sensing only if the experiment needs unattended volume measurement.

## Build sequence

1. **Define the bench test.** Use clean water and a tank. The minimum demonstration is one scheduled baseline draw into slot A and one manually initiated or simulated turbidity-triggered draw into slot B. Record what is automatic and what remains operator controlled.
2. **Check interfaces before powering anything.** Confirm probe supply and output levels, pump voltage and current, and valve type. Choose drivers rated for the measured load. Keep the pump supply switched and fused. Have a technically qualified supervisor review wiring.
3. **Assemble the wet path without electronics.** Secure the inlet, pump, tubing, selector, and two labeled outlets. Run water through each path with the pump disconnected from the controller. Check direction, leaks, and that each outlet reaches only its assigned vial.
4. **Wire the controller and sensors.** Connect the turbidity probe to a compatible interface and the temperature probe if included. Log raw readings to serial first. Do not connect a sensor output to a microcontroller pin until its voltage range is verified.
5. **Add pump control.** Use a suitable MOSFET or relay driver, flyback protection where required, and fuse. Keep low-voltage logic separate from wet fittings. Start with a short manual pulse and verify the pump stops when commanded.
6. **Implement conservative control.** Log timestamp, raw turbidity, selected slot, command, start/stop, and fault. For the first run, use a manual trigger or a threshold that requires several consecutive readings and hysteresis. Prevent slot reuse in software. Stop on timeout or operator stop.
7. **Measure delivered volume.** Tare each vial on a borrowed scale, run a timed draw, then weigh it again. For water near room temperature, convert mass to approximate volume using a stated density assumption. Repeat at least ten draws per line and report every result and failure.
8. **Run the paired demonstration.** Collect a baseline draw, introduce a safe, nonhazardous turbidity change in the tank, and collect the second draw. Use a separate reference reading or manual observation to confirm the condition changed. This tests the prototype workflow, not environmental science or eDNA performance.
9. **Check blanks and carryover.** Run clean water through the line before and after a visibly turbid test. Record turbidity and inspect for retained particles. Replace or clean tubing as specified. Do not describe samples as scientifically valid until a lab-defined protocol supports that claim.
10. **Document and decide.** Save wiring diagram, parts and actual receipts, firmware revision, raw logs, trial counts, failures, and measured volumes. Decide whether to add automatic flow measurement, cold tests, or a more reliable enclosure before requesting funds for the next stage.

## Stop conditions and next stage

Stop if there is a leak near energized connections, unexpected pump activation, a probe voltage mismatch, overheating, or a line that cannot be reliably isolated. Keep testing supervised and on a contained bench. This plan does not establish cold tolerance, waterproofing, unattended safety, sample preservation, Arctic deployment permission, or reliable field performance. The separate [Phase I proposal and $10,000 budget](one-page.md) fund engineering time, reference tests, cold and fault tests, partner planning, and a documented go/no-go decision.
