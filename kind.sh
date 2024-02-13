#!/bin/bash

# Set cluster name 
CLUSTER_NAME=${1:-"test-cluster"}

# Check if Kind is installed
if ! command -v kind &> /dev/null; then
  echo "Kind is not installed. Please install it before running this script."
  exit 1
fi

# Create the cluster
echo "Creating cluster: $CLUSTER_NAME"
kind create cluster --name "$CLUSTER_NAME"

# Verify cluster status
echo "Waiting for cluster nodes to be Ready..."
kubectl wait --for=condition=ready node --all --timeout=60s


# Cluster deploy status
echo "Kind cluster '$CLUSTER_NAME' deployed successfully!"
