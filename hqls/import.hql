
!echo "add OSM2Hive.jar";
ADD JAR OSM2Hive.jar;

!echo "creating temporary functions";
CREATE TEMPORARY FUNCTION OSMImportNodes AS 'info.pavie.osm2hive.controller.HiveNodeImporter';
CREATE TEMPORARY FUNCTION OSMImportWays AS 'info.pavie.osm2hive.controller.HiveWayImporter';
CREATE TEMPORARY FUNCTION OSMImportRelations AS 'info.pavie.osm2hive.controller.HiveRelationImporter';

use mapproject;
!echo "dropping osmdata";
DROP TABLE osmdata;

!echo "creating table osmdata";
CREATE TABLE osmdata(osm_content STRING) STORED AS TEXTFILE;
!echo "loading data into osmdata";
LOAD DATA LOCAL INPATH 'Chicago.osm.gz' OVERWRITE INTO TABLE osmdata;

!echo "creating table osmnodes";
CREATE TABLE osmnodes AS SELECT OSMImportNodes(osm_content) FROM osmdata;
!echo "creating table osmways";
CREATE TABLE osmways AS SELECT OSMImportWays(osm_content) FROM osmdata;
!echo "creating table osmwrelations";
CREATE TABLE osmrelations AS SELECT OSMImportRelations(osm_content) FROM osmdata;
