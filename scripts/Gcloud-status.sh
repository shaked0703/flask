#!/bin/bash -xe

# Check if all Flask pods are in the Running state
while [[ "$(kubectl get pods -l app=flask-app -o 'jsonpath={..status.phase}')" != "Running Running" ]]; do
  echo "Flask pods are still not Running..."
  sleep 10
done

echo "Flask pods are Running!"

echo "All pods are Running!!"
