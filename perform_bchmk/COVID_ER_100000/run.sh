#!/bin/bash

wk_dir="/Users/px54/Documents/TB_software/manuscript_test/perform_bchmk/COVID_ER_100000"
code_path="/Users/px54/Documents/TB_software/V2_code/enivol_packaging/enivol"
config_path="/Users/px54/Documents/TB_software/manuscript_test/perform_bchmk/COVID_ER_100000/test_config.json"

#randomseed=12345


## Network generation:
#python ${code_path}/network_generator.py -popsize 100000 -wkdir ${wk_dir} \
#	-method randomly_generate -p_ER 0.0001 -model ER -random_seed ${randomseed}


## Seed match: Self-defined (randomed)
#python ${code_path}/seed_host_matcher.py -method randomly_generate \
#	-wkdir ${wk_dir} -n_seed 1 -match_scheme '{"0": "ranking"}' \
#	-match_scheme_param '{"0": 50000}'

#python ${code_path}/outbreak_simulator.py -config ${wk_dir}/slim.json

python -u ${code_path}/outbreak_simulator.py -config ${config_path} 


