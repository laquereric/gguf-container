# Mistral

**Creator:** Mistral AI (France)
**License:** Apache 2.0 (core models)
**Architecture:** Dense transformer with sliding window attention
**Sizes:** 7B, 12B (Nemo), 22B (Small 3)

## Strengths

- Permissive Apache 2.0 license — fully commercial use
- Sliding window attention enables efficient long-context handling
- Strong reasoning and instruction following relative to model size
- Mistral Nemo (12B) at 128K context is a strong mid-range option
- Efficient tokenizer (tiktoken-based in v0.3+)

## Variants

| Model | Params | Context | Notes |
|---|---|---|---|
| Mistral 7B v0.3 | 7B | 32K | Foundational model; well-supported ecosystem |
| Mistral Nemo | 12B | 128K | Collaboration with NVIDIA; best mid-tier |
| Mistral Small 3 | 22B | 128K | Flagship small model |

## Quantization Sizes

### Mistral 7B v0.3

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~4.4 GB | ~6.9 GB |
| Q5_K_M | ~5.1 GB | ~7.6 GB |
| Q8_0 | ~7.7 GB | ~10.2 GB |
| F16 | ~14 GB | ~16.5 GB |

### Mistral Nemo (12B)

| Quant | File Size | Min RAM |
|---|---|---|
| Q2_K | 3.9 GB | 6.4 GB |
| Q4_K_M | 7.5 GB | 10.0 GB |
| Q5_K_M | 8.8 GB | 11.3 GB |
| Q8_0 | 13.0 GB | 15.5 GB |
| F16 | 24.5 GB | 27.0 GB |

### Mistral Small 3 (22B)

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~14 GB | ~16.5 GB |
| Q5_K_M | ~16 GB | ~18.5 GB |
| Q8_0 | ~24 GB | ~26.5 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | 7B Q4_K_M | 12–18 |
| M2 24GB | 7B Q5_K_M | 20–28 |
| M1 Pro 16GB | Nemo 12B Q4_K_M | 15–20 |
| M2 24GB | Nemo 12B Q4_K_M | 18–25 |
| M3 Max 48GB | Small 3 22B Q4_K_M | 25–35 |

## HuggingFace Repos

- 7B: `TheBloke/Mistral-7B-Instruct-v0.3-GGUF`
- Nemo: `bartowski/Mistral-Nemo-Instruct-2407-GGUF`
- Small 3: `bartowski/Mistral-22B-v0.2-GGUF`

## Notes

- Mistral 7B remains the most widely supported base model across tools and fine-tune ecosystems
- Mistral Nemo (12B) is the recommended Mistral model for 16 GB Macs — fits at Q4_K_M with context headroom
- Mistral Small 3 (22B) targets 24+ GB Mac systems
- Apache 2.0 license makes all Mistral models safe for commercial applications without special agreements
