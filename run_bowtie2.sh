#!/bin/sh

# Your job will use 1 node, 28 cores, and 168gb of memory total.
#PBS -l select=1:ncpus=28:mem=168gb
#PBS -l place=pack:shared
#PBS -l walltime=48:00:00

source config.sh

"$BOWTIE"bowtie2 --un-conc "$BOWOUT"/cotton_rm.fastq -x "$INDEX"/gossypium_hirsutum.fasta -q -1 "$RAW"/RAPiD-Genomics_F128_UAZ_146201_P001_WA01_i5-509_i7-97_S553_L001_R1_001.fastq -q -2 "$RAW"/RAPiD-Genomics_F128_UAZ_146201_P001_WA01_i5-509_i7-97_S553_L001_R2_001.fastq -S "$OUT_DIR"/bowtie2/WA01.SAM


