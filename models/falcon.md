# Falcon

**Creator:** Technology Innovation Institute (TII), UAE
**License:** Apache 2.0
**Architecture:** Dense transformer (Falcon 3); Hybrid SSM+Attention (Falcon H1/H1R); Pure SSM (Falcon Mamba)
**Sizes:** 0.5B–34B

## Strengths

- Apache 2.0 — fully commercial
- Falcon H1 introduces novel hybrid architecture combining Mamba2 SSM and attention in parallel
- Falcon H1R reasoning variant "out-reasons models up to 7x its size"
- Official GGUF files published by TII on HuggingFace
- Falcon Mamba: first competitive attention-free 7B LLM

## Variants

### Falcon 3 (Dense Transformer)

Standard transformer architecture; strong general instruction following.

| Size | Notes |
|---|---|
| 1B | Ultra-compact; fast inference |
| 3B | Good small model |
| 7B | Competitive mid-range |
| 10B | Best Falcon 3 quality |

### Falcon H1 (Hybrid SSM+Attention, 2025)

Novel architecture: parallel Mamba2 state-space layers + attention heads. Benefits over pure transformers:
- Better memory efficiency at long contexts
- Constant memory per token (SSM portion doesn't grow KV cache linearly)

Available sizes: 0.5B, 1.5B, 1.5B-Deep, 3B, 7B, 34B

### Falcon H1R (Reasoning Variant)

| Size | Notes |
|---|---|
| 7B | Reasoning-focused H1 with RL training |

### Falcon Mamba (Pure SSM)

| Size | Notes |
|---|---|
| 7B | First competitive attention-free LLM; experimental |

## Quantization Sizes

### Falcon 3 7B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~4.4 GB | ~6.9 GB |
| Q5_K_M | ~5.1 GB | ~7.6 GB |
| Q8_0 | ~7.7 GB | ~10.2 GB |

### Falcon 3 10B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~6.4 GB | ~8.9 GB |
| Q5_K_M | ~7.4 GB | ~9.9 GB |
| Q8_0 | ~11 GB | ~13.5 GB |

### Falcon H1 7B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~4.4 GB | ~6.9 GB |
| Q8_0 | ~7.7 GB | ~10.2 GB |

### Falcon H1 34B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~21 GB | ~23.5 GB |
| Q5_K_M | ~24 GB | ~26.5 GB |

### Falcon H1R 7B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~4.4 GB | ~6.9 GB |
| Q8_0 | ~7.7 GB | ~10.2 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | Falcon 3 7B Q4_K_M | 12–18 |
| M2 24GB | Falcon H1 7B Q4_K_M | 18–26 |
| M2 24GB | Falcon H1R 7B Q4_K_M | 14–22 |
| M3 Max 48GB | Falcon H1 34B Q4_K_M | 15–22 |

**Note:** H1/Mamba performance characteristics may differ from pure transformer models — SSM layers have constant KV memory vs. linear growth, which benefits long-context throughput.

## HuggingFace Repos

- Falcon 3: `tiiuae/Falcon3-1B-Instruct-GGUF`, `tiiuae/Falcon3-3B-Instruct-GGUF`, `tiiuae/Falcon3-7B-Instruct-GGUF`, `tiiuae/Falcon3-10B-Instruct-GGUF`
- H1R 7B: `tiiuae/Falcon-H1R-7B-GGUF`, `unsloth/Falcon-H1R-7B-GGUF`

## Notes

- **Falcon H1R 7B** is an interesting alternative for users who want reasoning at 8 GB RAM budget
- llama.cpp added Falcon H1 support in July 2025 — ensure up-to-date llama.cpp build
- Falcon Mamba (SSM-only) requires SSM inference support which is still maturing in llama.cpp
- At equivalent sizes, Phi-4 mini and Qwen3-4B currently outperform Falcon on most benchmarks
- Falcon models are worth considering for Apache 2.0 compliance requirements or architecture experimentation
