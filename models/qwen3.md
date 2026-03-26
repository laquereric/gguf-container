# Qwen 3

**Creator:** Qwen Team, Alibaba Cloud
**License:** Apache 2.0
**Architecture:** Dense transformer (4B–14B) and Mixture-of-Experts (30B, 235B)
**Context:** 128K tokens
**Released:** 2025–2026

## Strengths

- "Thinking" and "non-thinking" modes in the same model (toggle at inference time)
- Qwen3-4B reportedly rivals Qwen2.5-72B on reasoning benchmarks
- Apache 2.0 license — fully commercial
- MoE variants offer large-model quality at smaller active-parameter cost
- Best multilingual reasoning of any model family at its sizes

## Thinking vs. Non-Thinking Mode

Qwen3 models support two inference modes:
- **Thinking mode**: Extended chain-of-thought reasoning (slower, higher quality on complex tasks)
- **Non-thinking mode**: Fast, direct responses (comparable to Qwen2.5 quality)

Toggle via system prompt or chat template parameter.

## Variants

### Dense Models

| Size | Notes |
|---|---|
| Qwen3-4B | Best 4B class model for reasoning; rivals 72B models |
| Qwen3-8B | Strong general model; good 8 GB Mac option |
| Qwen3-14B | Premium small model |

### MoE Models

| Model | Total Params | Active Params | Notes |
|---|---|---|---|
| Qwen3-30B-A3B | 30B | 3B active | Fast inference; quality above parameter count |
| Qwen3-235B-A22B | 235B | 22B active | Frontier; needs 128+ GB RAM |

## Quantization Sizes

### Dense Models

| Size | Q4_K_M | Q5_K_M | Q8_0 |
|---|---|---|---|
| 4B | ~2.8 GB | ~3.3 GB | ~4.6 GB |
| 8B | ~5.0 GB | ~5.8 GB | ~8.6 GB |
| 14B | ~9.0 GB | ~10.5 GB | ~15.7 GB |

### Qwen3-30B-A3B (MoE)

| Quant | File Size | Min RAM | Notes |
|---|---|---|---|
| Q2_K | ~11 GB | ~13.5 GB | |
| Q3_K_M | ~14 GB | ~16.5 GB | |
| Q4_K_M | ~18.6 GB | ~21 GB | Recommended |
| Q5_K | ~21 GB | ~23.5 GB | |
| Q6_K | ~24 GB | ~26.5 GB | |
| Q8_0 | ~31 GB | ~33.5 GB | |

### Qwen3-235B-A22B (MoE)

| Quant | File Size | Min RAM |
|---|---|---|
| IQ1_M | ~67 GB | ~71 GB |
| Q2_K | ~100 GB | ~104 GB |
| Q4_K_M | ~112 GB | ~116 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) | Notes |
|---|---|---|---|
| M1 Air 8GB | 4B Q4_K_M | 25–35 | |
| M2 24GB | 8B Q5_K_M | 20–30 | |
| M2 24GB | 14B Q4_K_M | 16–24 | |
| M3 Max 48GB | 30B-A3B Q4_K_M | 20–30 | Fast due to MoE low active params |
| M2 Ultra 192GB | 235B-A22B Q4_K_M | 8–12 | |
| CPU+RAM (any) | 30B-A3B Q8 | ~22 gen / ~160 prompt | Community reported |

## HuggingFace Repos

- `Qwen/Qwen3-4B-GGUF`
- `Qwen/Qwen3-8B-GGUF`
- `Qwen/Qwen3-14B-GGUF`
- `Qwen/Qwen3-30B-A3B-GGUF`
- `Qwen/Qwen3-235B-A22B-GGUF`
- Community: `bartowski/Qwen3-*-GGUF`, `unsloth/Qwen3-*-GGUF`

## Notes

- **Qwen3-4B is the new benchmark for 8 GB Macs** — reasoning quality that rivals 72B models at 2.8 GB
- **Qwen3-30B-A3B fits 24 GB Macs** at Q4_K_M (~21 GB total) with surprisingly fast generation due to only 3B active params
- 235B-A22B requires 128+ GB RAM; Mac Ultra or equivalent
- Thinking mode increases generation time substantially but is worth it for math, coding, and complex reasoning
- For non-reasoning tasks (chat, summarization), non-thinking mode matches Qwen2.5 performance at the same size
