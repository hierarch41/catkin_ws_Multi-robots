clc;
clear;
figure(1)
load('/home/hierarch/catkin_ws_Multi-robots/fusion_data.txt');
pos_x = 0;
pos_y = 0;
heading = 0;
GPS_pos_x = 0;
GPS_pos_y = 0;
Odom_pos_x = 0;
Odom_pos_y = 0;
IMU_heading = 0;
data = fusion_data;

pos_x = data(:,1);
pos_y = data(:,2);
heading = data(:,3);
GPS_pos_x = data(:,4);
GPS_pos_y = data(:,5);
Odom_pos_x = data(:,7);
Odom_pos_y = data(:,8);
IMU_heading = data(:,6);

plot(pos_x,pos_y,'r');
hold on
plot(GPS_pos_x,GPS_pos_y,'b');
hold on;
plot(Odom_pos_x,Odom_pos_y,'g');