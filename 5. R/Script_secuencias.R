## Cargar librerías
library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)
library(tibble)
library(stringr)
# 2. IMPORTAR Y PREPARAR DATOS (sin cambios en la importación)

# 2.1. Tabla de Frecuencias (Abundancias)
counts_table_raw <- read.table("feature-table.tsv", sep = "\t", header = FALSE, skip = 1, stringsAsFactors = FALSE)

sample_names <- as.character(counts_table_raw[1, -1]) 
feature_ids <- counts_table_raw[-1, 1]              

counts_matrix <- counts_table_raw[-1, -1]

# CAMBIO: Asignar los IDs correctos a las columnas
sample_names_corrected <- c("L-S1-MaxChl", "L_S1MinO2", "L-S1-B")  # ajustar según tu número de muestras
colnames(counts_matrix) <- sample_names_corrected
rownames(counts_matrix) <- feature_ids

counts_table <- counts_matrix %>% 
  t() %>% 
  as.data.frame() %>%
  rownames_to_column(var = "SampleID") 

# 2.2. Taxonomía (SILVA) - Divide la columna 'Taxon' en niveles
taxonomy_table <- read.table("taxonomy_SILVA.tsv", sep = "\t", header = TRUE, row.names = 1, stringsAsFactors = FALSE) %>% 
  select(Taxon) %>% 
  rownames_to_column(var = "FeatureID") %>%
  separate(col = Taxon, 
           into = c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species"), 
           sep = ";",
           fill = "right", 
           extra = "drop") %>%
  mutate(across(Domain:Species, ~str_trim(.))) %>% 
  mutate(Genus = gsub("g__", "", Genus)) 

# 2.3. Metadatos (Usando Library.Name como variable de agrupación)
metadata_table <- read.table("metadata.tsv", sep = "\t", header = TRUE, row.names = 1, stringsAsFactors = FALSE) %>% 
  select(Library.Name) %>% 
  rename(GroupName = Library.Name) %>% 
  rownames_to_column(var = "SampleID")


# 3. COMBINAR DATOS Y PREPARACIÓN FINAL

long_counts <- counts_table %>%
  pivot_longer(cols = -SampleID, names_to = "FeatureID", values_to = "Abundance")

merged_data <- long_counts %>%
  left_join(taxonomy_table, by = "FeatureID") %>%
  left_join(metadata_table, by = "SampleID")

# 4. CALCULAR ABUNDANCIA RELATIVA Y VISUALIZAR (NIVEL GÉNERO)
# 4.1. Calcular Abundancia Relativa Agrupada por GÉNERO
composition_data_genus <- merged_data %>%
  group_by(SampleID, GroupName, Genus) %>% 
  summarise(Total_Abundance = sum(Abundance), .groups = 'drop') %>% 
  group_by(SampleID) %>%
  mutate(Relative_Abundance = Total_Abundance / sum(Total_Abundance)) %>%
  ungroup() %>%
  # CAMBIO: Convertir SampleID en factor para respetar el orden deseado
  mutate(SampleID = factor(SampleID, levels = c("L-S1-MaxChl", "L_S1MinO2", "L-S1-B")))

# 4.2. Crear Gráfico de Barras Apiladas (Composición Taxonómica)
composition_plot_genus <- composition_data_genus %>%
  ggplot(aes(x = SampleID, y = Relative_Abundance, fill = Genus)) +
  geom_col(position = "stack") +
  labs(y = "Abundancia Relativa", 
       x = "Muestra",
       title = "Composición Taxonómica a Nivel de Género (Clasificación SILVA)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
        legend.position = "bottom")

# Mostrar el gráfico
print(composition_plot_genus)
