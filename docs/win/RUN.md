# Run on Windows (via WSL2)

Assumes the container image is already built or pulled. See [BUILD.md](BUILD.md).

All commands run inside the WSL2 terminal unless noted.

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
  --group-add keep-groups \
  -v ~/models:/models \
  -p 8080:8080 \
  llama-cpp-vulkan \
  -m /models/Llama-3.2-1B-Instruct-Q4_K_M.gguf \
  --host 0.0.0.0 \
  --port 8080 \
  --n-gpu-layers 99
```

The server will be accessible from Windows at `http://localhost:8080` (WSL2 port forwarding is automatic).

| Flag | Purpose |
|------|---------|
| `--device /dev/dri` | Passes the WSL2 GPU node into the container |
| `--group-add keep-groups` | Preserves host render/video group membership |
| `-v ~/models:/models` | Mounts your local models folder |
| `--n-gpu-layers 99` | Offloads all layers to the Vulkan GPU |

---

## 3. Query the API

From PowerShell on Windows:

```powershell
Invoke-RestMethod -Uri "http://localhost:8080/v1/chat/completions" `
  -Method POST `
  -ContentType "application/json" `
  -Body '{"model":"llama","messages":[{"role":"user","content":"Hello!"}]}'
```

Or from inside WSL2:

```bash
curl http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```
