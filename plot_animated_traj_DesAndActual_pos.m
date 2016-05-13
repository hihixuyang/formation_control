%% creates a video of the trajectories of the desired robots position and its actual positions
% trajectories should move in formation with the reference frame and keep
% the relative positions assigned

% number of vehicles
N = size(simout1.data,2);
% number of timesteps
timesteps = size(simout1.data,3);

figure('Position',[0 100 800 800]);

% color vector
c = ['b','m','k','r','g','b','m','k','r','g','b','m','k','r','g','b','m',...
    'k','r','g','b','m','k','r','g','b','m','k','r','g','b','m','k','r',...
    'g','b','m','k','r','g','b','m','k','r','g','b','m','k','r','g'];

v = VideoWriter('C:\Users\Jens\Documents\Uni Stuttgart\BA\BA ohne Video\Matlab\Consensus_wheeled_formation\4 formation_control\Videos\vehicle_trajectories_changed4.mp4', 'MPEG-4');
v.FrameRate = 60;
open(v);

% loop over each data entry of the simout results
for j=1:5:(timesteps)
    % plot of the reference frame trajectory
    plot(xi_ref.data(:,1),xi_ref.data(:,2));
    axis([-2 2 -1 3])
    hold on;
    
    % loop over each vehicle
    for i=1:1:N
        % plots the x,y-values of the actual i-th robot position
        x = simout1.data(1,i,j);
        y = simout1.data(2,i,j);
        plot(x,y,'d','Color',c(i));
        
        % plots i-th robot desired position
        %         x_ref = simout.data(1,i,j);
        %         y_ref = simout.data(2,i,j);
        %         plot(x_ref, y_ref,'o', 'Color',c(i));
        
        axis([-2 2 -1 3]);
    end
    writeVideo(v,getframe);
    %     legend('ref','v1','v1_des','v2','v2_des','v3','v3_des','v4','v4_des');
    hold off;
end

close(v);