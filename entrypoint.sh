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

if [ -n $CRON_RULE ]; then
    echo "$CRON_RULE /app/execute.sh 2>&1" > /var/spool/cron/crontabs/root
fi


./execute.sh

exec "$@"
