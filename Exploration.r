# Introduction ----
# I analyzed the processed scRNAseq data from:
# "In vivo transcriptional analysis of mice infected with Leishmania major unveils cellular heterogeneity and altered transcriptomic profiling at single-cell resolution"
# https://doi.org/10.1371/journal.pntd.0010518
# From Tiffany Weinkopff's lab

# See script Camilas_processing.R for the processing steps done at Penn, in the CHMI Linux server: /publicData/amorimc/JackStraw_scRNAseq_Tiffany
# Those included:
# 1) downloading processed tsv files from https://www-ncbi-nlm-nih-gov.ezproxy.u-pec.fr/geo/query/acc.cgi?acc=GSE181720;
# 2) Creating the Seurat object, normalizing, FindVariableFeatures, calculating PCAs and UMAPs (used Jackstraw).

# Libraries ----
library(tidyverse)
library(patchwork)
library(ggrepel)
library(ggthemes)
library(Seurat)


# ggplot theme set and color palette ----

# Load objects data1 ----
load("Camilas_processing/data1")

# Just some modeling ----
data1@meta.data[["treatment"]] <- factor(data1@meta.data[["treatment"]], levels = c("Naive","Inf"))
levels(data1@meta.data[["treatment"]]) <- c("Uninfected","L.major")
data1 <- SetIdent(data1, value = "treatment")
Idents(data1)

data2 <- data1
rm(data1)
save(data2, file = "Camilas_processing/data2")