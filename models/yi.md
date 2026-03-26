# Yi

**Creator:** 01.AI (founded by Kai-Fu Lee)
**License:** Apache 2.0
**Architecture:** Dense transformer (Llama-based)
**Context:** 4K (base), 200K (long-context variant)
**Sizes:** 6B, 9B, 34B

## Strengths

- Apache 2.0 — fully commercial
- Yi-9B-200K and Yi-34B-200K offer 200K token context — among the largest in open weights
- Strong multilingual: English and Chinese optimized
- Good coding, math, and reasoning benchmarks
- Llama-based architecture means broad compatibility with llama.cpp tooling

## Variants

| Model | Params | Context | Notes |
|---|---|---|---|
| Yi-6B | 6B | 4K | Compact; fast inference |
| Yi-9B | 9B | 4K or 200K | Long-context variant available |
| Yi-34B | 34B | 4K or 200K | Top-tier open model; strong all-round |

## Quantization Sizes

### Yi-6B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~4.0 GB | ~6.5 GB |
| Q5_K_M | ~4.6 GB | ~7.1 GB |
| Q8_0 | ~6.8 GB | ~9.3 GB |

### Yi-9B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~5.7 GB | ~8.2 GB |
| Q5_K_M | ~6.6 GB | ~9.1 GB |
| Q8_0 | ~9.8 GB | ~12.3 GB |

### Yi-34B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~20.7 GB | ~23.2 GB |
| Q5_K_M | ~24 GB | ~26.5 GB |
| Q8_0 | ~34.4 GB | ~36.9 GB |

**Note:** 200K context models require substantial KV cache memory on top of model weights. Yi-34B-200K at full context can use 100+ GB of KV cache even at moderate batch sizes.

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | Yi-6B Q4_K_M | 12–18 |
| M1 Pro 16GB | Yi-9B Q4_K_M | 14–20 |
| M2 24GB | Yi-34B Q4_K_M | 12–16 |
| M3 Max 48GB | Yi-34B Q5_K_M | 18–24 |

## HuggingFace Repos

- Yi-6B: `TheBloke/Yi-6B-GGUF`
- Yi-9B-200K: `LoneStriker/Yi-9B-200K-GGUF`
- Yi-34B: `TheBloke/Yi-34B-GGUF`

## Notes

- Yi-34B is the best use case: fits 24 GB Mac systems at Q4_K_M (~20.7 GB, but tight — close other apps)
- **200K context is the main differentiator** — if you need to process very long documents, Yi is a strong choice
- For general use at these sizes, Qwen2.5-14B or Phi-4-14B typically outperform Yi-9B/34B on benchmarks
- Yi models are more dated (2023–2024) — newer alternatives generally preferred unless long-context is the primary requirement
- TheBloke repos may be unmaintained; check for community updates with newer quant types
