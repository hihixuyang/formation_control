%% Example about of the relativ positions
% plots
clear;
close all;

% parameters to initializa relativ positions
l = 0.6;
phi = zeros(4,1);
r_relative = zeros(2,4);

% relative position (x_rel, y_rel) to coordinate frame for the i-th vehicle
% here 4 vehicles
for i=1:1:4
    phi(i) = pi/4 + pi/2*(i-1);
    r_relative(:,i) = [l*cos(phi(i)); l*sin(phi(i))];
end


plot(r_relative(1,:), r_relative(2,:),'bd');
hold on;

% calculates the absolute positions regarding a reference frame
des_pos_abs = desired_pos_abs([0;0;pi/4], r_relative);

plot(des_pos_abs(1,:), des_pos_abs(2,:), 'rd');
