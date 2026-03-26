# Llama 3.3

**Creator:** Meta AI
**License:** Meta Llama Community License
**Architecture:** Dense transformer
**Context:** 128K tokens
**Sizes:** 70B

## Strengths

- Matches or exceeds Llama 3.1 405B quality at 70B parameter count
- Same RAM requirements as Llama 3.1 70B with significantly better output
- Best open-weights dense model at the 70B class as of early 2026
- Strong instruction following, reasoning, coding, and multilingual

## Quantization Sizes

| Quant | File Size | Min RAM |
|---|---|---|
| Q2_K | 27 GB | 30 GB |
| Q3_K_M | 33 GB | 36 GB |
| Q4_K_S | 39 GB | 42 GB |
| Q4_K_M | 43 GB | 46 GB |
| Q5_K_M | 50 GB | 53 GB |
| Q6_K | 58 GB | 61 GB |
| Q8_0 | 75 GB | 78 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Quant | Tok/s (gen) | Notes |
|---|---|---|---|
| M2 Ultra 192GB | Q4_K_M | 12–15 | Fits entirely in GPU memory |
| M3 Ultra 192GB | Q4_K_M | 12–15 | Similar bandwidth |
| M4 Max 128GB | Q4_K_M | 8–15 | Fits in 128 GB |
| M3 Max 128GB | Q4_K_M | 10–14 | |
| M2 Max 96GB | Q5_K_M | 8–12 | |

## HuggingFace Repos

- `bartowski/Llama-3.3-70B-Instruct-GGUF`
- `unsloth/Llama-3.3-70B-Instruct-GGUF`

## Notes

- **Preferred over Llama 3.1 70B** — better quality, same hardware requirements
- Requires 64 GB+ RAM at Q4_K_M; practical on M-series Max or Ultra machines
- At Q2_K (27 GB), can run on 36 GB RAM machines but quality degrades substantially
- For Mac laptops (8–24 GB), use Llama 3.2 3B or Phi-4 instead
