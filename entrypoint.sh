#!/bin/sh

# 启用错误检测
set -e

# 定义错误处理函数
error_handler () {
    echo "[$(date +'% Y-% m-% d % H:% M:% S')] [ERROR] 脚本在第 ${LINENO} 行发生错误"
    exit 1
}

# 捕获 ERR 信号，调用错误处理函数
trap 'error_handler' ERR

# 校验环境变量参数，对部分必要参数进行校验
if [ -z $GIST_PAT ]; then
    echo "[$(date +'% Y-% m-% d % H:% M:% S')] [ERROR] 缺少 GIST_PAT (github token) ，无法将结果上传。"
    exit 1
fi

if [ -z $GIST_LINK ]; then
    echo "[$(date +'% Y-% m-% d % H:% M:% S')] [ERROR] 缺少 GIST_LINK (github usename/gist_id) ，无法将结果上传。"
    exit 1
fi

if [ -z $PROXY ]; then
    echo "[$(date +'% Y-% m-% d % H:% M:% S')] [WARN] 缺少 PROXY ，可能无法获取到结果。"
fi

# 设置代理
export https_proxy=$PROXY http_proxy=$PROXY all_proxy=$PROXY

cd /app/aggregator

# 更新代码
echo "[$(date +'% Y-% m-% d % H:% M:% S')] [INFO] 更新代码 >>>"
git pull

# 安装 / 更新依赖
echo "[$(date +'% Y-% m-% d % H:% M:% S')] [INFO] 安装 / 更新依赖 >>>"
pip3 install -r requirements.txt -i https://mirrors.cloud.tencent.com/pypi/simple

# 运行代码
echo "[$(date +'% Y-% m-% d % H:% M:% S')] [INFO] 运行代码 >>>"
python -u subscribe/collect.py -si

exec "$@"
