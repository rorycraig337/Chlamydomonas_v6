MUM&CO was run for each chromosome individually to call structural mutations 

Due to the translocation (which was identified manually), chromosomes 2 and 9 had to be artificially split to be compared

```
bedtools getfasta -fi CC503_v6.fa -bed chr1_v6.bed -fo chr1_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr1_CC4532.bed -fo chr1_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr1_CC4532_v6.fa -q ./chr1_v6.fa -g 8225636 -o chr1

bedtools getfasta -fi CC4532_v6.fa -bed chr2_CC4532.bed -fo chr2_CC4532_v6.fa
bedtools getfasta -fi CC503_v6.fa -bed chr2_v6.bed -fo chr2_v6.fa -s -name
bash mumandco_v2.4.sh -r ./chr2_CC4532_v6.fa -q chr2_9_fix/fixed.chromosome_02.fa -g 8655884 -o chr2

bedtools getfasta -fi CC503_v6.fa -bed chr3_v6.bed -fo chr3_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr3_CC4532.bed -fo chr3_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr3_CC4532_v6.fa -q ./chr3_v6.fa -g 9286894 -o chr3

bedtools getfasta -fi CC503_v6.fa -bed chr4_v6.bed -fo chr4_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr4_CC4532.bed -fo chr4_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr4_CC4532_v6.fa -q ./chr4_v6.fa -g 4130073 -o chr4

bedtools getfasta -fi CC503_v6.fa -bed chr5_v6.bed -fo chr5_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr5_CC4532.bed -fo chr5_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr5_CC4532_v6.fa -q ./chr5_v6.fa -g 3682160 -o chr5

bedtools getfasta -fi CC503_v6.fa -bed chr6_v6.bed -fo chr6_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr6_CC4532.bed -fo chr6_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr6_CC4532_v6.fa -q ./chr6_v6.fa -g 8913359 -o chr6

bedtools getfasta -fi CC503_v6.fa -bed chr7_v6.bed -fo chr7_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr7_CC4532.bed -fo chr7_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr7_CC4532_v6.fa -q ./chr7_v6.fa -g 6492107 -o chr7

bedtools getfasta -fi CC503_v6.fa -bed chr8_v6.bed -fo chr8_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr8_CC4532.bed -fo chr8_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr8_CC4532_v6.fa -q ./chr8_v6.fa -g 4526983 -o chr8

bedtools getfasta -fi CC4532_v6.fa -bed chr9_CC4532.bed -fo chr9_CC4532_v6.fa
bedtools getfasta -fi CC503_v6.fa -bed chr9_v6.bed -fo chr9_v6.fa -s -name
bash mumandco_v2.4.sh -r ./chr9_CC4532_v6.fa -q chr2_9_fix/fixed.chromosome_09.fa -g 6807148 -o chr9

bedtools getfasta -fi CC503_v6.fa -bed chr10_v6.bed -fo chr10_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr10_CC4532.bed -fo chr10_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr10_CC4532_v6.fa -q ./chr10_v6.fa -g 6800247 -o chr10

bedtools getfasta -fi CC503_v6.fa -bed chr11_v6.bed -fo chr11_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr11_CC4532.bed -fo chr11_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr11_CC4532_v6.fa -q ./chr11_v6.fa -g 4479522 -o chr11

bedtools getfasta -fi CC503_v6.fa -bed chr12_v6.bed -fo chr12_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr12_CC4532.bed -fo chr12_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr12_CC4532_v6.fa -q ./chr12_v6.fa -g 9952739 -o chr12

bedtools getfasta -fi CC503_v6.fa -bed chr13_v6.bed -fo chr13_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr13_CC4532.bed -fo chr13_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr13_CC4532_v6.fa -q ./chr13_v6.fa -g 5281438 -o chr13

bedtools getfasta -fi CC503_v6.fa -bed chr14_v6.bed -fo chr14_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr14_CC4532.bed -fo chr14_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr14_CC4532_v6.fa -q ./chr14_v6.fa -g 4217303 -o chr14

bedtools getfasta -fi CC503_v6.fa -bed chr15_v6.bed -fo chr15_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr15_CC4532.bed -fo chr15_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr15_CC4532_v6.fa -q ./chr15_v6.fa -g 5870643 -o chr15

bedtools getfasta -fi CC4532_v6.fa -bed chr16_CC4532.bed -fo chr16_CC4532_v6.fa
bedtools getfasta -fi CC503_v6.fa -bed chr16_v6.bed -fo chr16_v6.fa -s -name
bash mumandco_v2.4.sh -r ./chr16_CC4532_v6.fa -q ./chr16_v6.fa -g 8042475 -o chr16

bedtools getfasta -fi CC503_v6.fa -bed chr17_v6.bed -fo chr17_v6.fa -s -name
bedtools getfasta -fi CC4532_v6.fa -bed chr17_CC4532.bed -fo chr17_CC4532_v6.fa
bash mumandco_v2.4.sh -r ./chr17_CC4532_v6.fa -q ./chr17_v6.fa -g 6954842 -o chr17
```

SVs in regions where both genomes were haplotype 1 were then compared in IGV (ignoring hypermutatable tandem repeat regions)
v6 assemblies were mapped to themselves, and also CC-1690 

```
minimap2 -ax asm5 -t36 CC503_v6.fa CC4532_v6.fa | samtools sort -@6 -T v6.sorting.tmp -O bam -o CC503_CC4532.bam -
minimap2 -ax asm5 -t36 CC503_v6.fa CC1690.fa | samtools sort -@6 -T v6.sorting.tmp -O bam -o CC503_CC1690.bam -

minimap2 -ax asm5 -t36 CC4532_v6.fa CC503_v6.fa | samtools sort -@6 -T v6.sorting.tmp -O bam -o CC4532_CC503.bam -
minimap2 -ax asm5 -t36 CC4532_v6.fa CC1690.fa | samtools sort -@6 -T v6.sorting.tmp -O bam -o CC4532_CC1690.bam -
```
