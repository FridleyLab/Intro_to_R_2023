library(tidyverse)

clinical <- read_csv("data/tcga_clinical.csv")
gene_exp <- read_csv("data/tcga_gene_exp.txt")

# merging data

full_data <- clinical %>% 
  left_join(gene_exp)

clinical_kirc <- clinical %>%
  filter(acronym == "KIRC")

left_data <- clinical_kirc %>% 
  left_join(gene_exp)

right_data <- clinical_kirc %>% 
  right_join(gene_exp)

inner_data <- clinical_kirc %>% 
  inner_join(gene_exp)

full_data <- clinical_kirc %>% 
  full_join(gene_exp)

semi_data <- clinical_kirc %>% 
  semi_join(gene_exp)

anti_data <- clinical_kirc %>% 
  anti_join(gene_exp)

# transposing 

gene_long <- gene_exp %>%
  pivot_longer(cols = contains("_exp"), names_to = "gene",
               values_to = "expression")

gene_wide <- gene_long %>% 
  pivot_wider(id_cols = bcr_patient_barcode, names_from = gene,
              values_from = expression)

# working with NAs

clinical %>% 
  drop_na(race)

clinical %>% 
  fill(race)

clinical %>% 
  replace_na(list(race = "unknown", 
                  tobacco_smoking_history = "probably not"))

# working with strings

clinical %>% 
  unite("race_and_ethnicity", race, ethnicity, sep=":")

clinical %>% 
  unite("race_and_ethnicity", race, ethnicity, sep=":") %>% 
  separate(race_and_ethnicity, into = c("race", "ethnicity"), sep=":")