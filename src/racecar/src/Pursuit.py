# Using pd controller to pursuit as the path tracking method.


import vrep
import numpy as np
import matplotlib.pyplot as plt
import sys

import time
import math

LSignalName = "CycleLeft"
RSignalName = "CycleRight"
BaseFreq = -3
# BaseFreq = -4

class Pursuit:
    def __init__(self, client, leftName, rightname):
        self.clientID = client
        self.LSignalName = leftName
        self.RSignalName = rightname

        self.LCycleFreq = BaseFreq
        self.RCycleFreq = BaseFreq

        self.goal_received = False
        self.goal_reached = False

        self.rPose = None

        self.last_theta = 0

        self.pos = None     # robot position
        self.ori = None     # robot orientation
        self.pos_gyro = None

        self.path = []      # destination points

        self.kp = 0.3
        self.kd = -0.3

        self.eta = None

        self.radiu = 50      # the dist from destination point that robot stop
        self.flag = False   # check if robot reach the destination point

        # for test :: to get the handle
        self.cube = None
        self.cube1 = None


    def clearSignal(self):
        """
        clear the signal at the very begining
        """
        vrep.simxClearFloatSignal(self.clientID, self.LSignalName, vrep.simx_opmode_oneshot)
        vrep.simxClearFloatSignal(self.clientID, self.RSignalName, vrep.simx_opmode_oneshot)

    def preparation(self):
        """
        implement localization and getPath
        """

        error, self.cube = vrep.simxGetObjectHandle(clientID, 'body#1', vrep.simx_opmode_blocking)
        error, self.cube1 = vrep.simxGetObjectHandle(clientID, 'GyroSensor#1', vrep.simx_opmode_blocking)

        self.localization()
        self.orientation()
        self.getPath()

    def localization(self):
        """
        get the position of robot   TODO
        """
        # get position
        error, position_hexa_base = vrep.simxGetObjectPosition(clientID, self.cube, -1,
                                                                        vrep.simx_opmode_blocking)
        self.pos = [position_hexa_base[0], position_hexa_base[1]]

        # get orientation
        error, orientation_hexa_base = vrep.simxGetObjectOrientation(clientID, self.cube, -1,
                                                                              vrep.simx_opmode_blocking)
        self.ori = orientation_hexa_base[1]

        ############################################################################

        error, position_hexa = vrep.simxGetObjectPosition(clientID, self.cube1, -1,
                                                                        vrep.simx_opmode_blocking)
        self.pos_gyro = [position_hexa[0], position_hexa[1]]


        print("position :", self.pos)
        print("orientation : ", self.ori)       # TODO : orientation is in the world frame

    def orientation(self):
        """
        get the orientation of robot    TODO
        :return:
        """

    def get_x(self, point):
        """
        get the x of point
        :param point:
        :return:
        """
        return point[0]

    def get_y(self, point):
        """
        get the y of point
        :param point:
        :return:
        """
        return point[1]

    def getPath(self):
        """
        get the path which need to track    TODO
        """
        # destination (for first step)
        self.path = [[-1, 1], [10,15], [10,20], [10,25], [10,30]]

    def getCos(self):
        """
        get the cos theta of pos - pos_gyro - pos_path
        :return:
        """
        dis_r_2_gyro = ((self.get_x(self.pos) - self.get_x(self.pos_gyro)) ** 2 + (self.get_y(self.pos) - self.get_y(self.pos_gyro)) ** 2) ** (1 / 2)
        dis_r_2_path = ((self.get_x(self.pos) - self.get_x(self.path[0])) ** 2 + (self.get_y(self.pos) - self.get_y(self.path[0])) ** 2) ** (1 / 2)
        dis_gyro_2_path = ((self.get_x(self.pos_gyro) - self.get_x(self.path[0])) ** 2 + (self.get_y(self.pos_gyro) - self.get_y(self.path[0])) ** 2) ** (1 / 2)
        cos_theta = (dis_r_2_gyro ** 2 + dis_r_2_path ** 2 - dis_gyro_2_path ** 2) / (2 * dis_r_2_path * dis_r_2_gyro)
        return cos_theta

    def publish(self):
        """
        send msg to vrep
        msg : the frequency of leg
        """
        vrep.simxSetFloatSignal(self.clientID, self.LSignalName, self.LCycleFreq, vrep.simx_opmode_oneshot)
        vrep.simxSetFloatSignal(self.clientID, self.RSignalName, self.RCycleFreq, vrep.simx_opmode_oneshot)

    def getEta(self, pose):
        """
        get the eta between robot orientation and robot position to destination     TODO: how to get the delta orientation
        :param pose: tracking position
        :return: eta
        """
        dx = self.get_x(self.pos) + self.get_x(pose)
        dy = self.get_y(self.pos) - self.get_y(pose)
        tan = dy / dx
        self.eta = tan - self.ori
        return tan - self.ori

    def if_goal_reached(self, pose):
        """
        check iff dist between robot and destination is less than limit
        :return: True / False
        """
        dx = self.get_x(self.pos) - self.get_x(pose)
        dy = self.get_y(self.pos) - self.get_y(pose)
        dist = (dx ** 2 + dy ** 2) ** (1 / 2)
        if dist < self.radiu:
            self.goal_reached = True

    # def controller(self):
    #     """
    #     express the policy
    #     currently, simply using kp controller           TODO
    #     """
    #     if self.if_goal_reached(self.path[0]):      # TODO : how to get the exact point to track
    #         print("goal reached!!!")
    #         self.LCycleFreq = 0
    #         self.RCycleFreq = 0
    #     else:
    #         self.getEta(self.path[0])               # TODO : which pose??
    #         print("Error : ", self.eta)
    #         self.LCycleFreq = BaseFreq + self.kp * self.eta
    #         self.RCycleFreq = BaseFreq - self.kp * self.eta
    #
    #     self.publish()
    #     # self.clearSignal()

    def controller(self):
        cos_theta = self.getCos()       # TODO : using arcCos
        # print("cos_theta : ", cos_theta)
        theta = math.acos(cos_theta)
        print("Error : ", theta)
        self.LCycleFreq = BaseFreq + (self.kp * theta + (theta - self.last_theta) * self.kd)
        self.RCycleFreq = BaseFreq - (self.kp * theta + (theta - self.last_theta) * self.kd)

        # for test
        # self.LCycleFreq = -BaseFreq
        # self.RCycleFreq = BaseFreq

        self.last_theta = theta

        self.publish()



vrep.simxFinish(-1)  # clean up the previous stuff
clientID = vrep.simxStart('127.0.0.1', 19999, True, True, 5000, 5)
if clientID != -1:
    print('Connected to remote API server')
else:
    print('Connection unsuccessful')
    sys.exit('Error: Could not connect to API server')


pursuit = Pursuit(clientID, LSignalName, RSignalName)
while True:
    pursuit.clearSignal()
    pursuit.preparation()
    pursuit.controller()
    time.sleep(0.1)
