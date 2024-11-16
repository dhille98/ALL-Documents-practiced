#!/bin/bash

###########################
# AUTHER :  DEVOPS
# DATE:     22-09-2024
# MAIL-ID:  devops@gmail.com
###########################

# aws ec2 describe-vpcs

REGION=$1
echo "Retrieving VPCs in ${REGION}.."
aws ec2 describe-vpcs --region ${REGION} | jq '.Vpcs[].VpcId' -r
echo "VPCs Retrieved Successfully.."

echo "Retrieving S3 Buckets in ${REGION}.."
aws s3api list-buckets --region ${REGION} | jq '.Buckets[].Name' -r
echo "S3 Buckets Retrieved Successfully.."
