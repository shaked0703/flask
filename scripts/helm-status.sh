#!/bin/bash

command_output=$(helm status shaked 2>&1)

expected_error="Error: release: not found"

if [ "$command_output" = "$expected_error" ]; then
    helm install shaked flask-app/
else
    helm upgrade --recreate-pods shaked flask-app/
fi
