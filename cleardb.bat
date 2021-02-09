#bin#bash

MYSQL_ROOT="root"
MYSQL_PASS="root"

echo "Checking container status..."
#Check if docker-compose is running
if docker ps | grep -q mysql_cont
then 
    echo "Running!"
	echo
	# login mysql container
	docker exec -i mysql_cont mysql -u ${MYSQL_ROOT} -p${MYSQL_PASS} -e "use ulinkdb; SET FOREIGN_KEY_CHECKS=0; update file_process set process_status='FILE_SYNC_GRAB' where id >0 ; update file_process set bin_process_status=NULL where id>0; TRUNCATE file_process_log; TRUNCATE test_result; TRUNCATE test_result_filters; TRUNCATE file_path_info; TRUNCATE test_result_version_detailts; TRUNCATE device; TRUNCATE file_path_info_not_parsed_files; TRUNCATE ulink_groups_devices; TRUNCATE bin_file_process; TRUNCATE non_template_file_info; TRUNCATE non_template_files; TRUNCATE test_system_view; SET FOREIGN_KEY_CHECKS=1;"

	echo 
	echo "Clearing Test Result..."
	echo "Clearing Device..."
	echo "Clearing Test System..."
	echo "Clearing Non Template..."
	echo "Data has been cleared succesfully!"
	echo ========================
else
    echo "docker-compose is not running!"
	exit 1
fi

