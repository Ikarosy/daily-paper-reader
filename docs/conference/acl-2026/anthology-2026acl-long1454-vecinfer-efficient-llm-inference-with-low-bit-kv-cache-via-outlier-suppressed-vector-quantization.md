---
title: "VecInfer: Efficient LLM Inference with Low-Bit KV Cache via Outlier-Suppressed Vector Quantization"
title_zh: VecInfer：通过离群值抑制向量量化实现高效低比特KV缓存推理
authors: "Dingyu Yao, Chenxu Yang, Zhengyang Tong, Zheng Lin, Wei Liu, Jian Luan, Weiping Wang"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.1454.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 直接面向超低比特KV缓存向量量化
tldr: 现有向量量化(VQ)方法在超低比特KV缓存压缩上因关键缓存离群值阻碍码本利用而性能严重下降。为此提出VecInfer，通过平滑变换和Hadamard变换抑制离群值，使码本能覆盖原始数据分布，降低量化误差。实验表明VecInfer在极低比特率下显著提升KV缓存压缩精度与推理效率。该工作为高效LLM推理中的低比特向量量化提供了有效方案。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1629, \"height\": 503, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 755, \"height\": 401, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 814, \"height\": 395, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1599, \"height\": 359, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1649, \"height\": 314, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 806, \"height\": 291, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 811, \"height\": 416, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 810, \"height\": 413, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1671, \"height\": 1649, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1660, \"height\": 439, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1454/fig-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 813, \"height\": 772, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 808, \"height\": 258, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1651, \"height\": 1412, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1644, \"height\": 540, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 795, \"height\": 534, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 798, \"height\": 602, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1650, \"height\": 369, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1649, \"height\": 356, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 888, \"height\": 249, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1652, \"height\": 711, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1454/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1391, \"height\": 573, \"label\": \"Table\"}]"
motivation: 现有VQ方法在超低比特下因关键缓存离群值导致性能严重下降。
method: 提出VecInfer，利用平滑和Hadamard变换抑制离群值，提升码本覆盖。
result: 在极低比特率下显著提升KV缓存压缩精度与推理效率。
conclusion: 为高效LLM推理提供了低比特向量量化压缩方案。
---

## Abstract
The Key-Value (KV) cache introduces substantial memory overhead during large language model (LLM) inference. Although existing vector quantization (VQ) methods reduce KV cache usage and provide flexible representational capacity across bit-widths, they suffer severe performance degradation at ultra-low bit-widths due to key cache outliers that hinder effective codebook utilization. To address this challenge, we propose VecInfer, a novel VQ method for aggressive KV cache compression while enabling efficient inference. By applying smooth and Hadamard transformations, VecInfer suppresses outliers in the key cache, enabling the codebook to comprehensively cover the original data distribution and thereby reducing quantization difficulty. To facilitate efficient deployment, we design an optimized CUDA kernel that fuses computation with dequantization to minimize memory access overhead. Extensive evaluations demonstrate that VecInfer consistently outperforms existing quantization baselines across both long-context understanding and mathematical reasoning tasks. With only 2-bit quantization, VecInfer achieves performance comparable to full precision, while delivering up to 2.7× speedup in large-batch self-attention computation and 8.3× reduction in single-batch end-to-end latency on Llama-3.1-8B with a 196k sequence length.

---

## 论文详细总结（自动生成）

# VecInfer：通过离群值抑制向量量化实现高效低比特KV缓存推理

## 一、核心问题与研究动机

- **背景**：Transformer-based LLM在长上下文任务中表现出色，但KV cache随序列长度线性增长，带来巨大的**内存开销**，严重制约推理效率和部署成本。
- **现有方案的不足**：
  - **标量量化（SQ）**：如KIVI，将浮点值映射为定点整数，但跨位宽的灵活性有限，且超低比特下精度崩溃。
  - **向量量化（VQ）**：如MILLION、CQ，将高维向量映射到有限码本条目，提供了更高灵活性和比特利用率。
  - **关键瓶颈**：VQ方法在超低比特宽（1.25–2 bit）下仍性能严重下降，根本原因是**key cache中的离群值向量**远离任何码本质心，导致码本条目利用不足、量化困难加剧；同时，预训练码本呈现高度**任务依赖性**，进一步恶化泛化性能。此外，去量化与注意力计算的分离引入了显著的内存访问开销，限制了实际推理加速。

## 二、方法论：核心技术细节

### 1. 核心思想
**通过双重变换抑制离群值，改善数据分布均匀性，提升VQ码本覆盖率和利用率，从而降低量化难度；同时通过硬件友好的融合kernel实现真实推理加速。**

### 2. 双重等价变换（Dual Equivalent Transformation）

**（1）Smooth变换（通道级缩放）：**
- 使用离线校准得到缩放因子 λ，对键和查询进行不等价缩放以保持计算等价性：

```
q ← q·diag(λ)
K ← K·diag(λ)⁻¹
```

- 缩放因子定义：λᵢ = √max(|Kᵢ|)，其中Kᵢ为第i个通道的键值。
- 作用：减小**通道间**方差。

**（2）Hadamard变换（正交旋转）：**
- 使用Walsh–Hadamard正交矩阵 H（满足 HHᵀ = I），对查询和键同时施加旋转：

```
q ← q·H
K ← K·H
```

- **Lemma 1（Hadamard）**：当键状态的符号独立同分布于 {−1, +1} 时，经Hadamard矩阵变换后，利用中心极限定理可得变换结果近似服从高斯分布，从而**重新分布离群值**，减小**通道内**方差。
- 作用：将离群值"扩散"到邻近元素，产生更均匀的分布。

**（3）SVD分析视角：**
- 原始矩阵 A = UΣVᵀ 中，列向量的模长差异大（最大/最小值差距悬殊）；
- 单独应用Smooth或Hadamard变换均不能最优均衡向量幅值；
- **两者组合**（Smooth先、Hadamard后）可在旋转与拉伸之间达到最优平衡，消除离群值。

### 3. VQ量化流程

- **预填充阶段**：对变换后的键和原始值分别进行VQ量化，获得码本索引存储：

```
K̃q = VQ(K̃, Cₖ)
Vq = VQ(V, Cᵥ)
```

- **解码阶段**：逐token生成时，在线对到达的键施加双重变换后量化，拼接至已有缓存。
- **注意力计算**：对查询施加逆变换后，以码本查表方式去量化并计算注意力：

```
s = q̃·(VQ⁻¹(K̃q, Cₖ))ᵀ/√D
o = softmax(s)·(VQ⁻¹(Vq, Cᵥ))
```

### 4. Key/Value混合精度分配
- 实验发现：即使经过变换抑制离群值，key cache的量化敏感性仍高于value cache（与Dong et al. 2024的发现一致）。
- 策略：对key分配更高比特宽，value采用更低比特宽。例如1.25-bit配置中Key用d8b12、Value用d8b8，精度优于对称配置。

### 5. 硬件高效CUDA Kernel
- **融合设计**：将去量化与注意力计算融合为单一kernel，消除中间矩阵的全局内存读写。
- **细粒度瓦片计算**：三维grid（batch_size, num_heads, num_splits），每个线程块（128线程）处理一个KV瓦片，计算部分注意力输出。
- **异步流水线执行**：利用 `memcpy_async` 将内存拷贝与计算重叠。计算 s⁽ⁱ⁾ 时异步加载 V⁽ⁱ⁾；计算 o⁽ⁱ⁾ 时预取 K̃⁽ⁱ⁺¹⁾。
- **共享内存布局优化**：减少bank冲突，提高吞吐。
- **预计算查找表（LUT）**：先将变换后查询与码本相乘得到查询码本查找表 lut ∈ R^{M×2^b}，避免每个瓦片重复计算。

---

## 三、实验设计

### 1. 评测任务与数据集

| 任务类型 | 数据集 | 说明 |
|---------|--------|------|
| 长上下文理解 | LongBench 13个数据集 | 涵盖单文档QA（Qasper、MultiFieldQA-en）、多文档QA（HotpotQA、2WikiMultihopQA）、摘要（GovReport、MultiNews）、少样本学习（TREC、SAMSum、TriviaQA）、代码补全（LCC、RepoBench-P）、合成任务（PassageCount、PassageRetrieval-en） |
| 数学推理 | GSM8K、MATH500、AIME24、AMC2023 | 期末数学、竞赛级推理题，AIME24输出上限32,768 tokens，其余16,384 tokens |

### 2. 评测模型
- Llama-3.1-8B-Instruct
- Mistral-7B-Instruct-v0.3
- Qwen2.5-14B-Instruct
- DeepSeek-R1-Distill-Llama-8B
- DeepSeek-R1-Distill-Qwen-14B
- Qwen3-8B

### 3. 对比基线
- **KIVI**（标量量化代表），记作 bngm（n比特、组大小m）
- **MILLION**（向量量化代表），记作 dnbm（子向量维度n、比特数m）
- 全精度FP16基线

### 4. 量化配置
- 1.25 bit、1.5 bit、2 bit、3 bit、4 bit 多种配置
- 残差长度统一为128 tokens（即部分通道不量化）

### 5. 实施细节
- **码本校准**：基于Qasper数据集用K-means预训练码本，最大迭代30次
- **平滑因子校准**：Pile数据集随机256个样本（各512 tokens），H100上运行仅需数秒

---

## 四、资源与算力

- **GPU硬件**：H100（80GB）和A100（40GB）均用于kernel性能评测。
- **校准成本**：平滑因子校准仅需数百秒（论文原文为"a few seconds on an H100 GPU"），主要基于Pile的256个样本，总体上是一次性低成本离线过程。
- **文献未明确说明的信息**：
  - 未指明训练码本时的GPU数量及总耗时（仅给出最大迭代次数）。
  - 未给出端到端评测时使用的GPU型号与数目。
  - 未报告功耗或扩展性指标。

---

## 五、实验数量与充分性评估

### 实验规模
1. **主实验（LongBench）**：3个模型 × 多种量化比特（4/3/2/1.5/1.25 bit）× 13个任务，共约200组以上量化配置-任务组合的评测。
2. **数学推理实验**：3个推理模型 × 4个数据集 × 4种量化等级（4/3/2 bit），使用Pass@1指标（每个问题采样1次或8次响应）。
3. **核性能评测**：H100 / A100 × headdim（64/128）× batch（1/4/8/16/32）× 序列长度（96k/128k/160k/192k），覆盖2种比特配置，形成数十组对比。
4. **消融实验**：
   - 不同变换组合（VQ-only、Smooth、Hadamard、两序组合）× 2个模型；
   - 码本大小（d8b16/d4b8/d2b4等）× 2个模型；
   - Key/Value混合精度配置 × 2组；
   - 码本任务无关性（5个不同数据集训练码本）。
5. **端到端延迟**：解码延迟对比（96k–192k），以及注意力模块的延迟分解分析。

### 充分性评估
**优点**：
- 覆盖面广：6个不同系列和规模的模型、多个量化位宽（1.25–4 bit）、长上下文+数学推理双任务场景；
- 消融完整：每种设计决策（变换组合、码本大小、位宽分配）均有独立验证；
- 硬件评测全面：两种GPU架构、多种batch和序列长度组合。

**不足**：
- 未在更大规模模型（如70B+）上验证方法可扩展性；
- 数学推理任务中，未报告KIVI/MILLION在低比特下的端到端效率对比（KIVI在解码实验中出现OOM）；
- 对少样本和合成任务的评估相对浅层，部分数据集（如PassageCount）在低比特下各方法差异不明显，区分度有限；
- 不同方法（KIVI残差长度、MILLION/VecInfer码本大小）的配置不完全对称，尽管已标注，但精度对比的公平性仍有讨论空间。

---

## 六、主要结论与发现

1. **精度保持**：2-bit量化下，VecInfer在LongBench上平均精度仅下降2.1%，且相比MILLION平均提升14.5%（几乎相同的比特率）。
2. **超低比特鲁棒性**：在1.5-bit甚至1.25-bit下，VecInfer仍保持接近全精度的性能，而KIVI和MILLION在该区域几乎完全崩溃（如KIVI 1.5-bit LongBench平均分从53.7跌至11.4）。
3. **数学推理**：3-bit下VecInfer在AIME24上比基线高9.2个百分点；2-bit下VecInfer仍能保持连贯输出，而MILLION全部失效（Acc=0）。
4. **推理加速**：
   - 大型batch自注意力计算：H100上最高2.7×加速，A100上最高2.8×（相比FP16 SDPA）；
   - 单batch端到端解码延迟：输入192k、输出129 tokens时，1-bit下9.0×、2-bit下8.3×、4-bit下6.6×加速（H100，Llama-3.1-8B）；
   - 加速比随序列长度增大而增长，表明方法对长上下文场景尤其有效。
5. **变换有效性**：Smooth和Hadamard变换单独应用分别提升平均精度4.9%和14.1%（相对VQ-only），组合后增益更大（14.9%），且两者顺序（S+H 与 H+S）性能基本一致。
6. **任务无关码本**：用不同数据集训练的码本性能几乎一致（52.7–53.0），证明双重变换使码本真正实现了任务无关。

---

## 七、方法优点

1. **问题定位精准**：明确指出VQ方法在超低比特下失败的根因是**key cache离群值**，并通过SVD分析和可视化证据（Figure 1、10、11）提供理论支撑。
2. **理论严谨**：Lemma 1利用中心极限定理严格证明Hadamard变换的高斯化效应，为方法提供数学保证。
3. **双重变换的互补设计**：Smooth变换处理通道间方差，Hadamard变换消除通道内方差，两者结合实现最优分布均衡，且保证查询-键计算等价性。
4. **硬件意识强**：融合kernel设计（细粒度瓦片化+异步流水线）将技术从算法层面落地到实际加速，贯穿精度与效率双目标；不仅是内存压缩，更实现了真实推理延迟降低。
5. **混合精度策略**：基于key/value量化敏感性的实证分析，合理分配比特预算，进一步提升精度效率平衡点。
6. **低校准成本**：码本离线训练+平滑因子快速校准，无需训练或微调模型，即插即用。
7. **一致性稳健**：在6个不同架构模型、13+4个任务、4种量化位宽上均稳定超越基线，结论可信度高。

---

## 八、不足与局限

1. **稀疏注意力结合未探索**：论文指出VQ与稀疏注意力（如H2O、StreamingLLM等）理论正交可组合，但未给出具体实验结果，组合方案的精度-效率折衷未经验证。
2. **服务框架集成难度**：VLLM和SGLang等主流推理框架对KV cache压缩缺乏原生支持或灵活API，实际工程化部署仍需额外适配工作。
3. **扩展性未验证**：实验最大模型为14B，未在70B+甚至更大规模模型上验证方法效果；码本容量（如2^12×8×2字节）对超大规模模型的适配性未知。
4. **KIVI在解码实验中OOM**：因KIVI缺少融合kernel，在长序列解码对比中无法运行，导致部分效率对比缺少一个基线（不过这也反过来凸显了VecInfer融合kernel的必要性）。
5. **混合精度位宽整体分配**：论文按Key和Value分别配置位宽，但对跨层/跨头的差异化分配（如某些层可更低比特）未做探索，可能仍有压缩空间。
6. **实验细节透明性不足**：未提供错误条、多次运行标准差或统计显著性检验；未给出完整能耗/吞吐量等指标。

---

（完）
