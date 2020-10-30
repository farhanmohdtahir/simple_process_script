zcat /export1/git/References/DBSNP/build_154_38/VCF_000001405.38.vcf.gz | /export/git/Programs/SNVtools/bcftools/bcftools-1.5/bcftools query  -f 'rs%RS\t%GENEINFO\n' > /export/home/farhan/project_PLEASE_DONT_DELETE/29_mygenome/21_gene_rsid_db/03_latest_rsid_gene/rsid_gene.tsv

cat rsid_gene.tsv | awk '{if ($2 != "."){print $0}}' | awk -F ":" '{print $1}' > /export/home/farhan/project_PLEASE_DONT_DELETE/29_mygenome/21_gene_rsid_db/03_latest_rsid_gene/rsid_gene_filtered.tsv
