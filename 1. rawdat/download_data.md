# *Archivos SRA*

Los archivos de secuenciación *(FASTQ)* usados en este proyecto se encuentran en el repositorio: *[NCBI SRA - Proyecto PRJNA486555](https://www.ncbi.nlm.nih.gov/sra/?term=PRJNA486555).*

### *1. Crea una carpeta dentro de tu directorio*
``` bash
mkdir proyecto_rawdata
```

### *2. Crea un archivo .txt**
Dentro de la carpeta (proyecto_rawdata) crea un archivo de texto, el cuál posteriormente deberá contener el nombre de las secuencias de interés
``` bash
cd proyecto_rawdata
nano sra_list.txt 
```

### *3. Dentro del archivo .txt (sra_list.txt) deberas pegar los siguientes nombres:* 
``` bash
SRR7724465 
SRR7724466 
SRR7724468
```
### *4. Descarga de datos en formato .sra*
``` bash
prefetch --option-file sra_list.txt
```

### *5. Conversion de archivos .sra a .fastq*
Se utilizó un ciclo for para optimizar la tarea:
``` bash
for sra in SRR7724465 SRR7724466 SRR7724468
do
    fasterq-dump --split-files $sra
done
```
- Estos archivos nos ayudarán para conocer la calidad de dichas secuencias en el siguiente paso (FastQC y MultiQC) y demmás análisis con QIIME2.
  
