#!/bin/bash
curl "https://www.openstreetmap.org/api/0.6/map?bbox=${1},${2},${3},${4}" > "data.xml"
echo "hola"
