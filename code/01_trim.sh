#!/bin/bash

## Set polyGfilters first using code in polyGfilter.sh file before starting the trimming step

## Activate genomics conda environment 
conda activate genomics

## Enter Final-Project directory to analyze Cyanobacteria data 
cd ~/Final-Project

polyg_len=200 ## copied from qiime2_parameters.sh

### Run polyG filter. This will remove polyG tails and also filter out reads that are too short after trimming.
chmod +x code/polyGfilter.sh

### This is the same as..
code/polyGfilter.sh ${polyg_len}
### this
code/polyGfilter.sh 200 

## Remove empty files before qiime import
find data/poly-G-trimmed/ -size 0 -print -delete

## Proceed to 02_cutadapt.sh