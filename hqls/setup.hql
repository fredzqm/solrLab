use mapproject;


-- create the node table
CREATE TABLE IF NOT EXISTS node
(
	id string,
	isvisible boolean,
	tags map<string, string>,
	latitude double,
	longitude double
)
-- Partitioned by (cno string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc;


-- insert data into the node table
INSERT OVERWRITE TABLE node
	SELECT id, isvisible, tags, latitude, longitude
		FROM osmnodes;


-- create the way table
CREATE TABLE IF NOT EXISTS way
(
	id string,
	isvisible boolean,
	tags map<string, string>,
	nodes array<string>
)
-- Partitioned by (cno string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc;


-- insert data into the way table
INSERT OVERWRITE TABLE way 
	SELECT id, isvisible, tags, nodes
		FROM osmways;


-- create the relation table
CREATE TABLE IF NOT EXISTS relation
(
	id string,
	isvisible boolean,
	tags map<string, string>,
	members map<string, string>
)
-- Partitioned by (cno string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc;


-- insert data into the relation table
INSERT OVERWRITE TABLE relation 
	SELECT id, isvisible, tags, members
		FROM osmrelations;
