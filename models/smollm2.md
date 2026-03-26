# SmolLM2

**Creator:** HuggingFace
**License:** Apache 2.0
**Architecture:** Dense transformer
**Context:** 8K tokens
**Sizes:** 135M, 360M, 1.7B

## Strengths

- Tiny but highly capable — trained on 11 trillion tokens
- Best-in-class performance at the sub-2B parameter scale
- Apache 2.0 — fully commercial
- Designed for on-device, embedded, and real-time inference
- 135M and 360M models run on smartphones and microcontrollers
- 1.7B is competitive with much larger models on basic instruction tasks

## Variants

| Size | Target Use Case |
|---|---|
| 135M | Microcontrollers, iPhones (native), extreme speed |
| 360M | Embedded devices, background agents |
| 1.7B | Full local inference; best quality in this family |

## Quantization Sizes

### 135M

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~0.1 GB | ~2 GB |
| Q8_0 | ~0.2 GB | ~2 GB |
| F16 | ~0.3 GB | ~2 GB |

### 360M

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~0.25 GB | ~2.5 GB |
| Q8_0 | ~0.4 GB | ~2.5 GB |

### 1.7B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~1.1 GB | ~3.5 GB |
| Q5_K_M | ~1.3 GB | ~3.8 GB |
| Q8_0 | ~1.9 GB | ~4.4 GB |
| F16 | ~3.4 GB | ~5.9 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | 1.7B Q4_K_M | 80–120 |
| M2 24GB | 1.7B Q8_0 | 100–150 |
| M1 Air 8GB | 360M Q8_0 | 200–300 |
| iPhone (native) | 135M Q8_0 | ~50 tok/s |

## HuggingFace Repos

- 135M: Community repos
- 360M: `prithivMLmods/SmolLM-360M-GGUF`
- 1.7B: `prithivMLmods/SmolLM-1.7B-Instruct-GGUF`
- All sizes: `HuggingFaceTB/SmolLM2-*-Instruct` (base models; convert to GGUF locally)

## Notes

- SmolLM2 1.7B is the **best choice when raw tokens-per-second matters more than output quality**
- Excellent for: autocomplete, brief summarization, classification, intent detection, lightweight chatbots
- Not suitable for: complex reasoning, coding assistance, long-form generation, math
- 135M/360M are competitive with GPT-2 era models but much more efficiently trained
- 8K context is smaller than most models — plan accordingly for document-length tasks
- SmolLM2 is particularly useful as a **background or secondary model** alongside a primary larger model
