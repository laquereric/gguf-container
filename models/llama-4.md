# Llama 4

**Creator:** Meta AI
**License:** Meta Llama Community License
**Architecture:** Mixture-of-Experts (MoE) — 17B active parameters per token
**Released:** Early 2025
**Sizes:** Scout (109B total / 16 experts), Maverick (402B total / 128 experts)

## Strengths

- MoE architecture: despite large total param count, only 17B params activate per token
- Multimodal: supports text and image input
- Scout has 10M token context window (largest of any practical local model)
- Maverick has 1M token context window
- Inference cost similar to a 17B dense model despite much higher total capacity

## Variants

| Model | Total Params | Active Params | Experts | Context | Use Case |
|---|---|---|---|---|---|
| **Scout** | 109B | 17B | 16 | 10M | Practical local choice; multimodal |
| **Maverick** | 402B | 17B | 128 | 1M | High capability; requires large RAM |

## Quantization Sizes

### Scout (109B MoE)

| Quant | File Size | Min RAM | Notes |
|---|---|---|---|
| IQ1_S dynamic | ~33 GB | ~36 GB | Unsloth dynamic quant (recommended) |
| Q3_K_M | ~45 GB | ~48 GB | |
| Q4_K_M | ~60 GB | ~63 GB | Standard 4-bit |
| BF16 | ~113 GB | ~117 GB | Full precision |

### Maverick (402B MoE)

| Quant | File Size | Min RAM | Notes |
|---|---|---|---|
| IQ1_S dynamic | ~122 GB | ~126 GB | Unsloth dynamic quant |
| Q2_K | ~168 GB | ~172 GB | |
| BF16 | ~422 GB | ~426 GB | Datacenter only |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) | Notes |
|---|---|---|---|
| M2 Ultra 192GB | Scout IQ1_S | 8–12 | Fits in memory |
| M3 Ultra 192GB | Scout IQ1_S | 8–12 | |
| M4 Max 128GB | Scout Q3_K_M (partial offload) | ~5–8 | Likely RAM+swap |

## HuggingFace Repos

- Scout: `unsloth/Llama-4-Scout-17B-16E-Instruct-GGUF`
- Maverick: `unsloth/Llama-4-Maverick-17B-128E-Instruct-GGUF`

## Notes

- Scout at IQ1_S dynamic (~33 GB) is the most practical option for local Mac inference (64+ GB RAM)
- MoE models load all expert weights into RAM even though only some activate per token
- Vision capabilities require compatible front-end support
- Maverick is practical only on 192 GB Mac Ultra or multi-GPU servers
- For most Mac laptop users (8–24 GB), Llama 4 is not suitable — use Llama 3.2 3B, Phi-4, or Qwen3 instead
