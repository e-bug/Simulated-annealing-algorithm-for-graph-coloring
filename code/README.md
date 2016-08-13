The main algorithm is in final.m which loads the data from a file "graph_adjacency_matrix.mat" and saves 
- the coloring
- the residual energy
- the number of steps used
in the struct "result"

There are also 3 scripts that test the various schedules and give a plot of the avg min residual energy as function of c

All these scripts need the functions:
accept_reject.m
compute_delta.m
generate_graph.m
h_init.m