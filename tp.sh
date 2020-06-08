#!/bin/bash

west=${1#*=}
south=${2#*=}
east=${3#*=}
north=${4#*=}
echo "West: " $west
echo "South: " $south
echo "East: " $east
echo "North: " $north

# long_regex="[-]?[0-9]{1,3}(\.[0-9]+)?"
# [-]?[0-9]{1,3}(\.[0-9]+)?
long_regex="[-]?([0-9]{1,2}|1[0-7][0-9]|180)(\.[0-9]+)?"
lat_regex="[-]?([0-8][0-9]|90)(\.[0-9]+)?"
if (( "$west" =~ $long_regex  && "$south" =~ $lat_regex && "$east" =~ $long_regex && "$north" =~ $lat_regex ));
then
    echo "FFFF"
    if (( $(echo "$west < $east"| bc) && $(echo "$south < $north"| bc) ));
    then
        curl "https://www.openstreetmap.org/api/0.6/map?bbox=${west},${south},${east},${north}" > "data.xml"
        echo "data.xml generated."
    else
        echo "Parametros invalidos"
    fi
fi


#curl "https://www.openstreetmap.org/api/0.6/map?bbox=${west},${south},${east},${north}" > "data.xml"
#curl "https://www.openstreetmap.org/api/0.6/map?bbox=-74.00,40.711,-73.99,40.73" > "data.xml"
java net.sf.saxon.Query query_map.xq west=$west south=$south east=$east north=$north > intermediate.xml
echo "intermediate.xml generated."

java net.sf.saxon.Transform -s:./intermediate.xml -xsl:./convert_csv.xsl -o:output.csv

#rm ./data.xml
#rm ./intermediate.xml
#echo "Archivos intermedios eliminados"
echo "output.csv generated, check your directory."
