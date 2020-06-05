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
// unsigned char charArray[50]={0};
float fArray[50]={0};


unsigned char id[6] = {6, 5, 4, 3, 2};   //For Servo 5, POS should be less than 850
unsigned short int pos[6] = {500, 500, 500, 500, 500};
#define SERVO_NUM 5
#define ARM_SERVO_FRAME_HEADER         0x55

#define GET_LOW_BYTE(A) ((unsigned char)(A))
//宏函数 获得A的低八位
#define GET_HIGH_BYTE(A) ((unsigned char)((A) >> 8))
//宏函数 获得A的高八位

// 改变转动方向
unsigned short int ReverseDirection(unsigned short int ang)
{
	return (-(ang - 500)+500);
}

//******************************************************//
//Description: This function aims to control multiple   //
//             servos within the arm by giving the ids  //
//             and positions of them and time range for //
//             them to arrive to those positions.       //
//******************************************************//
void ArmSerialServoMove(unsigned char n, unsigned short int time, unsigned char id[], unsigned short int position[])
{
    unsigned char i;  
    unsigned char buf[25];
    
    buf[0] = buf[1] = ARM_SERVO_FRAME_HEADER;
    buf[2] = 3*n+5;
    buf[3] = 0x03;
	  buf[4] = n;
	  buf[5] = GET_LOW_BYTE(time);
    buf[6] = GET_HIGH_BYTE(time);
 for (i=0; i<7; i++)
    printf("%02X \n",buf[i]);
	for (i=0; i<n; i++) {
		if(position[i] < 0)
            position[i] = 0;
      	if(position[i] > 1000)
	      	position[i] = 1000;
	  
	  	buf[7+3*i] = id[i];
      	buf[8+3*i] = GET_LOW_BYTE(position[i]);
      	buf[9+3*i] = GET_HIGH_BYTE(position[i]);
        printf("%02X \n",buf[7+3*i]);
        printf("%02X \n",buf[8+3*i]);
        printf("%02X \n",buf[9+3*i]);
	}
    
    ser.write(buf, 7+3*n);
    
}


//回调函数
void write_callback(const joint_msg::joint_msg::ConstPtr& msg)
{
    ROS_INFO_STREAM("Writing to serial port" <<msg->id<<": "<<msg->r);
    unsigned char mid = (char) msg->id;
    double r = msg->r;
    
    //记录已经收到多少个数据
    static int count=0;  //static自动初始化为0

   //转换数据到字节数组 
    unsigned char i;
    float floatVariable = r; 
    unsigned short int intVariable = 1000*(floatVariable/(2*3.14159)+0.5);
    printf("%d \n",intVariable);
     
    // unsigned char *pdata = (unsigned char *) &intVariable; //把unsigned short int类型的指针强制转换为unsigned char型
    // for(i=0;i<2;i++)
    // {
    //     charArray[i] = *pdata++;//把相应地址中的数据保存到unsigned char数组中           
    // }
    // 不需要再进行转换了, 转换函数要求的就是int

    //储存角度到数组里
    pos[count] = intVariable; 
    count++; 

    //如果收到5个角度位置就发送
    if (count == SERVO_NUM) 
    {  	
    	try
    	{
     		//size_t len = ser.write(charArray,2);

    		//第4 5号电机转动方向和规划方向相反
         pos[1] = ReverseDirection(pos[1]);
    		 pos[2] = ReverseDirection(pos[3]);
    		 pos[3] = ReverseDirection(pos[4]);
     
     		ArmSerialServoMove(SERVO_NUM, 10, id, pos); // 要控制电机数 完成指令时长 要控制的电机id数组 对应的角度数组
     		count = 0;
    	} catch (boost::system::system_error e){
        	ROS_ERROR_STREAM("serail write err ");
    	}
    }

}
 
int main (int argc, char** argv)
{
 
    //初始化节点
    ros::init(argc, argv, "joint_interpolation");
    //声明节点句柄
    ros::NodeHandle nh;
 
    //订阅主题，并配置回调函数
    ros::Subscriber write_sub = nh.subscribe("/arm_motors", 1000, write_callback);
    
   //打开串口
  try {
    ser.setPort("/dev/ttyUSB0");
    ser.setBaudrate(9600);
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
 
