#!/bin/bash

dir=$1;

files=`ls $dir`

while read p; do
tar -xvf $dir/$p
done <<< "$files"
