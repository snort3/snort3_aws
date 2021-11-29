#!/bin/bash

if [ $# -ne "6" -a $# -ne "8" ]; then
    echo "usage: $0 eks-stack-name aws-region key-pair-name vpc-id public-subnet1-id public-subnet2-id private-subnet1-id private-subnet2-id"
    echo "usage: $0 eks-stack-name aws-region key-pair-name vpc-id private-subnet1-id private-subnet2-id"
    exit
fi

STACK_NAME=$1
REGION=$2
KEY_PAIR_NAME=$3
VPC_ID=$4
PRIVATE_SUBNET1_ID=$5
PRIVATE_SUBNET2_ID=$6

if [ $# -eq "8" ]; then
  PUBLIC_SUBNET1_ID=$7
  PUBLIC_SUBNET2_ID=$8
  aws cloudformation create-stack \
	--stack-name $STACK_NAME \
	--region $REGION \
	--template-body file://eks-template.yaml \
	--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND CAPABILITY_IAM \
	--parameters ParameterKey=KeyPairName,ParameterValue=$KEY_PAIR_NAME \
	ParameterKey=MaxNumberOfNodes,ParameterValue=2 \
	ParameterKey=NumberOfNodes,ParameterValue=2 \
	ParameterKey=VPCID,ParameterValue=$VPC_ID \
	ParameterKey=PrivateSubnet1ID,ParameterValue=$PRIVATE_SUBNET1_ID \
	ParameterKey=PrivateSubnet2ID,ParameterValue=$PRIVATE_SUBNET2_ID
	ParameterKey=PublicSubnet1ID,ParameterValue=$PUBLIC_SUBNET1_ID \
	ParameterKey=PublicSubnet2ID,ParameterValue=$PUBLIC_SUBNET2_ID
  exit
fi

if [ $# -eq "6" ]; then
  aws cloudformation create-stack \
	--stack-name $STACK_NAME \
	--region $REGION \
	--template-body file://eks-template.yaml \
	--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND CAPABILITY_IAM \
	--parameters ParameterKey=KeyPairName,ParameterValue=$KEY_PAIR_NAME \
	ParameterKey=MaxNumberOfNodes,ParameterValue=2 \
	ParameterKey=NumberOfNodes,ParameterValue=2 \
	ParameterKey=VPCID,ParameterValue=$VPC_ID \
	ParameterKey=PrivateSubnet1ID,ParameterValue=$PRIVATE_SUBNET1_ID \
	ParameterKey=PrivateSubnet2ID,ParameterValue=$PRIVATE_SUBNET2_ID
fi
