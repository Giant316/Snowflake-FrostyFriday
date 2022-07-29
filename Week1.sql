-- OBJECTIVE: Bulk Loading from Amazon S3 Bucket into a table from a stage

-- Setup --
create database if not exists FrostyFriday;

create or replace temporary table W1_TABLE
	(col1 varchar);

create or replace warehouse FFC_WAREHOUSE;

use database FrostyFriday;
use schema PUBLIC;

-- create csv file format object
create or replace file format csvformat
  type = 'CSV'
  field_delimiter = '|'
  skip_header = 1;

-- create stage
create or replace stage CHALLENGE1_S3_BUCKET
	file_format = csvformat
	url = 's3://frostyfridaychallenges/challenge_1/';

-- view all files in the current stage
ls @~;

-- copy data into the table
copy into W1_TABLE
	from @external_stage/datadumps/
	pattern = '.*csv'
	on_error = 'skip_file';

-- verify output 
select * from W1_TABLE;
