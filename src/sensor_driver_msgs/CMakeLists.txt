cmake_minimum_required(VERSION 2.8.3)
project(sensor_driver_msgs)

set(PACKAGE_DEPENDENCIES
  geometry_msgs
  nav_msgs
  sensor_msgs
  std_msgs
)

find_package(catkin REQUIRED COMPONENTS
  ${PACKAGE_DEPENDENCIES}
  roscpp
  roslib
  rospy
  tf
  message_generation)

file(GLOB_RECURSE ALL_MSG_FILE_ABS "msg/*.msg" )
message("${ALL_MSG_FILE_ABS}")
set(ALL_MSG_FILE_REL)
foreach(ABS_FIL ${ALL_MSG_FILE_ABS})
  file(RELATIVE_PATH REL_FIL ${PROJECT_SOURCE_DIR}/msg ${ABS_FIL})
  list(APPEND ALL_MSG_FILE_REL ${REL_FIL})
endforeach()
message("${ALL_MSG_FILE_REL}")
add_message_files(
  FILES
  ${ALL_MSG_FILE_REL}
)

file(GLOB_RECURSE ALL_SRV_FILE_ABS "srv/*.srv" )
set(ALL_SRV_FILE_REL)
foreach(ABS_FIL ${ALL_SRV_FILE_ABS})
  file(RELATIVE_PATH REL_FIL ${PROJECT_SOURCE_DIR}/srv ${ABS_FIL})
  list(APPEND ALL_SRV_FILE_REL ${REL_FIL})
endforeach()

add_service_files(FILES ${ALL_SRV_FILE_REL})

generate_messages(
DEPENDENCIES
${PACKAGE_DEPENDENCIES}
)

catkin_package(
  CATKIN_DEPENDS
    ${PACKAGE_DEPENDENCIES}
)
