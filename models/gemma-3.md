# Gemma 3

**Creator:** Google DeepMind
**License:** Gemma Terms of Use (free for research and commercial use up to certain thresholds)
**Architecture:** Dense transformer with multimodal encoder
**Context:** 128K tokens
**Sizes:** 1B, 4B, 12B, 27B

## Strengths

- Official Quantization-Aware Trained (QAT) GGUF files published by Google
- QAT models preserve near-BF16 quality at Q4_0 — better than post-training quantization
- Multimodal: text + image input across all sizes
- 128K context window across all sizes
- Strong instruction following and reasoning

## QAT Advantage

Google trained Gemma 3 with quantization in the loop, so the model's weights are optimized for Q4_0 precision rather than quantized after the fact. This typically yields higher quality than equivalent post-training quantized models from other families.

## Variants

| Size | Notes |
|---|---|
| 1B | Smallest practical Gemma; fast on any Mac |
| 4B | Best small multimodal model for local use |
| 12B | Strong mid-range; fits 16 GB Mac at Q4 |
| 27B | Flagship; fits 24 GB Mac at Q4_K_M |

## Quantization Sizes

### 1B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_0 (official QAT) | ~0.6 GB | ~3 GB |
| Q4_K_M | ~0.7 GB | ~3 GB |
| Q8_0 | ~1.2 GB | ~3.5 GB |

### 4B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_0 (official QAT) | ~2.5 GB | ~5 GB |
| Q4_K_M | ~2.8 GB | ~5.3 GB |
| Q5_K_M | ~3.3 GB | ~5.8 GB |
| Q8_0 | ~4.6 GB | ~7.1 GB |

### 12B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_0 (official QAT) | ~7.0 GB | ~9.5 GB |
| Q4_K_M | ~7.7 GB | ~10.2 GB |
| Q5_K_M | ~9.0 GB | ~11.5 GB |
| Q8_0 | ~13.5 GB | ~16 GB |

### 27B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_0 (official QAT) | ~16 GB | ~18.5 GB |
| Q4_K_M | ~17 GB | ~19.5 GB |
| Q5_K_M | ~20 GB | ~22.5 GB |
| Q8_0 | ~29 GB | ~31.5 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | 1B Q4_0 | 55–70 |
| M1 Air 8GB | 4B Q4_K_M | 20–30 |
| M2 24GB | 12B Q4_K_M | 20–28 |
| M1 Pro 16GB | 12B Q4_K_M | 14–20 |
| M2 24GB | 27B Q4_K_M | 12–18 |
| M3 Max 48GB | 27B Q5_K_M | 18–25 |

## HuggingFace Repos

**Official QAT (recommended):**
- 1B: `google/gemma-3-1b-it-qat-q4_0-gguf`
- 4B: `google/gemma-3-4b-it-qat-q4_0-gguf`
- 12B: `google/gemma-3-12b-it-qat-q4_0-gguf`
- 27B: `google/gemma-3-27b-it-qat-q4_0-gguf`

**Community (full quant range):**
- 1B: `unsloth/gemma-3-1b-it-GGUF`
- 4B: `unsloth/gemma-3-4b-it-GGUF`
- 12B: `unsloth/gemma-3-12b-it-GGUF`
- 27B: `bartowski/google_gemma-3-27b-it-GGUF`

## Notes

- **Prefer the official QAT Q4_0 GGUF from Google** — it offers better quality than community Q4_K_M at similar or smaller file size
- Gemma 3 27B Q4_K_M (~17 GB) is the best 24 GB Mac option for a quality multimodal model
- Vision support requires a llama.cpp build with vision enabled or LM Studio / Ollama with vision support
- Gemma models use a unique tokenizer — verify front-end compatibility before deployment
- Gemma 2 (predecessor) available in 2B/9B/27B — still viable but 3x preferred at same sizes
