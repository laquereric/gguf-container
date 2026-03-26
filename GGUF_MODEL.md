# GGUF Model Format

## What is GGUF?

**GGUF** (GGML Universal File format) was introduced in August 2023 by Georgi Gerganov and the llama.cpp team as a replacement for the older GGML format. The name encodes the author's initials plus "UF" for Universal File. The current spec is **version 3**.

### Why GGUF Replaced GGML

| Problem with GGML | GGUF Solution |
|---|---|
| Breaking changes with every new architecture | Extensible key-value metadata; forward/backward compatible |
| No embedded tokenizer info | Full tokenizer vocab, merges, special tokens in-file |
| No model metadata | Architecture, quant type, author, license all embedded |
| Poor loading performance | Memory-mappable (mmap) binary layout; 32-byte aligned tensor data |
| Monolithic format | Shard support: `{stem}-{N}-of-{total}.gguf` |
| No mixed quantization | Per-tensor quantization type field supports mixed precision |

### File Structure

```
[Header: 24 bytes]
  Magic: 0x46554747 ("GGUF")
  Version: uint32 (currently 3)
  Tensor count: uint64
  KV pair count: uint64

[KV Metadata: variable]
  general.architecture (llama, mistral, falcon, qwen2, phi3, ...)
  llm.vocab_size, llm.context_length, llm.embedding_length
  llm.block_count, llm.attention.head_count
  tokenizer.ggml.model, tokenizer.ggml.tokens, tokenizer.ggml.merges
  general.quantization_version

[Tensor Info: variable, padded to 8 bytes]
  Name, dimensions, quantization type, byte offset

[Tensor Data: 32-byte aligned, mmap-ready]
```

The mmap alignment means models larger than available GPU memory can run via hybrid CPU+GPU execution.

---

## Quantization Types

### Legacy Formats (block size 32)

| Type | Bits/weight | Notes |
|---|---|---|
| Q4_0 | 4.5 | Original 4-bit; superseded by K-quants |
| Q5_0 | 5.5 | Original 5-bit; superseded |
| Q8_0 | 8.5 | 8-bit; still widely used for high fidelity |
| F16 | 16.0 | Half-precision float |
| BF16 | 16.0 | Brain float; better training stability |
| F32 | 32.0 | Full precision; rarely used for inference |

### K-Quants (block size 256 — superior quality-per-bit)

| Type | Bits/weight | 7B size | Quality vs F16 | Recommended use |
|---|---|---|---|---|
| Q2_K | ~2.6 | 2.8 GB | ~70% | Extreme RAM constraints only |
| Q3_K_S | ~3.0 | 3.0 GB | ~78% | Proof of concept |
| Q3_K_M | ~3.3 | 3.3 GB | ~80% | Edge/minimal RAM |
| Q3_K_L | ~3.5 | 3.5 GB | ~82% | Moderate quality |
| Q4_K_S | ~4.4 | 3.8 GB | ~90% | Cost-optimized |
| **Q4_K_M** | ~4.8 | **4.1 GB** | **~95%** | **Most popular default** |
| Q5_K_S | ~5.5 | 4.4 GB | ~97% | High quality |
| **Q5_K_M** | ~5.7 | **4.8 GB** | **~98%** | **Production/quality** |
| Q6_K | ~6.6 | 5.5 GB | ~99% | Premium quality |
| Q8_0 | ~8.5 | 7.0 GB | ~99.9% | Near-lossless |

### I-Quants (Importance-aware — require imatrix calibration)

Better quality-per-byte than K-quants at equivalent bit depth. Only download from trusted quantizers.

| Type | Bits/weight | Notes |
|---|---|---|
| IQ1_S / IQ1_M | ~1.6–1.8 | Extreme compression (Unsloth dynamic quants) |
| IQ2_XXS – IQ2_M | ~2.0–2.5 | Better than Q2_K at same size |
| IQ3_XXS – IQ3_M | ~2.9–3.5 | Better than Q3_K_* |
| IQ4_XS / IQ4_NL | ~4.3–4.5 | Smaller than Q4_K_M, comparable quality |

### Quality vs. RAM Ordering

```
Quality:  F16 > BF16 > Q8_0 > Q6_K > Q5_K_M > Q5_K_S > Q4_K_M > Q4_K_S > Q3_K > Q2_K
RAM use:  F16 > BF16 > Q8_0 > Q6_K > Q5_K_M > Q5_K_S > Q4_K_M > Q4_K_S > Q3_K > Q2_K
Speed:    Q2_K > Q3_K > Q4_K_M > Q5_K_M > Q6_K > Q8_0 > F16
```

**Decision guide by available RAM (leave ~4 GB for OS overhead):**

| System RAM | Mac config | Recommended strategy |
|---|---|---|
| 8 GB | M1/M2/M3 Air base | Q4_K_M on 1B–7B; Q3_K_M on 8–13B |
| 16 GB | M-series mid | Q4_K_M on 7B–14B; Q5_K_M on 7B |
| 24 GB | M2/M3 base | Q5_K_M on 14B; Q4_K_M on 27B |
| 32–36 GB | M3 Pro | Q5_K_M on 14B; Q4_K_M on 32B |
| 48–64 GB | M-series Max | Q5_K_M or Q8_0 on 14–30B; Q4_K_M on 70B |
| 96–128 GB | M-series Max | Q8_0 on 70B; Q4_K_M on 180B+ |
| 192 GB | M-series Ultra | Full DeepSeek-R1-671B at IQ1 dynamic quants |

---

## Apple Silicon Performance

Token generation speed on Apple Silicon is bounded by **memory bandwidth**, not compute. Always check bandwidth when comparing chips.

| Chip | Memory Bandwidth | Max Unified RAM |
|---|---|---|
| M1 | 68.25 GB/s | 16 GB |
| M2 | 100 GB/s | 24 GB |
| M3 | 100 GB/s | 24 GB |
| M4 | 120 GB/s | 32 GB |
| M1/M2 Pro | 200 GB/s | 32 GB |
| M3 Pro | 150 GB/s | 36 GB |
| M4 Pro | 273 GB/s | 64 GB |
| M1/M2 Max | 400 GB/s | 64–96 GB |
| M3 Max | 400 GB/s | 128 GB |
| M4 Max | 546 GB/s | 128 GB |
| M-series Ultra | 800 GB/s | 192 GB |

**MLX vs. llama.cpp:** Apple's MLX framework is consistently 30–50% faster than llama.cpp on Apple Silicon but uses its own weight format, not GGUF. For GGUF-based workflows (Ollama, LM Studio, llama.cpp CLI), the benchmarks in each model file apply.

---

## Trusted GGUF Quantizers

| Quantizer | HuggingFace Handle | Notes |
|---|---|---|
| **bartowski** | `bartowski` | Most prolific; comprehensive quant range per model |
| **unsloth** | `unsloth` | Dynamic quantization specialist; first to release new models |
| **TheBloke** | `TheBloke` | Original pioneer; many older models |
| **ggml-org** | `ggml-org` | Official llama.cpp team releases |
| **Google** | `google` | Official QAT GGUF for Gemma 3 |
| **Qwen team** | `Qwen` | Official GGUF for Qwen2.5 series |
| **TII** | `tiiuae` | Official GGUF for Falcon series |

---

## Model Index

| Family | File | Sizes | Strengths |
|---|---|---|---|
| [Llama 3.1](models/llama-3.1.md) | llama-3.1.md | 8B, 70B, 405B | General purpose, 128K context |
| [Llama 3.2](models/llama-3.2.md) | llama-3.2.md | 1B, 3B, 11B, 90B | Small/multimodal, 128K context |
| [Llama 3.3](models/llama-3.3.md) | llama-3.3.md | 70B | Matches 405B quality at 70B |
| [Llama 4](models/llama-4.md) | llama-4.md | 109B/402B MoE | Long context, multimodal |
| [Mistral](models/mistral.md) | mistral.md | 7B, 12B, 22B | Efficient, Apache 2.0 |
| [Mixtral](models/mixtral.md) | mixtral.md | 46.7B, 141B MoE | Quality at lower active params |
| [Gemma 3](models/gemma-3.md) | gemma-3.md | 1B, 4B, 12B, 27B | QAT official GGUFs, multimodal |
| [Phi-4](models/phi-4.md) | phi-4.md | 3.8B, 14B | Best quality-per-parameter |
| [Qwen 2.5](models/qwen2.5.md) | qwen2.5.md | 0.5B–72B | Best multilingual, coding |
| [Qwen 3](models/qwen3.md) | qwen3.md | 4B–235B dense+MoE | Reasoning, thinking modes |
| [DeepSeek-R1](models/deepseek-r1.md) | deepseek-r1.md | 1.5B–671B | Best-in-class reasoning |
| [Command-R](models/command-r.md) | command-r.md | 35B, 104B | Best RAG, 128K context |
| [Falcon](models/falcon.md) | falcon.md | 1B–34B | Hybrid SSM+attn, reasoning |
| [Yi](models/yi.md) | yi.md | 6B, 9B, 34B | Long context (200K), multilingual |
| [SmolLM2](models/smollm2.md) | smollm2.md | 135M, 360M, 1.7B | Embedded/on-device |
| [Sky-T1](models/sky-t1.md) | sky-t1.md | 32B | Reasoning, o1-preview competitive |
