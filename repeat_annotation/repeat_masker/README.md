The version 6 assemblies were repeat masked using the latest Chlamydomonas repeat library (v3.2) and RepeatMasker v4.0.9
Data was used in Figure 1 and Table 1

```
RepeatMasker -gff -a -xsmall -gccalc -pa 32 -lib repeat_lib_v3_2.cRei.fa CC4532_v6.fa
```

The resulting GFF was filtered to retain only TE copies <20% divergent from their consensus sequence 

```
perl rm_filter.pl --in CC4532_v6.fa.out.gff --lim 20 --out CC4532_v6.fa.rm20.gff
```

Repeat annotations were split to TEs, other repeats, and ZeppL elements (centromeric repeats)
Overlapping coordinates in the resulting files were merged
ZeppL coordinates were subtracted from TE coordinates

```
perl rm2beds.pl --rm CC4532_v6.fa.out --TE CC4532_v6.TEs.bed --other CC4532_v6.other.bed --zepp CC4532_v6.zepp.bed
sort -k1,1 -k2n,2n CC4532_v6.zepp.bed | bedtools merge -i stdin > m.CC4532_v6.zepp.bed
sort -k1,1 -k2n,2n CC4532_v6.TEs.bed | bedtools merge -i stdin > m.CC4532_v6.TEs.bed
sort -k1,1 -k2n,2n CC4532_v6.other.bed | bedtools merge -i stdin > m.CC4532_v6.other.bed
bedtools subtract -a m.CC4532_v6.TEs.bed -b m.CC4532_v6.zepp.bed > m.CC4532_v6.TEs_nonzepp.bed
```

Merge tandem repeat finder results with non-TE repeats from RepeatMasker
Remove overlapping TEs to get unique base counts

```
cat ../trf/CC4532_v6.sat_all.bed m.CC4532_v6.other.bed | sort -k1,1 -k2n,2n | bedtools merge -i stdin > m.CC4532_v6.all_TRs.bed
bedtools subtract -a m.CC4532_v6.all_TRs.bed -b m.CC4532_v6.TEs.bed > u.CC4532_v6.all_TRs.bed
```
