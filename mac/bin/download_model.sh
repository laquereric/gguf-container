#!/usr/bin/env bash
download_model.sh
mkdir -p ~/models
curl -L -o ~/models/Llama-3.2-1B-Instruct-Q4_K_M.gguf \
  "https://huggingface.co/unsloth/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q4_K_M.gguf"