#
# R Script to generate a dendrogram based on 37-marker STR data
#
# part of O'Mahony paper at www.caimaver.com/mahoney/dna-paper/
# 
# Cai Stuart-Maver, cai.maver@gmail.com
# Last modified: 2016-04-13
#
# Written in RStudio Version 0.99.903
#
# Expects a .csv formated such that the six columns are:
#   - hap_cluster (a manual subgrouping designation, may be arbitrary, 
#                  not used in cluster calculation and intended to be
#                  filled *after* cluster modeling)
#   - Kit.Number
#   - Name (surname)
#   - Paternal.Ancestor.Name
#   - Country
#   - County
#   - Parish
#   - Lat
#   - Long
#   - Haplogroup (terminal SNP as designated by FTDNA)
#
# The remaining columns should be the STR data, typically in FTDNA order.
#

# import Analyses of Phylogenetics and Evolution package
library(ape)

# file chooser dialog
myFile <- file.choose()

# import data
str_data <- read.csv(myFile)

# exclude rows with NA values, these should be kits with less than 37 tested markers or null values
#    change 47 to 77 for 67-markers, 121 for 111-markers
d <- str_data[rowSums(is.na(str_data[11:47]))==0,]

# let row names be the combination of Kit.Number, Surname and Haplogroup
#     this aids in identifying each kit in the resulting dendrogram
rownames(d) <- do.call(paste,c(d[c("Kit.Number","Name", "Haplogroup")],sep=" - "))

# create distribution matrix using default euclidean distance method
#    change 47 to 77 for 67-markers, 121 for 111-markers
d.dist <- dist(d[11:47])

# create hierarchical cluster from distance matrix
hc <- hclust(d.dist)

# set up pdf output parameters
pdf(file=choose.files(caption="Save As...", filters = c("PDF (.pdf)","*.pdf")), height = 22, width = 8)

# generate phylogenetic tree dendrogram
plot(as.phylo(hc), cex=0.6, no.margin = TRUE)

# close pdf device to create file
dev.off()
