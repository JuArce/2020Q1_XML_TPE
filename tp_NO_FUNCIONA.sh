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
# long_regex='[-]?(180|1[0-7][0-9]|[0-9]{1,2})\.[0-9]+'
# lat_regex='[-]?(90|[0-8][0-9])\.[0-9]+'
# num_regex='[-]?[0-9]{1,3}\.[0-9]+'

validate_parameters() {
    num_regex='[-]?[0-9]{1,3}\.[0-9]+'
    if [[ "$1" =~ $num_regex && "$2" =~ $num_regex && "$3" =~ $num_regex && "$4" =~ $num_regex ]];
    then
        echo "valid"
        return 0
    fi
    echo "boquita pasion"
    return 1
}

 if validate_parameters "$west" "$south" "$east" "$north"
then
    if (( $(echo "$west < $east"| bc) && $(echo "$south < $north"| bc) ));
    then
        curl "https://www.openstreetmap.org/api/0.6/map?bbox=${west},${south},${east},${north}" > "data.xml"
        echo "data.xml generated."
    else
        echo "Parametros invalidos"
    fi
fi
# curl "https://www.openstreetmap.org/api/0.6/map?bbox=${west},${south},${east},${north}" > "data.xml"
java net.sf.saxon.Query query_map.xq west=$west south=$south east=$east north=$north > intermediate.xml
echo "intermediate.xml generated."

java net.sf.saxon.Transform -s:./intermediate.xml -xsl:./convert_csv.xsl -o:output.csv
echo "output.csv generated, check your directory."
