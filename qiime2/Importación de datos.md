# Importar datos (.fastq.gz) a qiime 2

Crear una carpeta que contenga los archivos .fastq.gz

```bash 
mkdir fastq
mv *.fastq.gz /home/lab13/Documents/Ecologia_AnalisisGenomico/MariaVargas/petroleo_proyecto/fastq
```

Crear un archivo manifest.tsv
echo -e "sample-id\tforward-absolute-filepath\treverse-absolute-filepath" > manifest.tsv
for id in SRR7724461 SRR7724463 SRR7724464 SRR7724465 SRR7724466 SRR7724468; do
  echo -e "$id\t$(pwd)/${id}_1.fastq.gz\t$(pwd)/${id}_2.fastq.gz" >> manifest.tsv
done

Activar el ambiente de qiime2 
source activate qiime2-amplicon-2023.9

Importar datos a qiime2
Apartir del archivo manifest.tsv era posible la importación de nuestros datos a qiime2
qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path manifest.tsv \
  --output-path demux.qza \
  --input-format PairedEndFastqManifestPhred33V2

Visualizar la calidad de las lecturas
qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv


qiime dada2 denoise-paired \
  --i-demultiplexed-seqs demux.qza \
  --p-trunc-len-f 240 \
  --p-trunc-len-r 190 \
  --o-table dada2_table.qza \
  --o-representative-sequences dada2_rep_set.qza \
  --o-denoising-stats dada2_stats.qza
