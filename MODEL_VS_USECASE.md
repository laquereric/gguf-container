# Model vs. Use Case Guide

This guide maps GGUF models to specific tasks — both generally and specifically for Mac laptops with 8 GB, 16 GB, and 24 GB unified memory.

---

## Quick Reference: Mac Laptop Recommendations

### 8 GB Mac (M1/M2/M3 Air base, M1 MacBook Pro base)

Available for models: ~4 GB (OS uses ~3–4 GB; leave 1–2 GB headroom for KV cache)

| Use Case | Recommended Model | Quant | File Size | Notes |
|---|---|---|---|---|
| General chat | Qwen3-4B | Q4_K_M | 2.8 GB | Best quality-per-byte at this size |
| Coding assistant | Qwen2.5-Coder-7B | Q4_K_M | 4.7 GB | Close apps first |
| Reasoning / math | DeepSeek-R1-Distill-Qwen-7B | Q4_K_M | 4.7 GB | Close apps first |
| Compact reasoning | Phi-4 mini Reasoning | Q4_K_M | 2.5 GB | Fast; strong math |
| Fastest responses | Llama 3.2 3B | Q5_K_M | 2.3 GB | ~45 tok/s |
| Multimodal | Gemma 3 4B (QAT) | Q4_0 | 2.5 GB | Image + text |
| Background agent | SmolLM2 1.7B | Q4_K_M | 1.1 GB | Minimal footprint |
| Long-context | Qwen3-4B | Q4_K_M | 2.8 GB | 128K context |

**8 GB constraint notes:**
- Q4_K_M on 7B models (~4.7 GB file) leaves ~3 GB for OS and KV cache — viable but requires closing other apps
- Q4_K_M on 3–4B models (~2–3 GB file) is the comfortable operating zone
- Avoid models above 7B entirely; 8B models push to 5+ GB and risk RAM pressure
- MLX-format models (not GGUF) run 30–50% faster on Apple Silicon if raw speed is the priority

### 16 GB Mac (M1/M2/M3 Pro base, M2/M3 Air max)

Available for models: ~10–11 GB (OS uses ~4–5 GB; leave 1–2 GB for KV cache)

| Use Case | Recommended Model | Quant | File Size | Notes |
|---|---|---|---|---|
| General chat | Qwen2.5-14B | Q4_K_M | 9.0 GB | Best 14B general model |
| Coding assistant | Qwen2.5-Coder-14B | Q4_K_M | 9.0 GB | Best local coding model |
| Reasoning / math | DeepSeek-R1-Distill-Qwen-14B | Q4_K_M | 9.0 GB | o1-class reasoning locally |
| Quality general | Phi-4 | Q4_K_M | 8.5 GB | Beats many 70B on reasoning |
| Multimodal | Gemma 3 12B (QAT) | Q4_0 | 7.0 GB | Image + text |
| RAG / documents | Mistral Nemo 12B | Q4_K_M | 7.5 GB | 128K context; efficient |
| Fastest 7B | Qwen2.5-7B | Q5_K_M | 5.4 GB | Speed + quality balance |
| Long context | Mistral Nemo 12B | Q4_K_M | 7.5 GB | 128K context |
| Low RAM mode | Qwen3-8B | Q4_K_M | 5.0 GB | Reasoning model, 5 GB footprint |

**16 GB constraint notes:**
- 14B models at Q4_K_M (~9 GB) leave ~7 GB for OS + KV cache — comfortable operation
- 12B models fit even more comfortably and still provide excellent quality
- Avoid 32B+ models; they don't fit at any useful quantization
- Q5_K_M vs Q4_K_M on a 7B: gains ~3% quality, costs ~0.7 GB — usually worth it

### 24 GB Mac (M2/M3 base with 24 GB option, M3 Pro mid)

Available for models: ~18–20 GB (OS uses ~4–5 GB; leave 1–2 GB for KV cache)

| Use Case | Recommended Model | Quant | File Size | Notes |
|---|---|---|---|---|
| General chat | Qwen2.5-32B | Q4_K_M | 20 GB | Best quality at this RAM; close other apps |
| Reasoning / math | DeepSeek-R1-Distill-Qwen-32B | Q4_K_M | 19.9 GB | Best local reasoning; close other apps |
| Quality reasoning | Sky-T1-32B | Q4_K_M | 20 GB | o1-preview competitive |
| MoE quality | Qwen3-30B-A3B | Q4_K_M | 18.6 GB | Large capacity, fast due to MoE |
| Coding assistant | Qwen2.5-Coder-32B | Q4_K_M | 20 GB | Top coding model |
| Multimodal | Gemma 3 27B (QAT) | Q4_0 | ~16 GB | 27B multimodal; best image+text |
| Comfortable fit | Qwen2.5-14B | Q5_K_M | 10.5 GB | High quality with full RAM headroom |
| RAG / documents | Command-R 35B | Q4_K_M | 22 GB | Best RAG; tight fit |
| Long context | Yi-34B-200K | Q4_K_M | 20.7 GB | 200K context window |

**24 GB constraint notes:**
- 32B models at Q4_K_M (~20 GB) leave only ~4 GB for OS + KV cache — **close all other apps**
- Qwen3-30B-A3B MoE (18.6 GB) is often the better choice: slightly smaller, fast due to 3B active params, high reasoning quality
- 14B models run very comfortably with KV cache for long sessions
- Command-R 35B at Q4_K_M (22 GB) is possible but requires disciplined RAM management

---

## Use Case Deep-Dive: General Categories

### General Conversation & Chat

Best models by quality tier:

| Tier | Model | Size | Notes |
|---|---|---|---|
| Best overall (any RAM) | Llama 3.3 70B | 70B | Requires 64+ GB |
| Best small | Qwen3-4B | 4B | Reasoning-capable chat |
| Best mid | Qwen2.5-14B | 14B | Well-rounded; multilingual |
| Best large-ish | Qwen2.5-32B | 32B | Excellent general chat |
| Best quality/param | Phi-4 | 14B | Beats larger models on many tasks |

For casual chat, general Q&A, writing assistance, and brainstorming — any model works. Use the largest one that fits your RAM comfortably.

### Coding & Software Development

| Priority | Model | Size | Strengths |
|---|---|---|---|
| Best code model | Qwen2.5-Coder-32B | 32B | Top open-weights code model |
| Best code 16B | Qwen2.5-Coder-14B | 14B | Best coding under 24 GB |
| Best code 7B | Qwen2.5-Coder-7B | 7B | Strong code completion |
| Best reasoning+code | DeepSeek-R1 Distill 14B | 14B | Algorithm design, debugging |
| Best small code | Phi-4 mini | 3.8B | Surprisingly capable at 3.8B |

For code generation, autocomplete, debugging, refactoring:
- Use Qwen2.5-Coder for pure code tasks (trained specifically on code)
- Use DeepSeek-R1 distills for algorithm design, competitive programming, or complex debugging
- Use Phi-4 for reasoning-heavy tasks like architecture decisions or code review

### Mathematics & Reasoning

| Priority | Model | Size | Benchmark Performance |
|---|---|---|---|
| Best local reasoner | DeepSeek-R1-Distill-Qwen-32B | 32B | o1-class |
| Best 14B reasoner | DeepSeek-R1-Distill-Qwen-14B | 14B | Strong AIME, MATH |
| Best 7B reasoner | DeepSeek-R1-Distill-Qwen-7B | 7B | Good for competition math |
| Alternative 32B | Sky-T1-32B | 32B | o1-preview competitive |
| Fastest reasoner | Phi-4 mini Reasoning | 3.8B | Best reasoning under 3 GB |
| Best thinking MoE | Qwen3-30B-A3B | 30B | Thinking mode + fast inference |

**Key insight:** R1 distill models generate "thinking" tokens before answering — output quality is much higher than the parameter count suggests, but generation time per answer is longer.

### RAG & Document Processing

Best models for retrieval-augmented generation, document Q&A, and summarization:

| Priority | Model | Size | Strengths |
|---|---|---|---|
| Best RAG | Command-R+ (104B) | 104B | Native RAG, grounded output, citations |
| Best accessible RAG | Command-R (35B) | 35B | Best RAG under 64 GB RAM |
| Best long context | Mistral Nemo 12B | 12B | 128K context; efficient |
| Best long context small | Yi-34B-200K | 34B | 200K context window |
| Best multilingual RAG | Qwen2.5-72B | 72B | 100+ languages; 128K context |

For most RAG workflows where Command-R is not available:
- Use any model with 128K context (Qwen, Mistral Nemo, Gemma 3, Llama 3.x)
- Feed document chunks via the context window
- Larger models produce better grounded summaries

### Multilingual Tasks

| Priority | Model | Languages | Notes |
|---|---|---|---|
| Best multilingual | Qwen2.5 / Qwen3 | 100+ | Specifically optimized |
| Best European languages | Mistral family | 7+ | French/German/Spanish/Italian strong |
| Best East Asian | Qwen (all sizes) | Chinese/Japanese/Korean | Best non-English open model |
| Best broad | Command-R | 23 languages | Enterprise-grade multilingual |

### Multimodal (Text + Images)

| Priority | Model | Size | Notes |
|---|---|---|---|
| Best small vision | Gemma 3 4B | 4B | 128K context; QAT GGUF from Google |
| Best mid vision | Gemma 3 12B | 12B | Strong vision+text quality |
| Best large vision | Gemma 3 27B | 27B | Best open vision model for local use |
| Alternative | Llama 3.2 11B Vision | 11B | 128K; good all-round |
| Large alternative | Llama 3.2 90B Vision | 90B | Best quality; needs 64+ GB |
| Frontier MoE vision | Llama 4 Scout | 109B MoE | 10M context; needs 64+ GB |

**Requirement:** Vision support must be enabled in your llama.cpp build, or use a front-end that supports it (LM Studio, Ollama with vision support).

### Long Context (>32K tokens)

All models listed here support 128K tokens unless noted.

| Priority | Model | Context | RAM at Q4_K_M |
|---|---|---|---|
| Extreme context | Yi-34B-200K | 200K | ~23 GB |
| Standard 128K | Qwen3-4B | 128K | ~5 GB |
| Standard 128K | Mistral Nemo 12B | 128K | ~10 GB |
| Standard 128K | Phi-4 mini | 128K | ~5 GB |
| MoE 10M context | Llama 4 Scout | 10M | 64+ GB |

**KV cache warning:** At 128K context, KV cache alone can consume 8–32 GB RAM depending on model size and batch size. For long-context workloads on 8–24 GB Macs, keep actual context short (under 32K) and use smaller models.

### Background / Agentic / Fast-Iteration Tasks

For tasks requiring rapid responses, high token throughput, or minimal RAM footprint:

| Priority | Model | Size | Tok/s (8GB Mac) |
|---|---|---|---|
| Fastest viable | SmolLM2 1.7B | 1.7B | 80–120 |
| Best quality fast | Llama 3.2 1B | 1B | 60–90 |
| Balanced | Llama 3.2 3B | 3B | 30–45 |
| Quality fast | Qwen3-4B | 4B | 25–35 |
| Reasoning fast | Phi-4 mini | 3.8B | 25–40 |

### Enterprise / Commercial Deployment

License considerations:

| License | Models |
|---|---|
| **Apache 2.0** (most permissive) | Mistral, Mixtral, Qwen2.5, Qwen3, Phi-4 (MIT), Falcon, Yi, SmolLM2, DeepSeek-R1, Sky-T1 |
| **Meta Llama License** | All Llama models — free for <700M MAU; check terms for larger scale |
| **Gemma Terms** | Gemma 3 — free for research and commercial up to certain thresholds |
| **CC-BY-NC** | Command-R / Command-R+ — non-commercial; enterprise license required |

For enterprise without legal review: **Mistral, Qwen, Phi-4, DeepSeek-R1 distills, Falcon** are all Apache 2.0 / MIT.

---

## Quantization Selection Guide

**When to use Q4_K_M (default choice):**
- First model deployment
- RAM is the primary constraint
- ~95% of F16 quality at ~30% the size

**When to upgrade to Q5_K_M:**
- You have 10–15% extra RAM headroom
- Tasks are quality-sensitive (legal, medical, precision coding)
- Long sessions where small errors compound

**When to use Q8_0:**
- RAM budget is comfortable and quality is paramount
- Evaluating a model before deploying a smaller quant
- Serving to multiple users simultaneously

**When to use IQ-quants (IQ3_XS, IQ4_XS):**
- You want a model that doesn't fit at Q4_K_M to just barely fit
- Download only from bartowski or unsloth — imatrix quality varies

**When to use official QAT (Gemma 3):**
- Always prefer `google/gemma-3-*-qat-q4_0-gguf` over community quants for Gemma 3
- QAT quality at Q4_0 ≈ community Q5_K_M quality at smaller size

---

## Model Families at a Glance

| Family | Best At | Worst At | License |
|---|---|---|---|
| Llama 3.x | General purpose; ecosystem | Not specialized | Meta |
| Llama 4 | Long context; MoE efficiency | RAM requirements | Meta |
| Mistral | Efficiency; Apache 2.0 | Not top benchmark | Apache 2.0 |
| Mixtral | MoE quality | High RAM minimum | Apache 2.0 |
| Gemma 3 | Vision; QAT quality | Context length (8K Gemma 2) | Gemma Terms |
| Phi-4 | Quality-per-param; reasoning | Context (Phi-4 14B = 16K) | MIT |
| Qwen2.5 | Multilingual; coding; ladder of sizes | Nothing notable | Apache 2.0 |
| Qwen3 | Reasoning; thinking mode; MoE | Still new | Apache 2.0 |
| DeepSeek-R1 | Reasoning; math; coding | Conversational latency | Apache 2.0 |
| Command-R | RAG; document QA | License (non-commercial) | CC-BY-NC |
| Falcon | Hybrid SSM architecture; experimental | Benchmark rankings | Apache 2.0 |
| Yi | 200K context | Dated benchmarks | Apache 2.0 |
| SmolLM2 | Speed; embedded | Complex tasks | Apache 2.0 |
| Sky-T1 | Reasoning; o1-competitive | 32B only option | Apache 2.0 |

---

## Decision Trees

### "What model should I download right now?"

```
Do you have 8 GB RAM?
├── Yes → Do you need reasoning/math?
│         ├── Yes → DeepSeek-R1-Distill-Qwen-7B Q4_K_M
│         └── No  → Qwen3-4B Q4_K_M (fastest useful model)
│
Do you have 16 GB RAM?
├── Yes → Do you primarily code?
│         ├── Yes → Qwen2.5-Coder-14B Q4_K_M
│         └── No  → Do you need reasoning?
│                   ├── Yes → DeepSeek-R1-Distill-Qwen-14B Q4_K_M
│                   └── No  → Phi-4 14B Q4_K_M (best general quality)
│
Do you have 24 GB RAM?
├── Yes → Do you need fast responses or best quality?
│         ├── Fast → Qwen2.5-14B Q5_K_M (comfortable fit, fast)
│         └── Best → Qwen3-30B-A3B Q4_K_M (MoE: quality + speed)
│                    OR DeepSeek-R1-Distill-Qwen-32B Q4_K_M (best reasoning)
```

### "I need to process images too"

```
8 GB  → Gemma 3 4B QAT Q4_0
16 GB → Gemma 3 12B QAT Q4_0
24 GB → Gemma 3 27B QAT Q4_0
64+ GB → Llama 4 Scout IQ1_S dynamic
```

### "I need the best reasoning and have 24 GB"

```
Math/Science   → DeepSeek-R1-Distill-Qwen-32B Q4_K_M (close all apps)
Coding         → Sky-T1-32B Q4_K_M or Qwen2.5-Coder-32B Q4_K_M
General        → Qwen3-30B-A3B Q4_K_M (thinking mode; 18.6 GB, more headroom)
```

### "I need this for work / commercial use"

```
Verify Apache 2.0 or MIT license:
→ Phi-4 (MIT): safest license
→ Qwen3 or Qwen2.5: Apache 2.0 + best multilingual
→ Mistral Nemo: Apache 2.0 + good quality
→ DeepSeek-R1 distills: Apache 2.0 + best reasoning

Avoid Command-R for commercial use without a Cohere enterprise agreement.
Check Llama and Gemma terms for your scale.
```
