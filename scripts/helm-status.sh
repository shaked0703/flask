#!/bin/bash

command_output=$(helm status bucket-shaked 2>&1)

expected_error="Error: release: not found"

if [ "$command_output" = "$expected_error" ]; then
    helm install bucket-shaked flask-app/
else
    helm upgrade --recreate-pods bucket-shaked flask-app/
fi
