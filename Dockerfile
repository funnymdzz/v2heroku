FROM alpine:latest

ENV CONFIG_JSON=none CERT_PEM=none KEY_PEM=none VER=4.20.0

RUN apk add --no-cache --virtual .build-deps ca-certificates wget \
        && mkdir /v2raybin \ 
        && cd v2raybin \
        && echo $PORT \
        && wget --no-check-certificate -O v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
	&& unzip v2ray.zip \
	&& chmod 777 v2ctl \
	&& chmod 777 v2ray \
        && chmod +x /v2raybin/v2ray \
 	&& chgrp -R 0 /v2raybin \
 	&& chmod -R g+rwX /v2raybin 
 
ADD entrypoint.sh /entrypoint.sh

COPY config.txt /v2raybin/config.json

RUN chmod +x /entrypoint.sh 

CMD  /entrypoint.sh 

