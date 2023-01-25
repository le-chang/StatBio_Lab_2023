### first set up gene data
gene_data <- read.csv("gene_data.csv", stringsAsFactors = FALSE, row.names = 1)
sig_genes <- read.csv("sig_genes.csv", stringsAsFactors = FALSE)

# gsub the _ to an empty space in colnames of gene_data
colnames(gene_data) <- gsub("_", " ", colnames(gene_data))

# 1. we want to extract the entrez ids of significant genes
sig_genes <- sig_genes[(sig_genes$adj.P.Val < 0.1 & abs(sig_genes$logFC) > 2), 1]

# 2. match the sig_genes to the rownames of the gene matrx
inx2 <- match(sig_genes, rownames(gene_data))

# 3. extract only those that match sig genes id from original matrix
sig_genes_data <- gene_data[inx2,]

# 4. univariate analyses

sgroup <- grep('^S', colnames(sig_genes_data)) # inx of samples starting with S
cgroup <- grep('^C', colnames(sig_genes_data))

# returns a list of lists (1214 lists, one containing t-test results for each gene)
t.test.info <- apply(sig_genes_data, 1, function(x) t.test(x[sgroup], x[cgroup]))
t.test.pvals <- sapply(t.test.info, function(x) x$p.value)


#t.test.info <- apply(sig_genes_data, 1, t.test(sig_genes_data[sgroup], sig_genes_data[cgroup]))
# this does not work