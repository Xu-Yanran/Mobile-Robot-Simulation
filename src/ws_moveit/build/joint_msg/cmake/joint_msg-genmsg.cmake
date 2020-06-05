# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "joint_msg: 1 messages, 0 services")

set(MSG_I_FLAGS "-Ijoint_msg:/home/picy/ws_moveit/src/joint_msg/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(joint_msg_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg" NAME_WE)
add_custom_target(_joint_msg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "joint_msg" "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(joint_msg
  "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/joint_msg
)

### Generating Services

### Generating Module File
_generate_module_cpp(joint_msg
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/joint_msg
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(joint_msg_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(joint_msg_generate_messages joint_msg_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg" NAME_WE)
add_dependencies(joint_msg_generate_messages_cpp _joint_msg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(joint_msg_gencpp)
add_dependencies(joint_msg_gencpp joint_msg_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS joint_msg_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(joint_msg
  "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/joint_msg
)

### Generating Services

### Generating Module File
_generate_module_eus(joint_msg
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/joint_msg
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(joint_msg_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(joint_msg_generate_messages joint_msg_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg" NAME_WE)
add_dependencies(joint_msg_generate_messages_eus _joint_msg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(joint_msg_geneus)
add_dependencies(joint_msg_geneus joint_msg_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS joint_msg_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(joint_msg
  "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/joint_msg
)

### Generating Services

### Generating Module File
_generate_module_lisp(joint_msg
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/joint_msg
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(joint_msg_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(joint_msg_generate_messages joint_msg_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg" NAME_WE)
add_dependencies(joint_msg_generate_messages_lisp _joint_msg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(joint_msg_genlisp)
add_dependencies(joint_msg_genlisp joint_msg_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS joint_msg_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(joint_msg
  "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/joint_msg
)

### Generating Services

### Generating Module File
_generate_module_nodejs(joint_msg
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/joint_msg
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(joint_msg_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(joint_msg_generate_messages joint_msg_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg" NAME_WE)
add_dependencies(joint_msg_generate_messages_nodejs _joint_msg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(joint_msg_gennodejs)
add_dependencies(joint_msg_gennodejs joint_msg_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS joint_msg_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(joint_msg
  "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/joint_msg
)

### Generating Services

### Generating Module File
_generate_module_py(joint_msg
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/joint_msg
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(joint_msg_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(joint_msg_generate_messages joint_msg_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/picy/ws_moveit/src/joint_msg/msg/joint_msg.msg" NAME_WE)
add_dependencies(joint_msg_generate_messages_py _joint_msg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(joint_msg_genpy)
add_dependencies(joint_msg_genpy joint_msg_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS joint_msg_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/joint_msg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/joint_msg
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(joint_msg_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/joint_msg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/joint_msg
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(joint_msg_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/joint_msg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/joint_msg
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(joint_msg_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/joint_msg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/joint_msg
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(joint_msg_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/joint_msg)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/joint_msg\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/joint_msg
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(joint_msg_generate_messages_py std_msgs_generate_messages_py)
endif()
