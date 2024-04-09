#!/bin/bash

wk_dir="/Users/px54/Documents/TB_software/profile/TB_10000_ER"
code_path=/Users/px54/Documents/TB_software/V2_code

## Seeds burn-in: WF:
## python ${code_path}/seed_generator.py -wkdir /Users/px54/Documents/TB_software/profile/TB_10000_ER -seed_size 5 -method SLiM_burnin_WF -Ne 1000 -ref_path /Users/px54/Documents/TB_transmissibility/GCF_000195955.2_ASM19595v2_genomic.fna -mu 4.4e-8 -n_gen 5000

## Network generation:
## python network_generator.py -popsize 1000 -wkdir ${wk_dir} -method randomly_generate -p_ER 0.01 -model ER

## genetic element
## python ${code_path}/genetic_effect_generator.py -wkdir /Users/px54/Documents/TB_software/profile/TB_10000_ER -method randomly_generate -trait_n 1 2 -es_low 1 1 1 -es_high 5 5 5 -gff /Users/px54/Documents/TB_transmissibility/slim_scripts/GCF_000195955.2_ASM19595v2_genomic.overlap.gff -causal_size_each 5 2 2 -normalize t -sim_generation 500 -mut_rate 4.4e-9

## Seed match: Self-defined (randomed)

python ${code_path}/outbreak_simulator.py -config ${wk_dir}/slim.json


