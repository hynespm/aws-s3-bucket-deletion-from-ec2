#!/bin/bash
# Description : Pull scripts from s3 & execute using aws-s3-agent
# Author : Patrick Hynes
# Date : 21.01.17

echo "Creating AWS EC2 Instance...."
instanceId=$(aws ec2 run-instances --cli-input-json file://cli-input-file/ec2-run-instances.json --user-data file://user-data/user-data-delete-bucket-s3.sh --output text --query "Instances[].InstanceId")
echo "Instance ID:"  $instanceId

echo "Tagging instance
aws ec2 create-tags --resources $instanceId --tags Key=Name,Value='Automated Job' Key='Use Case',Value='Automation' Key='Environment',Value='Production'

read -p "Automated Job Started Press [Enter]"
