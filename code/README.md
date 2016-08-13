The main algorithm is in <a href="final.m">final.m</a> which loads the data from a file <a href="graph_adjacency_matrix.mat">graph_adjacency_matrix.mat</a> and saves 

<ul style="text-align: justify;">
 	<li> the coloring</li><br/>
 	<li>the residual energy</li><br/>
 	<li>the number of steps used</li>
</ul>
in the struct <a href="result_404.mat">result</a>.

There are also 3 scripts that test the various schedules and give a plot of the avg min residual energy as function of c.</br>
All these scripts need the functions:</br>
<a href="accept_reject.m">accept_reject.m</a></br>
<a href="compute_delta.m">compute_delta.m</a></br>
<a href="generate_graph.m">generate_graph.m</a></br>
<a href="h_init.m">h_init.m</a>
