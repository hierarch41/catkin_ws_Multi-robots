编译：catkin_make
source devel/setup.bash

加载多个机器人模型到gazebo：
	设置机器人种类：export ROBOT_MODEL=waffle

加载单个机器人：roslaunch robots_gazebo Single_robot_empty_world.launch

加载多个机器人：	roslaunch robots_gazebo multi_robots.launch
启动键盘控制单独一个机器人：
	ROS_NAMESPACE=tb3_0 rosrun robots_teleop turtlebot3_teleop_key
分别启动每个机器人的SLAM建图程序
	设置机器人种类：export ROBOT_MODEL=waffle
		       export ROBOT_MODEL=Burger
	ROS_NAMESPACE=tb3_0 roslaunch robots_slam robot_gmapping.launch set_base_frame:=tb3_0/base_footprint set_odom_frame:=tb3_0/odom set_map_frame:=tb3_0/map
启动合并地图程序
	roslaunch robots_gazebo multi_map_merge.launch
启动RViz
	rosrun rviz rviz -d `rospack find robots_gazebo`/rviz/multi_robots_slam.rviz



需要：单独编译navi包：catkin_make  -DCATKIN_WHITELIST_PACKAGES="navi"

运行融合程序：roslaunch navi navi.launch



打开matlab：cd ~/Software/matlab/bin

​						sudo ./matlab



2019.10.25更新;

​	实现单个机器人的传感器数据消息获取。

2019.10.29更新;

​	建立初步的GPS+IMU+Odom融合框架：

GPS(x, y, heading), IMU(yaw_rate), odometry(speed) are used for sensor input.

存在问题：根据GPS计算得到的航向角错误；

2019.10.30更新;

​	GPS无法直接得到航向角，计算得到的结果误差也很大，暂时不考虑GPS的航向角，用IMU输出的yaw代替。

​	将融合结果写入txt文件中，准备用matlab画出轨迹，分析融合效果；

2019.10.31更新;

​	用matlab画出融和后位置与GPS结果对比，有时候会出现融和结果跑飞的情况。



2019.11.05更新：

​	之前的算法中的角速度计算符号错误；预测过程出错导致转弯出错，目前已解决。



gazebo中加入传感器：

GPS插件：

<gazebo>
      <plugin name="gps" filename="libhector_gazebo_ros_gps.so">
          <updateRate>10.0</updateRate>
          <topicName>sensor_msgs/NavSatFix</topicName>
          <gaussianNoise>0.0 0.0 0.0</gaussianNoise>
          <offset>0 0 0</offset>
          <velocityGaussianNoise>0 0 0</velocityGaussianNoise>
          <frameId>base_link</frameId>
      </plugin>
  </gazebo>

​	

UWB插件

     <plugin name='libgtec_uwb_plugin' filename='libgtec_uwb_plugin.so'>
      <update_rate>25</update_rate>
      <nlosSoftWallWidth>0.25</nlosSoftWallWidth>
      <tag_z_offset>1.5</tag_z_offset>
      <tag_link>tag_0</tag_link>
      <anchor_prefix>uwb_anchor</anchor_prefix>
      <all_los>false</all_los>
      <tag_id>0</tag_id>
    </plugin># Multi-robots
