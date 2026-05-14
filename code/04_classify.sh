#!/bin/bash

## Set project variables 
primer="16s_V4-V5"
projname="Cyanobac_${primer}"

## Enter QIIME2 conda environment 
conda activate qiime2-amplicon-2026.1 

## Classifiy variables copied from qiime2_parameters.sh.  These inputs will that will be analyzed with QIIME2 classifer tool to determine how taxa and reads need to be classified.
refreads=${refdbs/16s/ref_seqs_16S_V4-V5.qza}
reftax=${refdbs/16s/99_otus_16S_taxonomy.qza}
sklearn=${refdbs/16s/silva_99_otus_16S_nb-classifier.qza}

## copied from qiime2_parameters.sh to run QIIME2 classifier 
maxaccepts=10
query_cov=0.75 
perc_identity=0.75 
weak_id=0.65

## Set computing power variable 
threads=12

## QIIME2 classifier run based on the parameters above to organize data in specific formats to aid in the formation of a taxa bar plot
qiime feature-classifier classify-hybrid-vsearch-sklearn \
  --i-query data/results/${projname}_rep-seqs.qza \
  --i-classifier data/refdbs/${sklearn} \
  --i-reference-reads data/refdbs/${refreads} \
  --i-reference-taxonomy data/refdbs/${reftax} \
  --p-threads ${threads} \
  --p-query-cov ${query_cov} \
  --p-perc-identity ${perc_identity} \
  --p-maxrejects all \
  --p-maxaccepts ${maxaccepts} \
  --p-maxhits all \
  --p-min-consensus 0.51 \
  --p-confidence 0.7 \
  --o-classification data/results/${projname}_hybrid_taxonomy

## Proceed to 05_barcode.sh 