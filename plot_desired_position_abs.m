%% plots the trajectory of the desired i-th robots position
% trajectories should move in formation with the reference frame and keept
% the relative positions assigned

% number of vehicles
N = size(simout.data,2);
figure;
for i=1:1:N
    % saves the x,y-values of the i-th robot in vectors
    x = reshape(simout.data(1,i,:), 1, size(simout.data,3));
    y = reshape(simout.data(2,i,:), 1, size(simout.data,3));
    plot(x,y);
    hold on;
end