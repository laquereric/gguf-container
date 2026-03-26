# Llama 3.1

**Creator:** Meta AI
**License:** Meta Llama Community License (free for <700M MAU)
**Architecture:** Dense transformer
**Context:** 128K tokens
**Sizes:** 8B, 70B, 405B

## Strengths

- Best general instruction following in open weights at release
- Strong reasoning, coding, and multilingual capabilities
- Widest ecosystem support (fine-tunes, merges, tool integrations)
- 128K context window across all sizes
- Foundation for many derivative models (DeepSeek-R1 distills, Hermes 3)

## Variants

| Size | Use Case |
|---|---|
| 8B | Local inference, fast generation, coding assistant |
| 70B | High-quality general purpose, matches GPT-4 class on many tasks |
| 405B | Frontier open model; requires datacenter or multi-GPU setup |

## Quantization Sizes

### 8B

| Quant | File Size | Min RAM | Quality |
|---|---|---|---|
| Q2_K | 3.2 GB | 5.7 GB | ~70% |
| Q3_K_M | 3.6 GB | 6.1 GB | ~80% |
| Q4_K_M | 5.0 GB | 7.5 GB | ~95% |
| Q5_K_M | 5.7 GB | 8.2 GB | ~98% |
| Q6_K | 6.6 GB | 9.1 GB | ~99% |
| Q8_0 | 8.6 GB | 11.1 GB | ~99.9% |
| F16 | 15.0 GB | 17.5 GB | 100% |

### 70B

| Quant | File Size | Min RAM |
|---|---|---|
| Q2_K | 27 GB | 30 GB |
| Q4_K_M | 43 GB | 46 GB |
| Q5_K_M | 50 GB | 53 GB |
| Q8_0 | 75 GB | 78 GB |

### 405B

| Quant | File Size | Min RAM |
|---|---|---|
| Q2_K | ~161 GB | ~165 GB |
| Q4_K_M | ~243 GB | ~247 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | 8B Q4_K_M | 10–15 |
| M1 Pro 16GB | 8B Q4_K_M | 20–28 |
| M2 24GB | 8B Q4_K_M | 18–25 |
| M3 Max 48GB | 8B Q4_K_M | 50–60 |
| M4 Max | 8B Q4_K_M | 60–90 |
| M2 Ultra 192GB | 70B Q4_K_M | 12–15 |

## HuggingFace Repos

- 8B: `bartowski/Meta-Llama-3.1-8B-Instruct-GGUF`
- 70B: `bartowski/Meta-Llama-3.1-70B-Instruct-GGUF`
- 405B: `bartowski/Meta-Llama-3.1-405B-Instruct-GGUF`

## Notes

- Llama 3.1 8B is the best starting point for local inference on 8–16 GB Macs
- 70B requires 64+ GB RAM for Q4_K_M; fits M2/M3 Ultra at Q8_0
- 405B is practical only on multi-GPU clusters or 192+ GB Mac Ultra with extreme quants
- Superseded by Llama 3.3 70B (better quality at same size) and Llama 4 (MoE)
