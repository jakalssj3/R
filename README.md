A set of small R scripts helpful in various bioinformatics projects, e.g. in analyses of differential gene expression, gene ontology (GO) annotation, etc.

---

#### Draw GO donut pie chart ####
Input file format:
```text
GO_term1  20
GO_term2  15
GO_term3  1
GO_term4  1
```

Usage:
```bash
Rscript draw_GO_donut_piechart.R molecular_function.txt "GO: molecular function"
```
or
```bash
./draw_GO_donut_piechart.R molecular_function.txt "GO: molecular function"
```

Result:
![Image of presence/absence matrix](https://raw.githubusercontent.com/jakalssj3/R/master/draw-GO-donut-piechart/molecular_function.txt-GO_chart.png)

---
