# *Filtrado, corrección y agrupamiento (.asv) de secuencias*

## *1. Procesamiento de secuencias paired-end con DADA2*
Toma secuencias demultiplexadas (--i), aplica truncamiento (--p) y genera tabla de frecuencia, secuencias representativas y estadísticas (--o) usando DADA2.
```bash
qiime dada2 denoise-paired \
  --i-demultiplexed-seqs demux.qza \
  --p-trunc-len-f 240 \
  --p-trunc-len-r 190 \
  --o-table dada2_table.qza \
  --o-representative-sequences dada2_rep_set.qza \
  --o-denoising-stats dada2_stats.qza
```
El metadata que se utiliza esta para descargar en la carpeta de DADA2.

## *2. Vizualisación en QIIME2*
*2.1. Tabla de frecuencia*

Muestra cuántas secuencias tiene cada muestra (número de ASVs por muestra).
```bash
qiime feature-table summarize \
  --i-table dada2_table.qza \
  --o-visualization dada2_table.qzv \
  --m-sample-metadata-file sample-metadata.tsv
```

*2.2. Secuencias representativas*

Muestra todas las secuencias únicas (ASVs) que DADA2 identificó.
```bash
qiime feature-table tabulate-seqs \
  --i-data dada2_rep_set.qza \
  --o-visualization dada2_rep_set.qzv
```

*2.3. Estadísticas de denoising*
Te muestra cuántas secuencias entraron al proceso, fueron filtradas/eliminadas y cuántas se retuvieron al final.
```bash
qiime metadata tabulate \
  --m-input-file dada2_stats.qza \
  --o-visualization dada2_stats.qzv
```
