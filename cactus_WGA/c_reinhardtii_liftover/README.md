To enable convenient liftover between past and present versions of the reference genome, a cactus whole genome alignment was produced
Assemblies were softmasked for repeats, see: Chlamydomonas_v6/repeat_annotation/repeat_masker/
Branch lengths were arbitrary

Set paths

```
PATH=$HOME/opt/python-2.7.17/bin:$PATH
source /localdisk/home/s0920593/software/cactus_env/bin/activate

ttPrefix=/localdisk/home/s0920593/software/kyoto_061119
export kyotoTycoonIncl="-I${ttPrefix}/include -DHAVE_KYOTO_TYCOON=1"
export kyotoTycoonLib="-L${ttPrefix}/lib -Wl,-rpath,${ttPrefix}/lib -lkyototycoon -lkyotocabinet -lz -lbz2 -lpthread -lm -lstdc++"
export PATH=/localdisk/home/s0920593/software/kyoto_061119/bin:$PATH
export LD_LIBRARY_PATH=/localdisk/home/s0920593/software/kyoto_061119/lib:$LD_LIBRARY_PATH
```

Run cactus

```
cactus jobStore4 ./Cr_5way_seqFile.txt  ./Cr-5way.hal --binariesMode local --maxCores 30
```

Bed file liftover between assemblies was then performed e.g. for v5 hypermethylated region coordinates to CC-4532 v6

```
halLiftover Cr_5way.hal CC503v5 CC503-v5_hypermethylated.bed CC4532 CC4532_hypermethylated.bed
```

Or for the v5 gaps to CC-4532 v6

```
halLiftover Cr_5way.hal CC503v5 CC503-v5_gap_flanks.bed CC4532 CC4532_v5_gaps.bed
```
