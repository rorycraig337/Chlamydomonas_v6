Orthofinder was run against Chlorophyceaen green algal species to determine preliminary gene models with and without homologs

With the exception of CC-4532 preliminary genes, peptides were taken from: https://github.com/rorycraig337/Chlamydomonas_comparative_genomics/tree/master/Orthofinder_coreR

Files were placed in directory preprocess_fastas

Pre-process CC-4532 preliminary genes (requires kinfin)

```
filter_fastas_before_clustering.py -f CC4532_primary_peptides.fa > preprocessed_fastas/CC4532.protein.fa
```

Now run Orthofinder with other 10 species

```
orthofinder -f preprocessed_fastas -op > op_blastp.txt #produce file with BLAST commands
tail -n36 op_blastp.txt > blastp.txt #extract only BLAST commands from file
perl blastp_format.pl --commands blastp.txt --out blastp_commands.txt #add recommended additional parameters “-seq yes, -soft_masking true, -use_sw_tback”
parallel --jobs 24 < blastp_commands.txt #run BLASTp in parallel
orthofinder -b /localdisk/home/s0920593/projects/chlamy_genomics/Orthofinder_coreR/preprocessed_fastas/Results_Feb18/WorkingDirectory/ -t 32 -og #run Orthofinder using custom BLASTp output
```
