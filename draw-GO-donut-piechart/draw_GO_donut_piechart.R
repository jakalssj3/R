#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# This is a script that draws a donut-shaped pie chart of GO terms and their occurence.
# Usage:
# a) Rscript draw_GO_donut_piechart.R input.txt "plot title"
# b) ./draw_GO_donut_piechart.R input.txt "plot title"
# Input file format:
# GO_term1	20
# GO_term2	15
# GO_term3	1
# GO_term4	1

#####

library(ggplot2)
library(ggrepel)

#####

makedf <- function(l,c){
	go.df <- data.frame(go=l, freq=c)
	go.df$pct = go.df$freq / sum(go.df$freq)* 100
	go.df = go.df[rev(order(go.df$pct)), ]
	go.df$ymax = cumsum(go.df$pct)
	go.df$ymin = c(0, head(go.df$ymax, n = -1))
return(go.df)
}

makedonut <- function(go.df, currentlabel){
	donut = ggplot(go.df, aes(fill = go, ymax = ymax, ymin = ymin, xmax = 90, xmin = 60)) +
		geom_rect(colour = "black") +
		coord_polar(theta = "y") +
		xlim(c(0, 100)) +
		geom_label_repel(aes(label = paste(go, round(pct, 2),"%"), x = 90, y = (ymin + ymax)/2), inherit.aes = F, show.legend = F, size = 4, nudge_x=5) +
		theme(legend.title = element_blank(),
			legend.position="none",
			panel.grid = element_blank(),
			axis.text = element_blank(),
			axis.title = element_blank(),
			axis.ticks = element_blank()) +
		guides(fill=guide_legend(ncol = 1)) +
		annotate("text", x = 0, y = 0, size = 10, label = currentlabel)
return(donut)
}

#####

if (length(args)==0) {
	stop("At least two arguments must be supplied (input file, pie chart title).", call.=FALSE)
} else if (length(args)==2) {
	args[3] = paste(args[1], "GO_chart.png", sep='-')
}

d <- read.table(args[1], header=FALSE, sep="\t")
donut = makedonut(makedf(d[,1],d[,2]), args[2])
png(args[3], width = 1200, height = 1200, res=90) ; donut ; dev.off()
