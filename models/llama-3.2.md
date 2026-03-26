# Llama 3.2

**Creator:** Meta AI
**License:** Meta Llama Community License
**Architecture:** Dense transformer (1B, 3B); Vision encoder + transformer (11B, 90B)
**Context:** 128K tokens
**Sizes:** 1B, 3B, 11B (vision), 90B (vision)

## Strengths

- Best-in-class performance at 1B and 3B parameter counts
- Multimodal variants (11B, 90B) support text + image input
- 128K context even in the smallest models
- Ideal for on-device, embedded, or low-RAM local inference

## Variants

| Size | Architecture | Notes |
|---|---|---|
| 1B | Text only | Ultra-compact; fastest inference |
| 3B | Text only | Top performer at its size class |
| 11B | Vision (text+image) | Practical multimodal local model |
| 90B | Vision (text+image) | Flagship multimodal; needs 64+ GB |

## Quantization Sizes

### 1B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~0.7 GB | ~3 GB |
| Q5_K_M | ~0.8 GB | ~3.3 GB |
| Q8_0 | ~1.2 GB | ~3.7 GB |

### 3B

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | 2.0 GB | 4.5 GB |
| Q5_K_M | 2.3 GB | 4.8 GB |
| Q8_0 | 3.4 GB | 5.9 GB |
| F16 | 6.4 GB | 8.9 GB |

### 11B (Vision)

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~7.0 GB | ~9.5 GB |
| Q5_K_M | ~8.0 GB | ~10.5 GB |
| Q8_0 | ~12.5 GB | ~15 GB |

### 90B (Vision)

| Quant | File Size | Min RAM |
|---|---|---|
| Q4_K_M | ~55 GB | ~58 GB |
| Q5_K_M | ~64 GB | ~67 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M1 Air 8GB | 3B Q4_K_M | 30–45 |
| M2 24GB | 3B Q4_K_M | 35–50 |
| M1 Air 8GB | 1B Q4_K_M | 60–90 |
| M1 Pro 16GB | 11B Q4_K_M | 15–22 |

## HuggingFace Repos

- 1B: `bartowski/Llama-3.2-1B-Instruct-GGUF`
- 3B: `bartowski/Llama-3.2-3B-Instruct-GGUF`
- 11B: `bartowski/Llama-3.2-11B-Vision-Instruct-GGUF`
- 90B: `bartowski/Llama-3.2-90B-Vision-Instruct-GGUF`

## Notes

- 3B is the recommended choice for 8 GB Macs when you want a capable text model with speed
- 1B is useful for rapid prototyping, testing pipelines, or extremely resource-constrained devices
- 11B vision requires 16 GB RAM at Q4_K_M; first practical local multimodal option
- Vision models require llama.cpp with vision support or compatible front-ends (LM Studio, Ollama)
