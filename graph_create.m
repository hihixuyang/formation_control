function [A_c, A_c_2, A, A_2] = graph_create(connections, connections2, N)
%creates two random graphs using Erdos-Renyi-Algorithm of n-vehicles and
%finds minimum directed spanning tree of these two graphs
%
% Inputs:
%     N            - number of vehicles
%     connections  - to leader connected vehicles in graph 1
%     connections2 - to leader connected vehicles in graph 2
% Outputs:
%     A_c   - Consensus adjacency matrix graph 1 with virtual leader connections
%     A_c_2 - same as above for graph 2
%     A     - Adjacency matrix graph 1 without virtual leader
%     A_2   - same as above for graph 2


graphs = figure;
scrsz = get(groot,'ScreenSize');
set(graphs, 'Name', 'Communication Topologies', 'NumberTitle', 'off','OuterPosition',[0 0 scrsz(3)/2 scrsz(4)/2]);

% first graph
connect = zeros(1,N);

for i=1:1:length(connections)
    connect(connections(i)) = 1;
end

rnd_g = erdosRenyi(N,0.6,4);
G = graph(rnd_g.Adj,'upper','OmitSelfLoops');

subplot(2,2,1);
p = plot(G);
% find minimum spanning tree
[T,pred] = minspantree(G,'Type','forest','Root',connections(1));
highlight(p,T)
rootedTree = digraph(pred(pred~=0),find(pred~=0),[]);
subplot(2,2,2);
plot(rootedTree);

A = full(rootedTree.adjacency)'
A_c = [A connect'; zeros(1,N+1)]


% second graph
connect2 = zeros(1,N);

for i=1:1:length(connections2)
    connect2(connections2(i)) = 1;
end

rnd_g = erdosRenyi(N,0.6,4);
G = graph(rnd_g.Adj,'upper','OmitSelfLoops');

subplot(2,2,3);
p = plot(G);
[T,pred] = minspantree(G,'Type','forest','Root',connections2(1));
highlight(p,T)
rootedTree = digraph(pred(pred~=0),find(pred~=0),[]);
subplot(2,2,4);
plot(rootedTree);

A_2 = full(rootedTree.adjacency)'
A_c_2 = [A_2 connect2'; zeros(1,N+1)]

end

function [G]=erdosRenyi(nv,p,Kreg)
%Generates a random graph based on the Erdos and Renyi algoritm where all possible pairs of 'nv' nodes are
%connected with probability 'p'.
%
% Inputs:
%   nv - number of nodes
%   p  - rewiring probability
%   Kreg - initial node degree of for regular graph (use 1 or even numbers)
%
% Output:
%   G is a structure inplemented as data structure in this as well as other
%   graph theory algorithms.
%   G.Adj   - is the adjacency matrix (1 for connected nodes, 0 otherwise).
%   G.x and G.y -   are row vectors of size nv wiht the (x,y) coordinates of
%                   each node of G.
%   G.nv    - number of vertices in G
%   G.ne    - number of edges in G
%
%Created by Pablo Blinder. blinderp@bgu.ac.il
%
%Last update 25/01/2005

%build regular lattice
A=sparse(nv,nv);
Kreg=fix(abs(Kreg)/2);Kreg=(Kreg<1)+Kreg;

for k=1:Kreg
    A=sparse(A+diag(ones(1,length(diag(A,k))),k)+diag(ones(1,length(diag(A,nv-k))),nv-k));
end
ne0=nnz(A);
%find connected pairs
[v1,v2]=find(A);
% P=permPairs(nv);%my version is faster
Dis=(rand(length(v1),1)<=p);%pairs to disconnect
A(v1(Dis),v2(Dis))=0;
vDis=unique([v1(Dis),v2(Dis)]);%disconnected vertices
nDis=ne0-nnz(A);sum(Dis);

%cycle trough disconnected pairs
disconPairs=[v1(Dis),v2(Dis)];
for n=1:nDis
    %choose one of the vertices from the disconnected pair
    i=ceil(rand*size(disconPairs,1));
    j=logical(1+rand>0.5);
    vDisToRec=disconPairs(i,j);
    %find non adjacent vertices and reconnect
    adj=[find(A(:,vDisToRec)) ; find(A(vDisToRec,:))'];
    nonAdj=setdiff(1:nv,adj);
    vToRec=nonAdj(ceil(rand*length(nonAdj)));
    S=sort([vDisToRec vToRec]);
    A(S(1),S(2))=1;
end
[x,y]=getNodeCoordinates(nv);
%make adjacency matrix symetric
A=A+fliplr((flipud(triu(A))));
G=struct('Adj',A,'x',x','y',y','nv',nv,'ne',nnz(A));
end

function [x,y]=getNodeCoordinates(nv)
%Adapted from circle.m by Zhenhai Wang <zhenhai@ieee.org>. For more details
%see under  MATLAB Central >  File Exchange > Graphics > Specialized
%Plot and Graph Types > Draw a circle.

center=[0,0];
theta=linspace(0,2*pi,nv+1);
rho=ones(1,nv+1);%fit radius and nv
[X,Y] = pol2cart(theta',rho');
X=X+center(1);
Y=Y+center(2);
x=X(1:end-1)*10;
y=Y(1:end-1)*10;
end

