1，新建一个文件夹，mkdir test
2,进入新建的文件夹，cd test
3,新建文件夹 src, mkdir src

4, 拷贝car4wd到src
5,编译  catkin_make
6 source devel/setup.bash

##############################################
在gazebo中仿真
roslaunch car4wd my_simrobot_bringup.launch

键盘控制机器人
rosrun teleop teleop
WASD为控制机器人运动方向，Ｗ前进，Ａ右转，Ｓ左转，Ｄ后退
shift为提高机器人移动速度

在gazebo中建图
1. 开启gazebo仿真和rviz可视化 roslaunch car4wd sim_gmapping_bringup.launch　
2. 键盘控制机器人移动 rosrun teleop teleop　
3. 保存地图　新开终端 rosrun map_server map_saver -f ___/car4wd/map/___（car4wd前面的路径根据实际安装情况,map后横线为保存的地图名）　例如 rosrun map_server map_saver -f ~/catkin_ws/src/car4wd/map/new_map

导航







