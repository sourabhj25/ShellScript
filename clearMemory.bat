#!/bin/bash
exec_date=`date`
echo "Checking for log files in the log folder"
# Set the location of the log files and jar files
JAR_LOCATION_DEMO="/home/centos/taiwan/"
JAR_LOCATION_UTL="/home/centos/demo/"
demo_user_log="/home/centos/UlinkServerData/logs/taiwan/usermgmt/"
demo_test_log="/home/centos/UlinkServerData/logs/taiwan/testcompare/"
utl_user_log="/home/centos/UlinkServerData/logs/demo/usermgmt/"
utl_test_log="/home/centos/UlinkServerData/logs/demo/testcompare/"

# Change the directory
cd $demo_test_log

# Declare the number of files in the log directory
declare -i noOfFiles=$(find "$@" -type f | wc -l)

# Check the number of files greater than zero
# If files count greater than zero then delete all files
if [ $noOfFiles -gt 0 ]
then
        echo "Files Present"
        rm -f *
        echo "demo-test log files deleted"

        cd $demo_user_log
        rm -f *
        echo "demo-user log files deleted"

        cd $utl_user_log
        rm -f *
        echo "utl-user log files deleted"

        cd $utl_test_log
        rm -f *
        echo "utl-test log files deleted"
else
        echo "Files not Present"
fi

##################################################################################
echo "Checking for running java services"

# ========== DEMO (Taiwan) Environment ==========
cd $JAR_LOCATION_DEMO

# check if the ports are running
if ps -ef | grep "java" | grep -q "8889"
then
echo "Port: 8889 is Running"

# Check wheather other port is Running
if ps -ef | grep "java" | grep -q "8888"
then
echo "Port: 8888 is Running"

# Kill the port 8888
sudo kill -9 $(ps -fA | grep 'port=8888' | awk '{print $2}' )
echo "Stopped Port: 8888"
fi

# Kill the port 8889
sudo kill -9 $(ps -fA | grep 'port=8889' | awk '{print $2}' )
echo "Stopped Port: 8889"

# Start both the ports(8889 - DEMO_user_mgmt and 8888 - DEMO_test_comp)
echo "Starting Port: 8889"
sudo nohup java -Dserver.port=8889 -jar demo-user.jar > /dev/null &
echo "Port: 8889 Started Succesfully"

echo "Starting Port: 8888"
sudo nohup java -Dserver.port=8888 -jar demo-test.jar > /dev/null &
echo "Port: 8888 Started Succesfully"

else
echo "Port: 8889 is not Running"
# Kill the port 8889 and 8888
sudo kill -9 $(ps -fA | grep 'port=8889' | awk '{print $2}' )
sudo kill -9 $(ps -fA | grep 'port=8888' | awk '{print $2}' )

# Start both the ports(8889 - DEMO_user_mgmt and 8888 - DEMO_test_comp)
echo "Starting Port: 8889"
sudo nohup java -Dserver.port=8889 -jar demo-user.jar > /dev/null &
echo "Port: 8889 Started Succesfully"

echo "Starting Port: 8888"
sudo nohup java -Dserver.port=8888 -jar demo-test.jar > /dev/null &
echo "Port: 8888 Started Succesfully"
fi

echo "##################=================#####################"

# ========== UTL (demo) Environment ==========
cd $JAR_LOCATION_UTL

# check if the ports are running
if ps -ef | grep "java" | grep -q "9001"
then
echo "Port: 9001 is Running"

# Check wheather other port is Running
if ps -ef | grep "java" | grep -q "9000"
then
echo "Port: 9000 is Running"

# Kill the port 9000
sudo kill -9 $(ps -fA | grep 'port=9000' | awk '{print $2}' )
echo "Stopped Port: 9000"
fi

# Kill the port 9001
sudo kill -9 $(ps -fA | grep 'port=9001' | awk '{print $2}' )
echo "Stopped Port: 9001"

# Start both the ports(9001 - UTL_user_mgmt and 9000 - UTL_test_comp)
echo "Starting Port: 9001"
sudo nohup java -Dserver.port=9001 -jar utl-user.jar > /dev/null &
echo "Port: 9001 Started Succesfully"

echo "Starting Port: 9000"
sudo nohup java -Dserver.port=9000 -jar utl-test.jar > /dev/null &
echo "Port: 9000 Started Succesfully"

else
echo "Port: 9001 is not Running"
# Kill the port 9001 and 9000
sudo kill -9 $(ps -fA | grep 'port=9001' | awk '{print $2}' )
sudo kill -9 $(ps -fA | grep 'port=9000' | awk '{print $2}' )

# Start both the ports(9001 - UTL_user_mgmt and 9000 - UTL_test_comp)
echo "Starting Port: 9001"
sudo nohup java -Dserver.port=9001 -jar utl-user.jar > /dev/null &
echo "Port: 9001 Started Succesfully"

echo "Starting Port: 9000"
sudo nohup java -Dserver.port=9000 -jar utl-test.jar > /dev/null &
echo "Port: 9000 Started Succesfully"
fi

echo "Script Completed..."
echo
echo
echo " ===== Execution Completed at - ${exec_date} ====="
