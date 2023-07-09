FROM nginx:alpine

# Install openssl for Diffie-Hellman parameter generation
RUN apk add --no-cache openssl

COPY config /etc/nginx/conf.d
RUN chmod 0444 /etc/nginx/conf.d -R

# Add and configure scripts
# dos2unix is required when using Docker for Windows to convert CRLF to LF
COPY scripts/startup.sh /scripts/startup.sh
RUN apk add --no-cache dos2unix \
    && find /scripts -type f | xargs dos2unix \
    && chmod 0555 /scripts/* \
    && apk del dos2unix

CMD ["/scripts/startup.sh"]
