function [ adjacency ] = adjacency_weighted(graph)
% creates the adjacency matrix out of a graph with weights

nn = numnodes(graph);
[s,t] = findedge(graph);
A = sparse(s,t,graph.Edges.Weight,nn,nn);
% Transpose because of Wei Ren definition
A = A';
A = full(A);
adjacency = A;

end

