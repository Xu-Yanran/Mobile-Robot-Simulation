#include <ros/ros.h>
#include <serial/serial.h>
//ROS已经内置了的串口包
#include <std_msgs/String.h>
#include <std_msgs/Empty.h>
#include "joint_msg/joint_msg.h"
#include <boost/asio.hpp>                  //包含boost库函数
 
 
using namespace boost::asio;           //定义一个命名空间，用于后面的读写操作
using namespace std;
serial::Serial ser; //声明串口对象
io_service m_ios;
serial_port *pSerialPort;
boost::system::error_code ec;
std::string serial_port_name;
int serial_baudrate = 115200;
unsigned char AA=1;
unsigned char aa;
unsigned char mid_num = 1;//电机ID记录
unsigned char charArray[50]={0};
float fArray[50]={0};
//回调函数
void write_callback(const joint_msg::joint_msg::ConstPtr& msg)
{
    ROS_INFO_STREAM("Writing to serial port" <<msg->id<<": "<<msg->r);
    unsigned char mid=(char) msg->id;
    double r=msg->r;
   
   //转换数据到字节数组 
    unsigned char i;
    float floatVariable = r; 
    unsigned short int intVariable = 1000*(floatVariable/(2*3.14159)+0.5);
    printf("%d \n",intVariable);
     
    unsigned char *pdata = (unsigned char *) &intVariable; //把float类型的指针强制转换为unsigned char型
     for(i=0;i<2;i++)
    {
        charArray[i] = *pdata++;//把相应地址中的数据保存到unsigned char数组中     
       
    }
    try
    {
    
     size_t len = ser.write(charArray,2);
     
    }catch (boost::system::system_error e){
        ROS_ERROR_STREAM("serail write err ");
 
    }
}
 
int main (int argc, char** argv)
{
 
    //初始化节点
    ros::init(argc, argv, "jointserial");
    //声明节点句柄
    ros::NodeHandle nh;
 
    //订阅主题，并配置回调函数
    ros::Subscriber write_sub = nh.subscribe("/arm_motors", 1000, write_callback);
    
   //打开串口
  try {
    ser.setPort("/dev/ttyUSB0");
    ser.setBaudrate(115200);
    serial::Timeout to = serial::Timeout::simpleTimeout(1000);
    ser.setTimeout(to);
    ser.open();
  } catch (serial::IOException &e) {
    ROS_ERROR_STREAM("Unable to open port ");
    return -1;
  }
 
  if (ser.isOpen()) {
    ROS_INFO_STREAM("Serial Port initialized");
  } else {
    return -1;
  }

  ROS_INFO("-------------xarm joint serail is running .");
  ros::spin();
 
  return 0;
 
   
}
 
