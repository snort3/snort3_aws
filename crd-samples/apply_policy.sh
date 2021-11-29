#!/bin/bash

if [ -z "$1" ]; then
    echo "No IPS policy provided"
    echo "accepted policies:"
    echo "    no-rules-active"
    echo "    connectivity-over-security"
    echo "    security-over-connectivity"
    echo "    balanced-security-and-connectivity"
    echo "    maximum-detection"
    exit
fi

case $1 in
  "no-rules-active")
    ;;
  "connectivity-over-security")
    ;;
  "security-over-connectivity")
    ;;
  "balanced-security-and-connectivity")
    ;;
  "maximum-detection")
    ;;
  *)
    echo "invalid policy: $1"
    ;;
esac

echo "update IPS policy crd"
kubectl apply -f - << EOM
apiVersion: config.github.com/v1
kind: IpsPolicy
metadata:
  name: ipspolicy-sample
spec:
  policyName: "$1"
EOM
