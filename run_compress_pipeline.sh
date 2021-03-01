#! /bin/bash

## bash run_compress_pipeline.sh <directory to docker_module.txt> <directory location of stable docker tar file> <output folder where to put the pipeline.tar.gz>
## Example
## bash run_compress_pipeline.sh /export/Development/Docker/17_pipeline_folders/microbes_reference_guided_assembly_pipeline/microbes_reference_guided_assembly_pipeline_v1.0a /export/Development/Docker/03_stable_docker_tarfile /export/Development/Docker/18_pipeline_stable_zip

pipelinefolder=$1
dockerstabledir=$2
outputdir=$3

## get the docker tar list
dockertarlist=`echo $pipelinefolder/modules.txt`

## Copy stable tar file
echo "Copy stable tar file"

while read p; do
cp $dockerstabledir/$p $outputdir
done < <(cat $dockertarlist)

## Copy script and sql
echo "Copy script and sql"
cp $pipelinefolder/*.sql $pipelinefolder/*.sh $outputdir

## Compress folder to tar.gz
echo "Compress folder to tar.gz"
tarfilename=`echo $(basename $outputdir)`
(cd $outputdir && tar -czvf ../$tarfilename.tar.gz *)
