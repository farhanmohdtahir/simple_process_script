#! /bin/bash

outputfile=$1

end=$((SECONDS+5400))

while [ $SECONDS -lt $end ]; do
ps -u app_user -f >> $outputfile
echo -e "\n\n" >> $outputfile
sleep 300
done
