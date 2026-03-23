# Build Linux Container Image

Run **Llama-3.2-1B-Instruct** with GPU acceleration on Linux using a Podman container. The container uses Vulkan for GPU access — no CUDA required, fully local.

## Requirements

- Linux x86_64 or aarch64
- Podman 4.x+
- Vulkan-capable GPU (AMD, Intel, or NVIDIA via vulkan driver)
- Vulkan drivers installed on the host
- ~10 GB free disk space (image build + model)

---

## 1. Install Dependencies

**Fedora/RHEL/AlmaLinux:**

```bash
sudo dnf install -y podman vulkan-loader vulkan-tools
```

**Ubuntu/Debian:**

```bash
sudo apt-get install -y podman vulkan-tools libvulkan1
```

Verify Vulkan is working on the host:

```bash
vulkaninfo --summary
# Should list at least one GPU
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
cd llama-1b-container/linux
podman build -t llama-cpp-vulkan -f Containerfile ..
```

The build compiles `glslc` (from [google/shaderc](https://github.com/google/shaderc)) and `llama-server` from source with Vulkan enabled. Expect ~20–30 minutes on first run.

---

## How It Works

```
Linux GPU (AMD/Intel/NVIDIA)
      │  /dev/dri render node
  AlmaLinux 9 container
      │  Vulkan (Mesa radv / ANV / NVIDIA ICD)
  llama.cpp (llama-server)
```

On Linux there is no hypervisor layer — the container accesses the GPU render node directly. Vulkan calls are handled natively by the Mesa or NVIDIA driver inside the container.

---

Next: [Run on Linux](RUN.md)
