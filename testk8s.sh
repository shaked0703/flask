#!/usr/bin/bash -xe

# Set the timeout value (in seconds)
timeout=10

# Make curl requests with a timeout
curl -s --max-time $timeout 192.168.56.1:30300

# Check patterns using grep and handle the cases
if ! curl -s --max-time $timeout 192.168.56.1:30300 | grep -q Flask; then
  echo "Error: Pattern 'Flask' not found"
  exit 1
fi

if ! curl -s --max-time $timeout 192.168.56.1:30300 | grep -q App; then
  echo "Error: Pattern 'App' not found"
  exit 1
fi
