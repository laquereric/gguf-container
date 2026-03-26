#!/usr/bin/env bash
set -euo pipefail

# Persist the provider setting without sourcing .zshrc (avoid zsh-only syntax in bash)
if ! grep -q 'CONTAINERS_MACHINE_PROVIDER' ~/.zshrc 2>/dev/null; then
  echo 'export CONTAINERS_MACHINE_PROVIDER="libkrun"' >> ~/.zshrc
fi
export CONTAINERS_MACHINE_PROVIDER="libkrun"

# Check machine state
MACHINE_STATE=$(podman machine inspect --format '{{.State}}' 2>/dev/null || echo "missing")

case "$MACHINE_STATE" in
  running)
    echo "Podman machine already running."
    ;;
  stopped)
    echo "Starting existing podman machine..."
    podman machine start
    ;;
  *)
    echo "Initializing new podman machine with libkrun..."
    podman machine init --cpus 4 --memory 8192 --disk-size 100
    podman machine start
    ;;
esac
