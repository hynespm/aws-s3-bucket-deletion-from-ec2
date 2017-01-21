#!/bin/bash
# Description : Userdata Script to delete a S3 bucket and once complete, terminate itself
# Assumption : This script assumes that the EC2 instance has an IAM profile which allows s3 bucket deletion and ec2 termination. It also assumes that a SNS topic exists
# Author : Patrick Hynes
# Date : 21.01.17

# Set the SNS ARN
$SNS_ARN=SNS_ARN

#Now that I have the region and have assigned the AWS Credentials to this EC2 Instance, lets retrieve the job from s3
# To use this script, please insert your bucket name below
aws s3 rb s3://$BUCKET_NAME --force

#Once complete - Notify admin that the instance is to be terminated and that the bucket is deleted

#Send notification to SNS that the job is complete - alter the SNS notification as required
aws sns publish --topic-arn $SNS_ARN --message file://sns-notification/automated-job-completion.txt

#Terminate the instance
instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id/)
aws ec2 terminate-instances --instance-ids $instanceId --region $EC2_REGION
