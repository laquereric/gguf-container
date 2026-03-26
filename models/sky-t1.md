# Sky-T1

**Creator:** NovaSky (UC Berkeley)
**License:** Apache 2.0
**Architecture:** Dense transformer (Qwen2.5-32B-Instruct base + RL fine-tuning)
**Context:** 128K tokens
**Sizes:** 32B

## Strengths

- Reasoning model competitive with OpenAI o1-preview on math and coding benchmarks
- Built on Qwen2.5-32B-Instruct with reinforcement learning from human feedback
- Apache 2.0 — fully commercial
- Strong performance on AIME (math olympiad), MATH, and competitive programming
- Open-source: training code and methodology published

## Benchmarks

| Benchmark | Sky-T1-32B | o1-preview | Qwen2.5-32B |
|---|---|---|---|
| AIME 2024 | Competitive | ~44% | Baseline |
| MATH-500 | High | High | Lower |
| LiveCodeBench | Competitive | High | Lower |

## Quantization Sizes

| Quant | File Size | Min RAM |
|---|---|---|
| Q3_K_M | ~15 GB | ~17.5 GB |
| Q4_K_M | ~20 GB | ~22.5 GB |
| Q5_K_M | ~23 GB | ~25.5 GB |
| Q6_K | ~26 GB | ~28.5 GB |
| Q8_0 | ~35 GB | ~37.5 GB |

## Performance (Apple Silicon, llama.cpp)

| Hardware | Model+Quant | Tok/s (gen) |
|---|---|---|
| M2 24GB | Q4_K_M | 12–16 |
| M3 Max 48GB | Q4_K_M | 20–28 |
| M4 Max 64GB | Q5_K_M | 22–30 |

**Note:** Like DeepSeek-R1, Sky-T1 generates reasoning tokens before answering. Actual answer latency is higher than token rate suggests.

## HuggingFace Repos

- `NovaSky-UC/Sky-T1-32B-Preview` (base model)
- Community GGUF: search `Sky-T1-32B GGUF` on HuggingFace

## Notes

- **Best use case: 24 GB Mac** at Q4_K_M (~20 GB, tight — close other apps) or **32+ GB Mac** for comfort
- Also fits 36+ GB RAM systems comfortably at Q5_K_M
- Primary strength is competitive math and algorithm reasoning at the open-weights frontier
- Superseded in some benchmarks by DeepSeek-R1 distills and Qwen3, but remains competitive
- For users with 24 GB RAM choosing between Sky-T1-32B and DeepSeek-R1-Distill-Qwen-32B, both are close — benchmark your specific tasks
- Not ideal for conversational use; best deployed with system prompts guiding it toward structured problem-solving
