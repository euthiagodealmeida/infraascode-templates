#!/bin/bash

# Update system packages
yum update -y

# Install Docker
yum install -y docker

# Start and enable Docker service
systemctl start docker
systemctl enable docker

echo "Docker version: $(docker --version)"
