# POLARIS

**An affordable, modular autonomous water-sampling platform designed for Arctic research.**

**Status · Concept and reproducible software demonstration.** The repository contains a design proposal, a SQLite migration, and a deterministic synthetic mission. Physical collection, cold tolerance, field readiness, costs at scale, and scientific performance remain to be measured.

POLARIS will test whether a shore-side instrument can preserve physical evidence of short-lived changes in nearshore water quality using a shared controller and replaceable cartridges. The first prototype pairs one scheduled baseline draw with one turbidity-triggered draw in a supervised tank. Arctic nearshore deployments are a later step, gated by cold testing, a local partner, site authorization, and a recovery plan.

**Phase I request · US$10,000 in direct costs for six months.** The work funds a two-cartridge prototype, paired reference tests, cold and fault testing, and a documented decision on whether to advance to field planning.

| Review path | Material |
|---|---|
| Proposal and funding ask | [One-page summary](docs/one-page.md), [BOM and budget](docs/budget.csv) |
| Scientific rationale | [Gap, prior art and comparison](docs/science.md) |
| Build and data design | [Technical architecture and data dictionary](docs/architecture.md), [SQL migration](db/001.sql) |
| Evidence and feasibility | [Validation and milestones](docs/validation.md), [Field risks and governance](docs/field.md) |

## Reproduce the synthetic mission

Use Python 3.10+ from the repository root. No dependencies are required.

```sh
python3 examples/simulate.py /tmp/polaris-demo.sqlite
python3 examples/simulate.py /tmp/polaris-repeat.sqlite
```

The generator refuses to overwrite an existing file. Each fresh run creates the same logical records and prints a normalized JSON summary. Every row belongs, directly or indirectly, to a mission marked synthetic. The fixture includes a baseline draw, a threshold crossing, a successful event draw, and a later trigger suppressed because its cartridge has been used. Volumes, times, and QC decisions are fabricated. The script exercises the data model and threshold logic. It does not operate hardware.
