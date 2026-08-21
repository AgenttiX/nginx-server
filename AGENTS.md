# AGENTS.md

## Project description
This repository contains custom Nginx configurations for security hardening,
and unification of commonly used configurations.
These configurations can be used without Docker, or built into an Nginx Docker container.

## Commands
- First-time installation of configs for use without Docker: `./scripts/setup-config.sh`

## Repository structure
- `./config/conf.d` corresponds to `/etc/nginx/conf.d`.
- `./config/conf.d/nginx-docker.conf` and `./config/nginx-ubuntu.conf` correspond to `/etc/nginx/nginx.conf`.
- `./config/conf.d/servers` contains service-specific configurations
  that are copied or symlinked from the respective projects.

## Compatibility
These configurations are used for these services: Authentik, Home Assistant, Immich, Jellyfin, Jitsi, Kavita, LibreNMS,
LiteLLM, Open WebUI, Plex, and self-developed Django applications.
The clients use the latest versions of Firefox, Chromium and Chrome
on recent versions of Ubuntu, Windows, Android and iOS,
and also desktop and mobile client apps for the services that have those available.
For Jellyfin and Plex, there are also clients with Android TV / Google TV, Samsung Smart TV (Samsung Tizen),
and LG Smart TV (LG webOS).
