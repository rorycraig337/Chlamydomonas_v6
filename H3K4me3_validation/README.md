CC-4532 v6.1 gene models were validated against H3K4me3 peaks that were annotated as intergenic against v5.6 gene models

CC-503 v5 intergenic peaks were considered to be successfully lifted over to CC-4532 v6 if they were >=90% total length of original peak and covered no more than 10% greater span

```
perl H3K4me3_liftover.pl
```

Transcription start sites were then extracted from the CC-4532 v6 annotation and compared to lifted over coordinates

```
perl extract_TSS.pl
perl H3K4me3_TSS_intersect.pl
```
