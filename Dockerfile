FROM python:alpine3.20

RUN sed -i "s@https://dl-cdn.alpinelinux.org/@https://mirrors.cloud.tencent.com/@g" /etc/apk/repositories && \
    apk add --no-cache --update git && \
    echo '0 */8 * * * /app/entrypoint.sh 2>&1' > /var/spool/cron/crontabs/root && \
    mkdir /app && \
    cd /app && \
    git clone --depth=1 https://github.com/wzdnzd/aggregator.git

ENV GIST_PAT= \
    GIST_LINK= \
    PROXY= \
    CUSTOMIZE_LINK= \
    ENABLE_SPECIAL_PROTOCOLS= \
    TZ=Asia/Shanghai

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

CMD [ "crond", "-f" ]
