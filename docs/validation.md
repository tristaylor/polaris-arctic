# Validation and milestones

All thresholds are proposed engineering gates. Freeze protocols, trial counts and exclusion rules before measurement. Report denominators, distributions and confidence intervals where applicable. Preserve failed runs and record the hardware revision, firmware version and fixture settings.

| When | Test and evidence | Proposed gate |
|---|---|---|
| Month 1 | Review cartridge contract, comparator protocol and risk register. Exercise SQLite links and replay fixture. | Deterministic output and rejection of invalid foreign keys. |
| Months 2–3 | Integrate supervised rig. Run 20 normal draws with a gravimetric volume reference. | At least 18 within ±10% of setpoint, with zero leaks. |
| Month 4 | Randomize timing of 20 controlled turbidity pulses and include at least 10 no-pulse trials. Compare event and fixed schedules with equal cartridge counts and a common independent reference trace. | At least 18 pulses sampled during the reference-defined window and at most one false trigger in no-pulse trials. Report paired comparator results and trigger latency. |
| Months 4–5 | Compare sample and manual grab turbidity. Run clean-water blanks and tracer carryover checks after high readings. | Predeclare blank and agreement limits with the lab using instrument uncertainty. Report failures by run order and cartridge lot. |
| Month 5 | Separate cold-air exposure and cold-water operation. Start with +5 °C air and +2 to +4 °C water, then test colder air with a monitored wet path and defined stop point. Inject blocked inlet, disconnected probe, power loss and logging faults. | No unintended pumping or slot reuse. Report elapsed runtime, energy per draw, logged aborts and usable specimens by condition. |
| Month 6 | Publish cost and test report and review field prerequisites. | Advance only after acceptable sample integrity, safe abort behavior and a site-specific review. |

Compute cost per usable sample from amortized hardware, consumables, hands-on labor, calibration, travel, recovery and lab handling divided by accepted samples. Provide assumptions, sensitivity to utilization and an equal-scope comparison with manual or scheduled collection. A zero accepted-sample run has no finite estimate.
