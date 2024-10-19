#!/bin/bash

# 镜像源地址列表
mirrors=(
   "docker.chenby.cn"
    "dockerpull.com"
    "dockerproxy.cn"
    "registry.dockermirror.com"
)

# 定义颜色代码
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m" # No Color

# 统一的镜像名称和标签
image_name="hello-world:latest"

# 测试并记录每个镜像源的拉取时间
for mirror in "${mirrors[@]}"; do
    full_image_name="$mirror/$image_name"
    echo "--------------start-----------------"
    echo "Testing mirror: $full_image_name"
    # 记录开始时间
    start_time=$(date +%s)

    # 尝试拉取镜像
    docker pull "$full_image_name"

    # 检查拉取是否成功
    if [ $? -eq 0 ]; then
        # 记录结束时间
        end_time=$(date +%s)

        # 计算并输出拉取时间
        time_taken=$((end_time - start_time))
        echo  -e "Mirror: $full_image_name took ${GREEN}$time_taken${NC} seconds"
    else
        echo -e  "${RED}Failed${NC} to pull image from $full_image_name"
    fi
    # 等待 Docker 服务稳定
    sleep 2
done

echo "Testing complete."