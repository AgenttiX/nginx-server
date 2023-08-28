FROM nginx:alpine

# Install bash to support custom scripts and openssl for Diffie-Hellman parameter generation
RUN apk add --no-cache bash openssl

COPY ./config/conf.d /etc/nginx/conf.d
COPY ./config/nginx-docker.conf /etc/nginx/nginx.conf
RUN chmod 0444 -R /etc/nginx/conf.d /etc/nginx/nginx.conf

# Add and configure scripts
# dos2unix is required when using Docker for Windows to convert CRLF to LF
COPY scripts/startup.sh /scripts/startup.sh
RUN apk add --no-cache dos2unix \
    && find /scripts -type f | xargs dos2unix \
    && chmod 0555 /scripts/* \
    && apk del dos2unix

CMD ["/scripts/startup.sh"]
