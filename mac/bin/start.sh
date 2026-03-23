#!/usr/bin/env bash
echo 'export CONTAINERS_MACHINE_PROVIDER="libkrun"' >> ~/.zshrc
source ~/.zshrc
podman machine init --cpus 4 --memory 8192 --disk-size 100
podman machine start