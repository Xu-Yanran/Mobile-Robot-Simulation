#!/usr/bin/env python

import rospy
from std_msgs.msg import String, Header
import numpy as np

from scipy import signal, stats
import matplotlib.pyplot as plt
import math
from geometry_msgs.msg import Quaternion, Point, Vector3, Twist
from nav_msgs.msg import Odometry

import matplotlib.pyplot as plt
import sys

import time

BaseSpeed = 1.0

class Controller:
    def __init__(self):

        # prepare the sub and pub
        self.sub_odom = rospy.Subscriber("/odom", Odometry, self.getOdom, queue_size=1)
        # self.sub_path = rospy.Subscriber("/carPath", Vector3, self.getPath, queue_size=1)
        self.pub_vel = rospy.Publisher("/cmd_vel", Twist, queue_size = 1)
        # self.pub_pathNum = rospy.Publisher("/pathNum", Vector3, queue_size = 1)

        self.goal_received = False
        self.goal_reached = False

        self.last_theta = 0
        self.path_num = 0

        self.pos = Point()     # robot position
        self.ori = Quaternion()     # robot orientation

        self.path = Vector3()
        self.path.x = 1.0
        self.path.y = 1.0


        # self.kp = 0.3
        self.kp = 0.9
        # self.kd = -0.3
        self.kd = -0.0

        self.eta = None

        self.radiu = 0.15      # the dist from destination point that robot stop
        self.flag = False   # check if robot reach the destination point

        self.vel = Twist()


    def getOdom(self, msg):
        """
        implement localization and getPath
        """

        self.pos = msg.pose.pose.position
        self.ori = msg.pose.pose.orientation
        

        self.controller()

    # def getPath(self, msg):
    #     """
    #     get the path which need to track    TODO
    #     """
    #     # destination (for first step)
    #     self.path.x = msg.x
    #     self.path.y = msg.y



    def getEta(self, pose):
        """
        get the eta between robot orientation and robot position to destination
        :param pose: tracking position
        :return: eta
        """
        vector_x = np.cos(self.ori) * (pose.x - self.pos.x) + np.sin(self.ori) * (pose.y - self.pos.y)
        vector_y = -np.sin(self.ori) * (pose.x - self.pos.x) + np.cos(self.ori) * (pose.y - self.pos.y)
        eta = math.atan2(vector_y, vector_x)
        return eta

    def if_goal_reached(self, pose):
        """
        check iff dist between robot and destination is less than limit
        :return: True / False
        """
        dx = self.pos.x - pose.x
        dy = self.pos.y - pose.y
        dist = math.sqrt(dx ** 2 + dy ** 2)
        return dist < self.radiu

    def controller(self):
        # theta = self.getEta(self.path[self.path_num])
        theta = self.getEta(self.path)
        if theta < 0:
            if theta < -1.6:
                theta = -3.14 - theta
        else:
            if theta > 1.6:
                theta = 3.14 - theta
        

        if not self.if_goal_reached(self.path):
            self.vel.linear.x = BaseSpeed
            self.vel.linear.y = BaseSpeed
            self.vel.angular.z = (self.kp * theta + (theta - self.last_theta) * self.kd)
        else:
            print("goal reached !!")
            self.vel.linear.x = 0
            self.vel.linear.y = 0


        self.last_theta = theta

        vel = Vector3()
        vel.x = self.vel_curr_left
        vel.y = self.vel_curr_right

        pathMsg = Vector3()
        pathMsg.x = self.path_num

        self.pub_pathNum.publish(pathMsg)
        self.pub_vel.publish(vel)


if __name__=="__main__":
    rospy.init_node("Traj_Follow")
    Controller()
    rospy.spin()
