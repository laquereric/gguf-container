# Running llama.cpp with GPU Acceleration on macOS via Podman

This guide provides the complete configuration to run `llama.cpp` with Vulkan-over-virtio GPU acceleration on Apple Silicon using Podman and `libkrun`. This setup allows the Linux container to access the macOS Metal GPU via the Venus Vulkan translation layer.

## 1. Host Setup (macOS)

First, you need to install Podman and the `krunkit` hypervisor, which enables the virtualized GPU passthrough.

```bash
# Install Podman
brew install podman

# Install krunkit (the libkrun hypervisor wrapper)
brew tap slp/krunkit
brew install krunkit
```

## 2. Initialize the Podman Machine

You must create a specific Podman machine that uses the `libkrun` provider instead of the default `applehv` provider.

```bash
# Tell Podman to use libkrun for the VM
export CONTAINERS_MACHINE_PROVIDER="libkrun"

# Initialize a new machine (adjust CPUs and memory as needed)
podman machine init --cpus 4 --memory 8192 --disk-size 100

# Start the machine
podman machine start
```

*Note: You will need to keep `export CONTAINERS_MACHINE_PROVIDER="libkrun"` in your shell profile (e.g., `~/.zshrc`) so Podman always targets this machine.*

Verify the machine has GPU access by checking for the `/dev/dri` device:
```bash
podman machine ssh ls /dev/dri
# You should see output like: by-path  card0  renderD128
```

## 3. Build the Container Image

Save the provided `Containerfile.llama-vulkan` to your current directory, then build the image. This image uses Fedora 40 and installs a specially patched MESA driver (`slp/mesa-krunkit`) that knows how to talk to the `virtio-gpu` device.

```bash
podman build -t llama-cpp-vulkan -f Containerfile.llama-vulkan .
```

## 4. Download the Model

Download the Llama-3.2-1B-Instruct model in the requested `Q4_K_M` quantization format. We will store it in a local directory and mount it into the container.

```bash
mkdir -p ~/models
cd ~/models

# Download the GGUF model from Hugging Face
curl -L -o Llama-3.2-1B-Instruct-Q4_K_M.gguf "https://huggingface.co/unsloth/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q4_K_M.gguf"
```

## 5. Run the Server

Run the container, making sure to pass the `/dev/dri` device so the container can access the virtualized GPU. We also mount the models directory and map port 8080.

```bash
podman run --rm -it \
  --device /dev/dri \
  -v ~/models:/models \
  -p 8080:8080 \
  llama-cpp-vulkan \
  -m /models/Llama-3.2-1B-Instruct-Q4_K_M.gguf \
  --host 0.0.0.0 \
  --port 8080 \
  --n-gpu-layers 99
```

### Explanation of flags:
- `--device /dev/dri`: Passes the virtualized GPU into the container.
- `-v ~/models:/models`: Mounts your local models folder into the container.
- `--n-gpu-layers 99`: Tells `llama.cpp` to offload all model layers to the Vulkan GPU.

You can now interact with the model via the OpenAI-compatible API at `http://localhost:8080/v1/chat/completions`.
