#!/bin/bash

## qiime2 parameters for each metabarcode

### 16s_V4-V5 

    ## 515F-926R
    fw='^GTGYCAGCMGCCGCGGTAA'	
    rv='^CCGYCAATTYMTTTRAGTTT'
    
    cutadapt_config="--p-front-f $fw --p-front-r $rv"
    
    ## denoise
    polyg_len=200
    overlap=10

    ##taxonomy
    maxaccepts=10
    query_cov=0.75 
    perc_identity=0.75 
    weak_id=0.65

    ## trunc
    trunclenf=220
    trunclenr=215
    
    ## trim
    trimleftf=0
    trimleftr=0

    min=350
    max=430

    threads=8


    mkdir data/refdbs
cp /tmp/GEN711-811/refdbs/ref_seqs_16s_V4-V5.qza data/refdbs
cp -r /tmp/GEN711-811/Cyanobacteria/metadata/ Final-Project/data/metadata
cp /tmp/GEN711-811_data/refdbs/silva_99_otus_16S_nb-classifier.qza
cp /tmp/GEN711-811_data/refdbs/99_otus_16S_taxonomy.qza data/refdbs/
cp -r /tmp/GEN711-811_data/Cyanobacteria/metadata/ Final-Project/data/metadata/
