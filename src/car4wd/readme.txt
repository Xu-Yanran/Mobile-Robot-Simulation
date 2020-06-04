##############################################
＃＃＃　　　　　　　　准备部分             　　＃＃＃
##############################################
1，新建一个文件夹，
    eg: mkdir catkin_ws
2,进入新建的文件
    eg: cd catkin_ws
3,新建源码文件夹 src
    mkdir src
4,拷贝功能包car4wd和teleop到src目录下
5,进入刚才新建的文件夹catkin_ws并编译
    eg: cd ~/catkin_ws 进入刚才新建的文件夹
        catkin_make 编译文件夹
6,在新建文件夹目录下配置环境
    source ./devel/setup.bash

##############################################
＃＃＃　　　　　　　　实验部分             　　＃＃＃
##############################################

#######################
在gazebo中仿真
roslaunch car4wd my_simrobot_bringup.launch

#######################
键盘控制机器人
rosrun teleop teleop
WASD为控制机器人运动方向，Ｗ前进，Ａ左转，D右转，S后退
shift为提高机器人移动速度

#######################
在gazebo中建图
1. 开启gazebo仿真和rviz可视化 roslaunch car4wd sim_gmapping_bringup.launch　
2. 键盘控制机器人移动 rosrun teleop teleop　
3. 保存地图　新开终端 rosrun map_server map_saver -f ___/car4wd/map/___（car4wd前面的路径根据实际安装情况,map后横线为保存的地图名）　例如 rosrun map_server map_saver -f ~/catkin_ws/src/car4wd/map/new_map

#######################
在gazebo中导航
roslaunch car4wd sim_navigation_bringup.launch 打开gazebo仿真以及rviz，在rviz里通过最上排绿箭头"2D Nav Goal"设置导航目标点
(将gmapping建图保存名为map，或者修改/car4wd/launch/include/my_map_server.launch.xml文件第三行最后.yaml文件为你所保存的地图名)







