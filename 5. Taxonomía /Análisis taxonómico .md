# *Análisis taxonómico*
## *1. Dercargas SILVA*
Descarga Para realizar el análisis taxonómico de nuestras muestras es necesario descargar la base de datos de [SILVA](https://docs.qiime2.org/2024.10/data-resources/)
```bash
wget https://data.qiime2.org/2024.10/common/silva-138-99-seqs.qza
wget https://data.qiime2.org/2024.10/common/silva-138-99-tax.qza
```
## *2. Crear un clasificador*
2.1. Extrae la región V3-V4 de las secuencias de referencia para entrenar un clasificador específico.
```bash
qiime feature-classifier extract-reads \
  --i-sequences silva-138-99-seqs.qza \
  --p-f-primer CCTACGGGNGGCWGCAG \
  --p-r-primer GACTACHVGGGTATCTAATC \
  --p-trunc-len 0 \
  --o-reads silva-138-99-seqs-v3v4.qza
```
2.2. Entrenamiento del clasificador Naive Bayes con las secuencias extraídas.
```bash
qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads silva-138-99-seqs-v3v4.qza \
  --i-reference-taxonomy silva-138-99-tax.qza \
  --o-classifier silva-138-99-classifier-v3v4.qza
```

## *3. Clasificación taxonomica*
Asigna una clasificación taxonómica a cada secuencia representativa (ASV) usando el clasificador Naive Bayes entrenado específicamente para la región V3-V4.
```bash
qiime feature-classifier classify-sklearn \
  --i-classifier silva-138-99-classifier-v3v4.qza \
  --i-reads test_rep_set.qza \
  --o-classification test_taxonomy.qza
```

## *4.Visualizar en  QIIME2*
Convierte la clasificación taxonómica a un archivo visualizable (.qzv)
```bash
qiime metadata tabulate \
  --m-input-file test_taxonomy.qza \
  --o-visualization test_taxonomy.qzv
```

## *5. Exportar la tabla de frecuencias desde QIIME 2*
Exporta el contenido del archivo test_table.qza (tabla de frecuencias generada por DADA2) al formato estándar .biom, y lo guarda en la carpeta exported_table.
```bash
qiime tools export \
  --input-path test_table.qza \
  --output-path exported_table
```

## *6. Convertir la tabla .biom a formato .tsv (tabular)*
Convierte la tabla de formato .biom a un archivo .tsv (tabulado), que puede abrirse fácilmente en Excel o R
```bash
biom convert \
  -i exported_table/feature-table.biom \
  -o feature-table.tsv \
  --to-tsv
```
