Preliminary contig level assemblies of strains CC-503 and CC-4532 were mapped to the near-complete CC-1690 assembly using minimap2 

The asm5 and asm20 options represent differnt divergence options 

asm5 was generally used for manual scaffolding of contigs, although asm20 alignments were also queried for haplotype 1 - haplotype 2 alignment regions (where divergence is ~2%) 

Assemblies were manually scaffolded, redundant contigs removed, and gap lengths estimated based on manual curation of PAF files

```
minimap2 -cx asm5 CC1690.fa CC4532_preliminary_contigs.fa -t12 --cs | sort -k6,6 -k8,8n > CC1690_CC4532_asm5.paf 
minimap2 -cx asm20 CC1690.fa CC4532_preliminary_contigs.fa -t12 --cs | sort -k6,6 -k8,8n > CC1690_CC4532_asm20.paf

minimap2 -cx asm5 CC1690.fa CC503_preliminary_contigs.fa -t12 --cs | sort -k6,6 -k8,8n > CC1690_CC503_asm5.paf 
minimap2 -cx asm20 CC1690.fa CC503_preliminary_contigs.fa -t12 --cs | sort -k6,6 -k8,8n > CC1690_CC503_asm5.paf
```

For visual confirmation in IGV, raw PacBio reads were mapped to the final assemblies

```
minimap2 -ax map-pb -t12 CC4532_v6.fa CC4532.reads.fa | samtools sort -@6 -T v6.sorting.tmp -O bam -o CC4532_v6.CC4532_reads.bam - minimap2 -ax map-pb -t12 CC503_v6.fa CC503.reads.fa | samtools sort -@6 -T v6.sorting.tmp -O bam -o CC503_v6.CC503_reads.bam -
```

To assess assembly changes and produce figures 1, 2 and S1, the v5 assembly was mapped to CC-4532 v6

```
minimap2 -cx asm5 CC4532_v6.fa CC503_v5.fa -t12 --cs | sort -k6,6 -k8,8n > CC4532_CC503-v5_asm5.paf
```
