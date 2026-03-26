# Mixtral (MoE)

**Creator:** Mistral AI
**License:** Apache 2.0
**Architecture:** Sparse Mixture-of-Experts (MoE)
**Sizes:** 8x7B (46.7B total / 12.9B active), 8x22B (141B total / 39B active)

## Strengths

- MoE architecture: quality of a large model at lower active-parameter inference cost
- Apache 2.0 license — fully commercial
- Strong coding, reasoning, and multilingual capabilities
- 8x7B was the dominant open-weights model of late 2023/early 2024

## Variants

| Model | Total Params | Active Params | Context | Notes |
|---|---|---|---|---|
| Mixtral 8x7B | 46.7B | 12.9B | 32K | Community standard; widely supported |
| Mixtral 8x22B | 141B total | 39B | 64K | Higher quality; needs 64+ GB RAM |

## Quantization Sizes

### Mixtral 8x7B

| Quant | File Size | Min RAM |
|---|---|---|
| Q2_K | 15.6 GB | 18.1 GB |
| Q3_K_M | 20.4 GB | 22.9 GB |
| Q4_K_M | 26.4 GB | 28.9 GB |
| Q5_K_M | 32.2 GB | 34.7 GB |
| Q6_K | 38.4 GB | 40.9 GB |
| Q8_0 | 49.6 GB | 52.1 GB |

**Note:** MoE models require all expert weights in RAM even though only 2 of 8 experts activate per token. Minimum ~18 GB RAM even at Q2_K.

### Mixtral 8x22B

| Quant | File Size | Min RAM |
|---|---|---|
| Q2_K | ~57 GB | ~60 GB |
| Q4_K_M | ~80 GB | ~83 GB |
| Q5_K_M | ~92 GB | ~95 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Pro 32GB | 8x7B Q3_K_M | 8–12 |
| M2 Max 64GB | 8x7B Q4_K_M | 15–20 |
| M3 Max 128GB | 8x7B Q5_K_M | 20–28 |
| M2 Ultra 192GB | 8x22B Q4_K_M | 8–12 |

## HuggingFace Repos

- 8x7B: `TheBloke/Mixtral-8x7B-Instruct-v0.1-GGUF`
- 8x22B: Community repos (search HuggingFace for `Mixtral-8x22B GGUF`)

## Notes

- **Requires 24+ GB RAM minimum** for 8x7B at any usable quality (Q3_K_M = 22.9 GB)
- Not suitable for 8 GB or 16 GB Mac laptops
- Mixtral 8x7B is largely superseded by Qwen3-30B-A3B MoE and Llama 3.3 70B for comparable RAM budgets
- 8x22B requires 64+ GB RAM; M-series Max or Ultra machines only
- Mistral AI officially deprecated Mixtral from their primary support line; community GGUF still available
