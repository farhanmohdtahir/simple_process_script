#!/bin/bash

dir=$1;

files=`ls $dir | grep '\.tar$'`

while read p; do
echo "docker load --input $p"
docker load --input $p
done <<< "$files"
