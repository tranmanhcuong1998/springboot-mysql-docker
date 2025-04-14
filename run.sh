#!/bin/bash

# Gán tag theo ngày giờ
TAG=$(date +%Y%m%d-%H%M%S)

# Xuất tag cho Docker Compose
export IMAGE_TAG=$TAG

# In ra tag đang build
echo "🔨 Building image: springboot-mysql-docker:$TAG"

# Build + Run
docker-compose up --build