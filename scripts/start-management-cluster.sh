#!/bin/bash

. env.sh
. libs.sh

os=$(uname -s)
arch=$(uname -m)

echo "Installing requirements..."
install_requirements $os $arch

kind create cluster

echo "Creating base64 encoded credentials..."
clusterawsadm bootstrap iam create-cloudformation-stack
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile)

echo "Initializing the management cluster..."
clusterctl init --infrastructure aws
