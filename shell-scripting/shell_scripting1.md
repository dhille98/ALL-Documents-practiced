
# shell-scripting -1

1. base lab shell scripting 
2. introduction to shell scripting 
3. Declaring and accesing varibles 
4. git hub copilte 

## why scripting

* I want to create 100 copies of files 
* any automation process use scripting

[ReferHere](github.com/mavric202/)




scripting is set of commands 
sample.sh
```sh
	#!/bin/bash
	
	# download lastes terraform zip files
	
	wget <terraform.zip file> -o terraform.zip
	
	# create 10 copies of the terraform file
	
	for x in {1..10}; do 
	  echo 'creating terraform file'
	  cp terraform.zip terraform-${x}.zip
	done
```
nano editor 
crtl + o and x --> save

crtl + k ----> delete line by line

* writing a shell scripting givee the permission on excuteve `chmod +x name.sh`

* run script `./name.sh` or `sh name.sh` or `bash name.sh`

**conclusion**
- why we learn in shell scripting
- create a git hub account
- writing a sample shell scripting 
- nano editor using 




