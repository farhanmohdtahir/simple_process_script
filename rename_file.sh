#!/bin/bash

dir=$1;

files=`ls $dir`

while read p; do
newfilename=`echo -e "$p" | sed 's/_/\t/g' | cut -f1`
mv $dir/$p $dir/${newfilename}.tar
done < <(echo -e "$files")
#done <<< "$files"
