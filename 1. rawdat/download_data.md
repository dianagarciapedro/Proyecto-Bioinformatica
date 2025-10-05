# **Archivos SRA**

Los archivos de secuenciación (FASTQ) usados en este proyecto se encuentran en el repositorio 
[NCBI SRA - Proyecto PRJNA486555](https://www.ncbi.nlm.nih.gov/sra/?term=PRJNA486555).

**Crea una carpeta dentro de tu directorio**
``` bash
mkdir proyecto_rawdata
```

**Crea un archivo .txt**

Dentro de tu nueva carpeta (proyecto_rawdata) crea un archivo de texto, dentro debe contener el nombre de las secuencias de interes
``` bash
cd proyecto_rawdata
nano sra_list.txt 
```
Dentro de tu archivo .txt (sra_list.txt) deberas pegar los siguientes nombres: 

SRR7724461 

SRR7724463 

SRR7724464 

SRR7724465 

SRR7724466 

SRR7724468

**Desacrga de datos en formato .sra**
``` bash
prefetch --option-file sra_list.txt
```

**Conversion de archivos .sra a .fastq**

Se utilizo un ciclo for para optimizar la tarea
``` bash
for sra in SRR7724461 SRR7724463 SRR7724464 SRR7724465 SRR7724466 SRR7724468
do
    fasterq-dump --split-files $sra
done
```

**QIIME 2**
Ya que tenemos los archivos fastq, pordemos pasar a qiime 2.

Activa tu ambiente

