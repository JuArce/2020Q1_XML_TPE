#!/bin/bash
echo hello world
curl "https://www.openstreetmap.org/api/0.6/map?bbox=-74.00,40.711,-73.99,40.73" > "data.xml"
