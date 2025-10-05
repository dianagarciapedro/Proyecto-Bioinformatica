# *Evaluación de la calidad con FastQC*
El resultado de FastQC es una representación visual de la calidad de la secuencia, proporcionando un práctico sistema de agrupación de tres colores: marcas verdes para alta calidad, signos de exclamación naranjas para una calidad media que puede requerir una investigación manual y cruces rojas para baja calidad. 

Para realizar dicha evaluación, realizaremos los siguientes pasos:

#### *1.* Crearemos una nueva carpeta llamada RAW y otra llamada QC

``` bash
mkdir RAW
mkdir QC
```
#### *2.* Después moveremos nuestras muestras en formato .fastq al directorio RAW

``` bash
mv /directorio/presente/*.fastq /directorio/deseado(RAW)
```
#### *3.* Finalmente, realizaremos el análisis con la herramienta de FastQC y nuestros resultados serán guardados en la carpeta QC

``` bash
fastqc -o QC/ RAW/*
```
#### *4. * Para visulizar los resultados nos moveremos al directorio QC

``` bash
cd QC
ls -lh
```
Deberíamos de ver dos tipos de archivos para cada una de nuestras muestras. Estos deberían llamarse algo así:

#### "SRR7724461_1_fastqc.html"
#### "SRR7724461_1_fastqc.zip"

- Los archivos con salida html de FastQC se pueden abrir en el navegador para su fácil visualización. 


# *MultiQC: análisis de muestras múltiples*
La aplicación MultiQC crea un informe basado en todos los documentos de un directorio determinado. MultiQC tomará entradas de muchas aplicaciones de software diferentes, incluido fastQC. 

Para dicho análisis, llevaremos a cabo los siguentes pasos: 

#### *1.* Primero, crearemos un nuevo directorio llamado MultiQC y posteriormente nos moveremos a este

``` bash
mkdir MultiQC
cd MultiQC
```
#### *2.* Enseguida, copiaremos los archivos del directorio QC (donde anteriormente guardamos nuestros resultados del FastQC), al directorio actual (MultiQC)

``` bash
cp -r ../QC/* ./
```
#### Por último, ejecutaremos el análisis MultiQC en nuestro actual directorio 

``` bash
multiqc .
```

- De igual forma que los archivos resultantes de la herramienta FastQC, los archivos resultantes de MultiQC con salida html podrán ser visualizados a través de un navegador.
