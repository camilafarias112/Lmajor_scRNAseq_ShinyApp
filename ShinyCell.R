# ShinyCell

# Libraries ----
library(Seurat)
library(ShinyCell)

# Clean Seurat, save and Load ----
data_clean <- data2
data_clean$percent.mt <- NULL
data_clean$old.ident <- NULL
data_clean$RNA_snn_res.1.2 <- NULL
data_clean$RNA_snn_res.1.4 <- NULL
data_clean$S.Score <- NULL
data_clean$RNA_snn_res.0.8 <- NULL
data_clean$RNA_snn_res.1 <- NULL
data_clean$RNA_snn_res.1.5 <- NULL
data_clean$G2M.Score <- NULL
data_clean$seurat_clusters <- NULL
data_clean$RNA_snn_res.1.1 <- NULL
data_clean$seurat_clusters.treatment <- NULL
data_clean$Phase <- NULL
data_clean$RNA_snn_res.2 <- NULL
data_clean$RNA_snn_res.1.3 <- NULL
data_clean$RNA_snn_res.1.3 <- NULL

saveRDS(data_clean, file = "Camilas_processing/data_clean_rds.rds")
data_clean_rds <- readRDS("Camilas_processing/data_clean_rds.rds")

# Run ShinnyCell ----
scConf <- createConfig(data_clean_rds)
makeShinyApp(data_clean_rds, scConf, gene.mapping = TRUE,
             shiny.title = "Lmajor_scRNAseq ShinyCell",
             shiny.footnotes = "Farias Amorim 2023 re-analyses: L. major scRNA-seq from Venugopal G. et al., Plos NTD 2021",
             shiny.dir = "Lmajor_scRNAseq/",)

# Open ShinnyApp ----
# Open the "Lmajor_scRNAseq/server.R"

# Publish shiny app ----
library(rsconnect)
rsconnect::deployApp('Lmajor_scRNAseq/')
