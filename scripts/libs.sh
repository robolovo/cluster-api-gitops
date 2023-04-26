#!/bin/bash

function install_requirements() {

  ######################################
  # $1 os i.e) linux, darwin
  # $2 arch i.e) x86_64, arm64, aarch64
  ######################################

  if ! command -v kind &> /dev/null
  then
    echo "Kind not found. Installing..."
    [ $2 = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.18.0/kind-{$1}-amd64
    [ $2 = arm64 ] || [ $2 = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.18.0/kind-{$1}-arm64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
  else
    echo "Kind is already installed."
  fi

  if ! command -v clusterctl &> /dev/null
  then
    echo "Clusterctl not found. Installing..."
    [ $2 = x86_64 ] && curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.4.1/clusterctl-${1}-amd64 -o clusterctl
    [ $2 = arm64 ] || [ $2 = aarch64 ] && curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.4.1/clusterctl${1}-arm64 -o clusterctl
    chmod +x ./clusterctl
    sudo mv ./clusterctl /usr/local/bin/clusterctl
  else
    echo "Clusterctl is already installed."
  fi

  if ! command -v clusterawsadm &> /dev/null
  then
    echo "Clusterawsadm not found. Installing..."
    [ $2 = x86_64 ] && curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/v2.0.2/clusterawsadm-${1}-amd64 -o clusterawsadm
    [ $2 = arm64 ] || [ $2 = aarch64 ] && curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/v2.0.2/clusterawsadm-${1}-arm64 -o clusterawsadm
    chmod +x clusterawsadm
    sudo mv clusterawsadm /usr/local/bin/clusterawsadm
  else
    echo "Clusterawsadm is already installed."
  fi
}
