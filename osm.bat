REM SYNTAX
REM ======
REM osm.bat OUTPUT_NAME without! file extension
REM e.g. osm.bat roermond
REM
REM SOURCES
REM =======
REM wget: https://eternallybored.org/misc/wget/
REM osmconvert https://wiki.openstreetmap.org/wiki/DE:Osmconvert#Windows
REM ogr2ogr -> OSGeo4W: https://trac.osgeo.org/osgeo4w/
REM
REM start this BAT from within OSGeo4W-Shell

@ECHO off
SETLOCAL

REM user options
REM ============
REM set the desired Bounding Box in WGS84 coordinates
REM xmin, ymin, xmax, ymax
SET BBOX=6.707,49.277,6.790,49.342
REM set to desired output CRS
SET TSRS=EPSG:3035


SET OSMCONVERT=osmconvert64.exe
REM ogr2ogr should come with OSGeo4W
SET OGR2OGR=ogr2ogr.exe
SET CONFIG_FILE=osmconfig.ini
SET WGET=wget.exe
SET OUTPUT=%1%

REM data sources
SET PBF=http://download.geofabrik.de/europe-latest.osm.pbf
REM repeat output file name from PBF source
SET PBFFILE=europe-latest.osm.pbf

REM Download OSM data
REM TIPP: comment this if no download required
REM requires a europe-latest.osm.pbf file in current working directory
%WGET% %PBF%

REM cut out BBOX (see above)
%OSMCONVERT% %PBFFILE% -b="%BBOX%" -o=%OUTPUT%.pbf

REM convert PBF to something useful
%OGR2OGR% -f SQLite -dsco SPATIALITE=YES -gt 65536 %OUTPUT%.sqlite %OUTPUT%.pbf
REM %OGR2OGR% -f SQLite -dsco SPATIALITE=YES -gt 65536 -t_srs "%TSRS%" %OUTPUT%.sqlite %OUTPUT%.pbf