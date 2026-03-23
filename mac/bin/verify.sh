#!/usr/bin/env bash
podman machine ssh ls /dev/dri
# should show: card0  renderD128
