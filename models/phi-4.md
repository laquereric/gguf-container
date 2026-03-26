# Phi-4

**Creator:** Microsoft Research
**License:** MIT
**Architecture:** Dense transformer
**Sizes:** 3.8B (mini), 14B (standard), reasoning variants

## Strengths

- Exceptional quality-per-parameter ratio — best in class at its sizes
- Phi-4 14B beats many 70B models on reasoning and coding benchmarks
- MIT license — fully open, commercial-friendly
- Phi-4 Reasoning matches o1-mini on math and science tasks
- Smallest model family with serious reasoning capability

## Variants

| Model | Params | Context | Strengths |
|---|---|---|---|
| Phi-4 mini | 3.8B | 128K | Real-time apps, mobile, low-RAM |
| Phi-4 | 14B | 16K | Flagship; beats many 70B on reasoning |
| Phi-4 Reasoning | 14B | 32K | o1-mini level math/science/coding |
| Phi-4 mini Reasoning | 3.8B | 128K | Compact reasoning model |

## Quantization Sizes

### Phi-4 mini (3.8B)

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~2.5 GB | ~5 GB |
| Q5_K_M | ~2.9 GB | ~5.4 GB |
| Q8_0 | ~4.1 GB | ~6.6 GB |
| F16 | ~7.6 GB | ~10.1 GB |

### Phi-4 (14B)

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~8.5 GB | ~11 GB |
| Q5_K_M | ~10 GB | ~12.5 GB |
| Q6_K | ~11.5 GB | ~14 GB |
| Q8_0 | ~15 GB | ~17.5 GB |
| F16 | ~28 GB | ~30.5 GB |

### Phi-4 Reasoning (14B)

Same file sizes as Phi-4 14B above. Uses extended thinking tokens.

### Phi-4 mini Reasoning (3.8B)

Same file sizes as Phi-4 mini above. Uses chain-of-thought reasoning.

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | mini 3.8B Q4_K_M | 25–40 |
| M2 24GB | mini 3.8B Q5_K_M | 35–50 |
| M1 Pro 16GB | 14B Q4_K_M | 15–22 |
| M2 24GB | 14B Q4_K_M | 18–26 |
| M3 Max 48GB | 14B Q8_0 | 30–40 |

## HuggingFace Repos

- mini: `unsloth/Phi-4-mini-instruct-GGUF`
- 14B: `bartowski/phi-4-GGUF`, `unsloth/phi-4-GGUF`
- Reasoning: `unsloth/Phi-4-reasoning-GGUF`
- mini Reasoning: `unsloth/Phi-4-mini-reasoning-GGUF`

## Notes

- **Best choice for 8 GB Macs** needing reasoning capability — Phi-4 mini at Q4_K_M uses ~2.5 GB leaving headroom
- **Best choice for 16 GB Macs** needing high-quality output — Phi-4 14B at Q4_K_M uses ~11 GB
- Phi-4 14B outperforms Llama 3.1 70B on several benchmarks despite being 5x smaller
- Reasoning variants require longer generation time but produce significantly better outputs on math/coding tasks
- 16K context on Phi-4 14B is smaller than competitors; use Mistral Nemo or Qwen2.5 if 128K context is needed
- MIT license is the most permissive of any major model family
