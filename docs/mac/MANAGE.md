# macOS — Apple Silicon

Run **Llama-3.2-1B-Instruct** with GPU acceleration on any Apple Silicon Mac using a Podman container and `libkrun`. The Linux container accesses your Mac's Metal GPU via the Venus Vulkan translation layer — no CUDA, no cloud, fully local.

## Requirements

- Apple Silicon Mac (M1/M2/M3/M4)
- [Homebrew](https://brew.sh)
- ~10 GB free disk space (image + model)

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

## manage.rb

`mac/bin/manage.rb` is the single entry point for all setup and run operations.

```bash
ruby mac/bin/manage.rb <command>
```

| Command | Script | Description |
|---------|--------|-------------|
| `--ok` | _(inline)_ | Bring up prebuilt image end-to-end; print `true` / `false` |
| `install` | `install.sh` | Install podman + krunkit via Homebrew |
| `start` | `start.sh` | Init and start the libkrun podman machine |
| `verify` | `verify.sh` | Verify GPU (`/dev/dri`) is accessible in the VM |
| `pull` | `pull.sh` | Pull pre-built image from ghcr.io |
| `build` | `build.sh` | Build the container image from source (~20–30 min) |
| `download` | `download_model.sh` | Download `Llama-3.2-1B-Instruct-Q4_K_M.gguf` |
| `run` | `run.sh` | Run the llama-server container on port 8080 (foreground) |
| `setup` | _(composite)_ | Full setup: install → start → verify → pull → download → run |

---

## --ok

Automated end-to-end bring-up using the prebuilt image. Runs install → start → pull → download, starts the container **detached**, polls `http://localhost:8080/health` for up to 120 seconds, then prints:

```
true   # API responded — container is healthy
false  # timed out or API unreachable
```

Exit code mirrors the result (`0` = true, `1` = false).

```bash
ruby mac/bin/manage.rb --ok
```

---

## Setup

### 1. Install dependencies

```bash
ruby mac/bin/manage.rb install
```

Installs `podman`, taps `slp/krunkit`, and installs `krunkit` via Homebrew.

### 2. Initialize the Podman machine

> **Important:** The `libkrun` provider must be set **before** `podman machine init`. If you already have a default machine, remove it first.

```bash
ruby mac/bin/manage.rb start
```

Persists `CONTAINERS_MACHINE_PROVIDER=libkrun` in `~/.zshrc`, then runs `podman machine init` and `podman machine start`.

If you already initialized a machine with the default provider, remove it first:

```bash
podman machine stop
podman machine rm
```

### 3. Verify GPU access

```bash
ruby mac/bin/manage.rb verify
```

Runs `podman machine ssh ls /dev/dri` — expects `card0` and `renderD128`. If `/dev/dri` is missing, the machine is not using `libkrun`. Run `podman machine rm` and retry after confirming `echo $CONTAINERS_MACHINE_PROVIDER` outputs `libkrun`.

### 4. Get the container image

**Option A — Download pre-built image (faster):**

```bash
ruby mac/bin/manage.rb pull
```

**Option B — Build from source:**

```bash
ruby mac/bin/manage.rb build
```

Compiles `glslc` (from [google/shaderc](https://github.com/google/shaderc)) and `llama-server` with Vulkan enabled. Expect ~20–30 minutes on first run.

### 5. Download the model

```bash
ruby mac/bin/manage.rb download
```

Downloads `Llama-3.2-1B-Instruct-Q4_K_M.gguf` from HuggingFace into `~/models/`.

---

## Running the server

```bash
ruby mac/bin/manage.rb run
```

Starts `llama-server` with `--device /dev/dri`, model volume mount, and port 8080. Leave it running in a separate terminal.

| Flag | Purpose |
|------|---------|
| `--device /dev/dri` | Passes the virtualized GPU into the container |
| `-v ~/models:/models` | Mounts your local models folder |
| `--n-gpu-layers 99` | Offloads all layers to the Vulkan GPU |

---

## Querying the API

The server exposes an OpenAI-compatible API at `http://localhost:8080/v1`:

```bash
curl http://localhost:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

---

## Integration Tests

```bash
ruby test/integration/llama_container_test.rb
```

If the container is not running, all tests are automatically skipped — the suite will not fail.
