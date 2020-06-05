// 包含miveit的API头文件
#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>

#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>

//#include <moveit_visual_tools/moveit_visual_tools.h>

int main(int argc, char **argv)
{
  ros::init(argc, argv, "moveit_custom_demo");
  ros::NodeHandle node_handle; 
  ros::AsyncSpinner spinner(1);
  spinner.start();

  static const std::string PLANNING_GROUP = "arm";
 // moveit::planning_interface::MoveGroupInterface group("arm");
 moveit::planning_interface::MoveGroupInterface move_group(PLANNING_GROUP);

 
  // 设置机器人终端的目标位置
 /* geometry_msgs::Pose target_pose1;
  target_pose1.orientation.w = 0.726282;
  target_pose1.orientation.x= 4.04423e-07;
  target_pose1.orientation.y = -0.687396;
  target_pose1.orientation.z = 4.81813e-07;

  target_pose1.position.x = 0.1;
  target_pose1.position.y = 0.0;
  target_pose1.position.z = 0.1;
  move_group.setPoseTarget(target_pose1);

  // 进行运动规划，计算机器人移动到目标的运动轨迹，此时只是计算出轨迹，并不会控制机械臂运动
 // moveit::planning_interface::MoveGroupInterface::Plan my_plan;
 // moveit::planning_interface::MoveItErrorCode success = group.plan(my_plan);

  moveit::planning_interface::MoveGroupInterface::Plan my_plan; 

  bool success = (move_group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
  ROS_INFO("-----------Visualizing plan 1 (pose goal) %s",success?"":"FAILED");   

  //让机械臂按照规划的轨迹开始运动。
  if(success)
      move_group.execute(my_plan);*/
  moveit::planning_interface::MoveGroupInterface::Plan my_plan;
  const robot_state::JointModelGroup* joint_model_group =
      move_group.getCurrentState()->getJointModelGroup(PLANNING_GROUP);

  moveit::core::RobotStatePtr current_state = move_group.getCurrentState();
  //
  // Next get the current set of joint values for the group.
  std::vector<double> joint_group_positions;
  current_state->copyJointGroupPositions(joint_model_group, joint_group_positions);

  // Now, let's modify one of the joints, plan to the new joint space goal and visualize the plan.
  joint_group_positions[0] = 0.0;  // radians
  joint_group_positions[1] = 0.0;  // radians
  joint_group_positions[2] = 0.0;  // radians
  joint_group_positions[3] = 0.0;  // radians
  joint_group_positions[4] = 0.0;  // radians
  move_group.setJointValueTarget(joint_group_positions);

  bool success = (move_group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
  ROS_INFO_NAMED("xarm", "Visualizing plan 1 (joint space goal home) %s", success ? "" : "FAILED");

  if(success)
      move_group.execute(my_plan);
//sleep(1000);
//---------------------------------------------
  current_state->copyJointGroupPositions(joint_model_group, joint_group_positions);
  joint_group_positions[0] = 1.0;  // radians
  joint_group_positions[1] = 0.5;  // radians
  joint_group_positions[2] = 0.4;  // radians
  joint_group_positions[3] = 0.5;  // radians
  joint_group_positions[4] = 0.8;  // radians
  move_group.setJointValueTarget(joint_group_positions);

  success = (move_group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
  ROS_INFO_NAMED("xarm", "Visualizing plan 2 (joint space goal target) %s", success ? "" : "FAILED");

  if(success)
      move_group.execute(my_plan);
  
//----------------home---

  current_state->copyJointGroupPositions(joint_model_group, joint_group_positions);
  joint_group_positions[0] = 0.0;  // radians
  joint_group_positions[1] = 0.0;  // radians
  joint_group_positions[2] = 0.0;  // radians
  joint_group_positions[3] = 0.0;  // radians
  joint_group_positions[4] = 0.0;  // radians
  move_group.setJointValueTarget(joint_group_positions);

  success = (move_group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
  ROS_INFO_NAMED("xarm", "Visualizing plan 3 (joint space goal home) %s", success ? "" : "FAILED");

  if(success)
      move_group.execute(my_plan);
 /* 
  //-------------------
  joint_group_positions[0] = -1.0;  // radians
  joint_group_positions[1] = 1.0;  // radians
  joint_group_positions[2] = -1.0;  // radians
  joint_group_positions[3] = -1.0;  // radians
  joint_group_positions[4] = -1.0;  // radians
  move_group.setJointValueTarget(joint_group_positions);

  success = (move_group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
  ROS_INFO_NAMED("xarm", "Visualizing plan 4 (joint space goal target) %s", success ? "" : "FAILED");

  if(success)
      move_group.execute(my_plan);

 //----------------home---
  joint_group_positions[0] = 0.0;  // radians
  joint_group_positions[1] = 0.0;  // radians
  joint_group_positions[2] = 0.0;  // radians
  joint_group_positions[3] = 0.0;  // radians
  joint_group_positions[4] = 0.0;  // radians
  move_group.setJointValueTarget(joint_group_positions);

  success = (move_group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
  ROS_INFO_NAMED("xarm", "Visualizing plan 5 (joint space goal home) %s", success ? "" : "FAILED");

  if(success)
      move_group.execute(my_plan);

*/
  ros::shutdown(); 
  return 0;
}
