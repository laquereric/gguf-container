# Command-R

**Creator:** Cohere
**License:** CC-BY-NC (non-commercial) for free tier; commercial license available
**Architecture:** Dense transformer
**Context:** 128K tokens
**Sizes:** 35B (Command-R), 104B (Command-R+)

## Strengths

- Best RAG (Retrieval-Augmented Generation) performance in open weights
- Native tool use and function calling built into the model
- 128K context across both sizes
- 23 languages natively supported
- Optimized for enterprise document tasks: summarization, Q&A over large corpora
- Grounded generation: can cite sources in structured output

## Variants

| Model | Params | Notes |
|---|---|---|
| Command-R | 35B | Efficient RAG model; fits 64 GB RAM |
| Command-R+ | 104B | Maximum quality; needs 128+ GB |
| Command-R+ 08-2024 | 104B | Updated version; same hardware requirements |

## Quantization Sizes

### Command-R (35B)

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~22 GB | ~24.5 GB |
| Q5_K_M | ~26 GB | ~28.5 GB |
| Q6_K | ~30 GB | ~32.5 GB |
| Q8_0 | ~38 GB | ~40.5 GB |

### Command-R+ (104B)

| Quant | File Size | Min RAM |
|---|---|---|
| IQ1_S | 23.2 GB | ~26 GB |
| IQ2_XXS | 28.6 GB | ~31 GB |
| Q2_K | 39.5 GB | ~42 GB |
| IQ3_XS | 43.6 GB | ~46 GB |
| Q3_K_M | 51 GB | ~54 GB |
| IQ4_XS | 56.2 GB | ~59 GB |
| Q4_K_M | 62.8 GB | ~66 GB |
| Q5_K_M | 73.6 GB | ~77 GB |
| Q6_K | 85.2 GB | ~89 GB |
| Q8_0 | 110 GB | ~114 GB |
| F16 | 208 GB | ~212 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M2 Max 64GB | Command-R Q4_K_M | 10–15 |
| M3 Max 128GB | Command-R Q5_K_M | 14–20 |
| M2 Ultra 192GB | Command-R+ Q5_K_M | 6–10 |
| M3 Ultra 192GB | Command-R+ Q5_K_M | 6–10 |
| M3 Max 128GB | Command-R+ IQ2_XXS | 8–12 |

## HuggingFace Repos

- `bartowski/c4ai-command-r-GGUF`
- `bartowski/c4ai-command-r-plus-GGUF`
- `bartowski/c4ai-command-r-plus-08-2024-GGUF`

## Notes

- **Best choice for RAG pipelines** regardless of hardware budget at the appropriate size
- Command-R (35B) at Q4_K_M (~22 GB) can fit 24 GB+ Mac systems (tight — close other apps)
- Command-R+ IQ2_XXS (28.6 GB) fits 36+ GB RAM systems while retaining much of the 104B quality
- License requires review: CC-BY-NC restricts commercial use without a Cohere enterprise agreement
- Tool use format is unique to Cohere — ensure your front-end supports it (LM Studio has support)
- Ideal for: document QA, long-form summarization, multi-document synthesis, structured grounding
