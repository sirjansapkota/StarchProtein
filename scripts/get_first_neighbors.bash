#!/bin/bash

GENES=$1

grep -f ${GENES} /panicle/ssapkot/git_repo/StarchProtein/results/annotation/Sorghum.4558.protein.links.v11.0.txt > pairwise_hits.txt
awk -F ' ' '($3 >= 700) {print $0}' pairwise_hits.txt > temp
mv temp pairwise_hits.txt
cut -f 1 pairwise_hits.txt > mid
cut -f 2 pairwise_hits.txt >> mid
grep -oP "Sb\d+g\d+" mid | sort -u > genes_and_first_neighbors.txt
rm mid pairwise_hits.txt 
