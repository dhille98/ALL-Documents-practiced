1) Create a shell script to check the available free memory on the system and alert the user if it falls below the threshold

```bash
threshold=10
total_memory=$(free -m | awk 'NR==2{print $2}') 
available_memory=$(free -m | awk 'NR==2 {print $7}')
free_mem_percen=$(( 100th available_memory/total_memory))

if ["$free_mem_percen -lt $threshold"]; then
	echo "Alert: free memory is below threshold $threshold%!"

else 
	echo "memory usage is space"
fi

```

2) Create a shell script to automate the creation of a new user with specific permissions and home directory.

```bash
#! /bin/bash

if ["$(id -u)" -ne 0]; then
	echo "This user script must be run on root!"
exit 1
fi

read -p "Enter the home directory:" home_dir
read -p "Enter the new user name:" user_name
read -p "Enter the group name:" group_name

useradd -m -d "$home_dir" -g "$group_name" "$user_name"
password "$user_name"
chmod 750 "$home_dir"
echo "user $username " hoo been successfully created"
```

3) Write a shell script to find all large files greater than 1GB in a directory and move them to another directory.

```bash
#! /bin/bash

source_dir=$1
destinations_dir=$2
find "$sources_dir" type f -size +100M | while read -r file; do 
	echo "Moving: $file"
	mv "$file" "$destination_dir"
done 
```
4) Write a shell script that automatically updates all installed packages on a system and reboots the system if needed.

5) Write a script to count the number of lines in all .log files in a specified directory.

6) Write a script that checks for the presence of specific software on the system on the system (e.g. Docker, Git) and installs if it is missing.