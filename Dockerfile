FROM python:alpine3.20

RUN apk add --no-cache --update git && \
    echo '0 */2 * * * /app/execute.sh 2>&1' > /var/spool/cron/crontabs/root && \
    mkdir /app && \
    cd /app && \
    git clone --depth=1 https://github.com/wzdnzd/aggregator.git

RUN cd /app/aggregator && \
    pip3 install -r requirements.txt

ENV GIST_PAT= \
    GIST_LINK= \
    PROXY= \
    CUSTOMIZE_LINK= \
    ENABLE_SPECIAL_PROTOCOLS= \
    TZ=Asia/Shanghai \
    CRON_RULE=

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
COPY execute.sh /app/execute.sh

RUN chmod +x /app/entrypoint.sh && chmod +x /app/execute.sh

ENTRYPOINT ["/app/entrypoint.sh"]

CMD [ "crond", "-f" ]
