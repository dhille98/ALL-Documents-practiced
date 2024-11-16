#!/bin/bash

###########################
# AUTHER :  DEVOPS
# DATE:     22-09-2024
# MAIL-ID:  devops@gmail.com
###########################

# download the terraform file in binaries 
set -x
wget https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_amd64.zip -o terraform.zip

for I in {1..10}
do
cp terraform.zip /tmp/terraform-{$I}.zip
done
