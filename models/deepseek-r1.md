# DeepSeek-R1

**Creator:** DeepSeek AI
**License:** Apache 2.0
**Architecture:** Dense transformer (distills); MoE 671B (full R1 and V3)
**Released:** January 2025 (R1), ongoing (V3.x)

## Strengths

- Best-in-class reasoning: matches or beats OpenAI o1 on math, coding, and science
- Distilled variants (1.5B–70B) run locally and retain strong reasoning
- Apache 2.0 — fully open, commercial-friendly
- Distills built on trusted base models (Qwen2.5, Llama 3.1)
- Full R1/V3 671B are the most capable open-weights models available

## Variants

### R1 Distilled (locally runnable)

Smaller models fine-tuned on R1's reasoning traces — they inherit the chain-of-thought reasoning ability.

| Model | Params | Base | Notes |
|---|---|---|---|
| R1-Distill-Qwen-1.5B | 1.5B | Qwen2.5 | Tiny reasoning model |
| R1-Distill-Qwen-7B | 7B | Qwen2.5 | Best 8 GB Mac reasoning choice |
| R1-Distill-Qwen-14B | 14B | Qwen2.5 | Best 16 GB Mac reasoning choice |
| R1-Distill-Qwen-32B | 32B | Qwen2.5 | 24 GB+ Mac |
| R1-Distill-Llama-8B | 8B | Llama 3.1 | Alternative 8B reasoning |
| R1-Distill-Llama-70B | 70B | Llama 3.1 | 64+ GB RAM required |

### Full Models (datacenter/extreme hardware)

| Model | Architecture | Notes |
|---|---|---|
| DeepSeek-R1 (671B) | MoE | Best open reasoning; needs 400+ GB at standard quants |
| DeepSeek-V3 (671B) | MoE | General purpose; comparable scale to R1 |
| DeepSeek-V3.1 (671B) | MoE | Updated V3 iteration |

## Quantization Sizes

### R1 Distilled Models

| Model | Q4_K_M | Q5_K_M | Q8_0 |
|---|---|---|---|
| R1-Distill-Qwen-1.5B | ~1.1 GB | ~1.3 GB | ~1.9 GB |
| R1-Distill-Qwen-7B | ~4.7 GB | ~5.4 GB | ~8.1 GB |
| R1-Distill-Llama-8B | ~5.0 GB | ~5.7 GB | ~8.6 GB |
| R1-Distill-Qwen-14B | ~9.0 GB | ~10.5 GB | ~15.6 GB |
| R1-Distill-Qwen-32B | ~19.9 GB | ~23 GB | ~34.8 GB |
| R1-Distill-Llama-70B | ~43 GB | ~50 GB | ~75 GB |

**Min RAM ≈ File Size + 2.5 GB** (more for long reasoning chains — KV cache grows with thinking tokens)

### Full R1/V3 (671B MoE)

| Quant | File Size | Min RAM | Notes |
|---|---|---|---|
| IQ1_S dynamic | ~170 GB | ~180 GB | Unsloth dynamic quant; minimum viable |
| Q2_K | ~270 GB | ~280 GB | |
| Q4_K_M | ~400 GB | ~420 GB | Datacenter only |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) | Notes |
|---|---|---|---|
| M1 Air 8GB | R1-Qwen-7B Q4_K_M | 10–15 | Reasoning tokens = long output |
| M2 24GB | R1-Qwen-7B Q5_K_M | 18–25 | |
| M1 Pro 16GB | R1-Qwen-14B Q4_K_M | 12–18 | |
| M2 24GB | R1-Qwen-14B Q4_K_M | 16–22 | |
| M3 Max 48GB | R1-Qwen-32B Q4_K_M | 15–20 | |

**Important:** R1 models generate reasoning "thinking" tokens before answering. A 500-word answer might involve 2000+ internal reasoning tokens. Effective throughput for final answers is similar but total generation is much longer.

## HuggingFace Repos

- `bartowski/DeepSeek-R1-Distill-Qwen-1.5B-GGUF`
- `bartowski/DeepSeek-R1-Distill-Qwen-7B-GGUF`
- `bartowski/DeepSeek-R1-Distill-Qwen-14B-GGUF`
- `bartowski/DeepSeek-R1-Distill-Qwen-32B-GGUF`
- `bartowski/DeepSeek-R1-Distill-Llama-8B-GGUF`
- `unsloth/DeepSeek-R1-GGUF` (full 671B dynamic quants)
- `unsloth/DeepSeek-V3.1-GGUF`

## Notes

- **R1-Distill-Qwen-7B** is the top reasoning choice for 8 GB Macs
- **R1-Distill-Qwen-14B** is the top reasoning choice for 16 GB Macs
- **R1-Distill-Qwen-32B** is the top reasoning choice for 24+ GB Macs (Q4_K_M = ~20 GB)
- Reasoning models excel at: math competitions, algorithm design, proof writing, complex debugging
- For conversational tasks without complex reasoning, non-R1 models (Qwen3, Phi-4) are faster
- Full 671B models require server infrastructure — not practical on consumer Macs
