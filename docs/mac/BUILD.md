# Build macOS Container Image (Apple Silicon)

Run **Llama-3.2-1B-Instruct** with GPU acceleration on any Apple Silicon Mac using a Podman container and `libkrun`. The Linux container accesses your Mac's Metal GPU via the Venus Vulkan translation layer — no CUDA, no cloud, fully local.

## Requirements

- Apple Silicon Mac (M1/M2/M3/M4)
- [Homebrew](https://brew.sh)
- ~10 GB free disk space (image build + model)

---

## 1. Install Dependencies

```bash
brew install podman
brew tap slp/krunkit
brew install krunkit
```

---

## 2. Initialize the Podman Machine

> **Important:** The `libkrun` provider must be set **before** running `podman machine init`. If you already have a default machine, remove it first.

```bash
# Persist the provider in your shell profile (do this first)
echo 'export CONTAINERS_MACHINE_PROVIDER="libkrun"' >> ~/.zshrc
source ~/.zshrc
```

If you already initialized a machine with the default provider, remove it:

```bash
podman machine stop
podman machine rm
```

Then initialize a new machine with `libkrun`:

```bash
podman machine init --cpus 4 --memory 8192 --disk-size 100
podman machine start
```

Verify GPU access:

```bash
podman machine ssh ls /dev/dri
# Expected: by-path  card0  renderD128
```

If `/dev/dri` is missing, the machine is not using `libkrun`. Run `podman machine rm` and retry after confirming `echo $CONTAINERS_MACHINE_PROVIDER` outputs `libkrun`.

---

## 3. Get the Container Image

### Option A — Download pre-built image (faster)

```bash
podman pull ghcr.io/laquereric/llama-cpp-vulkan:latest
podman tag ghcr.io/laquereric/llama-cpp-vulkan:latest llama-cpp-vulkan
```

### Option B — Build from source

```bash
git clone https://github.com/laquereric/llama-1b-container.git
cd llama-1b-container/mac
podman build -t llama-cpp-vulkan -f Containerfile ..
```

The build compiles `glslc` (from [google/shaderc](https://github.com/google/shaderc)) and `llama-server` from source with Vulkan enabled. Expect ~20–30 minutes on first run.

---

## How It Works

```
macOS Metal GPU
      │
  libkrun VM  (krunkit hypervisor)
      │  virtio-gpu (Venus protocol)
  AlmaLinux 9 container
      │  Vulkan (patched mesa-krunkit driver)
  llama.cpp (llama-server)
```

`libkrun` creates a lightweight VM that exposes the host GPU as a `virtio-gpu` device. The patched Mesa driver inside the container translates Vulkan calls over that device back to Metal on the host.

---

Next: [Run on macOS](RUN.md)
