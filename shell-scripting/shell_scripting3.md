# shell scripting -3


1. Env variable and how to access them using AWS CLI and Azure CLI
2. $@, $#, $?, $*
3. chaining commands using &, |, &&, ||
4. Grep 
5. 

vs code 
   - shift alt 
   - crtl d
   - crtl /

### positional Arguments
 
* Parameters in shell scripting  
```sh
#!/bin/bash

ARG1=$1
ARG2=$2
ARG3=$3

echo "file_name 1:$0" 

echo "Actor Number 1:$ARG1" 
echo "Actor Number 2:$ARG2" 
echo "Actor Number 3:$ARG3" 
```

- set the alias commands in Linux
- use the export command set the env or alias commands in linux system but temprary 
- set on permenent env and alias as 
- vi .bashrc
- alias <name>='command name'

- source .bashrc


- $0 is represent --> file name 

### explain this chaining commands 

- **if the command is successful, then the second command will run**
	- ls -al && free -h

- **if the first command fails, then the second command will run**
	- ls -all || free -h

- **Run first command in background and second command in foreground**
	- ls -all & free -h
- **Pipe the output of the first command to the second command** 
	- cat /etc/passwd | grep -I 'root'

- **run the command is background even the connection is lost** 
	- ping -c 100 www.google.com &

**grep**==> Regular Expression and Print > Grab
I --> case sensitive 

### set the environments 

--> env is print the environment  

set the environment is use this command `export`


**scenarios on environment**  

change the env is use different folders in on server how to set


dev-envs: 
	export AWS_ACCESSES_key=''
	export AWS_SECERET_KEY=''
	AWS_DEFAULT_REGIONS=''

prod-envs: 
	export AWS_ACCESSES_key=''
	export AWS_SECERET_KEY=''
	AWS_DEFAULT_REGIONS=''

**direnv** is used on folder level set environment 

[ReferHere](https://direnv.net/docs/installation.html) using this link providing to dirctory level env

```sh
	sudo apt install direnv -y
	vi .bashrc
	eval "$(direnv hook bash)"
	direnv allow
	vi .envrc # set the directory level env
```
**Q. how to grep the information on json format**

install -jq
`sudo apt install jq -y`
ex: aws ec2 describe-vpcs | jq ".Vpcs [ ].VpcId" -r
	cat test.json | jq ".[].name.english" -r | wc -l



## get vpcs in aws useing shell scripting 
```sh
#!/bin/bash
REGION=$1
echo "Retrieving VPCs in ${REGION}.."
aws ec2 describe-vpcs --region ${REGION} | jq '.Vpcs[].VpcId' -r
echo "VPCs Retrieved Successfully.."

echo "Retrieving S3 Buckets in ${REGION}.."
aws s3api list-buckets --region ${REGION} | jq '.Buckets[].Name' -r
echo "S3 Buckets Retrieved Successfully.."

```







