# *Archivos SRA*

Los archivos de secuenciación *(FASTQ)* usados en este proyecto se encuentran en el repositorio: *[NCBI SRA - Proyecto PRJNA486555](https://www.ncbi.nlm.nih.gov/sra/?term=PRJNA486555).*

## *1. Crea una carpeta dentro de tu directorio*
``` bash
mkdir proyecto_equipo1
```

## *2. Crea una carpeta para almacenar nuestros archivos .sra*
Posicionate dentro de la carpeta que creaste previamente (ej. proyecto_equipo1) y crea tu nueva carpeta (ej. rawdata)
``` bash
cd proyecto_equipo1
mkdir rawdata
```

## *3. Crea un archivo .txt*
Dentro de la carpeta (rawdata) crea un archivo de texto, el cuál deberá contener el nombre de las secuencias de interés
``` bash
cd rawdata
nano sra_list.txt 
```

## *4. Dentro del archivo .txt (sra_list.txt) deberas pegar los siguientes nombres:* 
``` bash
SRR7724465 
SRR7724466 
SRR7724468
```

## *5. Descarga de datos en formato .sra*
Este comando nos ayudara a bajar las secuencias elegidas de NCBI 
``` bash
prefetch --option-file sra_list.txt
```

## *6. Conversion de archivos .sra a .fastq*
Se utilizó un ciclo for para optimizar la tarea:
``` bash
for sra in SRR7724465 SRR7724466 SRR7724468
do
    fasterq-dump --split-files $sra
done
```
- Estos archivos nos ayudarán para conocer la calidad de dichas secuencias en el siguiente paso (FastQC y MultiQC) y demás análisis con QIIME2.
  
