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

-- Run bucket-pop.py to populate the table then ...

TRACING ON

select * from time_bucket where tx_hour = '2017-12-01T17';

/*

Tracing session: d432c6a0-d820-11e7-9bc7-11ccb9bf63cc

 activity                                                                                         | timestamp                  | source    | source_elapsed | client
--------------------------------------------------------------------------------------------------+----------------------------+-----------+----------------+-----------
                                                                               Execute CQL3 query | 2017-12-03 11:55:16.874000 | 127.0.0.1 |              0 | 127.0.0.1
 Parsing select * from time_bucket where tx_hour = '2017-12-01T17'; [Native-Transport-Requests-1] | 2017-12-03 11:55:16.874000 | 127.0.0.1 |            128 | 127.0.0.1
                                                Preparing statement [Native-Transport-Requests-1] | 2017-12-03 11:55:16.875000 | 127.0.0.1 |            259 | 127.0.0.1
                                               Read-repair DC_LOCAL [Native-Transport-Requests-1] | 2017-12-03 11:55:16.875000 | 127.0.0.1 |            449 | 127.0.0.1
                                    Executing single-partition query on time_bucket [ReadStage-3] | 2017-12-03 11:55:16.875000 | 127.0.0.1 |            551 | 127.0.0.1
                                                       Acquiring sstable references [ReadStage-3] | 2017-12-03 11:55:16.875000 | 127.0.0.1 |            635 | 127.0.0.1
          Skipped 0/0 non-slice-intersecting sstables, included 0 due to tombstones [ReadStage-3] | 2017-12-03 11:55:16.875000 | 127.0.0.1 |            771 | 127.0.0.1
                                          Merged data from memtables and 0 sstables [ReadStage-3] | 2017-12-03 11:55:16.875000 | 127.0.0.1 |           1211 | 127.0.0.1
                                                Read 100 live and 0 tombstone cells [ReadStage-3] | 2017-12-03 11:55:16.876000 | 127.0.0.1 |           1379 | 127.0.0.1
                                                                                 Request complete | 2017-12-03 11:55:16.875779 | 127.0.0.1 |           1779 | 127.0.0.1
*/


select * from time_bucket where tx_hour = '2017-12-01T17' and tx_ts > '2017-12-01T17:13:02';


 activity                                                                                                                           | timestamp                  | source    | source_elapsed | client
------------------------------------------------------------------------------------------------------------------------------------+----------------------------+-----------+----------------+-----------
                                                                                                                 Execute CQL3 query | 2017-12-03 11:56:12.044000 | 127.0.0.1 |              0 | 127.0.0.1
 Parsing select * from time_bucket where tx_hour = '2017-12-01T17' and tx_ts > '2017-12-01T17:13:02'; [Native-Transport-Requests-1] | 2017-12-03 11:56:12.045000 | 127.0.0.1 |            137 | 127.0.0.1
                                                                                  Preparing statement [Native-Transport-Requests-1] | 2017-12-03 11:56:12.045000 | 127.0.0.1 |            283 | 127.0.0.1
                                                                      Executing single-partition query on time_bucket [ReadStage-2] | 2017-12-03 11:56:12.045000 | 127.0.0.1 |            577 | 127.0.0.1
                                                                                         Acquiring sstable references [ReadStage-2] | 2017-12-03 11:56:12.045000 | 127.0.0.1 |            626 | 127.0.0.1
                                            Skipped 0/0 non-slice-intersecting sstables, included 0 due to tombstones [ReadStage-2] | 2017-12-03 11:56:12.045000 | 127.0.0.1 |            694 | 127.0.0.1
                                                                            Merged data from memtables and 0 sstables [ReadStage-2] | 2017-12-03 11:56:12.045000 | 127.0.0.1 |            868 | 127.0.0.1
                                                                                   Read 51 live and 0 tombstone cells [ReadStage-2] | 2017-12-03 11:56:12.045001 | 127.0.0.1 |            948 | 127.0.0.1
                                                                                                                   Request complete | 2017-12-03 11:56:12.045304 | 127.0.0.1 |           1304 | 127.0.0.1
