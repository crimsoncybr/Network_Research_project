#!/bin/bash

	#Student name: Dean Cohen    
	
	
    # Interface Unit function, a set of variables for the user to use
	function IU()
	{ 
		echo -e "\033[1;34m connecting via SSH.\e[0m"
		read -p "enter an address to scan: " VICTIM
		USER=kali
		IP="192.168.221.142"
	}
		
	
	#Remote connection via SSH function to be controlled by the IP variable.
	function SSH()
	{

		echo -e "\033[1;33m uptime:\e[0m" $(sshpass -p"kali" ssh -o StrictHostKeyChecking=no $USER@$IP  "uptime" )
		echo -e "\033[1;33m remote server is at :\e[0m"  $( geoiplookup $IP| awk -F ":" '{print $2;}')
		# If shows the massage "remote server is at : IP Address not found"  its not a a code problame its because of the geoiplookup 
		echo -e "\033[1;33m IP of the remote server is :\e[0m" $IP
   	
	}
	
	
	
	# runs the nmap scan on the victim and put it in  ~/Desktop/scans/nmapscan.log
	#has a easy change VICTIM variable 
	function NMAP() 
	{
		mkdir ~/Desktop/scanlog 2>/dev/null
		echo "scan data of $VICTIM" >> ~/Desktop/scanlog/nmapscan.log
		echo "$(date)" >> ~/Desktop/scanlog/nmapscan.log
		echo "nmap scan data for $VICTIM was saved to ~/Desktop/scanlog/nmapscan.log"
		nmap "$VICTIM" >> ~/Desktop/scanlog/nmapscan.log
	}



	# runs the whois scan on the victim and put it in  ~/Desktop/scans/WHOISscan.log
	function WHOIS() 
	{
		mkdir ~/Desktop/scanlog 2>/dev/null
		echo "scan data of $VICTIM" >> ~/Desktop/scanlog/WHOISscan.log
		echo "$(date)" >> ~/Desktop/scanlog/WHOISscan.log
		echo "whois scan data for $VICTIM was saved to ~/Desktop/scanlog/WHOISscan.log"
		whois "$VICTIM" >> ~/Desktop/scanlog/WHOISscan.log
	}
	
	#ending massage command 
		function END()
	{
		sudo perl nipe.pl stop
		echo -e "\033[1;31m you are not anonymous any more, heve a nice day MEOW.\e[0m"
		
	}
	
	# check if nmap is installed
	if command -v nmap &>/dev/null; then
	echo -e "\033[1;32m nmap is installed\e[0m."
	else
		echo -e "\033[1;31m nmap is not installed, starting installation\033[0m"
		sudo apt-get install -qqy nmap
		echo -e "\033[1;32m nmap has been installed.\e[0m"
fi

	# check if sshpass is installed and installs it if not.
	if ! command -v sshpass &>/dev/null; 
	then
		echo -e "\033[1;31m sshpass is not installed, starting installation\033[0m"
		sudo apt-get update
		sudo apt-get -qqy install sshpass
		echo -e "\033[1;32m sshpass has been installed.\e[0m"
	else
		echo -e "\033[1;32m sshpass is installed\e[0m."
	fi

	# ffind nipe.pl using the find command
	path=$(find ~ -name nipe)
	# Check if nipe is installed at the current users machine and installs nipe if its not found.
	if [ -n "$path" ];  
	then
		echo -e "\033[1;32m nipe is installed.\e[0m"
	else
		
		echo -e "\033[1;31m nipe is not installed installing.\e[0m."
	
		sudo apt-get install -y git tor iptables perl #aproves all installations 
	
	
	#getting clone from github changing to nipe location and exiting the command if it failes
		git clone https://github.com/htrgouvea/nipe ~/nipe && cd ~/nipe 
	
		
	 #automatically installing configureing 
		sudo env PERL_MM_USE_DEFAULT=1 cpan install Try::Tiny Config::Simple JSON
	
	
		sudo cpanm --installdeps  #configaration installation 
		cd ~/nipe
		sudo perl nipe.pl install #install nipe
		echo -e "\033[1;32m nipe has been installed.\e[0m"
	fi
	
	
	 
	# Check if geoiplookup is installed and install if no
	if ! dpkg -s  geoip-bin &>/dev/null ; then
		echo -e "\033[1;31m geoiplookup is not installed, starting installation\033[0m"
		sudo apt-get install -qqy geoip-bin
		echo -e "\033[1;32m geoiplookup has been installed\e[0m."
	else
		echo -e "\033[1;32m geoiplookup is installed\e[0m."
	fi



	# a function to start the "Nipe" service
	function start_nipe() {
		cd "$path"
		sudo perl nipe.pl start
		sudo perl nipe.pl stop
		sudo perl nipe.pl start
		sudo perl nipe.pl stop
		sudo perl nipe.pl start
}
	start_nipe


	# restart loop
	while true; do
    # Check if "Nipe" service is running and aborting if not
    if  sudo perl nipe.pl status | grep -iq "Status: false" ;
	then
		echo -e "\033[1;31m Nipe is not running,Restarting.\e[0m"
		sudo perl nipe.pl restart ;
			if   sudo perl nipe.pl status | grep -iq "Status: false" ;
			then 
			echo -e "\033[1;31m you are not anonymous ,aborting!!!.\e[0m"
			fi
			
			
    else
		echo -e "\033[1;32m Nipe is running,you are now anonymous.\e[0m"
		echo -e "\033[1;33m your spoofed ip is:\e[0m"  $(sudo perl nipe.pl status | grep -i "ip" |awk -F ":" '{print $2;}')
	break  # Exiting the loop since "Nipe" isnt working
		
	fi

		sleep 2  # Waiting for 2 seconds before checking and trying again
	done
	
	if  sudo perl nipe.pl status| grep -iq "Status: true" ;
	then

	echo -e "\033[1;33m you are now spoofed in:\e[0m" $( geoiplookup $(sudo perl nipe.pl status | grep -i "ip" |awk -F ":" '{print $2;}') | awk -F ":" '{print $2;}')

	else 
	echo -e "\033[1;31m you are not anonymous ,aborting!!!.\e[0m."
	exit
	fi 
		
		mkdir ~/Desktop/mapscan.log 2>/dev/null
		
		mkdir ~/Desktop/WHOISscan.logn 2>/dev/null
		
		#functions activation
		IU
		SSH
		NMAP
		WHOIS
		END
