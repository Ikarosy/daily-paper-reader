---
title: "Quantize What Counts: More for Keys, Less for Values"
title_zh: 量化关键：键多值少
authors: "Mohsen Hariri, Alan Luo, Weicong Chen, Tianyi Zhang, Qifan Wang, Xiaotian Han, Vipin Chaudhary"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.findings-acl.1314.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 键值缓存混合精度量化与比特分配理论
tldr: 大语言模型推理时键值（KV）缓存成为内存瓶颈，而键与值的比特分配往往依赖启发式。本文提出两个定理：键权重矩阵的谱范数和Frobenius范数系统性大于值矩阵，因此在相同内存预算下优先给键更多精度能严格降低量化误差并更好保持精度。实验验证了混合精度策略在KV缓存量化上的有效性。该工作为极低比特量化中的比特分配提供了理论依据和方法支撑。
source: ACL-2026-Findings
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 785, \"height\": 400, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 804, \"height\": 605, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1662, \"height\": 416, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 806, \"height\": 820, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 802, \"height\": 604, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1664, \"height\": 416, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1646, \"height\": 646, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 642, \"height\": 470, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1483, \"height\": 2356, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1314/fig-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1628, \"height\": 1197, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1621, \"height\": 854, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1646, \"height\": 676, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 808, \"height\": 430, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1666, \"height\": 1225, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 802, \"height\": 264, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1463, \"height\": 606, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1463, \"height\": 606, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 811, \"height\": 1355, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 807, \"height\": 1355, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 811, \"height\": 1356, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 808, \"height\": 1355, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-012.webp\", \"caption\": \"\", \"page\": 0, \"index\": 12, \"width\": 799, \"height\": 182, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-013.webp\", \"caption\": \"\", \"page\": 0, \"index\": 13, \"width\": 815, \"height\": 329, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-014.webp\", \"caption\": \"\", \"page\": 0, \"index\": 14, \"width\": 1419, \"height\": 1431, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-015.webp\", \"caption\": \"\", \"page\": 0, \"index\": 15, \"width\": 1404, \"height\": 1436, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-016.webp\", \"caption\": \"\", \"page\": 0, \"index\": 16, \"width\": 1414, \"height\": 1431, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1314/table-017.webp\", \"caption\": \"\", \"page\": 0, \"index\": 17, \"width\": 1417, \"height\": 1430, \"label\": \"Table\"}]"
motivation: KV缓存量化中键值比特分配缺乏理论指导，启发式调参难以泛化，亟待可解释的分配原则。
method: 从Transformer几何出发证明键权重矩阵信息密度更高，提出优先保证键精度的混合精度量化方案。
result: 在相同内存预算下，优先键精度严格降低量化误差并更好保持任务精度。
conclusion: 为KV缓存量化提供了理论支持与实用的比特分配策略。
---

## Abstract
Large Language Models (LLMs) suffer inference-time memory bottlenecks dominated by the attention Key-Value (KV) cache, which scales with model size and context length. While KV-cache quantization alleviates this cost, bit allocation between keys and values is often tuned heuristically, lacking theoretical grounding and generalizability. This paper proposes two theorems that anchor mixed-precision KV quantization in the intrinsic geometry of Transformer models. First, key weight matrices systematically have larger spectral and Frobenius norms than value matrices, implying higher information density along the key path. Second, for any given memory budget, prioritizing precision for keys over values strictly reduces quantization error and better preserves accuracy. Empirical evaluations across various prominent LLMs and benchmarks show that key-favored allocations (e.g., 4-bit keys, 2-bit values) retain up to 98.3% accuracy compared to uniform allocations (e.g., 4-bit for both), while conserving memory. These results transform bit allocation from ad hoc tuning into a theoretically grounded, geometry-driven design principle for efficient LLM inference. Source code is available at https://github.com/mohsenhariri/spectral-kv.

---

## 论文详细总结（自动生成）

## 论文详细中文总结

### 1. 论文的核心问题与整体含义（研究动机与背景）

随着大语言模型（LLM）的规模急剧膨胀（GPT 系列从 1.17 亿参数增长至 GPT-4 的 1.8 万亿参数，Llama 甚至达到 2 万亿），**推理阶段的 KV（Key-Value）缓存已成为内存瓶颈的核心来源**。KV 缓存大小随模型参数量和上下文长度同步增长，在长上下文场景下（最高可达 1000 万 token）甚至会耗尽 GPU 显存，严重制约实际部署效率与经济性。

KV 缓存量化（将 BF16 精度的键值张量压缩为 INT4 等低精度）是缓解该瓶颈的有效手段，但**现有方法对键（K）和值（V）之间的比特分配几乎完全依赖启发式调参**，例如基于推理时激活值统计的网格搜索。这类方法存在三个关键缺陷：

- **缺乏理论依据**：无法解释为何某些比特分配方式更优；
- **泛化性差**：调参结果高度依赖特定模型、数据集和量化后端；
- **开销高**：推理时动态调整增加了额外计算负担。

该论文的核心贡献在于：**首次从 Transformer 模型的内在几何属性出发，为 KV 量化比特分配提供了严格的理论基础**。作者通过两个定理证明——键权重矩阵的谱范数和 Frobenius 范数系统性大于值权重矩阵，因此在给定内存预算下，**优先保障键的精度、压缩值的精度**可以严格降低量化误差并更好地保持模型精度。这一发现将比特分配从随意调参转变为有理论支撑的“基于几何结构的设计原则”。

---

### 2. 方法论：核心思想、关键技术细节与流程

#### 2.1 核心思想

论文的核心洞察基于 Transformer 中键和值投影矩阵的角色不对称性：

- **键（Key）路径**：键不仅要存储表示，还要与查询（Query）进行**乘法交互**来塑造注意力图，这一“双重角色”使得键权重矩阵梯度信号被放大，训练中累积更大的范数，信息密度更高；
- **值（Value）路径**：值只影响注意力后的表示形成，梯度缺乏这种乘法放大效应，范数相对更小。

#### 2.2 两个核心定理

**定理 1（键值范数差异，Key-Value Norm Disparity）**：
设 WK 和 WV 为 Transformer 中的键和值投影矩阵，则：

> E[‖WK‖F] > E[‖WV‖F]

证明思路：从 Xavier 初始化出发（此时各投影矩阵期望范数相同），在 SGD 训练动力学下分析范数演化。由于键权重具有双重作用（塑造注意力图 + 存储表示），其梯度信号被查询矩阵的乘法交互放大，导致期望范数增长率高于值权重。

**定理 2（键优先量化，Key-Prioritized Quantization）**：
设 (bK, bV) 为键和值缓存的均匀标量量化比特分配，当 E[‖K‖²F] > E[‖V‖²F] 时，**对于任何满足 bK > bV 的分配方案，其期望推理精度严格高于对调方案 (bV, bK)**。

证明逻辑链：

1. 量化误差与矩阵范数成正比：E[‖M − M̃‖²F] = Θ(‖M‖²F · 2^(−2b))；
2. 由于 ‖K‖F ≫ ‖V‖F，在同等比特数下键缓存的量化误差远大于值缓存；
3. 为最小化总量化误差，应按能量比例分配比特，即**键分配更多比特**；
4. 附录 B.2 和 B.3 进一步给出了基于谱范数和 Frobenius 范数的量化误差上界（定理 3 和 4），证明了范数更大的矩阵在量化中更易受损，需要更高精度来保护。

#### 2.3 技术流程

该方法是**纯权重分析**方案，操作流程为：

1. **离线分析**：对给定模型计算每一层键/值投影矩阵的谱范数和 Frobenius 范数，确认键 > 值的规律；
2. **比特分配**：根据范数差异直接确定混合精度方案（如 K4V2），**无需任何推理时激活统计或网格搜索**；
3. **无缝集成**：该分配策略可作为“正交模块”嵌入现有 KV 量化框架（如 QuaRot 等旋转方法），叠加增益。

---

### 3. 实验设计

#### 3.1 数据集与场景

| 实验类别 | 数据集 | 用途 |
|---------|--------|------|
| 量化误差分析 | C4、MMLU、GSM8K | 测量各比特位宽下键/值的重建误差（MSE） |
| 下游任务精度 | GSM8K（数学推理）、CoQA（对话问答）、EQ-Bench（情商结构化生成）、LongBench（长文本生成） | 评估混合精度对实际任务的影响 |
| 旋转集成消融 | 上述全部任务基准 | 验证与 QuaRot 结合的协同效果 |

作者刻意选择**生成式任务**（而非 BoolQ、PIQA 等判别式常识推理基准），理由是 KV 量化主要影响解码阶段而非预填充阶段，判别式任务不涉及生成解码，无法隔离量化效果。

#### 3.2 模型覆盖

涉及 9 个模型族、覆盖 0.6B 至 70B 规模：

- **Llama 系列**：Llama-3.2-1B/3B、Llama-3.1-8B、Llama-3.3-70B、Llama-2-7B、Nemotron-70B
- **Phi 系列**：Phi-3-Medium-128K、Phi-4-14B
- **Mistral 系列**：Mistral-0.3-7B、Ministral-8B、Mistral-Large
- **Qwen 系列**：Qwen3-0.6B/1.7B/4B/8B/32B、Qwen2.5-14B
- **DeepSeek 系列**：DeepSeek-R1-Qwen-14B、DeepSeek-R1-Llama-8B

#### 3.3 对比方法与量化后端

- **Optimum Quanto**：token-wise（逐行）量化，支持 2/4 比特混合精度；
- **HQQ**（Half-Quadratic Quantization）：channel-wise（逐列）量化，支持 {1, 2, 4, 6, 8} 比特；
- **对照方案**：K2V2、K2V4、K4V2、K4V4（即同时对比键优配、值优配和均匀分配）；
- **旋转方法集成**：QuaRot（结构化随机 Hadamard 旋转），比较四种旋转策略（无旋转、仅键旋转、仅值旋转、两者都旋转）与三种组大小配置（32/64/128）的交叉组合。

#### 3.4 关键实验配置

- 每个数据集采样 10 条随机序列，自回归生成最长 1000 token；
- 采用 64-token 残差缓冲区和 128 元素激活分组，模拟 KIVI、Flash-Decoding、Marlin 等实际部署配置；
- 最大上下文长度为 2,000 token。

---

### 4. 资源与算力

论文在附录 D 中给出了计算环境信息：

- **两个 HPC 集群**：
  - **集群 A**：AMD EPYC 7742 ×2 CPU、2048GB RAM、NVIDIA A100 80GB HBM2e ×8 GPU，共 5 个节点（40 块 A100）；
  - **集群 B**：Intel Xeon Platinum 8468 ×2 CPU、2048GB RAM、NVIDIA H200 141GB HBM3e ×8 GPU，共 5 个节点（40 块 H200）。

- **软件栈**：Hugging Face Transformers、Accelerate、FlashAttention、Quanto、HQQ、Language Model Evaluation Harness 等。

**论文未明确给出**每个实验具体消耗的 GPU 时长（如总卡时数）或训练/推理的总运行时间，仅提供了硬件配置和推理配置细节。

---

### 5. 实验数量与充分性

#### 5.1 实验规模概述

论文的**实验数量相当丰富**，主要分为四大板块：

| 实验板块 | 具体内容 |
|---------|---------|
| 量化误差分析（表 1、2、6、7） | 横跨 7–14 个模型 × 3 个数据集 × 3 种位宽（2/3/4-bit），每个模型每个配置给出逐层、逐头误差统计 |
| 下游任务精度（表 3、4、14–17） | Optimum Quanto 端：4 模型 × GSM8K × 2 种 shot 设置；HQQ 端：7 模型 × 3 数据集 × 25 种 (K,V) 比特组合 |
| 旋转方法集成（表 8–12，图 4） | 7 模型 × 4 任务 × 4 种量化配置 × 4 种旋转策略 × 固定组大小 |
| 组大小消融（图 10） | K/V 组大小各取 {32, 64, 128} 的 9 种组合，在 4 个任务上对比 |

#### 5.2 充分性与公平性评估

**充分性方面**：
- ✅ 模型覆盖极广（9 个家族、0.6B–70B），跨模型泛化证据充分；
- ✅ 两种独立量化后端（Quanto、HQQ）互证，避免了对单一后端的过度拟合；
- ✅ 从原始量化误差、下游任务精度、旋转集成三个层面递进验证，层次完整。

**公平性方面**：
- ✅ 对比 K2V4 与 K4V2 时**保持相同总内存预算**，确保比较公平；
- ✅ 对比同位数下 K 与 V 的重建误差时，两者使用**相同量化配置**（如表 1 中的 K2V2 对比）；
- ✅ 旋转实验固定组大小为 64，隔离旋转变量的影响。

**可能的偏差风险**：
- ⚠️ 所有模型均为公开预训练模型，论文未涉及从零训练模型的验证；
- ⚠️ 表 4 中 HQQ 的“x”表示对另一缓存所有位宽求平均，虽然公平，但可能掩盖某些极端位宽组合下的异常表现；
- ⚠️ 部分量子化配置（如 1-bit 键）下精度极低，但论文将其解释为“键是瓶颈”的证据，这一论证方向总体合理。

---

### 6. 主要结论与发现

1. **键权重矩阵范式系统更高**：在 Llama 3 全系列（1B–70B）和 Mistral 系列中，键的谱范数和 Frobenius 范数在几乎所有层中都超过值，这一规律具有跨模型家族的普遍性；
2. **键缓存量化误差更大**：在相同位宽下（2/3/4-bit），键重建误差（MSE）比值高出一个数量级以上（例如 Llama3.2-1B 在 C4 上 K2 误差 4.885 vs V2 误差 0.207，差距约 23 倍）；
3. **键优先分配显著更优**：K4V2（4-bit 键 + 2-bit 值）相比 K2V4（2-bit 键 + 4-bit 值），在 GSM8K 上可高出最高 30 个百分点（Llama-3.2-1B）；在 HQQ 后端的极低比特场景（1-bit vs 2-bit 键对比）增益最多可达 +62 个百分点；
4. **K4V2 接近全精度基线**：平均保留 K4V4 精度约 98.3%（CoQA 99.2%、EQ-Bench 99.35%、GSM8K 97.7%），同时减少 25% KV 缓存内存；
5. **键精度是性能瓶颈而非值**：当键精度 ≥4-bit 时，值从 2-bit 调到 8-bit 带来的增益很小；反之，键从 2-bit 升到 4-bit 时增益巨大——值的可压缩空间远大于键；
6. **旋转应主要作用于键**：仅对键进行旋转（key-only rotation）就能获得与旋转两者几乎相同的增益（K4V2 + 键旋转匹配 K4V4 基线），对值旋转收益甚微甚至有害；
7. **键需要更细的量化粒度**：键组大小设为 32 时表现最佳，而值的组大小可放宽至 64/128 而无明显损失。

---

### 7. 优点

1. **理论贡献扎实**：首次从训练动力学层面解释并证明了键/值权重范数差异的来源，将量化比特分配从经验主义提升到理论指导层面；
2. **方法轻量与泛化**：仅需对模型权重做一次性离线分析（∅ 推理时内省成本），权重统计不随输入和任务变化，天然跨数据集、跨任务、跨模型泛化；
3. **与现有方法正交兼容**：该策略可作为独立模块嵌入任意 KV 量化框架，与旋转（QuaRot）、组大小调整等技术可叠加增益，而非替代关系；
4. **实验覆盖面极广**：9 个模型家族、6 个基准数据集、2 个独立量化后端、约 25 种比特组合、4 种旋转策略交叉验证，结论稳健；
5. **分析角度全面**：从矩阵范数、奇异值谱、逐层逐头误差、下游任务精度、与旋转/分组的交互效应多个维度提供了相互印证的证据链；
6. **实际部署价值高**：K4V2 在几乎不损失精度的前提下节省 25% 内存，对长上下文推理的经济性有直接改善。

---

### 8. 不足与局限

1. **上下文长度覆盖有限**：论文明确声明最大实验上下文为 2,000 token，而论文动机中提及的 10M token 超长上下文场景未做验证——长上下文下的量化敏感性、累积误差和内存管理开销可能有新问题；
2. **判别式任务被排除**：论文仅使用生成式任务评估，虽给出了合理理由（判别式任务与 KV 量化关系较弱），但这也意味着在 BoolQ、PIQA 等常见基准上的表现未知；
3. **理论证明依赖简化假设**：附录中的训练动力学分析假设了各向同性输入、梯度与权重近似正交（高维空间中第二项可忽略）、单头 attention 等简化为条件，与真实训练（如学习率调度、动量、Adam 优化器、Attention 输出投影等）存在偏差；
4. **未评估训练时量化（QAT）场景**：结论主要建立在 PTQ（训练后量化）基础上，对于 QAT 方法是否同样适用未做讨论；
5. **Bit 分配粒度为层统一**：论文采用全局统一的 K4V2 分配（全层相同），虽然简单有效，但未探索**逐层**比特适配可能带来的进一步优化空间（这是 KVTuner 等方法的取向）；
6. **与最先进混合精度方法的直接对比不足**：论文重点对比了不同分配方案（K2V4 vs K4V2）及与旋转的集成，但与其他混合精度 KV 量化方法（如 KVTuner、SKVQ、QAQ）的直接端到端对比试验不够充分；
7. **硬件实测数据缺失**：论文验证了量化算法的精度指标，但未提供实际的推理吞吐量、延迟或显存占用实测数据，对“内存节省 25%”的表述仅限于理论计算层面。

---

（完）
