Run Tandem Repeats Finder and parse output to satellites and microsatellites

```
trf CC4532_v6.fa 2 7 7 80 10 50 1000 -f -d -m -ngs > CC4532_v6.trf.dat
perl trf2sats.pl --in CC4532_v6.trf.dat --prefix CC4532_v6

sort -k1,1 -k2n,2n CC4532_v6.microsats.bed | bedtools merge -i stdin > m.CC4532_v6.microsats.bed
sort -k1,1 -k2n,2n CC4532_v6.sats.bed | bedtools merge -i stdin > m.CC4532_v6.sats.bed
bedtools subtract -a m.CC4532_v6.microsats.bed -b m.CC4532_v6.sats.bed > f.CC4532_v6.microsats.bed

cat CC4532_v6.microsats.bed CC4532_v6.sats.bed | sort -k1,1 -k2n,2n | bedtools merge -i stdin > CC4532_v6.sat_all.bed
```
