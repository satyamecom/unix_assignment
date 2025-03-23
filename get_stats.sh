#!/usr/bin/bash

while true
do

	#Getting load stats and printing data in a log file also script will print the current stats if it breaches the hard limit 5

	current_load=`uptime |awk -F'load average:' '{print $2}'|awk -F"," '{print $1}'`

	#echo $current_load

	#round up current value to compare

	current_load_rp=`echo $current_load + 0.999 |bc|awk '{print int($1)}'`
	#echo $current_load_rp


	#Getting storage stats of /home/satyam/Downloads folder...!!! Used df -h command to get mountpoint details as we have a default /root mount point so checking in /home/satyam folder

	current_storage=`du -s /home/satyam/Downloads|awk -F" " '{print $1}'`

	#echo $current_storage


	max_util_cpu_name=`ps -eo pid,comm,%mem --sort=-%cpu | head -2 | tail -1 |awk -F" " '{print $2}'`
	max_util_cpu_perc=`ps -eo pid,comm,%mem --sort=-%cpu | head -2 | tail -1|awk -F" " '{print $3}'`
	max_util_mem_name=`ps -eo pid,comm,%mem --sort=-%mem | head -2 | tail -1 | awk -F" " '{print $2}'`
	max_util_mem_perc=`ps -eo pid,comm,%mem --sort=-%mem | head -2 | tail -1 | awk -F" " '{print $3}'`

	#echo $max_util_cpu_perc
	#echo $max_util_cpu_name
	#echo $max_util_mem_perc
	#echo $max_util_mem_name

	if (( $(echo "$current_load >= 5" | bc -l) )) ## Used here () brackets with bc because I was not able to compare float value with integer
		then
		date;echo ,"Load is high on a system....!!! breaching the limit" |tee -a log_file.txt
	elif [ "$current_storage" -ge 180456 ]
		then
		date;echo ,"Disk space is increasing....!!! Please check and remove old logs..!!" |tee -a log_file.txt
	elif (($(echo "$max_util_cpu_perc > 2" |bc -l) ))
		then
		date;echo ,"Max CPU used by process:" $max_util_cpu_name ":" $max_util_cpu_perc |tee -a log_file.txt
	elif (($(echo "$max_util_mem_perc > 3" |bc -l) ))
		then
		date;echo ,"Max Memory used by process:" $max_util_mem_name ":" $max_util_mem_perc |tee -a log_file.txt
	fi

	sleep 20
done



