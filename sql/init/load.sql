--
-- load.sql
-- Data load for SSB Tables.
-- (Data format: dbgen output, (https://github.com/electrum/ssb-dbgen/)
--
TRUNCATE customer, dates, part, supplier, lineorder;
COPY customer FROM '/tmp/customer.tbl' DELIMITER '|';
COPY dates FROM '/tmp/date.tbl' DELIMITER '|';
COPY part FROM '/tmp/part.tbl' DELIMITER '|';
COPY supplier FROM '/tmp/supplier.tbl' DELIMITER '|';
COPY lineorder FROM '/tmp/lineorder.tbl' DELIMITER '|';
