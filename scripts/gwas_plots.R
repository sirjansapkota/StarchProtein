setwd("~/GBS/BAP/SeedColor/")

gwas.results <- read.table("GAPIT_GEMMA_SeedColor_merge.txt", header=TRUE)

### Adjust the positions for plotting genome-wide
chr.lengths <- c(0)
for (i in 1:9) {
    chr.counts <- subset(gwas.results, gwas.results$CHR==i)
    len <- max(chr.counts$POS)
    addon <- len + chr.lengths[i]
    chr.lengths <- c(chr.lengths, addon)
}

adj.pos <- c()
for (i in 1:nrow(gwas.results)) {
    pos <- gwas.results[i,2]
    curr.chr <- as.numeric(gwas.results[i,1])
    new.pos <- pos + chr.lengths[curr.chr]
    adj.pos <- c(adj.pos, new.pos)
}

# Calculate the -log(10) of the p-values
log.p.glm <- (-1) * log10(gwas.results$Pval_GAPIT_GLM)
log.p.cmlm <- (-1) * log10(gwas.results$Pval_GAPIT_CMLM)

# Make a code for odd and even chromosomes
is.even <- function(x) x %% 2 == 0
chr.codes <- c()
for (i in 1:nrow(gwas.results)) {
    chr <- as.numeric(gwas.results[i,1])
    if (is.even(chr)) {
        chr.codes <- c(chr.codes, 1)
    } else {
        chr.codes <- c(chr.codes, 2)
    }
}

new.gwas.results <- cbind(gwas.results, adj.pos, log.p.glm, log.p.cmlm, chr.codes)
write.table(new.gwas.results, file="GAPIT_GEMMA_SeedColor_adjusted.txt", sep="\t", row.names=FALSE, quote=FALSE)

# Split the results by even and odd chromosomes
subset.even <- subset(new.gwas.results, new.gwas.results$chr.codes==1)
subset.odd <- subset(new.gwas.results, new.gwas.results$chr.codes==2)

# Calculate the bonferroni correction value
bonf.corr <- 0.05/(nrow(new.gwas.results))

# Save the start position of the y1 gene
y1.start <- 61171659

# Plot the results for each GWAS (make sure y-limits are the same for the GLM and the CMLM)

### GLM
pdf(file="SeedColor_GLM.pdf")
plot(subset.odd$adj.pos, subset.odd$log.p.glm, xlim=c(0, max(adj.pos)), ylim=c(0,11), main="", xlab="", ylab=expression(paste(-log[10], "p")), col="darkgrey", pch=20)
points(subset.even$adj.pos, subset.even$log.p.glm, col="black", pch=20) 
abline(h=bonf.corr)
abline(v=y1.start, lty=3)
dev.off()

### CMLM
pdf(file="SeedColor_CMLM.pdf")
plot(subset.odd$adj.pos, subset.odd$log.p.cmlm, xlim=c(0, max(adj.pos)), ylim=c(0,11), main="", xlab="", ylab=expression(paste(-log[10], "p")), col="darkgrey", pch=20)
points(subset.even$adj.pos, subset.even$log.p.cmlm, col="black", pch=20) 
abline(h=bonf.corr)
abline(v=y1.start, lty=3)
dev.off()

### BSLMM
pdf(file="SeedColor_BSLMM.pdf")
plot(subset.odd$adj.pos, subset.odd$TotalEffect_Gemma, xlim=c(0, max(adj.pos)), main="", xlab="", ylab="Total Effect", col="darkgrey", pch=20)
points(subset.even$adj.pos, subset.even$TotalEffect_Gemma, col="black", pch=20) 
abline(h=0.02)
abline(v=y1.start, lty=3)
dev.off()

