---
title: "ACBQ: Adaptive Cross-Block Quantization of Large Language Models"
title_zh: ACBQ：大语言模型的自适应跨块量化
authors: "Hailing Wang, Jianglin Lu, Yitian Zhang, Huimin Zeng, Yun Fu"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.1971.pdf"
tags: ["query:wbv"]
score: 8.0
evidence: 面向权重-激活联合与极端低比特权重量化的PTQ框架
tldr: 深度大模型的跨层依赖使量化误差逐层累积，现有PTQ难以同时支持权重-激活联合量化与极端低比特权重量化。ACBQ提出自适应的跨块量化框架，通过协同处理块间依赖来抑制误差传播。实验证明其在极低比特权重与联合量化设定下均能取得更高精度，为PTQ部署提供了简单有效的解决方案。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1971/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 619, \"height\": 409, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1971/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 746, \"height\": 634, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1971/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 658, \"height\": 657, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1971/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 787, \"height\": 681, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1658, \"height\": 1044, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1611, \"height\": 651, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 820, \"height\": 645, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1619, \"height\": 249, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 833, \"height\": 271, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1661, \"height\": 1088, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1661, \"height\": 1095, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1660, \"height\": 1026, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1662, \"height\": 1073, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1660, \"height\": 1026, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 1663, \"height\": 1073, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-012.webp\", \"caption\": \"\", \"page\": 0, \"index\": 12, \"width\": 1662, \"height\": 1076, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-013.webp\", \"caption\": \"\", \"page\": 0, \"index\": 13, \"width\": 1655, \"height\": 235, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1971/table-014.webp\", \"caption\": \"\", \"page\": 0, \"index\": 14, \"width\": 1630, \"height\": 361, \"label\": \"Table\"}]"
motivation: 跨层依赖导致量化误差累积，PTQ难以兼顾联合量化与极低比特权重。
method: 提出ACBQ框架，自适应地按块处理量化并考虑块间依赖以减少误差传播。
result: ACBQ在极端低比特权重与权重-激活联合量化场景下均提升精度。
conclusion: 该框架为PTQ同时支持低比特权重与激活量化提供了简洁方案。
---

## Abstract
Post-training quantization (PTQ) has emerged as a promising approach for reducing the memory footprint and computational cost of large language models (LLMs), enabling efficient deployment without full model retraining. However, existing PTQ methods struggle to simultaneously support weight–activation joint quantization and extreme low-bit weight quantization. This limitation primarily arises from the depth of LLMs and their strong cross-layer dependencies, which cause quantization errors to propagate and accumulate across layers, ultimately leading to significant performance degradation. In this paper, we present ACBQ, a simple yet effective framework that simultaneously addresses weight–activation joint quantization and extreme weight quantization. We first propose a granular quantization strategy that treats self-attention and FFN as separate quantization units with module-specific optimization objectives. To mitigate the propagation and accumulation of quantization errors across layers, we introduce an adaptive cross-block quantization strategy that explicitly accounts for cross-layer dependencies by encouraging consistency across blocks. Extensive experiments across diverse LLMs, including OPT and the LLaMA family, demonstrate that ACBQ achieves superior performance under both W4A4 and highly aggressive W2 settings, while incurring negligible additional computational overhead.

---

## 论文详细总结（自动生成）

## 论文详细中文总结

### 1. 核心问题与研究动机

- **研究背景**：大语言模型（LLM）参数规模庞大（如 GPT-3 有 175B 参数），推理时面临巨大的内存占用和计算成本。模型量化可将高精度浮点数转换为低比特表示（如 int4），最高可减少 8 倍内存占用，并显著提升计算吞吐量。
- **核心问题**：后训练量化（PTQ）是实际部署中最具吸引力的方案，但现有 PTQ 方法存在一个关键局限——**无法同时支持“权重-激活联合量化”与“极端低比特权重量化”**（如 W2 或 W4A4）。
- **根本原因**：LLM 深度极深、跨层依赖强。量化误差在逐层前向传播中不断累积放大，导致严重性能退化。现有方法（如 SmoothQuant、QuaRot、SpinQuant 等）虽能缓解激活离群值问题，但**未能显式建模跨层误差累积**，因此在极端低比特场景下性能受限。

### 2. 方法论：ACBQ 框架

ACBQ 的核心由两大策略组成，分别对应块内（intra-block）和块间（inter-block）的误差控制：

#### 2.1 模块级优化（Module-Wise Optimization, MWO）

- **核心思想**：将每个 Transformer 块内的 self-attention 和 FFN 视为**独立的量化单元**，而非对整个块施加统一的重构损失。
- **动机依据**：
  - self-attention 与 FFN 功能角色不同（前者建模跨 token 依赖，后者逐 token 独立变换）；
  - 二者的残差连接也是独立构建的；
  - 两者激活值分布差异显著（即使经过旋转变换后依然不同）。
- **self-attention 优化目标**（联合损失）：
  - L1：量化前后自注意力模块输出的 L2 重构损失；
  - L2：基于 KL 散度的**注意力保持损失**，使量化模型的注意力矩阵逼近全精度模型的注意力矩阵，保留 token 间关系结构；
  - 总损失：**L_self-attn = L1 + λ·L2**（λ 默认为 10）。
- **FFN 优化目标**：对 gate/up/down 投影层联合量化，使用 L2 重构损失 L_FFN。

#### 2.2 自适应跨块量化（Adaptive Cross-Block Reconstruction, ACBR）

- **动机**：Hessian 矩阵可视化显示不同 Transformer 块间存在强二阶依赖（非对角项幅值显著），说明量化误差会跨块传播放大。
- **跨块依赖度量**：基于**激活熵**定义相邻块依赖 D(k, k+1)，非相邻块依赖累加中间所有相邻块依赖。
- **自适应分组策略**：设置阈值 h₀，将平均依赖超过阈值的若干连续块划分为一组，进行联合重构（限制最大块数以控制计算开销）。
- **联合重构损失**：最小化多个连续块组合的量化输出与全精度输出之间的 MSE，鼓励量化的早期块表示与后续全精度计算对齐。

### 3. 实验设计

#### 3.1 数据集与基准

- **语言建模**：WikiText-2 和 C4 上的困惑度（Perplexity，↓），上下文长度 2048。
- **零样本推理**：9 个任务——BoolQ、LAMBADA、OpenBookQA、SIQA、PIQA、ARC-Challenge、ARC-Easy、HellaSwag、WinoGrande（准确率 ↑）。
- **标定数据**：初始化采用 Pile 数据集 8 个样本（网格搜索），优化采用 512 个样本，序列长度 1024。

#### 3.2 模型覆盖

- **LLaMA 家族**：LLaMA-1（7B/13B/30B/65B）、LLaMA-2（7B/13B/70B）、LLaMA-3（8B/70B）；
- **OPT**：OPT-30B、OPT-66B。

#### 3.3 对比方法

RTN、SmoothQuant、GPTQ、OmniQuant、AWQ、QuaRot、SpinQuant、CBQ（专门对标跨块重构方法）、RPTQ、QLLM。

#### 3.4 量化配置覆盖

W4A16KV16、W4A4KV16、W4A4KV4、W3A16KV16、W2A16KV16、W4A8KV16，以及带分组量化（group size=128）的设置。

### 4. 资源与算力

- 论文正文**未明确说明所使用的 GPU 型号、集群规模或总训练时长**。
- 附录提供了部分效率数据（LLaMA-7B）：在 W2A16 和 W4A4 设置下，ACBQ 的标定时间约为 1.29–1.87 GPU 小时，峰值显存约 39GB；相比之下，CBQ 需要约 4 个块、3.5 小时、41GB 显存。ACBQ 在时间上显著更优。
- 但需要指出：**文中未报告每个模型的确切优化时间成本**（仅提到 W4A4 训练 20 个 epoch、W2A16 训练 5 个 epoch，学习率 5e-5/2e-5），整体算力透明度不足。

### 5. 实验数量与充分性评估

#### 实验规模

- **主实验（Table 1–3）**：覆盖 4-bit 场景（W4A16、W4A4KV16、W4A4KV4）、3-bit 和 2-bit 极端低比特场景（W3/W2）、以及 W4A8 场景，每个配置横跨多个模型规模，**实验矩阵非常庞大**。
- **零样本基准逐任务结果表（Table 6–12）**：详细列出了每个模型、每种位宽配置下 9 个任务的准确率，数据透明度高。
- **消融实验**：W2A16 下（Table 4）和 W4A4 下（Table 13）分别验证了 MWO、BWQ、ACBR 各组件的贡献，逻辑清晰。
- **超参数敏感性**：对损失系数 λ（0.1–20）进行了系统分析（Table 14）。
- **效率对比**：与 CBQ 的标定时间和内存占用对比（Table 5）。

#### 充分性与客观性评价

- **优点**：对比方法覆盖全面（从经典 RTN/SmoothQuant 到最新的 SpinQuant/CBQ），模型规模跨度大（7B–70B），位宽配置丰富，实验结果具有较高说服力。
- **不足**：① 未与更多近期方法（如 DuQuant、FlatQuant、BiLLM 等）对比，部分 SOTA 方法缺失；② W3 实验仅在部分模型上报告，OPT 模型的 W3/W2 结果未覆盖；③ 对 70B 模型报告了部分“–”（如 OmniQuant 在 LLaMA-3 70B 下未报告 W4A16 结果），对比完整性略有不足；④ 没有报告多次重复实验的标准差或统计显著性检验。

### 6. 主要结论与发现

1. **ACBQ 在 W4A4 联合量化下显著领先**：在 LLaMA-3 70B 上，W4A4KV16 配置下 WikiText2 困惑度达到 4.13（SpinQuant 为 6.10），零样本平均准确率 72.01%（SpinQuant 为 66.99%），优势非常明显。
2. **ACBQ 在 W2 极端低比特下保持可用性**：在 LLaMA-2 7B 上 W2A16 困惑度降至 14.15，而 OmniQuant 为 37.37、QuaRot 为 22.07；其他基线（RTN/GPTQ）几乎完全崩溃。
3. **跨块重构优于块内独立优化**：在与 CBQ 的直接对比中，ACBQ 在 OPT-30B/66B 和 LLaMA-1 30B/65B 上几乎所有设置下都取得更低困惑度，且开销更低。
4. **模块级优化优于块级优化**：消融显示，MWO（14.83 ppl）比 BWQ（16.86 ppl）在 W2 下显著更好，验证了将 self-attention 和 FFN 分开优化的有效性。

### 7. 方法亮点与优点

- **细粒度模块感知量化**：从 Transformer 功能分工和分布差异出发，将 self-attention 与 FFN 分离优化，并设计了注意力保持损失（KL 散度对齐）这一创新目标，实现了更高保真度的量化。
- **启发式自适应分组**：以激活熵为代理指标计算跨块依赖，使分组策略是**自适应、数据驱动**的，而非固定窗口或全层联合，平衡了性能和计算开销。
- **统一框架**：同时支持权重-激活联合量化（W4A4）和极端权重低比特量化（W2），一个框架解决两类问题，具有较强的通用性。
- **轻量高效**：以极低的额外计算开销（约 1–2 GPU 小时）获得显著性能提升，对实际部署非常友好。

### 8. 不足与局限

- **精度仍不及 QAT**：在极端低比特下，ACBQ 仍与量化感知训练方法存在差距，论文作者在 Limitations 中明确承认这一点。
- **优化耗时较长**：即使比 CBQ 快，整体标定仍需要数小时（尤其是大模型），对快速适配场景不够理想。
- **熵代理的局限**：基于激活熵的跨块依赖度量是一种启发式方法，可能无法完全捕捉复杂的跨层交互（如非线性放大效应），分组质量在某些场景下可能次优。
- **实验盲区**：未报告 W2 配置下零样本任务的准确率（仅困惑度）、未覆盖 4-bit 以下 KV 量化的更多组合、缺少与 QAT 方法的定量差距对比，也未涉及更大模型（如 100B+）。
- **应用限制**：论文未讨论量化模型在特定下游任务（如代码生成、数学推理、多模态）上的表现，泛化性证据主要集中在语言建模和常识推理上。

（完）
