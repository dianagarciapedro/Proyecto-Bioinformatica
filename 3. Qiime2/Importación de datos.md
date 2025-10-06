# Importar datos (.fastq.gz) a qiime 2

## *1. Crear una carpeta que contenga los archivos .fastq.gz*
Una vez creada la nueva carpeta, posicionate dentro del directorio que contiene tus archivos .fastq.gz y muévelos a la carpeta recién creada utilizando su ruta absoluta.

*Recuerda sustituir el nombre de tu directorio según corresponda.*
```bash 
mkdir ../fastq
mv *.fastq.gz /home/lab13/Documents/Ecologia_AnalisisGenomico/TU DIRECTORIO/proyecto_equipo1/fastq
```

## *2. Crear un archivo manifest.tsv*
Se utiliza principalmente en QIIME2 para importar datos de secuenciación (.fastq.gz) en el entorno QIIME 2.  Es una forma de decirle a QIIME2 dónde están tus archivos de secuencia y a qué muestra corresponden. 
```bash
echo -e "sample-id\tforward-absolute-filepath\treverse-absolute-filepath" > manifest.tsv
for id in SRR7724465 SRR7724466 SRR7724468; do
  echo -e "$id\t$(pwd)/${id}_1.fastq.gz\t$(pwd)/${id}_2.fastq.gz" >> manifest.tsv
done
```
Genera una tabla que asocia cada muestra (sample-id) con los archivos de lectura directa (forward) y reversa (reverse) usando rutas absolutas.

## *3. Activar el ambiente de qiime2*
Un ambiente es un entorno aislado que contiene su propio conjunto de programas y bibliotecas con versiones especificas. 

Este ambiente tiene instalado la versión 2023.9 de QIIME 2 para análisis de amplicones.
```bash
source activate qiime2-amplicon-2023.9
```

## *4. Importar datos a qiime2*
Importa tus archivos .fastq.gz de lecturas emparejadas (paired-end) utilizando un archivo manifest.tsv, para generar un archivo .qza que pueda ser analizado dentro del entorno de QIIME 2.
```bash
qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path manifest.tsv \
  --output-path demux.qza \
  --input-format PairedEndFastqManifestPhred33V2
```

## *5. Visualizar en QIIME2*
Crea un resumen "visual" de los datos de secuenciación que ya fueron importados a QIIME 2 (en el archivo .qza) y genera un archivo .qzv, que puedes abrir con QIIME 2 View para explorar la calidad de tus secuencias.
```bash
qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv
```


