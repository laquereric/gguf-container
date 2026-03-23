# Build Windows Container Image (via WSL2)

Run **Llama-3.2-1B-Instruct** with GPU acceleration on Windows using a Podman container via WSL2. The container uses Vulkan for GPU access — no CUDA required, fully local.

## Requirements

- Windows 10 22H2+ or Windows 11
- WSL2 enabled with a Linux distro (Ubuntu 22.04+ recommended)
- Podman 4.x+ (installed inside WSL2)
- Vulkan-capable GPU (AMD, Intel, or NVIDIA)
- GPU drivers with WSL2/D3D12 support (latest drivers recommended)
- ~10 GB free disk space (image build + model)

---

## 1. Enable WSL2

Open PowerShell as Administrator:

```powershell
wsl --install -d Ubuntu-22.04
wsl --set-default-version 2
```

Reboot if prompted, then launch Ubuntu from the Start menu and complete setup.

---

## 2. Install Podman inside WSL2

Inside the WSL2 Ubuntu terminal:

```bash
sudo apt-get update
sudo apt-get install -y podman
```

Verify:

```bash
podman --version
```

---

## 3. Verify GPU Access in WSL2

WSL2 exposes the host GPU via `/dev/dxg` and DRI nodes. Check that Vulkan works:

```bash
sudo apt-get install -y vulkan-tools
vulkaninfo --summary
# Should list your GPU via the Mesa D3D12 adapter or native driver
```

If no GPU is listed, update your GPU drivers on the Windows host (AMD Adrenalin, Intel Arc Control, or NVIDIA Game Ready driver).

---

## 4. Get the Container Image

All commands run inside the WSL2 terminal.

### Option A — Download pre-built image (faster)

```bash
podman pull ghcr.io/laquereric/llama-cpp-vulkan:latest
podman tag ghcr.io/laquereric/llama-cpp-vulkan:latest llama-cpp-vulkan
```

### Option B — Build from source

```bash
git clone https://github.com/laquereric/llama-1b-container.git
cd llama-1b-container/win
podman build -t llama-cpp-vulkan -f Containerfile ..
```

The build compiles `glslc` (from [google/shaderc](https://github.com/google/shaderc)) and `llama-server` from source with Vulkan enabled. Expect ~20–30 minutes on first run.

---

## How It Works

```
Windows GPU (AMD/Intel/NVIDIA)
      │  WSL2 D3D12/dxg bridge
  Ubuntu WSL2
      │  /dev/dri render node (Mesa D3D12 or native)
  AlmaLinux 9 container (via Podman)
      │  Vulkan
  llama.cpp (llama-server)
```

WSL2 exposes the host GPU through a D3D12 translation layer. The Mesa driver inside the container translates Vulkan calls through that layer to the Windows GPU driver.

---

Next: [Run on Windows](RUN.md)
