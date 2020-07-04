#!/usr/bin/env python

import rospy
from std_msgs.msg import String, Header
import numpy as np

from scipy import signal, stats
import matplotlib.pyplot as plt
import math
from geometry_msgs.msg import Polygon, Point32, Vector3
from nav_msgs.msg import Odometry


# import vrep
import matplotlib.pyplot as plt
import sys

import time

#BaseFreq = -2.0
BaseFreq = 3.0

class Pursuit:
    def __init__(self):


        self.pos0 = Point32()
        self.pos1 = Point32()
        self.pos2 = Point32()
        # prepare the sub and pub
        self.sub_r_pos = rospy.Subscriber("/carPos", Point32, self.getPos, queue_size=1)
        self.sub_path = rospy.Subscriber("/carPath", Vector3, self.getPath, queue_size=1)
        self.pub_vel = rospy.Publisher("/carVel", Vector3, queue_size = 1)
        self.pub_pathNum = rospy.Publisher("/pathNum", Vector3, queue_size = 1)



        self.LCycleFreq = BaseFreq
        self.RCycleFreq = BaseFreq

        self.goal_received = False
        self.goal_reached = False

        self.rPose = None

        self.last_theta = 0
        self.path_num = 0

        self.pos = Point32()     # robot position
        self.ori = None     # robot orientation

        self.path = Vector3()      # destination points

        # self.kp = 0.9
        self.kp = 0.9
        # self.kd = -0.3
        self.kd = -0.0

        self.eta = None

        self.radiu = 0.15      # the dist from destination point that robot stop
        self.flag = False   # check if robot reach the destination point

        # for test :: to get the handle
        self.cube = None
        self.cube1 = None

        self.vel_diff = 0.02
        # self.vel_diff = 0.1
        self.vel_curr_left = 0
        self.vel_curr_right = 0

    def getPos(self, msg):
        """
        implement localization and getPath
        """

        self.pos = msg
        self.ori = msg.z
        

        self.controller()

    def getPath(self, msg):
        """
        get the path which need to track    TODO
        """
        # destination (for first step)
        self.path.x = msg.x
        self.path.y = msg.y



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
            self.RCycleFreq = BaseFreq + (self.kp * theta + (theta - self.last_theta) * self.kd)
            self.LCycleFreq = BaseFreq - (self.kp * theta + (theta - self.last_theta) * self.kd)

            # for acceleration
#            if abs(self.LCycleFreq - self.vel_curr_left) > 0.5 :
#                if self.LCycleFreq < self.vel_curr_left:
#                    self.vel_curr_left -= self.vel_diff
#                elif self.LCycleFreq > self.vel_curr_left:
#                    self.vel_curr_left += self.vel_diff
#            if abs(self.RCycleFreq - self.vel_curr_right) > 0.5 :
#                if self.RCycleFreq < self.vel_curr_right:
#                    self.vel_curr_right -= self.vel_diff
#                elif self.RCycleFreq > self.vel_curr_right:
#                    self.vel_curr_right += self.vel_diff
#            if self.vel_curr_left < BaseFreq - 1 :
#                self.vel_curr_left = BaseFreq - 2
#                self.vel_curr_right += 2
#            if self.vel_curr_right < BaseFreq - 1 :
#                self.vel_curr_right = BaseFreq - 2
#                self.vel_curr_left += 2
            
        else:
            print("goal reached !!")
            if self.path_num == 7:
                print("Bingo !!!")
                self.LCycleFreq = 0
                self.RCycleFreq = 0
                self.vel_curr_left = 0
                self.vel_curr_right = 0
            else:
                self.path_num += 1

        self.last_theta = theta

        vel = Vector3()
#        vel.x = self.vel_curr_left
#        vel.y = self.vel_curr_right
        vel.x = self.LCycleFreq
        vel.y = self.RCycleFreq

        pathMsg = Vector3()
        pathMsg.x = self.path_num

        self.pub_pathNum.publish(pathMsg)
        self.pub_vel.publish(vel)


if __name__=="__main__":
    rospy.init_node("AGV")
    Pursuit()
    rospy.spin()
