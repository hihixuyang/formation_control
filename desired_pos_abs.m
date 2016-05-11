function [r_d] = desired_pos_abs(xi_ref, r_relative)
% desired_pos_abs computes the desired absolute positions depending on the
% reference frame and the relative coordinates of the desired positions
% outputs x_d and y_d in a vector r_d
% inputs are xi_ref = [x_coordinate_frame, y_coordinate_frame,
% theta_coordinate frame] the reference frame

r_d = zeros(size(r_relative));

for i=1:1:size(r_relative,2)
    r_d(:,i) = xi_ref(1:2) + [cos(xi_ref(3)) -sin(xi_ref(3)); sin(xi_ref(3)) cos(xi_ref(3))]*r_relative(:,i);
end

end

