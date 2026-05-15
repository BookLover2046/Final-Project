#!/bin/bash

### Set project variables
primer=16s_V4-V5
projname="Cyanobac_${primer}"

## Enter QIIME2 conda environment 

conda activate qiime2-amplicon-2026.1

### import fastqs. Add the demultiplexed sequences to the data/results directory. This will create a .qza file that can be used for cutadapt and qiime2 downstream analyses.
qiime tools import \
    --type "Cyanobacteria[PairedEndSequencesWithQuality]"  \
    --input-format 16srRNACyanobacteriaSample \
    --input-path data/poly-G-trimmed \
    --output-path data/results/${projname}_demux 


## Setting forward and reverse primers 
fw='^GTGYCAGCMGCCGCGGTAA'	
rv='^CCGYCAATTYMTTTRAGTTT'

## Set configuration for qiime's cutadapt tool 
cutadapt_config="--p-front-f $fw --p-front-r $rv"

### See qiime2_parameters.sh for cutadapt parameters and 01_trim.sh for polyG filter parameters.

## import qiime tools 
qiime cutadapt trim-paired \
  --i-demultiplexed-sequences data/results/${projname}_demux.qza \
  --p-error-rate 0.12 \
  --p-front-f GTGYCAGCMGCCGCGGTAA \
  --p-front-r CCGYCAATTYMTTTRAGTTT \
  --p-cores 4 \
  --p-discard-untrimmed \
  --p-match-adapter-wildcards \
  --o-trimmed-sequences data/results/${projname}_demux_cutadapt.qza \
  --verbose

## Summarize generated data in an analyzable .qzv file format that can be later plotted 
qiime demux summarize \
    --i-data data/results/${projname}_demux_cutadapt.qza \
    --o-visualization data/results/${projname}_demux_cutadapt.qzv

### Proceed to 03_denoise.sh for next step 