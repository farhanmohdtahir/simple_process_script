
#! /bin/bash
outdir=$1

dockerimages=`docker images | awk '{print $1":"$2}'`

while read p; do
tarname=`echo $p | sed 's/:/_/g' | sed 's|/|_|g' | cut -f1`
echo "docker save $p > $outdir/$tarname.tar"
docker save $p > $outdir/$tarname.tar
done <<< "$dockerimages"
