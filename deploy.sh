#!/bin/bash

# 定义环境变量
# 0.10.1
# IMAGE_NAME="foreveross/kong-smartstack-10"
# CONTAINER_NAME="kong-smartstack-10"
# 0.10.2
# 定义环境变量
IMAGE_NAME="foreveross/kong-smartstack-10-2"
CONTAINER_NAME="kong-smartstack-10-2"


# 构建镜像
docker build -t $IMAGE_NAME .


# 删除容器
if docker ps -a | grep $CONTAINER_NAME | awk '{print $1 }' ; then
    docker rm -f $CONTAINER_NAME
fi

# 启动kong数据库(新增)
mkdir -p $PWD/data
docker rm -f ab-gateway-database
docker run -d --restart=on-failure:5 --name ab-gateway-database \
                -p 5432:5432 \
                -e "POSTGRES_USER=kong" \
                -e "POSTGRES_DB=kong" \
                -v $PWD/data:/var/lib/postgresql/data \
                postgres:9.4

sleep 5;

# 主机模式
docker run -d  \
    -e TZ="Asia/Shanghai" -v /etc/localtime:/etc/localtime:ro \
    -e "SERVER_IP=10.108.1.209" \
    -e "ZOOKEEPER_ADDR=112.74.114.59:2181" \
    -e "LIMIT_CONNECTION=5000" \
    --add-host ${HOSTNAME}:127.0.0.1 \
    --net=host \
    --name $CONTAINER_NAME \
    $IMAGE_NAME

# 打印日志,方便查看,生产模式下可以去掉
docker logs -f $CONTAINER_NAME
