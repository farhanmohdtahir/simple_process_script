#!/bin/bash

## bash run_pipeline_import.sh <location of zip file> <location of temporary output files>
## example 
## bash run_pipeline_import.sh /export/Development/Docker/18_pipeline_stable_zip/microbes_reference_guided_assembly_pipeline_v1.0a.tar.gz /home/app_user/temp_folder

zipfile=$1
outputdir=$2

pipelinename=`echo $(basename $zipfile) | sed 's/\.tar\.gz//g'`
novoworxdb=`echo /export/home/app_user/framework/files/WORKSPACE/databases`

## unzip zip file
rm -rf $outputdir/$pipelinename.stderr $outputdir/$pipelinename
echo "Now unzip the $pipelinename"

mkdir -p $outputdir/$pipelinename
tar -xzvf $zipfile -C $outputdir/$pipelinename


## Get the ip address of the slavehost
hostname=`qstat -f | grep 'slave\.q' | awk '{print $1}' | cut -d '@' -f2`

## Import docker to host machine
while read p; do
hostip=`cat /etc/hosts | grep "$p" | awk '{print $1}'`
echo "Now importing the modules docker to $hostip"

ssh app_user@$hostip bash $outputdir/$pipelinename/run_docker_import_pipeline.sh $outputdir/$pipelinename
done < <(echo -e "$hostname")

##--------------------------------------------------------------------------------------------------------
## Import pipeline mysql
echo "Now importing the pipeline to the vm's mysql"
bash $outputdir/$pipelinename/run_mysql_import_pipeline.sh $outputdir/$pipelinename

##---------------------------------------------------------------------------------------------------------

## Import pipeline database
if [[ -d $outputdir/$pipelinename/databases ]]
then
echo "Now importing databases for $pipelinename"

## Checking the host databases directory
if [[ -d $novoworxdb ]]
then
cp -r $outputdir/$pipelinename/databases $novoworxdb

if [[ $? -eq 0 ]]
then
echo "Databases Import Status: Completed. All $pipelinename databases had been imported"
else
echo -e "Databases Import Status: Failed. You can try to cp it manually. The command is as below: cp -r $tarfile/databases $novoworxdb"
fi

else
echo -e "Databases Import Status: Failed. $novoworxdb not found"
fi

fi

## Remove pipeline directory
rm -rf $outputdir/$pipelinename
