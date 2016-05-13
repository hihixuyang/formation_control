function [r_rel_1, r_rel_2, r_rel_3] = create_r_relative(N)
%creates three formations of n-vehicles in different shapes
%
% Inputs:
%     N - number of vehicles
% Outputs:
%     r_rel_1 - first formation here line-shape
%     r_rel_2 - second formation here heart-shape
%     r_rel_3 - third formation here circle-shape

% line shape
length_line = 1;
r_rel_line = [zeros(1,N); linspace(length_line/2,-length_line/2,N)];

% heart shape
flag = false;
r_rel_heart = zeros(2,N);
% checks if odd number of vehicles
if (mod(N,2) == 1)
    r_rel_heart(:,N) = [0;-1];
    N = N-1;
    flag = true;
end
for i=1:2:N
    t = 1/N*i;
    r_rel_heart(1,i) = (-3*t^2+2*t+1)*sin(t);
    r_rel_heart(2,i) = (-3*t^2+2*t+1)*cos(t)-1;
    r_rel_heart(1,i+1) = -(-3*t^2+2*t+1)*sin(t);
    r_rel_heart(2,i+1) = (-3*t^2+2*t+1)*cos(t)-1;
end
if (flag)
    N = N + 1;
end

% circle shape
r_rel_circle = zeros(2,N);
for i=1:1:N
    r_rel_circle(:,i) = [cos(2*pi/N*(i-1)); sin(2*pi/N*(i-1))];
end

% parabolic shape
r_rel_parabol = zeros(2,N);
r_rel_parabol(2,:) = linspace(-1,1,N);
r_rel_parabol(1,:) = (r_rel_parabol(2,:).^2)*(-1);


r_rel_1 = r_rel_line;
r_rel_2 = r_rel_parabol;
r_rel_3 = r_rel_circle;

% plot of formations
pos = figure;
scrsz = get(groot,'ScreenSize');
set(pos, 'Name', 'Relative positions2 / Formation', 'NumberTitle', 'off', 'OuterPosition',[0 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);

for i=1:1:N
    subplot(1,3,1);
    plot(r_rel_1(1,i), r_rel_1(2,i),'d');
    hold on;
    subplot(1,3,2);
    plot(r_rel_2(1,i), r_rel_2(2,i),'d');
    hold on;
    subplot(1,3,3);
    plot(r_rel_3(1,i), r_rel_3(2,i),'d');
    hold on;
end

subplot(1,3,1);
plot(0,0,'x');
subplot(1,3,2);
plot(0,0,'x');
subplot(1,3,3);
plot(0,0,'x');
end

