
lf="ros.log"
if [ -e $lf ]; then
  \rm $lf
fi
touch $lf


echo "Starting roscore..."
( ( (stdbuf -oL roscore) 1> >(stdbuf -oL sed 's/^/ROSCORE: /') 2>&1 ) >> $lf ) &

sleep 1


rosparam set robot_description --textfile kuka_lwr_arm.urdf

echo "Launching robot_sim..."
( ( (stdbuf -oL rosrun robot_sim robot_sim_bringup) 1> >(stdbuf -oL sed 's/^/KUKA: /') 2>&1 ) >> $lf ) &

sleep 1

echo "Launching robot_mover..."
( ( (stdbuf -oL rosrun robot_mover mover) 1> >(stdbuf -oL sed 's/^/MOVER: /') 2>&1 ) >> $lf ) &
