#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# This is a script that draws a presence/absence matrix based on a user provide input file.
# The input file is a 0/1 matrix with 1st row providing names, e.g. of genes, and the 1st
# column providing names of organisms, genomes, etc. The input file should be tab-separated.
# Usage:
# a) Rscript draw_presence_absence_matrix.R input.txt
# b) ./draw_presence_absence_matrix.R input.txt
# Input file format:
# 	gene1	gene2	gene3
# genome1	1	0	1
# genome2	1	1	1
# genome3	1	1	0

library("pheatmap")

if (length(args)==0) {
	stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
	args[2] = paste(args[1], "matrix.png", sep='-')
}

d <- read.table(args[1], header=TRUE, sep="\t", row.names=1)

png(args[2], width = round(length(d[,1])/13), height = round(length(d[1,])/2), units = 'in', res = 300)
pheatmap(t(as.matrix(d)), # table is transposed to have gene names on the right-hand side
	scale = "none",
	cluster_rows = T,
	cluster_cols = T,
	clustering_method = "centroid",
	clustering_distance_rows = "euclidean",
	clustering_distance_cols = "euclidean",
	treeheight_row = 0,
	treeheight_col = 0,
	color = c("grey","cyan"),
	border_color = "black",
	show_rownames = T,
	show_colnames = F, # change to T for displaying column names
	#fontsize_col = 4, # uncomment to set up font size for column names
	legend = F,
	cellwidth = 5
)
dev.off()
