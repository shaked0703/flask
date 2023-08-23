#!/bin/bash

command_output=$(helm status flask-helm 2>&1)

expected_error="Error: release: not found"

if [ "$command_output" = "$expected_error" ]; then
    helm install flask-helm flask-app/
else
    helm upgrade --recreate-pods flask-helm flask-app/
fi
