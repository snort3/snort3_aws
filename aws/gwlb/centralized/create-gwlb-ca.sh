#!/bin/bash

if [ $# -ne "5" ]; then
    echo "usage: $0 gwlb-stack-name aws-region key-pair-name availability-zone-1 availability-zone-2"
    echo "example:	./create-gwlb-ca.sh snort3-gwlb us-west-2 test-key-pair us-west-2a us-west-2b"
    exit
fi

STACK_NAME=$1
AWS_REGION=$2
KEY_PAIR_NAME=$3
AZ1=$4
AZ2=$5

aws cloudformation create-stack \
	--stack-name $STACK_NAME \
	--template-body file://gwlb-ca.yaml \
	--region $AWS_REGION \
	--parameters ParameterKey=KeyPairName,ParameterValue=$KEY_PAIR_NAME \
	ParameterKey=AvailabilityZone1,ParameterValue=$AZ1 \
	ParameterKey=AvailabilityZone2,ParameterValue=$AZ2 \
	--capabilities CAPABILITY_NAMED_IAM
