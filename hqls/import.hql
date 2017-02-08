
!echo 'add OSM2Hive.jar';
ADD JAR OSM2Hive.jar;

!echo 'creating temporary functions';
CREATE TEMPORARY FUNCTION OSMImportNodes AS 'info.pavie.osm2hive.controller.HiveNodeImporter';

!echo 'creating database mapdata';
CREATE DATABASE IF NOT EXISTS mapdata;
USE mapdata;
!echo 'dropping osmdata table if it already exists - we want to start fresh';
DROP TABLE IF EXISTS osmdata;

!echo 'creating table osmdata;
CREATE TABLE osmdata(osm_content STRING) STORED AS TEXTFILE;

!echo 'loading Chicago data into osmdata';
LOAD DATA LOCAL INPATH 'Chicago.osm.gz' OVERWRITE INTO TABLE osmdata;

!echo 'creating table chicagonodes';
CREATE TABLE chicagonodes AS SELECT OSMImportNodes(osm_content) FROM osmdata;

!echo 'loading San Francisco data into osmdata';
LOAD DATA LOCAL INPATH 'SanFrancisco.osm.gz' OVERWRITE INTO TABLE osmdata;

!echo 'creating table sanfrancisconodes';
CREATE TABLE sanfrancisconodes AS SELECT OSMImportNodes(osm_content) FROM osmdata;
