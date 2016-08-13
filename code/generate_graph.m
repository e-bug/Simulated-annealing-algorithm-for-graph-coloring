function [G,vertex_color]= generate_graph(N,c,q)

p=c/N;

G = rand(N,N) < p;
G = triu(G,1);
G = G + G'; 

vertex_color = ceil(rand(1,N)*q);

end