Download OSM data from a URL and extract a subregion
Convert the extract to Spatialite
====================================================

This BAT-file (Windows) downloads OSM data, e.g. from Geofabrik http://download.geofabrik.de/ and extracts a subregion from it.
Several tools are needed to work correctly: 
* ogr2ogr from OSGeo4W https://trac.osgeo.org/osgeo4w/
* Windows wget https://eternallybored.org/misc/wget/
* osmconvert https://wiki.openstreetmap.org/wiki/DE:Osmconvert#Windows

Make sure the tools are in your path or reference them accordingly in osm.bat (there's a variable for each tool)


Motivation
==========
finding and getting extracts from OpenStreetMap with the necessary data for cartographic purposes which are cross-national are hard to get by. Therefore I wrote this Batch-file which downloads a europe dataset and extracts a subregion from that. The subregion is converted into a Spatialite database for further processing, like in QGIS.


SYNTAX
======
osm.bat OUTPUT_FILE
e.g. osm.bat saarlouis

Note that there's no file extension, it's added later automatically


Necessary edits before running
==============================
There are some things to alter before running the tool (line numbers). Just open osm.bat in Notepad++ or similar:
21: set your desired bbox
23: set a CRS if you want your coordinate system other than 4326 (see lines 47 & 48 too), line 47 ignores this setting
34: set the source URL, already set for the latest europe file
36: give the file name from the download once again (I need to make this automatic one day)
41: if you already downloaded the source PBF, you may comment this line by prepending REM so nothing gets downloaded more often than necessary
47: un/comment this for no coordinate transformation. You only need line 47 OR 48 active. If you like, you can alter the ogr2ogr command for your desired format and actions.
48: un/comment this if you want coordinate transformation. You only need line 47 OR 48 active. If you like, you can alter the ogr2ogr command for your desired format and actions.


ogr2ogr configuration file
==========================
At the moment osm.bat outputs a SQLite database. The configuration file for what is extracted is the „osmconf.ini“ [1] which you might need to adapt to your needs. This is my altered version which extracts more information (for carto-purposes) than the original one. But you might want to alter it to fit your needs.

[1] http://www.gdal.org/drv_osm.html


Have fun!