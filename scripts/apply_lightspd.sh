#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage:"
    echo "$0 Talos_LightSPD_File_Path Talos_LightSPD_Version"
    exit
fi

if [ -z "$1" ]; then
    echo "No Talos_LightSPD provided"
    exit
fi

if [ ! -f "$1" ]; then
    echo "$1 does not exist"
    exit
fi

if [ -z "$2" ]; then
    echo "Talos_LightSPD version not provided"
    echo "Accepted example version:"
    echo "    2021-11-09-001"
    exit
fi
verlen=${#2}
if [ $verlen -lt 14 ]; then
    echo "Invalid Talos_LightSPD version"
    echo "Accepted example version:"
    echo "    2021-11-09-001"
    exit
fi

pod=`kubectl get pods -n isv-namespace -o wide | grep storage- |cut -d" " -f 1`
echo "upload $1 to storage server"
kubectl cp $1 $pod:/usr/share/nginx/html/Talos_LightSPD.tar.gz -n isv-namespace

echo "update Talos Talos_LightSPD crd"
kubectl apply -f - << EOM
apiVersion: config.github.com/v1
kind: TalosSpd
metadata:
  name: talosspd-sample
spec:
  version: "$2"
EOM
