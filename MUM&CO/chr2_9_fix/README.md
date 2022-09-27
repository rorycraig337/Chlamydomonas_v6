Fixing break in chr2 and 9 in CC-503 v6 for fair comparison by MUM&CO

```
bedtools getfasta -fi CC503_v6.fa -bed left_chr2.bed -fo left_chr2.fa -s -name
bedtools getfasta -fi CC503_v6.fa -bed chr2_inversion.bed -fo chr2_inversion.fa -s -name
bedtools getfasta -fi CC503_v6.fa -bed right_chr2.bed -fo right_chr2.fa -s -name
cat left_chr2.fa chr2_inversion.fa right_chr2.fa > fixed_chromosome_02.fa


bedtools getfasta -fi CC503_v6.fa -bed left_chr9.bed -fo left_chr9.fa -s -name
bedtools getfasta -fi CC503_v6.fa -bed right_chr9.bed -fo right_chr9.fa -s -name
cat left_chr9.fa right_chr9.fa > fixed_chromosome_09.fa

```
