#! /bin/bash

honeypot(){



read -p "do you wish to make the honeypot for 1) local use bridged adapter  or 2)  in the current network segment ip: " opt
case $opt in
	1)	read -p "do you wish to change current dir  1) no  2)yes : " cdir
		case $cdir in
			1)  	echo "you'll be using the current dir location: " 
				python3 -m http.server  80  2>&1 | tee -a report.txt
			;;
			2) read -p "add dir path via relative route or via main route: " d
				python3 -m http.server -d $d  80 2>&1 | tee -a report.txt
			;;
		esac
	;;
	2)
		read -p "do you wish to change current dir? 1) no  2)yes : " cdir
                case $cdir in
                        1)     	ip=$(ifconfig wlan0 | grep -Po '(?!(inet 127.\d.\d.1))(inet \K(\d{1,3}\.){3}\d{1,3})')
		                echo "Using IP: $ip"
                		python3 -m http.server  -b "$ip" 80 2>&1 | tee -a report.txt
;;
                        2) read -p "add dir path via relative route or via main route: " d
                                ip=$(ifconfig wlan0 | grep -Po '(?!(inet 127.\d.\d.1))(inet \K(\d{1,3}\.){3}\d{1,3})')
		                echo "Using IP: $ip"
                		python3 -m http.server -d $d -b "$ip" 80 2>&1 | tee -a report.txt

                        ;;
                esac
;;
esac


} #here we are telling  through our bash script for our system to use python and spawn a module called http.server that assists us  in creating a active web service  in our machine 

#and @ the end were telling it to use the port 80, the command 2>&1 is to say that the  stderr stdout will be redirected and recieved hence forth thats  why  with our pipe que output  and  append the logs to the file if its not  there  it will create it


