#!/bin/bash

# 定义环境变量
IMAGE_NAME="foreveross/smartstack-kong"

# 构建镜像
docker build -t $IMAGE_NAME .
