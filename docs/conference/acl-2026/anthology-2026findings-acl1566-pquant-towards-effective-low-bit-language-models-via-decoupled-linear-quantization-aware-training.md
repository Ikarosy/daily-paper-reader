---
title: "pQuant: Towards Effective Low-Bit Language Models via Decoupled Linear Quantization-Aware Training"
title_zh: pQuant：通过解耦线性量化感知训练实现高效低比特语言模型
authors: "Wenzheng Zhang, Bingzheng Liu"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.findings-acl.1566.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 通过解耦线性层分支实现亚2比特量化感知训练
tldr: 针对从零开始的量化感知训练在极低比特（亚2比特）权重下精度与可扩展性不足的问题，pQuant发现参数敏感性均匀化是主要瓶颈。它通过将线性层解耦为主干1比特分支与紧凑高精度分支，在保持高效计算的同时保留关键表达能力。实验表明该方法在极低比特大模型上取得了更优的精度与可扩展性，为边缘部署提供了实用方案。
source: ACL-2026-Findings
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 679, \"height\": 574, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 799, \"height\": 284, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1614, \"height\": 1180, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 714, \"height\": 499, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1635, \"height\": 418, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 789, \"height\": 566, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 799, \"height\": 336, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 794, \"height\": 426, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 755, \"height\": 424, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 703, \"height\": 405, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1566/fig-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 753, \"height\": 385, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1566/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 805, \"height\": 249, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1566/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1661, \"height\": 794, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1566/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 806, \"height\": 264, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1566/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 695, \"height\": 223, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1566/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 661, \"height\": 230, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1566/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1659, \"height\": 495, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1566/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1651, \"height\": 184, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1566/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 615, \"height\": 230, \"label\": \"Table\"}]"
motivation: 参数敏感性被均匀化限制了亚2比特量化模型的表达能力与可扩展性。
method: 提出pQuant，将线性层拆分为1比特主干分支和高精度紧凑分支并解耦训练。
result: pQuant在极低比特权重下显著提升精度并支持更大规模的模型训练。
conclusion: 该工作验证了解耦参数设计对极低比特量化感知训练的有效性。
---

## Abstract
Quantization-Aware Training from scratch has emerged as a promising approach for building efficient large language models (LLMs) with extremely low-bit weights (sub 2-bit), which can offer substantial advantages for edge deployment. However, existing methods still fail to achieve satisfactory accuracy and scalability. In this work, we identify a parameter democratization effect as a key bottleneck: the sensitivity of all parameters becomes homogenized, severely limiting expressivity. To address this, we propose pQuant, a method that decouples parameters by splitting linear layers into two specialized branches: a dominant 1-bit branch for efficient computation and a compact high-precision branch dedicated to preserving the most sensitive parameters. Through tailored feature scaling, we explicitly guide the model to allocate sensitive parameters to the high-precision branch. Furthermore, we extend this branch into multiple, sparsely-activated experts, enabling efficient capacity scaling. Extensive experiments indicate our pQuant achieves state-of-the-art performance in extremely low-bit quantization.

---

## 论文详细总结（自动生成）

# pQuant：通过解耦线性量化感知训练实现高效低比特语言模型 —— 论文详细总结

## 1. 核心问题与整体含义（研究动机与背景）

- **研究背景**：大语言模型（LLM）计算和内存开销巨大，量化技术成为边缘设备部署的关键手段。其中极低比特（sub 2-bit，即每个权重低于 2 比特）量化是最激进的压缩方案，可将权重存储降至 FP16 的 1/16，并以位运算替代浮点矩阵乘法，极具硬件吸引力。
- **现有瓶颈**：现有极低比特方法性能仍有明显差距——后训练量化（PTQ）方法（如 PTQ1.61、BiLLM）仅恢复到 FP16 基线的 60%~70% 准确率；量化感知微调方法最高也只恢复到约 79.3%。从零开始的量化感知训练（QAT-Scratch）虽然更有前景（如 BitNet 达到 90.1% FP16 对齐度），但仍然存在两个关键问题：
  - **精度差距**：即使最先进的 1-bit 方法仍有不可忽略的准确率损失；
  - **扩展效率低下**：随着模型规模增大，性能提升呈亚线性增长，远落后于 FP16 模型，严重限制实用性。
- **核心发现（参数民主化效应）**：论文通过基于扰动（perturbation-based）的敏感性分析发现，现有 1-bit QAT-Scratch 模型丢失了参数敏感性结构——在 FP16 模型中存在少量高敏感性参数（对输出影响不成比例），而 1-bit BitNet 模型的权重敏感性呈现近均匀分布。作者将这一现象称为**参数民主化（parameter democratization）**，即极端量化下参数敏感性的非预期均匀化，严重限制了模型的表达能力和可扩展性。

## 2. 提出的方法论：核心思想与技术细节

### 2.1 核心思想

- **总体目标**：通过**结构化的参数解耦**来对抗参数民主化——将一小部分敏感性权重隔离到高精度分支中，在保持 1-bit 主干高效计算的同时，保留模型表达力。
- **设计原则**：并非预先指定哪些参数是"敏感"的，而是通过**特征缩放（feature scaling）**引导模型在训练过程中动态地将最有影响力的表示分配到高精度路径。

### 2.2 解耦线性层架构

- **多头注意力（MHA）模块**：所有线性投影层（Q、K、V、输出投影）使用纯 1-bit 量化（保持计算效率），采用与 BitNet 一致的 AbsMean 量化方案：
  - 权重 binarization 前先减去均值 μ 以提升二值权重的信息容量；
  - 使用缩放因子 λ 降低 ℓ2 量化误差。
- **前馈网络（FFN）模块**：采用**解耦线性层（decoupled linear layer）**，将原始权重矩阵拆分为两个并行计算分支：
  - **1-bit 主干分支**（占约 95% 参数）：保证计算效率和低内存占用；
  - **8-bit 高精度分支**（占约 4%~5% 参数）：专门保留敏感性关键参数，选择 INT8 格式（基于硬件支持与部署兼容性）。
- **特征缩放（Feature Scaling）**：两个分支的输出分别乘以可学习标量 α 和 β 后相加。重要的是，**初始化时设置 α ≫ β**（如 α=2.0, β=0.2），使 8-bit 分支在反向传播中获得更强的梯度信号，引导模型学会将关键参数分配至高精度路径：

  Y = α · FFN_INT8(r)(LayerNorm(X)) + β · FFN_INT1(r:)(LayerNorm(X))

  其中 r 为 8-bit 分支维度，为 128 的整数倍。
- **高效的容量扩展（Efficient Scaling）**：将高精度分支扩展为 N 个稀疏激活的"专家"分支，由轻量级路由器（top-1 门控 + softmax）根据输入 token 动态选择最合适的分支。该设计使总参数容量可扩展，同时每次前向传播激活的参数数量与标准 FFN 相当（近似 MoE 架构，但精度与维度不同）。论文分析表明，2.6B pQuant 的性能优于 1.3B FP16 LLaMA-2 以及 7B 规模上应用的 PTQ1.61。

### 2.3 关键量化公式

- 1-bit 权重量化：W_INT1 = Sign(W_Float − μ)，其中 Sign(w) = +1 若 w > 0，否则 −1；
- 反量化输出：Y = λγ × W_INT1 · Q(LayerNorm(X))；
- 8-bit 激活/权重量化（AbsMax 方法）：Q(X) = RoundClip(X × γ, −2⁷+ε, 2⁷+ε)。

### 2.4 训练细节

- 采用**从零开始（QAT-Scratch）**端到端训练，用 Straight-Through Estimator（STE）近似量化操作的梯度；
- 训练中保留 FP16 影子权重用于梯度计算，推理时丢弃；
- 两阶段学习率调度（先高后低，第二阶段禁用权重衰减），以加速 1-bit 参数收敛并防止符号翻转。

## 3. 实验设计

### 3.1 数据集

- **预训练数据**：C4、Wikipedia、ArXiv。批大小配置：LLaMA-2 使用 4M tokens，其他模型使用 1M tokens；序列长度统一为 2048；BPE tokenizer 词表大小 32K。
- **评估基准**：
  - **困惑度**：WikiText-2；
  - **零样本下游任务**：ARC-Easy、ARC-Challenge、BoolQ、PIQA、Winogrande、OpenbookQA、Hellaswag 共 7 项，使用 lm-evaluation-harness 流程，每项重复 10 次取平均。

### 3.2 对比方法

- **同条件 QAT-Scratch 基线**（相同模型规模和 100B tokens 数据预算）：BitNet（1-bit）、BitNet1.58（2-bit）、FP16 LLaMA-2（16-bit 参考）；
- **跨方法参考**（非严格对比）：OmniQuant（PTQ）、OneBit（基于 SVID 分解的 QAT 微调）、PTQ1.61（极低比特 PTQ 基线）。

### 3.3 模型规模

- pQuant 在四个规模上训练：300M、700M、1.3B、2.6B 参数；此外 300M/700M/1.3B 上训练了基线模型用于公平对比；
- 8-bit 分支占比约 4%~5%（按规模略有不同）。

## 4. 资源与算力

- **训练硬件**：16 块 NVIDIA A100-80G GPU，1TB CPU 内存，使用 DeepSpeed 框架，混合精度训练 + Adam 优化器（β₁=0.9, β₂=0.95）；
- **训练时长**（表 8）：
  - 300M 模型：约 1.9~2.3 天（N=1 至 N=8）；
  - 700M 模型：约 4.9~6.0 天；
  - 1.3B 模型：约 8.5~11.1 天。
- **说明**：QAT-Scratch 训练成本显著高于传统 QAT 和 PTQ，训练中需同时保留 FP16 影子权重和 1-bit 权重，内存效率低于标准 Transformer 训练。

## 5. 实验数量与充分性评估

### 5.1 实验数量（较为丰富）

- **主实验**（表 2）：4 个规模 × 多基线对比 + 7 项下游任务 + 困惑度；
- **扩展实验**（表 5）：N=8 时在 300M/700M/1.3B 上与 FP16 和 2-bit 基线的完整对比；
- **消融实验**（图 5、图 7）：特征缩放的初始化值与存在性、高精度分支维度 r（256→768）、专家分支数量 N（1→8）、批大小、学习率调度；与原生混合精度（Native Mix 8%）、channel-wise、group-wise 量化方法的对比；
- **机制验证**（图 2、图 5a）：敏感性分布可视化分析（FP16 vs. BitNet vs. pQuant）；
- **匹配参数对比**（表 3）：在同等总参数量（1.3B）和减少激活参数（926M）条件下与 BitNet1.58 的公平对比；
- **效率评估**（图 6、图 8）：内存占用对比、推理时延分解（Apple M2 + 7B 模型 + 256 序列长度）。

### 5.2 充分性与公平性评估

- **公平性强的方面**：主要对比严格控制在相同模型规模和相同 100B tokens 数据预算下；匹配参数预算的对照实验（表 3）设计严谨；每种配置训练两次验证一致性；评估重复 10 次取均值。
- **客观性受限的方面**：
  - OmniQuant、OneBit、PTQ1.61 的对比不完全公平（这些方法基于更大的预训练模型，如 OPT-1.3B 用了 180B tokens，PTQ1.61 基于 ≥3T tokens 训练的 7B LLaMA-2）；作者对此有明确说明；
  - 最大训练规模仅到 2.6B，未验证更大规模（如 7B、70B）的行为；
  - 多组实验（如 N=8 扩展）的总参数量有所增加（如表 6 所示），虽激活参数量不变，但物理存储成本提升。

## 6. 主要结论与发现

- **参数民主化是极低比特量化模型的核心瓶颈**：1-bit 模型中权重敏感性呈均匀分布，限制了表达力，而 pQuant 的解耦设计能有效恢复敏感性的差异化结构（敏感性可视化验证了这一机制）。
- **精度显著提升**：pQuant（平均 1.28~1.35-bit）相比最先进的 1-bit 基线 BitNet，困惑度降低 32.0%；1.3B pQuant 与 2-bit BitNet1.58 的平均准确率差缩小至仅 0.4 个百分点，但每个权重少了 0.65 bit。
- **参数效率突出**：700M pQuant 即匹配 1.3B BitNet 的性能；2.6B pQuant 平均准确率 47.1，超过 1.3B FP16 LLaMA-2（45.4）和 7B 上的 PTQ1.61（41.8）。
- **可扩展性超越低比特基线**：当 8-bit 分支数 N=8 时，pQuant 在训练损失上超越 BitNet1.58 并几乎匹配 FP16 LLaMA-2 的扩展曲线（图 4）；1.3B 规模下 pQuant（N=8）准确率 45.8，逼近 FP16（45.4）且困惑度更低（14.3 vs 14.4）。
- **效率优势显著**：内存降低 92%（vs LLaMA-2）和 31%（vs BitNet1.58）；推理计算时间比 BitNet1.58 快 38%、比 FP16 LLaMA-2 快 82%；匹配参数预算下比 BitNet1.58 推理快 1.6×。

## 7. 优点

- **问题诊断有洞见**：首次系统地在 QAT-Scratch 背景下识别并命名"参数民主化"现象，并通过敏感性分析（基于 OBS 框架的封闭解）提供定量的经验证据，类比合理、可视化清晰。
- **方法设计巧妙**：
  - 解耦结构让高精度分支规避了 per-tensor 1-bit 量化的动态范围坍缩问题；
  - 特征缩放（而非固定位置分配）允许模型自适应学习敏感参数的分配位置，解决了从零训练中无法先验确定敏感参数位置的问题；
  - 将高精度分支扩展为 MoE 风格的稀疏专家模块，在不增加激活参数的前提下实现容量扩展，设计具有可扩展性。
- **实验严谨性较好**：做到了同数据预算下的严格对比、匹配参数预算下的效率对比，以及重复实验取一致的稳健性验证。
- **部署友好**：推理时可将所有缩放参数融合进相邻层，消除了训练中的额外开销；支持基于查找表的位运算加速（如 T-MAC 框架），对内存带宽受限的边缘部署具有切实价值。

## 8. 不足与局限

- **训练成本较高**：QAT-Scratch 的固有开销较大，需同时维护 FP16 影子权重和低比特权重，训练时间以天计；虽然作者在附录 H 中报告了各配置的训练时长，但并未与其他方法（如 BitNet、OneBit）进行同条件下的训练成本对比，读者难以直接判断额外训练开销的性价比。
- **模型规模受限**：由于训练成本，最大实验规模仅到 2.6B，未在 7B、13B 或更大规模上验证。参数民主化效应和 pQuant 方法在更大模型上是否成立，目前缺乏直接证据。作者在 Limitations 中也承认了这一点，并指出未来可在 70B 规模上进一步验证。
- **物理内存开销的隐性成本**：当 N≥4 时虽然推理速度提升（因激活参数少、内存访问量降低），但总参数量增加（表 6），物理存储需求上升（如表 3 中 N=8 时内存 0.98G vs BitNet1.58 的 0.72G）。作者明确承认这是速度与内存之间的权衡，其设计依赖"内存容量比带宽更便宜"的硬件趋势假设。
- **高精度分支的精度选择缺乏系统性论证**：文中主要依据已有文献选择 INT8，并仅做了一个 FP16 替代实验说明 8-bit 已足够，但未对 FP8、MXFP8 等格式做直接比较实验。
- **跨方法对比的公平性局限**：与 OmniQuant、OneBit、PTQ1.61 的对比存在训练数据量差异（180B~3T tokens vs 100B tokens），虽然作者对此有说明并在正文中避免将其作为直接竞争对比，但这种"跨方法参考"在结论叙述中仍存在一定的偏差风险，读者需要小心判别。
- **下游任务覆盖有限**：仅评估了常识推理类任务（共 7 个 benchmark），未覆盖代码生成、数学推理、多语言、长上下文等能力维度；评价指标主要基于困惑度和零样本准确率，也缺少对生成质量（如 BLEU、ROUGE）或多轮对话能力的评估。

（完）
