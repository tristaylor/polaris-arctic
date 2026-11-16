"""Write an explicitly synthetic POLARIS mission to a new SQLite file."""
import argparse
import hashlib
import json
from pathlib import Path
import sqlite3

MIGRATION = Path(__file__).resolve().parents[1] / "db" / "001.sql"
MISSION = "synthetic-001"
TURBIDITY = (2, 3, 14, 16, 4, 15)
THRESHOLD = 10


def time_utc(second):
    return f"2000-01-01T00:00:{second:02d}Z"


def simulate(connection):
    connection.executescript(MIGRATION.read_text())
    connection.execute("INSERT INTO missions VALUES (?,?,?,?,1)",
                       (MISSION, "synthetic-device", time_utc(0), time_utc(59)))
    digest = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    connection.execute("INSERT INTO provenance VALUES (?,?,?,?,?)",
                       (MISSION, "generator", "synthetic generator", "1", digest))
    connection.execute("INSERT INTO calibrations VALUES (?,?,?,?,?,?,?)",
                       (MISSION, "sim-cal", "turbidity", time_utc(0), time_utc(59),
                        "synthetic identity transform", "fabricated reference"))
    for slot in ("A", "B"):
        connection.execute("INSERT INTO cartridges VALUES (?,?,?,?,?)",
                           (MISSION, slot, f"synthetic-{slot}", "sim-lot", "water vial"))

    used_slots = set()
    previous = 0
    for index, value in enumerate(TURBIDITY):
        stamp = time_utc(8 * index)
        observation = f"obs-{index}"
        connection.execute("INSERT INTO observations VALUES (?,?,?,?,?,?,?,?,?)",
                           (MISSION, observation, stamp, "turbidity", value, value,
                            "NTU", "sim-cal", "generator"))
        crossing = previous < THRESHOLD <= value
        previous = value
        if index and not crossing:
            continue

        slot = "A" if index == 0 else "B"
        event = f"evt-{index}"
        kind = "baseline" if index == 0 else "threshold_crossing"
        reason = "slot already used" if slot in used_slots else "synthetic draw authorized"
        connection.execute("INSERT INTO events VALUES (?,?,?,?,?,?)",
                           (MISSION, event, stamp, kind, reason, observation))
        if slot in used_slots:
            continue

        used_slots.add(slot)
        sample = f"sample-{slot}"
        collected = time_utc(8 * index + 2)
        connection.execute("INSERT INTO samples VALUES (?,?,?,?,?,?,?)",
                           (MISSION, sample, event, slot, collected, 250, "collected"))
        connection.execute("INSERT INTO qc VALUES (?,?,?,?,?,?,?)",
                           (MISSION, sample, "qc-1", collected, "sim-v1", "pass",
                            "fabricated volume within synthetic limits"))
        connection.execute("INSERT INTO custody VALUES (?,?,?,?,?,?,?)",
                           (MISSION, sample, "transfer-1", collected, "sim-device",
                            "sim-receiver", "fabricated intact seal"))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    path = parser.parse_args().output
    try:
        path.touch(exist_ok=False)
    except FileExistsError:
        parser.error(f"output already exists: {path}")

    with sqlite3.connect(path) as connection:
        simulate(connection)
        rows = connection.execute("""
            SELECT m.synthetic, e.kind, e.reason, s.id, s.volume_ml
            FROM events e JOIN missions m ON m.id = e.mission_id
            LEFT JOIN samples s ON s.mission_id = e.mission_id AND s.event_id = e.id
            ORDER BY e.time_utc, e.id
        """).fetchall()
    print(json.dumps({"synthetic": True, "columns": [
        "synthetic", "event_kind", "reason", "sample_id", "volume_ml"
    ], "events": rows}, indent=2))


if __name__ == "__main__":
    main()
