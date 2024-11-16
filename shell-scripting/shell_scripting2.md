# scripting-2

1. Declaring Varibles and accessing them
2. using echo and set for debuging the scripting
3. env variblesand how to access them ?
4. passing args/params to scripting ?

### variables in shell scripting

ex: A=10
    VERSION=1.9.3
	
write a sheel scripting 

```sh
A=10
B=25
C=85
VERSION=1.9.3

# call the variables
echo "The value is $A /
     the value is$B /
	 the version is $VERSION /
	 the version is '${VERSION}' "

```
### write a shell script version

```sh
#!/bin/bash

# Declare Version 
	T_VERSION='1.9.6'

# download leatest script code 
	echo 'download terraform file'
	wget https://releases.hashicorp.com/terraform/${T_VERSION}/terraform_${T_VERSION}_linux_amd64.zip - o terraform.zip
	echo 'unzip file and remove ing terraform zip file'
	unzip terraform.zip && rm -rf terraform.zip
	echo 'move the terraform file bin file'
	chmod +x /usr/local/bin/terraform
	echo 'check the terraform file'
	terraform --version
```
Q ls -al && uptime 
ls -al || uptime explan this commands 

Q. Deploy keys vs ssh-keys gpe keys keys 

**.gitignore** set up on git hub 

shell scripting debuging use 
	`set -x` add debuging 
	`set +x` removing debugging 

## parameters in shell scripting 

use $1
```sh
#!/bin/bash
# Declare Version 
T_VERSION=$1 # decalar version on cmd line


#Download Terraform Latest Zip File
echo "We are Downloading Terraform Version: ${T_VERSION}.."
wget https://releases.hashicorp.com/terraform/${T_VERSION}/terraform_${T_VERSION}_linux_amd64.zip -O terraform.zip

echo "Unzipping Terraform File and Removing Zip File.."
unzip terraform.zip && rm -rf terraform.zip LICENSE.txt

echo "Removing Existing Terraform File if exists.."
rm -rf /usr/local/bin/terraform
chmod 700 terraform

echo "Moving Terraform File to /usr/local/bin/.."
mv terraform /usr/local/bin/

echo "Checking Terraform Version.."
terraform --version
```
**conclusion**
- variable use in shel scripting
- parames in shell scripting 
- how to .gitignore 
- how do call the variable in shell scripting
- how to debuging in shell scripting 
$0 is reperesnt in file name