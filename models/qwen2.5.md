# Qwen 2.5

**Creator:** Qwen Team, Alibaba Cloud
**License:** Apache 2.0
**Architecture:** Dense transformer
**Context:** 128K tokens
**Sizes:** 0.5B, 1.5B, 3B, 7B, 14B, 32B, 72B

## Strengths

- Best multilingual performance in open weights (100+ languages)
- Excellent coding with dedicated Qwen2.5-Coder variants
- Apache 2.0 license — fully commercial
- Official GGUF files published by the Qwen team on HuggingFace
- Widest size ladder of any model family — something for every RAM budget

## Variants

| Model | Params | Specialization |
|---|---|---|
| Qwen2.5-Instruct | 0.5B–72B | General instruction following |
| Qwen2.5-Coder | 1.5B–32B | Code generation, debugging, completion |
| Qwen2.5-Math | 1.5B–72B | Mathematical reasoning |

## Quantization Sizes

| Size | Q4_K_M | Q5_K_M | Q8_0 |
|---|---|---|---|
| 0.5B | ~0.4 GB | ~0.5 GB | ~0.7 GB |
| 1.5B | ~1.0 GB | ~1.2 GB | ~1.8 GB |
| 3B | ~2.0 GB | ~2.3 GB | ~3.4 GB |
| 7B | 4.7 GB | 5.4 GB | 8.1 GB |
| 14B | 9.0 GB | 10.5 GB | 15.7 GB |
| 32B | ~20 GB | ~23 GB | ~35 GB |
| 72B | ~43 GB | ~50 GB | ~77 GB |

**Min RAM = File Size + ~2.5 GB OS overhead + KV cache**

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | 7B Q4_K_M | 12–18 |
| M1 Air 8GB | 3B Q4_K_M | 30–45 |
| M1 Max 64GB | 7B Q8_0 | ~40 |
| M1 Max 64GB | 7B Q4_K_M | ~60 |
| M2 24GB | 14B Q4_K_M | 18–25 |
| M1 Pro 16GB | 14B Q4_K_M | 12–18 |
| M3 Max 48GB | 32B Q4_K_M | 18–25 |

## HuggingFace Repos

**Official (from Qwen team):**
- `Qwen/Qwen2.5-0.5B-Instruct-GGUF`
- `Qwen/Qwen2.5-1.5B-Instruct-GGUF`
- `Qwen/Qwen2.5-3B-Instruct-GGUF`
- `Qwen/Qwen2.5-7B-Instruct-GGUF`

**Community (larger sizes):**
- `bartowski/Qwen2.5-14B-Instruct-GGUF`
- `bartowski/Qwen2.5-32B-Instruct-GGUF`
- `bartowski/Qwen2.5-72B-Instruct-GGUF`

**Coder:**
- `Qwen/Qwen2.5-Coder-7B-Instruct-GGUF`
- `bartowski/Qwen2.5-Coder-14B-Instruct-GGUF`
- `bartowski/Qwen2.5-Coder-32B-Instruct-GGUF`

## Notes

- **14B Q4_K_M (~9 GB) is the sweet spot for 16 GB Macs** — leaves 7 GB headroom for OS and KV cache
- **7B Q4_K_M (~4.7 GB) is the sweet spot for 8 GB Macs** — leaves ~3.3 GB headroom
- 32B requires 24+ GB RAM; fits 24 GB Mac at Q4_K_M if other apps are closed (~20 GB + overhead)
- 72B requires 64+ GB RAM; best on Mac Pro/Ultra configs
- Qwen2.5-Coder-14B is the best local coding model for 16 GB Macs
- Superseded at small sizes by Qwen3 but Qwen2.5 remains extremely capable and well-supported
