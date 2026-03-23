# Build Container Image — Jetson Orin Nano 8G

Run **Llama-3.2-1B-Instruct** with GPU acceleration on the Jetson Orin Nano 8G using a Podman container. The container uses Vulkan for GPU access via the NVIDIA Vulkan ICD included in JetPack.

## Requirements

- Jetson Orin Nano 8G
- JetPack 6.x (Ubuntu 22.04-based)
- Podman 4.x+
- ~10 GB free disk space (image build + model)

---

## 1. Install Dependencies

```bash
sudo apt-get update
sudo apt-get install -y podman
```

Verify Vulkan is available (JetPack ships the NVIDIA Vulkan ICD):

```bash
sudo apt-get install -y vulkan-tools
vulkaninfo --summary
# Should list: NVIDIA Orin (or similar)
```

---

## 2. Get the Container Image

### Option A — Download pre-built image (faster)

```bash
podman pull ghcr.io/laquereric/llama-cpp-vulkan:latest
podman tag ghcr.io/laquereric/llama-cpp-vulkan:latest llama-cpp-vulkan
```

### Option B — Build from source

```bash
git clone https://github.com/laquereric/llama-1b-container.git
cd llama-1b-container/jetson_orin_nano_8g
podman build -t llama-cpp-vulkan -f Containerfile ..
```

The build compiles `glslc` (from [google/shaderc](https://github.com/google/shaderc)) and `llama-server` from source with Vulkan enabled. Expect ~20–30 minutes on first run.

---

## How It Works

```
Jetson Orin Nano 8G (Ampere iGPU)
      │  /dev/dri render node
  AlmaLinux 9 container (via Podman)
      │  Vulkan (NVIDIA Vulkan ICD from JetPack)
  llama.cpp (llama-server)
```

The Jetson's integrated Ampere GPU is exposed as a standard DRI render node. The NVIDIA Vulkan ICD provided by JetPack handles GPU access inside the container.

---

Next: [Run on Jetson Orin Nano 8G](RUN.md)
