---
title: "MixKVQ: Query-Aware Mixed-Precision KV Cache Quantization for Long-Context Reasoning"
title_zh: MixKVQ：面向长上下文推理的查询感知混合精度KV缓存量化
authors: "Tao Zhang, Ziqian Zeng, Hao Peng, Huiping Zhuang, Cen Chen"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.326.pdf"
tags: ["query:wbv"]
score: 8.0
evidence: 面向长上下文推理的低比特KV缓存量化
tldr: 长思维链推理中大量KV缓存带来显存和延迟开销，现有低比特量化在复杂推理任务上性能下降严重。MixKVQ提出查询感知的混合精度KV缓存量化，同时考虑键通道的内在量化敏感性与查询依赖，以识别需要高精度表示的组件。实验表明该方法在保持低比特压缩的同时改善了长上下文推理性能。该工作为KV缓存量化中的混合精度分配提供了新思路。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long326/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 777, \"height\": 544, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long326/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 800, \"height\": 1025, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long326/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1567, \"height\": 717, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long326/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1639, \"height\": 747, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long326/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 751, \"height\": 547, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long326/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1655, \"height\": 852, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long326/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1646, \"height\": 1372, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1654, \"height\": 797, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 804, \"height\": 314, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1579, \"height\": 1002, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1650, \"height\": 908, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 824, \"height\": 121, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 691, \"height\": 483, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 712, \"height\": 249, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 809, \"height\": 215, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long326/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1648, \"height\": 427, \"label\": \"Table\"}]"
motivation: 现有低比特KV缓存量化在复杂推理任务上性能下降，混合精度难以识别关键组件。
method: 提出MixKVQ，结合键通道内在敏感性与查询感知机制分配混合精度比特。
result: 实验显示在低比特压缩下提升长上下文推理性能。
conclusion: 为KV缓存量化提供了查询感知的混合精度分配方法。
---

## Abstract
Long Chain-of-Thought (CoT) reasoning has significantly advanced the capabilities of Large Language Models (LLMs), but this progress is accompanied by substantial memory and latency overhead from the extensive Key-Value (KV) cache. Although KV cache quantization is a promising compression technique, existing low-bit quantization methods often exhibit severe performance degradation on complex reasoning tasks. Fixed-precision quantization struggles to handle outlier channels in the key cache, while current mixed-precision strategies fail to accurately identify components requiring high-precision representation. We find that an effective low-bit KV cache quantization strategy must consider two factors: a key channel’s intrinsic quantization difficulty and its relevance to the query. Based on this insight, we propose MixKVQ, a novel plug-and-play method that introduces a lightweight, query-aware algorithm to identify and preserve critical key channels that need higher precision, while applying per-token quantization for value cache. Experiments on complex reasoning datasets demonstrate that our approach significantly outperforms existing low-bit methods, achieving performance comparable to a full-precision baseline at a substantially reduced memory footprint.

---

## 论文详细总结（自动生成）

## 一、核心问题与整体含义（研究动机）

- **背景**：OpenAI-o1、DeepSeek-R1、Gemini 2.5 Pro 等新一代大语言模型通过生成长达数万甚至数十万 token 的思维链（Chain-of-Thought, CoT）大幅提升了复杂推理能力。然而，自回归解码过程中需要不断保存和读取不断增长的 Key-Value（KV）缓存，KV 缓存随序列长度线性增长，给 GPU 内存带来巨大压力。
- **问题**：例如 Qwen2.5-32B 模型在 batch size=64、序列长度 32,768 token 时，KV 缓存需约 512 GB 显存，是模型权重的 8.59 倍；同时注意力机制在每步解码时反复访问 KV 缓存，形成严重的**内存带宽瓶颈**，制约推理吞吐量。
- **现有方法的不足**：
  1. **固定精度方法**（KVQuant、KIVI 等）在极低比特（如 2-bit）下无法应对 Key cache 中具有极端离群值的通道，导致严重性能退化。
  2. **现有混合精度方法**（KVTuner、MixQ、PM-KVQ 等）通常仅依据量化误差分配比特，却忽略了"量化误差大"与"对注意力计算的实际影响大"并不等价——某些通道即使误差大，若对应 Query 激活很小，对注意力保真度的影响微乎其微，分配高精度反而浪费有限的内存预算。
- **核心洞察**：一个 Key 通道应分配多少比特，需同时考虑两个因素：**通道内在的量化难度**（Sensitivity，即量化尺度 S）和**该通道与 Query 的相关性**（Importance，即 Query 激活强度 I）。二者结合才能真正反映该通道对注意力分数的保真度影响。

## 二、提出的方法论（MixKVQ）

### 2.1 问题建模

令 Q∈R^{Lq×D} 为 Query 矩阵，K∈R^{Lk×D} 为 Key 矩阵，将 K 量化为 K̃ 后，注意力分数误差为：

\[
E_{attn}=Q(K-\tilde{K})^T
\]

单个 logit 误差可分解为各通道误差贡献之和：

\[
E_{i,j}=\sum_{d=1}^{D}Q_{i,d}\cdot \epsilon_{j,d}
\]

其中 ε_{j,d} 是第 d 个通道第 j 个 token 的量化噪声。为了最小化注意力机制受到的干扰，MixKVQ 旨在识别并保留 **E[|Q_{i,d}|·|ε_{j,d}|]** 最高的通道。

### 2.2 混合精度分配指标

MixKVQ 定义了 **显著性得分（Salience Score）**，由两个低开销统计量构成：

- **重要性分数（Importance Score, I_d）**：通道 d 上 Query 激活的平均绝对值，衡量该通道对注意力分数的贡献强度：
  \[
  I_d=\frac{1}{L_q}\sum_{i=1}^{L_q}|Q_{i,d}|
  \]

- **敏感度分数（Sensitivity Score, S_d）**：通道 d 在某一比特宽度下的量化尺度（scaling factor），是直接衡量量化敏感性的代理指标：
  \[
  S_d=\frac{\max(k_d)-\min(k_d)}{2^B-1}
  \]

- **显著性得分（Salience Score, A_d）**：
  \[
  A_d=I_d\cdot S_d
  \]

**关键论证**：论文展示了 Query 激活幅度与 Key scale 之间的 Pearson 相关系数仅为 0.16（Qwen-2.5-14B Layer 0），说明仅依赖 Key scale（即仅最小化量化误差）无法有效识别真正关键通道；而 S 值分布高度集中（80% 的通道集中在 [2.80, 4.46] 的狭窄范围内），区分能力有限。乘积 A=I·S 则能有效隔离出真正需要高精度保留的临界通道。

### 2.3 三档混合精度策略

基于显著性得分 A_d，MixKVQ 设置两个阈值 τ_{BF16} 和 τ_{UINT4}，将通道分为三档：

| 档位 | 条件 | 精度 |
|------|------|------|
| 高精度 | A_d > τ_{BF16} | BF16（全精度保留） |
| 中精度 | τ_{UINT4} < A_d ≤ τ_{BF16} | UINT4 |
| 低精度 | A_d ≤ τ_{UINT4} | UINT2 |

- **Key cache**：按通道（per-channel）混合精度量化，核心通道保留 BF16，中等通道 UINT4，非关键通道 UINT2。
- **Value cache**：按 token（per-token）统一 UINT2 量化，因为实验显示 Value cache 的量化误差分布更均匀、无显著离群值，且 Key cache 对精度更敏感。
- 使用 **R=128 的残差缓冲（residual buffer）**：新生成的 token 先全精度暂存于缓冲中，待积累到 R 个 token 后一次性批量量化，既摊薄了计算开销，又避免因近期 token 的瞬时波动导致精度分配不稳定。
- 自适应更新：I_d 和 S_d 每 R 个 token 更新一次，在解码阶段逐步累积 Query 幅度。

### 2.4 阈值搜索

采用 **Optuna 框架**、TPE 采样器，在 [0.1, 2.0] 范围内对两个阈值进行联合搜索（30 次试验），以 GSM8K 准确率最大化和有效比特宽度最小化为双目标优化，构建 Pareto 前沿后选择满足比特约束的效果最优配置。例如 R1-Llama-8B 选择 (τ_{BF16}, τ_{UINT4})=(1.44, 0.79)，有效位宽 2.7 bits。

## 三、实验设计

### 3.1 模型与数据集

| 类别 | 具体内容 |
|------|------|
| 评估模型 | DeepSeek-R1-Distill-Llama-8B、DeepSeek-R1-Distill-Qwen-14B/32B（以及附录中补充的 Qwen-7B）；Mistral-7B-Instruct-v0.3 与 Llama-3.1-8B-Instruct 用于长上下文任务 |
| 数学推理 | **AIME 2024-2025**、**MATH-500** |
| 科学推理 | **GPQA-Diamond**（研究生水平科学问答） |
| 代码生成 | **LiveCodeBench**（2025-01-01 至 2025-04-06 子集） |
| 长上下文 | **LongBench**（Qasper、MultiFieldQA、QMSum、MultiNews、TREC、TriviaQA、SAMSum、LCC、RepoBench-P 共 9 个子任务） |
| 消融与阈值搜索 | WikiText2/C4（困惑度）、GSM8K（阈值选择）、ShareGPT（效率测试） |

### 3.2 对比方法

与 **KVQuant**、**KIVI**、**KVTuner**、**RotateKV**、**SKVQ** 以及 **BF16 全精度基线** 进行对比。所有方法统一设置 group size G=32、residual length R=128，采样温度为 0.6、top-p=0.95。

### 3.3 核心结果

- **推理任务（表 3）**：在 Qwen-32B 上，MixKVQ 达到 66.04% 的平均准确率（BF16 基线为 67.84%），而 4-bit RotateKV 为 64.51%，2-bit KIVI 仅 58.89%。在 Llama-8B 上，MixKVQ 仅用 2.7 bits 平均位宽即达到 51.89%，而 KVQuant 的 2-bit 几乎崩溃（<10%）。
- **长上下文（表 4）**：在 LongBench 的 9 个任务上，MixKVQ 以 2.70 bits 的有效位宽将性能损失控制在 1% 以内，显著优于各量化基线。
- **效率（图 5）**：在 Llama2-13B-chat 上，MixKVQ 在相似峰值内存下支持 **2.25 倍更大批处理**，吞吐量提升 **2.63×~2.81×**。

## 四、资源与算力

- 论文明确说明所有实验在**单张 NVIDIA A800 GPU（80GB）** 上完成。
- **未说明**具体的 GPU 数量、总训练/推理时长、能耗等详细信息。该论文为推理优化类工作，核心是零训练（tuning-free）方法，无需模型微调或额外训练阶段。

## 五、实验数量与充分性

### 5.1 实验总量

- **4 个模型 × 4 个推理基准**的主体实验（表 3），覆盖 8B 到 32B 不同规模。
- **2 个长上下文模型 × 9 个 LongBench 子任务**的扩展实验（表 4）。
- **5 组消融实验**（附录 F）：
  - group size G 的敏感性（32/64/128）；
  - residual length R 的敏感性（32/64/96/128/256）；
  - 查询感知组件 I_d 的必要性（对照 error-only 基线，AIME 上提升约 6-7 个百分点）；
  - 阈值搜索 Pareto 前沿分析（4 个模型）；
  - 逐层时间开销分析（表 8）。
- **错误案例对比**（表 1）：直观展示了 2-bit 量化导致数学推理从"468"变为"429"的失败模式，强化了问题动机。
- **效率对比实验**（图 5）：使用 ShareGPT 合成负载、vLLM 评估设置。

### 5.2 充分性与客观性评估

- **优点**：覆盖了 8B~32B 四种模型规模、数学/科学/代码/长上下文多种场景，与 4-5 个主流基线全面对比，消融实验验证了各组件的必要性。尤其包含 2-bit 极端低比特场景，证明了方法的鲁棒性。
- **客观性注意点**：混合精度方法（MixKVQ 2.7 bits、KVTuner 2.9-3.9 bits）与固定精度方法（KVQuant/KIVI 2 bits 或 4 bits）的平均位宽并不完全一致，严格来说并非完全等比特条件下的公平对比。不过论文通过标注有效位宽并在相近位宽下对比（如 MixKVQ-C2.7 vs KVTuner-C3.25）缓解了这一问题。

## 六、主要结论与发现

1. **Key cache 比 Value cache 对量化更敏感**：Key cache 存在显著离群通道，Value cache 误差分布更均匀（图 2、表 2）。
2. **仅依赖量化误差分配精度是次优的**：Query 幅度与 Key scale 相关性极低（Pearson r=0.16~0.25），高 Key scale 通道可能因 Query 激活小而对注意力保真度贡献有限。精度分配必须**同时考虑通道的内在量化难度和其与 Query 的动态相关性**。
3. **MixKVQ 在极端低比特下显著优于现有方法**：在多个数学/科学/代码推理基准上，以约 2.3~2.7 bits 的平均位宽达到接近 BF16 全精度的性能，而现有方法普遍出现大幅退化甚至崩溃。
4. **查询感知的混合精度分配是可行的**：使用轻量级启发式指标 A_d=I_d·S_d，即可在无需微调、无需额外训练的情况下有效识别关键通道。

## 七、优点

1. **洞察深刻**：指出现有方法"以最小化量化误差作为保真度代理"这一前提是有缺陷的，并通过统计证据（低相关性、集中分布）有力支撑了这一论点。这是一个方法论层面的重要反思。
2. **轻量高效**：指标计算仅需 Query 幅度均值与量化尺度，计算开销极低（通道选择仅占每层耗时的 2.17%），却带来 79% 以上的 KV cache 显存节省。
3. **免训练调优**：无需校准数据或梯度更新，阈值搜索仅需 GSM8K 上的少量试验即可完成，实用性强。
4. **设计细致**：残差缓冲的懒更新机制（lazy update）既摊销了计算开销，又避免了近期 token 瞬时波动导致精度分配不稳定；对 GQA 架构的 KV head 分组处理体现了实现层面的严谨性。
5. **可泛化与正交性**：MixKVQ 的数值压缩方法与低秩分解、KV 驱逐、检索等结构性压缩方法正交，可相互组合。
6. **实验与理论兼备**：附录 A 提供了量化误差上界的严格推导（|x_i−x̃_i|≤s/2），附录 E 提供了算法 1 的完整伪代码，附录 D 提供了阈值搜索的完整流程，可复现性强。

## 八、不足与局限

1. **计算开销**（论文自述）：尽管进行了 GPU 优化，但张量变换过程中的计算开销仍不可忽视；解码阶段非连续混合精度内存块的管理可能引入延迟。尚未集成到 vLLM 等高性能推理框架中。
2. **注意力机制覆盖不全**（论文自述）：**未覆盖 Multi-Head Latent Attention（MLA）**——DeepSeek 系列模型采用的 MLA 与 GQA 差异显著，限制了方法在部分最新模型上的适用性。
3. **延迟分析偏重解码阶段**（论文自述）：prompt 处理（prefill）阶段的计算瓶颈，特别是跨多个 KV 序列的批量压缩操作，尚未充分探索。
4. **模型规模范围有限**：最大评估模型为 32B，未覆盖 70B 以上乃至百亿级参数的模型；且实验集中在 R1-Distill 系列和 Llama/Mistral，未在 GPT-4、Claude 等闭源模型上验证。
5. **推理评估的采样随机性**：推理基准采用 pass@1、温度 0.6 的采样方式，未报告多次采样的方差或置信区间，单次采样结果可能存在一定波动。
6. **阈值选择的跨任务泛化问题**：阈值在 GSM8K 上搜索得到，推理基准与 GSM8K 分布差异可能影响最优性；论文未系统报告阈值迁移到其他任务后的敏感性。

（完）
