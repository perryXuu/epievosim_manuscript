#!/bin/bash

wk_dir="/Users/px54/Documents/TB_software/manuscript_test/perform_bchmk/COVID_ER_50000"
code_path="/Users/px54/Documents/TB_software/V2_code/enivol_packaging/enivol"
config_path="/Users/px54/Documents/TB_software/manuscript_test/perform_bchmk/COVID_ER_50000/test_config.json"

#randomseed=12345


## Network generation:
#python ${code_path}/network_generator.py -popsize 50000 -wkdir ${wk_dir} \
#	-method randomly_generate -p_ER 0.0002 -model ER -random_seed ${randomseed}


## Seed match: Self-defined (randomed)
#python ${code_path}/seed_host_matcher.py -method randomly_generate \
	-wkdir ${wk_dir} -n_seed 1 -match_scheme '{"0": "ranking"}' \
	-match_scheme_param '{"0": 25000}'


python -u ${code_path}/outbreak_simulator.py -config ${config_path} 


