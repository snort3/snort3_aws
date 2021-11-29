#!/bin/bash

if [ $# -ne "15" ]; then
    echo "usage: $0 TgwStackName AwsRegion ApplianceVpcId "
    echo "          ApplianceVpcTgwAttachSubnet1Id ApplianceVpcTgwAttachSubnet2Id "
    echo "          ApplianceVpcApplianceRtb1Id ApplianceVpcApplianceRtb2Id "
    echo "          Spoke1VpcId Spoke1VpcTgwAttachSubnet1Id Spoke1VpcTgwAttachSubnet2Id Spoke1VpcRtb1Id "
    echo "          Spoke2VpcId Spoke2VpcTgwAttachSubnet1Id Spoke2VpcTgwAttachSubnet2Id Spoke2VpcRtb1Id"
    exit
fi

STACK_NAME=$1
REGION=$2
ApplianceVpcId=$3
ApplianceVpcTgwAttachSubnet1Id=$4
ApplianceVpcTgwAttachSubnet2Id=$5
ApplianceVpcApplianceRtb1Id=$6
ApplianceVpcApplianceRtb2Id=$7
Spoke1VpcId=$8
Spoke1VpcTgwAttachSubnet1Id=$9
Spoke1VpcTgwAttachSubnet2Id=$10
Spoke1VpcRtb1Id=$11
Spoke2VpcId=$12
Spoke2VpcTgwAttachSubnet1Id=$13
Spoke2VpcTgwAttachSubnet2Id=$14
Spoke2VpcRtb1Id=$15

aws cloudformation create-stack \
	--stack-name $TACK_NAME \
	--template-body file://tgw-ca.yaml \
	--region $REGION \
	--parameters ParameterKey=ApplianceVpcId,ParameterValue=$ApplianceVpcId \
	ParameterKey=ApplianceVpcTgwAttachSubnet1Id,ParameterValue=$ApplianceVpcTgwAttachSubnet1Id \
	ParameterKey=ApplianceVpcTgwAttachSubnet2Id,ParameterValue=$ApplianceVpcTgwAttachSubnet2Id \
	ParameterKey=ApplianceVpcApplianceRtb1Id,ParameterValue=$ApplianceVpcApplianceRtb1Id \
	ParameterKey=ApplianceVpcApplianceRtb2Id,ParameterValue=$ApplianceVpcApplianceRtb2Id \
	ParameterKey=Spoke1VpcId,ParameterValue=$Spoke1VpcId \
	ParameterKey=Spoke1VpcTgwAttachSubnet1Id,ParameterValue=$Spoke1VpcTgwAttachSubnet1Id \
	ParameterKey=Spoke1VpcTgwAttachSubnet2Id,ParameterValue=$Spoke1VpcTgwAttachSubnet2Id \
	ParameterKey=Spoke1VpcRtb1Id,ParameterValue=$Spoke1VpcRtb1Id \
	ParameterKey=Spoke2VpcId,ParameterValue=$Spoke2VpcId \
	ParameterKey=Spoke2VpcTgwAttachSubnet1Id,ParameterValue=$Spoke2VpcTgwAttachSubnet1Id \
	ParameterKey=Spoke2VpcTgwAttachSubnet2Id,ParameterValue=$Spoke2VpcTgwAttachSubnet2Id \
	ParameterKey=Spoke2VpcRtb1Id,ParameterValue=$Spoke2VpcRtb1Id \
	--capabilities CAPABILITY_NAMED_IAM
