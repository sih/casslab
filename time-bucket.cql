CREATE KEYSPACE IF NOT EXISTS lab
  WITH REPLICATION =
  { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

CREATE TABLE IF NOT EXISTS lab.time_bucket (
  tx_hour text,
  tx_ts text,
  record_id TEXT,
  PRIMARY KEY (tx_hour, tx_ts, record_id)
) WITH CLUSTERING ORDER BY (tx_ts  ASC)
;

/*

Demo cluster key

INSERT INTO lab.time_bucket
(tx_hour, tx_ts, record_id)
VALUES('2017-12-01T17:00:00', '2017-12-01T17:12:34Z', 'one');


INSERT INTO lab.time_bucket
(tx_hour, tx_ts, record_id)
VALUES('2017-12-01T17:00:00', '2017-12-01T17:34:56Z', 'two');


INSERT INTO lab.time_bucket
(tx_hour, tx_ts, record_id)
VALUES('2017-12-01T17:00:00', '2017-12-01T17:34:56Z', 'three');

SELECT * FROM lab.time_bucket;
*/
