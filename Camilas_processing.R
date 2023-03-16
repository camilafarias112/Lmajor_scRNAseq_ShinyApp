# Introduction ----
# In this script I downloaded the scRNA-seq processed dataset from the publication:
# "In vivo reprogramming of murine host immune response genes following Leishmania major infection."
# https://doi.org/10.1101/2021.10.05.463063
# From Tiffany Weinkopff's lab

# This dataset consists in scRNA-seq from the ears of L. major infect mice.

# Import data into R ----
library(tidyverse)
library(DropletUtils)
library(Seurat)
library(Matrix)
library(scales)
library(rjson)
library(R2HTML)
library(DT)

# ggplot theme set and color palette ----


# Load objects:
# from link: https://www-ncbi-nlm-nih-gov.ezproxy.u-pec.fr/geo/query/acc.cgi?acc=GSE181720
# Counts:
counts <- read.csv('combined.qc.counts.tsv', sep = '', header = T, row.names = 1)
counts_mtx <- as.matrix(counts)

metadata <- read.csv('combined.qc.metadata.tsv', sep = '', header = T, row.names = 1)
read_table2("")
rownames(head(counts))

# Creating the Seurat object, normalizing and Finding Variable Features ----
data <- CreateSeuratObject(counts = counts_mtx,
                           meta.data = metadata) %>%
  NormalizeData(verbose = FALSE) %>% 
  FindVariableFeatures(verbose = FALSE)

# Add PCA and UMAPs (recriating image 3B from the manuscript) ----
data <- ScaleData(data, verbose = FALSE)

#Check point1:
save(data, file = "data")

data1 <- RunPCA(data, npcs = 100, verbose = FALSE)

data1 <- JackStraw(data1, dims = 100)
data1 <- ScoreJackStraw(data1, dims = 1:100)
JackStrawPlot(data1, dims = 1:100)


data1 <- RunUMAP(data1, reduction = "pca", dims = 1:89)
data1 <- FindNeighbors(data1, reduction = "pca", dims = 1:89)
data1 <- FindClusters(data1, resolution = 1.5)

DimPlot(data1, reduction = "umap", group.by = "cell_type",label = TRUE)

DimPlot(data1, reduction = "umap", group.by = "cell_type", 
        split.by = "treatment", label = TRUE)

# Save Seurat object for our projects ----










