# Run on macOS (Apple Silicon)

Assumes the container image is already built or pulled. See [BUILD.md](BUILD.md).

---

## 1. Download the Model

```bash
mkdir -p ~/models
curl -L -o ~/models/Llama-3.2-1B-Instruct-Q4_K_M.gguf \
  "https://huggingface.co/unsloth/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q4_K_M.gguf"
```

---

## 2. Run the Server

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

| Flag | Purpose |
|------|---------|
| `--device /dev/dri` | Passes the virtualized GPU into the container |
| `-v ~/models:/models` | Mounts your local models folder |
| `--n-gpu-layers 99` | Offloads all layers to the Vulkan GPU |

---

## 3. Query the API

The server exposes an OpenAI-compatible API:

```bash
curl http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```
