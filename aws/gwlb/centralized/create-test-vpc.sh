#!/bin/bash

if [ $# -ne "4" ]; then
    echo "usage: $0 aws-region key-pair-name availability-zone-1 availability-zone-2"
    echo "example:	./create-test-vpc.sh us-west-2 test-key-pair us-west-2a us-west-2b"
    exit
fi
REGION=$1
KEY_PAIR_NAME=$2
AZ1=$2
AZ2=$3

aws cloudformation create-stack \
	--stack-name spoke1-vpc \
	--region $REGION \
	--template-body file://spoke1-vpc.yaml \
	--parameters ParameterKey=KeyPairName,ParameterValue=$KEY_PAIR_NAME \
	ParameterKey=AvailabilityZone1,ParameterValue=$AZ1 \
	ParameterKey=AvailabilityZone2,ParameterValue=$AZ2 \
	--capabilities CAPABILITY_NAMED_IAM

aws cloudformation create-stack \
	--stack-name spoke2-vpc \
	--region $REGION \
	--template-body file://spoke2-vpc.yaml \
	--parameters ParameterKey=KeyPairName,ParameterValue=$KEY_PAIR_NAME \
	ParameterKey=AvailabilityZone1,ParameterValue=$AZ1 \
	ParameterKey=AvailabilityZone2,ParameterValue=$AZ2 \
	--capabilities CAPABILITY_NAMED_IAM
