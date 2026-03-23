#!/usr/bin/env bash

git clone https://github.com/laquereric/llama-1b-container.git
cd llama-1b-container
podman build -t llama-cpp-vulkan -f Containerfile.llama-vulkan .