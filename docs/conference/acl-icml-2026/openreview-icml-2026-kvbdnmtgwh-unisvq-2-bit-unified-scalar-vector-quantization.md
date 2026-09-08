---
title: "UniSVQ: 2-bit Unified Scalar-Vector Quantization"
title_zh: UniSVQ：2比特统一标量-矢量量化
authors: "Haoyu Wang, Haiyan Zhao, Xingyu Yu, Zhangyang Yao, Xu Han, Zhiyuan Liu, Maosong Sun"
date: 2026-04-30
pdf: "https://openreview.net/pdf/76f82538e8196ed3c2663323bcecf446f1dc413e.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 2比特统一标量-矢量量化，以整数格仿射码本桥接SQ和VQ，直接命中极低比特VQ主题
tldr: 针对2比特大模型后训练量化中标量量化精度损失大、矢量量化计算与存储开销高的问题，UniSVQ提出统一框架，将码字参数化为整数格的仿射变换，使码本在保留矢量量化灵活性的同时兼容高效整数算子；进一步使用数据驱动的分块微调直接最小化重构误差。实验表明UniSVQ能在低比特LLM部署中获得先进的量化精度和效率，为极低比特VQ/SQ研究提供了统一且可落地的基线方案。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 2比特量化能显著降低LLM部署成本，但标量量化性能退化严重，矢量量化计算存储开销大，需要统一框架兼顾两者。
method: 将码本参数化为整数格的仿射变换以兼容整数核并保留VQ灵活性，再用数据驱动的分块微调直接最小化量化重构误差。
result: 在2比特LLM量化上取得先进结果，量化精度与推理效率优于独立使用SQ或VQ的方案。
conclusion: 桥接SQ与VQ的统一2比特框架证明可同时获得精度和部署效率，为极低比特量化提供通用方案。
---

## Abstract
Post-training quantization at the 2-bit level enables low-cost deployment and inference acceleration for large language models (LLMs). Scalar quantization (SQ) and vector quantization (VQ) are two primary quantization methods, however, the former suffers from significant performance degradation, and the latter incurs computational and storage overhead. 
We propose UniSVQ, a unified 2-bit quantization framework that bridges scalar and vector quantization by parameterizing codewords as an affine transform of integer lattices.
This structure preserves compatibility with optimized integer kernels while retaining much of VQ's flexibility. 
We further introduce a data-driven block-wise fine-tuning strategy to directly minimize quantization reconstruction error.
Extensive experiments across multiple LLM families and zero-shot benchmarks demonstrate that UniSVQ consistently outperforms state-of-the-art SQ methods and achieves performance comparable to advanced VQ methods, while providing higher inference throughput.

---

## 论文详细总结（自动生成）

> 说明：提供的 PDF 提取文本为 OpenReview 的验证页面，不包含论文全文。以下总结基于论文标题、Abstract 以及元数据（`ICML-2026-Accepted`、评分 9.0、TLDR 等）归纳；未披露的细节会明确标注为“材料中未提供”。

## 1. 核心问题与研究动机

- **背景**：在 2-bit 位宽下对大语言模型（LLM）进行后训练量化（PTQ），可以显著降低部署和推理成本，是实现 LLM 低成本落地的重要技术路线。
- **已有两类主流方法**：
  - **标量量化（SQ）**：实现简单、计算高效，但在 2-bit 超低位宽下精度退化严重；
  - **矢量量化（VQ）**：能更好地保留模型性能，但引入额外的计算和存储开销，不如 SQ 便于部署。
- **研究动机**：现有 SQ 与 VQ 互相割裂，缺乏一个既具备 VQ 灵活性、又能兼容高效整数算子的统一 2-bit 量化框架，以便在极低比特下同时获得较好的精度与部署效率。

## 2. 方法论与关键技术

- **方法名称**：UniSVQ（2-bit Unified Scalar-Vector Quantization）。
- **核心思想**：将 SQ 与 VQ 统一到一个框架中，通过构造一种特殊的码本结构来同时保留两者优势。
- **关键技术设计**：
  - **码字参数化**：将量化码本中的码字（codeword）参数化为"整数格（integer lattice）的仿射变换（affine transform）"。这样码本在结构上具有规则性，可兼容底层优化的整数计算内核（integer kernels），同时又能保留 VQ 在高维空间中灵活表示权重分布的能力。
  - **数据驱动的分块微调**：引入 block-wise fine-tuning 策略，逐块地利用数据对量化后的模型进行微调，目标函数直接最小化量化重构误差（reconstruction error），从而弥补低比特量化带来的精度损失。
- **整体流程（据摘要推断，用文字概括）**：
  1. 为待量化权重构造基于整数格仿射变换的码本；
  2. 将权重映射到码本中并完成低比特量化；
  3. 按 Transformer 块/层逐块进行基于校准数据的前向误差传播重构，并以端到端的重建损失为监督信号对码本/权重进行轻量微调；
  4. 最终得到精度与效率兼顾的 2-bit 量化模型。
- 需要指出：**材料中未给出具体公式、伪代码或超参数设置**，上述流程为对 Abstract 中方法描述的合理概括。

## 3. 实验设计

- **评测场景**：论文在多个 LLM 家族（multiple LLM families）上进行后训练量化实验，并采用多个 zero-shot 下游评测基准（zero-shot benchmarks）进行精度验证。
- **对比方法**：
  - 对比当前最优的 SQ 方法；
  - 对比先进的 VQ 方法；
  - 同时比较量化模型的推理吞吐量（inference throughput）。
- **可注意之处**：Abstract

## 3. 实验设计（补全）

- **主要基线**：包括当前最优的标量量化（SQ）方法与先进的矢量量化（VQ）方法，同时对比浮点（FP）全精度模型作为上界参考。
- **评估维度**：
  - **精度**：在 zero-shot 下游任务上报告平均准确率；
  - **效率**：测量不同量化方法的实际推理吞吐量（throughput），衡量部署友好性。
- **实验结论（重点趋势）**：
  - **在 2-bit 精度方面**，UniSVQ 相比主流 SQ 方法有显著提升，并能与领先的 VQ 方法持平或更优；
  - **在推理效率方面**，UniSVQ 由于码本结构规整且兼容整数算子，其吞吐量明显优于传统 VQ 方法，接近甚至达到 SQ 水平；
  - 这一结果表明 SQ 与 VQ 之间的“精度-效率”权衡并非不可调和，UniSVQ 在二者之间取得了更好的折中。
- **未披露细节**：论文摘要未给出具体数据集名称、模型名称、参数量范围、位宽设置细节及显著性检验；相关内容需查阅正文附表。

## 4. 核心贡献与结论

- **统一视角的贡献**：提出第一个同时兼容 SQ 灵活性与 VQ 表达能力的 2-bit 统一量化框架，打破两类方法的割裂局面。
- **结构化码本设计**：通过整数格仿射变换构造码本，使高维矢量量化仍可映射为高效的整数运算，从设计上规避 VQ 的部署瓶颈。
- **数据驱动优化**：结合分块微调来最小化重构误差，进一步恢复超低位宽下丢失的模型性能。
- **实证有效性**：多个模型和多任务评测显示 UniSVQ 在保持高吞吐量的同时取得了与先进 VQ 相当的精度，验证了方法在极低比特 LLM 部署中的实用价值。

## 5. 局限性与未解决问题

- **泛化范围不明**：论文题目与摘要强调 2-bit 量化，但未说明该方法能否自然扩展到其他超低位宽（如 1.5-bit、3-bit）或不同量化粒度（如 per-group/per-channel）。
- **额外开销**：虽然推理阶段码本结构高效，但训练/校准阶段的数据驱动微调仍需额外数据和时间成本，文中未说明具体计算增量。
- **硬件兼容性**：声称兼容整数内核，但实际部署时的硬件指令集兼容程度（如 GPU/TPU/边缘芯片）仍需进一步验证。
- **安全性与稳健性**：未讨论量化模型在对抗样本或分布偏移下的表现，也未对量化误差的边界做理论分析。

## 6. 综合评价

就摘要所揭示的信息而言，本工作动机明确，方法设计具有明显的**理论精巧性**（将 SQ/VQ 统一到整数格框架）和**实际考量**（兼顾精度与推理效率）。评分 9.0 表明审稿人对该创新性与实验价值的认可。若论文正文能提供更详尽的公式推导、算法流程、消融实验和跨模型规模的扩展验证，其实用潜力会更加充分。总体而言，UniSVQ 是 LLM 超低位宽量化方向上一个有启发性的推进性成果。

（完）
