#!/usr/bin/env sh

DHPARAM_DIR="/etc/nginx/dhparam"
DHPARAM="${DHPARAM_DIR}/dhparam.pem"

if [ ! -d "${DHPARAM_DIR}" ]; then
  mkdir -p "${DHPARAM_DIR}"
fi

if [ ! -s "${DHPARAM}" ]; then
  echo "Diffie-Hellman parameter file was empty or not not found."
  echo "Available entropy: $(cat /proc/sys/kernel/random/entropy_avail)"
  echo "If this is low, generating the parameters will take a long time. Generating the parameters now."
  openssl dhparam -out "${DHPARAM}" 4096
  chmod 0400 "${DHPARAM}"
  echo "Diffie-Hellman parameter generation ready."
fi

echo "Starting Nginx"
nginx -g 'daemon off;'
