#!/usr/bin/env python
# encoding:utf-8



import requests 
import base64
import rospy
from geometry_msgs.msg import Quaternion, Point, Vector3, Twist
import time


PATH = '/home/luminescence/1.jpeg'




class gesture_control:
    def __init__(self):
        self.pub_vel = rospy.Publisher("/turtle1/cmd_vel", Twist, queue_size = 1)
        self.vel = Twist()
        self.run()

    def get_token_key(self):
        # client_id 为官网获取的AK， client_secret 为官网获取的SK
        client_id = 'vhCvHxbqGPi1rHMomEtGGSQG'  # API key
        client_secret = 'Lv4EoOrm8ZMHKTcxTlGigSSzkUm5gVkz'  # Secret key
        # url = f'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials'+'&client_id={client_id}&client_secret={client_secret}'
        url = 'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=vhCvHxbqGPi1rHMomEtGGSQG&client_secret=Lv4EoOrm8ZMHKTcxTlGigSSzkUm5gVkz'
        headers = {'Content-Type': 'application/json; charset=UTF-8'}   
        res = requests.post(url, headers=headers)
        token_content = res.json()
        token_key = token_content['access_token']
        return token_key


    '''
    手势识别
    '''
    def recognition(self, path):
        request_url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/gesture"
        # 二进制方式打开图片文件
        f = open(path, 'rb')
        img = base64.b64encode(f.read())
    
        params = {"image":img}
        access_token = self.get_token_key()
        request_url = request_url + "?access_token=" + access_token
        headers = {'content-type': 'application/x-www-form-urlencoded'}
        response = requests.post(request_url, data=params, headers=headers)
        if response:
            print (response.json()['result'][0]['classname'])
            return (response.json()['result'][0]['classname'])


    def run(self):
        judge = self.recognition(PATH)
        if judge == 'Insult':
            self.run1()
        elif judge == 'Two':
            self.run2()

    def run1(self):
        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.angular.z = -1.6
        self.pub_vel.publish(self.vel)
        time.sleep(3)
        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.linear.x = 1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)

    def run2(self):
        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.linear.x = 1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)
        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.angular.z = -1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)

        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.linear.x = 1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)
        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.angular.z = -1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)

        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.linear.x = 1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)
        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.angular.z = 1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)

        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.linear.x = 1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)
        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.angular.z = 1.5
        self.pub_vel.publish(self.vel)
        time.sleep(3)

        self.vel.linear.x = 0
        self.vel.angular.z = 0
        self.vel.linear.x = 1.5
        self.pub_vel.publish(self.vel)


            
            



if __name__=="__main__":
    rospy.init_node("gesture_control")
    gesture_control()
    rospy.spin()



