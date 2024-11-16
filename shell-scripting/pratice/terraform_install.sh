#!/bin/bash

###########################
# AUTHER :  DEVOPS
# DATE:     22-09-2024
# MAIL-ID:  devops@gmail.com
###########################
set -x

#Declare Terraform Version To Download
T_VERSION='1.9.2'

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
