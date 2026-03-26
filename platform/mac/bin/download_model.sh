#!/usr/bin/env bash
set -euo pipefail

MODEL_DIR="$HOME/models"
MODEL_FILE="Llama-3.2-1B-Instruct-Q4_K_M.gguf"
MODEL_PATH="$MODEL_DIR/$MODEL_FILE"

if [ -f "$MODEL_PATH" ]; then
  echo "Model already exists at $MODEL_PATH"
  exit 0
fi

mkdir -p "$MODEL_DIR"
curl -L -o "$MODEL_PATH" \
  "https://huggingface.co/unsloth/Llama-3.2-1B-Instruct-GGUF/resolve/main/$MODEL_FILE"
