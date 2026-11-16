PRAGMA foreign_keys = ON;
BEGIN;
CREATE TABLE missions (
 id TEXT PRIMARY KEY NOT NULL, device TEXT NOT NULL, started_utc TEXT NOT NULL,
 ended_utc TEXT, synthetic INTEGER NOT NULL CHECK(synthetic IN (0,1)),
 CHECK(ended_utc IS NULL OR ended_utc >= started_utc)
);
CREATE TABLE provenance (
 mission_id TEXT NOT NULL REFERENCES missions(id), id TEXT NOT NULL,
 role TEXT NOT NULL, version TEXT NOT NULL, sha256 TEXT NOT NULL CHECK(length(sha256)=64),
 PRIMARY KEY(mission_id,id)
);
CREATE TABLE calibrations (
 mission_id TEXT NOT NULL REFERENCES missions(id), id TEXT NOT NULL,
 sensor TEXT NOT NULL, valid_from TEXT NOT NULL, valid_to TEXT NOT NULL,
 method TEXT NOT NULL, reference TEXT NOT NULL, CHECK(valid_to > valid_from),
 PRIMARY KEY(mission_id,id,sensor)
);
CREATE TABLE observations (
 mission_id TEXT NOT NULL REFERENCES missions(id), id TEXT NOT NULL,
 time_utc TEXT NOT NULL, sensor TEXT NOT NULL, raw_value REAL NOT NULL,
 value REAL, unit TEXT NOT NULL, calibration_id TEXT, source_id TEXT NOT NULL,
 CHECK(value IS NULL OR calibration_id IS NOT NULL),
 PRIMARY KEY(mission_id,id),
 FOREIGN KEY(mission_id,calibration_id,sensor) REFERENCES calibrations(mission_id,id,sensor),
 FOREIGN KEY(mission_id,source_id) REFERENCES provenance(mission_id,id)
);
CREATE TABLE events (
 mission_id TEXT NOT NULL REFERENCES missions(id), id TEXT NOT NULL,
 time_utc TEXT NOT NULL, kind TEXT NOT NULL, reason TEXT NOT NULL,
 observation_id TEXT, PRIMARY KEY(mission_id,id),
 FOREIGN KEY(mission_id,observation_id) REFERENCES observations(mission_id,id)
);
CREATE TABLE cartridges (
 mission_id TEXT NOT NULL REFERENCES missions(id), slot TEXT NOT NULL,
 serial TEXT NOT NULL UNIQUE, lot TEXT NOT NULL, medium TEXT NOT NULL,
 PRIMARY KEY(mission_id,slot)
);
CREATE TABLE samples (
 mission_id TEXT NOT NULL, id TEXT NOT NULL, event_id TEXT NOT NULL,
 slot TEXT NOT NULL, collected_utc TEXT NOT NULL,
 volume_ml REAL NOT NULL CHECK(volume_ml >= 0),
 status TEXT NOT NULL CHECK(status IN ('collected','aborted')),
 PRIMARY KEY(mission_id,id), UNIQUE(mission_id,slot),
 FOREIGN KEY(mission_id,event_id) REFERENCES events(mission_id,id),
 FOREIGN KEY(mission_id,slot) REFERENCES cartridges(mission_id,slot)
);
CREATE TABLE qc (
 mission_id TEXT NOT NULL, sample_id TEXT NOT NULL, id TEXT NOT NULL,
 time_utc TEXT NOT NULL, rule_version TEXT NOT NULL,
 verdict TEXT NOT NULL CHECK(verdict IN ('pass','fail','review')), reason TEXT NOT NULL,
 PRIMARY KEY(mission_id,sample_id,id),
 FOREIGN KEY(mission_id,sample_id) REFERENCES samples(mission_id,id)
);
CREATE TABLE custody (
 mission_id TEXT NOT NULL, sample_id TEXT NOT NULL, id TEXT NOT NULL,
 time_utc TEXT NOT NULL, from_holder TEXT NOT NULL, to_holder TEXT NOT NULL, condition TEXT NOT NULL,
 PRIMARY KEY(mission_id,sample_id,id),
 FOREIGN KEY(mission_id,sample_id) REFERENCES samples(mission_id,id)
);
PRAGMA user_version = 1;
COMMIT;
