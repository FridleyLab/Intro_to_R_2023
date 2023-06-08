# call necessary libraries 
library(tidyverse)

# import data 
clinical <- read_csv("data/tcga_clinical.txt")
tcga_gene_exp <- read_csv("data/tcga_gene_exp.txt")

# to convert a tibble to a data frame we can use the function as.data.frame()
# or as.tibble() to convert the other way around
# the tidyverse focuses on tibbles but can still utilize data frames
# we can tell which we have by using class()

class(clinical)
class(as.data.frame(clinical))
class(clinical)

### looking at our data

print(clinical) # fits to console
str(clinical) # more informative 
View(clinical) # same as clicking on the icon next to the tibble in your environment pane

colnames(clinical)
dim(clinical)

# subsetting 

### by name
clinical$acronym
clinical[["acronym"]]

### by position 
clinical[[2]]

# tidying data with dplyr
### the %>% operator is how we layer commands together ("and then ...")

## select(): subsetting columns 

clinical %>%
  select(bcr_patient_barcode, tumor_tissue_site)

tcga_gene_exp %>%
  select(bcr_patient_barcode, starts_with("DNAH")) # why do quotes around DNAH matter? 

## mutate(): creating new variables

clinical %>%
  mutate(os_time_months = OS.time/30.5) %>%
  select(bcr_patient_barcode, vital_status, os_time_months)

clinical %>% 
  mutate(full_name = case_when(
    acronym == "HNSC" ~ "Head and neck squamous cell carcinoma",
    acronym == "KIRC" ~ "Kidney renal clear cell carcinoma"
    TRUE ~ "Missing"
  ))

## filter(): subsetting rows 

clinical %>%
  filter(acronym == "HNSC") %>%
  filter(radiation_therapy == "YES") %>%
  nrow()

### why does this fail?

clinical %>%
  filter(stage == "Stage I" | "Stage II") %>%
  nrow()

### fixing the above sequence 

clinical %>%
  filter(stage %in% c("Stage I", "Stage II")) %>%
  nrow()

## summarise(): aggregate rows

clinical %>% 
  group_by(acronym) %>%
  summarise(
    n = n(),
    avg_os_months = mean(OS.time/30.5, na.rm = TRUE)
  )

## arrange() : sort rows 

clinical %>%
  filter(acronym == "HNSC") %>%
  select(bcr_patient_barcode, OS.time) %>%
  arrange(desc(OS.time))
