#!/usr/bin/env bash
set -e

# Set up configs for a host-installed Nginx

if [ "${EUID}" -ne 0 ]; then
  echo "This script should be run as root."
  exit 1
fi

echo "Configuring Nginx."

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPO_DIR="$( dirname "${SCRIPT_DIR}" )"

NGINX_CONF_DIR="/etc/nginx"
NGINX_CONF="${NGINX_CONF_DIR}/nginx.conf"
NGINX_CONF_D_DIR="${NGINX_CONF_DIR}/conf.d"
if [ -d "${NGINX_CONF_D_DIR}" ] && [ ! -L "${NGINX_CONF_D_DIR}" ]; then
  mv "${NGINX_CONF_D_DIR}" "${NGINX_CONF_D_DIR}-old"
fi
ln -f -s "${REPO_DIR}/config/conf.d" "${NGINX_CONF_D_DIR}"

if [ -f "${NGINX_CONF}" ] && [ ! -L "${NGINX_CONF}" ]; then
  mv "${NGINX_CONF}" "${NGINX_CONF}-old"
fi
ln -f -s "${REPO_DIR}/config/nginx-ubuntu.conf" "${NGINX_CONF}"

if [ -f "${NGINX_CONF_DIR}/sites-enabled/default" ]; then
  rm "${NGINX_CONF_DIR}/sites-enabled/default"
fi
systemctl restart nginx.service
systemctl status nginx.service

echo "Nginx configured."
