%% plot time changing graph topology from A_c_dist

clear all;
close all;

run('graph_topologies');
sim disturbed_adj;


v1 = timeseries(A_c_dist.Data(:,1,:), A_c_dist.time);

x = v1.time;
y = [1 2 3 4 5 6]';

c = v1.data;
c = reshape(c,5,length(x));

c = [c zeros(5,1)];
c = [c; zeros(1,size(c,2))];

figure;

A_c = [A_c zeros(5,1)];
A_c = [A_c; zeros(1,size(A_c,2))];

pcolor(A_c')
