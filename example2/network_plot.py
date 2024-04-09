import networkx as nx
import random
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.cm as cm
import matplotlib.colors as mcolors


path_network = "/Users/px54/Documents/TB_software/manuscript_test/example2/BA_highhigh/contact_network.adjlist"
ntwk = nx.read_adjlist(path_network)


#nx.draw_networkx(G, with_labels=False, node_size=1)

fig, ax = plt.subplots()
#degree_sequence = sorted((d for n, d in G.degree()), reverse=True)
#dmax = max(degree_sequence)

degrees = [ntwk.degree(n) for n in ntwk.nodes()]
degree_counts, bins, _ = ax.hist(degrees, bins=range(min(degrees), max(degrees) + 1, 1), color='grey')
max_count = np.max(degree_counts)
annotation_height = max_count + max_count * 0.1 

seed_size = 5
cmap = cm.get_cmap('viridis')
values = np.linspace(0, 1, seed_size)
colors = cmap(values)
hex_codes = [mcolors.to_hex(color) for color in colors]
print(hex_codes)
color_dict = {i : hex_codes[i] for i in range(seed_size)}


match_dict={}
## highhigh
# match_dict = {4:'1387', 0:'2040', 1:'3178', 3:'3858', 2:'7191'}
with open("/Users/px54/Documents/TB_software/manuscript_test/example2/BA_highhigh/seed_host_match.csv", "r") as csv:
	for line in csv:
		if line.startswith("seed")==False:
			ll = line.rstrip("\n")
			l = ll.split(",")
			match_dict[int(l[0])]=l[1]
## highlow
#with open("/Users/px54/Documents/TB_software/manuscript_test/example2/BA_highlow/seed_host_match.csv", "r") as csv:
#	for line in csv:
#		if line.startswith("seed")==False:
#			ll = line.rstrip("\n")
#			l = ll.split(",")
#			match_dict[int(l[0])]=l[1]
print(match_dict)
for seed_id, host_id in match_dict.items():
	host_degree = ntwk.degree(host_id)
	print(ntwk.degree(host_id))
	# Draw a vertical line for the matched host
	ax.axvline(x=host_degree, color=color_dict[seed_id], linestyle='--', lw=1)
	# Annotate the line with seed_id
	ax.text(host_degree, annotation_height, f'{seed_id}', rotation=45, color=color_dict[seed_id], fontsize=8, ha='right', va='bottom')
	annotation_height = annotation_height + max_count * 0.1 

ax.set_ylim(top=annotation_height + max_count * 0.2)
ax.set_xlim(1, 50)



# the histogram of the data
#ax.bar(*np.unique(degree_sequence, return_counts=True))

ax.set_xlabel('Degrees')
ax.set_ylabel('Host Counts')
ax.set_title('Contact network degree histogram')

# Tweak spacing to prevent clipping of ylabel
fig.tight_layout()
plt.show()




