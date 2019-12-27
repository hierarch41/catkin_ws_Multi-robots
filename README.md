Multi-robots  collaboration：

​	这是一个基于gazebo的多机器人协同建图程序框架，目前可加载6各机器人，并且分别搭载了单线激光雷达、深度摄像头、GPS、IMU和里程计和UWB等传感器。

参考链接：本程序主要参考该多机器人建图教程：https://www.ncnynl.com/archives/201811/2790.html  

![使用三个小机器人进行建图 from 2019-12-25 09-31-35](/home/hierarch/Desktop/使用三个小机器人进行建图 from 2019-12-25 09-31-35.png)

使用方法：（目前可先删除src中gazebosensorplugins和navi这两个包，因为gazebosensorplugins仅适用于gazebo-9，navi还在进一步开发中）

1、编译：catkin_make
source devel/setup.bash

2、加载多个机器人模型到gazebo：

加载多个机器人：	roslaunch robots_gazebo multi_robots.launch

（加载单个机器人：  roslaunch robots_gazebo Single_robot_empty_world.launch   ）


3、分别启动每个机器人的SLAM建图程序
	分别打开一个新终端：ROS_NAMESPACE=tb3_0 roslaunch robots_slam robot_gmapping.launch set_base_frame:=tb3_0/base_footprint set_odom_frame:=tb3_0/odom set_map_frame:=tb3_0/map

​	分别打开一个新终端：ROS_NAMESPACE=tb3_1 roslaunch robots_slam robot_gmapping.launch set_base_frame:=tb3_1/base_footprint set_odom_frame:=tb3_1/odom set_map_frame:=tb3_1/map

​	分别打开一个新终端：ROS_NAMESPACE=tb3_2 roslaunch robots_slam robot_gmapping.launch set_base_frame:=tb3_2/base_footprint set_odom_frame:=tb3_2/odom set_map_frame:=tb3_2/map

4、启动合并地图程序
	roslaunch robots_gazebo multi_map_merge.launch
5、启动RViz
	rosrun rviz rviz -d `rospack find robots_gazebo`/rviz/multi_robots_slam.rviz# catkin_ws_Multi-robots
