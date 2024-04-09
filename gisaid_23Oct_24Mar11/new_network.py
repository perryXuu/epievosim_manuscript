import networkx as nx

density_file = "/Users/px54/Documents/TB_software/manuscript_test/gisaid_23Oct_24Mar11/rescaled_density.txt"

f = open(density_file, "r")
den_txt = f.readlines()
den_txt_adjusted = den_txt[0].rstrip("\n")
density = [int(i) for i in den_txt_adjusted.split(" ")]

G = nx.random_degree_sequence_graph(density, seed=313, tries=10)

nx.write_adjlist(ntwk_, os.path.join(wk_dir, "/Users/px54/Documents/TB_software/manuscript_test/gisaid_23Oct_24Mar11/rescaled_contact.adjlist"))