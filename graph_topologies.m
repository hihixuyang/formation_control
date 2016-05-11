%% creates directed graph as consensus tracking topology and adjacency and laplacian matrix
% Creating directed graph

% Starting points for directed graph
s = [1 1 2 3 4 4 6];
% Ending points for directed graph
t = [2 4 3 4 2 5 1];
% weights of edges
w = [1 1 1 1 1 1 1];

G_c = digraph(s,t,w);

% Adjacency matrix with weights / direct reconstruction with adjacency(A)
% not possible because without weights!
disp('Adjacency matrix consensus tracking topology');
A_c = adjacency_weighted(G_c)

disp('Laplacian matrix consensus tracking topology');
L_c = laplacian_digraph(A_c)

%% creates directed graph as disturbed consensus tracking toplogy and ajacency matrix
% Starting points for directed graph
s = [1 1 3 4 1 6];
% Ending points for directed graph
t = [2 4 4 2 5 1];
% weights of edges
w = [1 1 1 1 1 1];

G_c_dist = digraph(s,t,w);

% Adjacency matrix with weights / direct reconstruction with adjacency(A)
% not possible because without weights!
disp('Adjacency matrix disturbed consensus tracking topology');
A_c_2 = adjacency_weighted(G_c_dist)


%% creates directed graph for vehicle control level topology and adjacency and laplacian matrix

% Starting points for directed graph
s = [1 1 2 2 3 3 3];
% Ending points for directed graph
t = [2 4 1 3 1 4 5];
% weights of edges
w = [1 1 1 1 1 1 1];

G_v = digraph(s,t,w);

% Adjacency matrix with weights / direct reconstruction with adjacency(A)
% not possible because without weights!
disp('Adjacency matrix vehicle control topology');
A_v = adjacency_weighted(G_v)

disp('Laplacian matrix vehicle control topology');
L_v = laplacian_digraph(A_v)

%% plot of topologies

scrsz = get(groot,'ScreenSize');
h = figure('OuterPosition',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
subplot(1,3,1), plot(G_c)
title('Consensus graph topology');
subplot(1,3,2), plot(G_c_dist)
title('Consensus graph disturbed topology');
subplot(1,3,3), plot(G_v)
title('Inter vehicle communication topology');
set(h, 'Name', 'Graph Topologies', 'NumberTitle', 'off');

