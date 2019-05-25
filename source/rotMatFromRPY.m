function R=rotMatFromRPY(roll,pitch,yaw)
%Creates rotation matrix from roll,pitch and yaw
R_x=[1 0 0; 0 cos(roll) -sin(roll);0 sin(roll) cos(roll)];
R_y=[cos(pitch) 0 sin(pitch);0 1 0;-sin(pitch) 0 cos(pitch)];
R_z=[cos(yaw) sin(yaw) 0;-sin(yaw) cos(yaw) 0; 0 0 1];

R=R_z*R_y*R_x;

end