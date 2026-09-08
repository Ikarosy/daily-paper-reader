---
title: "RQ-MoE: Residual Quantization via Mixture of Experts for Efficient Input-Dependent Vector Compression"
title_zh: RQ-MoE：基于专家混合的残差量化用于高效输入相关向量压缩
authors: "Zhengjia Zhong, Shuyan Ke, Zaizhou Lin, Jiaqi Song, Hongyi Lan, Hui Li"
date: 2026-04-30
pdf: "https://openreview.net/pdf/f8feff04b2dc042be3a9894fe830b1846199ee64.pdf"
tags: ["query:wbv"]
score: 6.0
evidence: 以残差量化和MoE做输入相关向量压缩，与VQ主题相关但非MoE模型量化
tldr: 传统多码本残差向量量化通常依赖静态码本，难以适应异构数据几何，而现有动态量化器存在串行解码瓶颈。文章提出RQ-MoE，用两层专家混合与双流量化把码本指令和量化过程解耦，从而按输入构造码本并支持并行解码。该方法在提升向量压缩表达力的同时降低了解码延迟，对极低比特向量量化方向具有迁移价值。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 传统多码本向量量化使用静态码本，难以适配异构数据几何，动态量量化器又受严格串行依赖限制。
method: 提出双层MoE加双流量化框架RQ-MoE，实现输入相关码本自适应并将指令与量化解耦以支持并行解码。
result: 缓解解码瓶颈并提高向量压缩效率，理论上支持动态码本构造和并行解码。
conclusion: 为残差向量量化提供兼顾表达能力、自适应性和效率的新方案。
---

## Abstract
Vector quantization is a fundamental tool for compressing high-dimensional embeddings, yet existing multi-codebook methods rely on static codebooks that limit expressiveness under heterogeneous data geometry. While recent dynamic quantizers like QINCo adapt codebooks to individual inputs and improve expressiveness, their strict sequential dependencies create decoding bottlenecks. We propose Residual Quantization via Mixture of Experts (RQ-MoE), a framework combining a two-level MoE with dual-stream quantization to enable input-dependent codebook adaptation for efficient vector quantization. RQ-MoE enables dynamic codebook construction and decouples instruction from quantization, facilitating parallel decoding. Theoretically, we show that standard Residual Quantization and QINCo can be recovered as constrained special cases of RQ-MoE, and derive a guideline for setting expert dimensionality in RQ-MoE. Extensive experiments show that RQ-MoE achieves state-of-the-art or on-par performance in reconstruction and retrieval, while it can provide 6×–14× faster decoding than prior vector quantization methods. The implementation is available at https://github.com/KDEGroup/RQ-MoE.

---

## 论文详细总结（自动生成）

## 1. 论文的核心问题与整体含义

- 向量量化（Vector Quantization）是压缩高维嵌入（embedding）的基础工具，广泛应用于信息检索与近似最近邻搜索等领域。
- **现有问题一**：传统多码本残差量化方法（如标准的 Residual Quantization, RQ）依赖**静态码本**，即码本在训练后固定不变。这限制了模型对**异构数据几何**（指不同输入向量在高维空间中的分布形态差异大）的表达能力。
- **现有问题二**：近年出现的动态量化器（如 QINCo）虽然能够根据**单个输入样本**动态调整码本，提升了表达力，但其解码过程存在**严格的串行依赖**，导致解码速度成为系统瓶颈。
- RQ-MoE 的核心意义在于：**在不牺牲动态码本适应性的前提下，打破串行解码限制**，实现更高效的输入相关向量压缩，为残差向量量化提供了兼顾表达力与吞吐量的新思路。

## 2. 论文提出的方法论

- **核心框架名称**：Residual Quantization via Mixture of Experts（RQ-MoE），即基于专家混合的残差量化。
- **整体架构**：结合 **两层 MoE（Mixture of Experts）** 与 **双流量化（dual-stream quantization）**。
- **核心思想**：
  - 用 MoE 根据输入特征动态生成/选择码本指令（instruction），实现**输入相关的动态码本构造**；
  - 通过**双流通路**将“指令生成”与“量化残差计算”解耦，使不同层的量化过程不再严格串行，从而**支持并行解码**。
- **理论贡献**：
  - 论文证明标准 Residual Quantization（RQ）与 QINCo 可以视为 RQ-MoE 在特定约束下的**特例**，说明 RQ-MoE 是更一般的动态量化框架；
  - 推导了 RQ-MoE 中专家维度（expert dimensionality）的设置**指导原则**，为实际部署提供理论依据。
- 实现代码已开源（GitHub: KDEGroup/RQ-MoE）。

## 3. 实验设计

- **任务场景**：向量重建（reconstruction）与检索（retrieval）。
- **Benchmark**：摘要中未明确列出具体数据集名称，推测为向量量化/近邻检索常用的标准评测集（正文需进一步确认）。
- **对比方法**：以标准 Residual Quantization（RQ）和动态量化器 QINCo 为主要基线，涵盖传统静态码本与现有动态方法两大类别。
- **评测指标**：侧重于重建质量、检索效果与**解码速度**（报告中给出 6×–14× 的加速提升）。

## 4. 资源与算力

- 提供的论文摘要与元数据中**未明确说明**训练所用 GPU 型号、数量或训练时长等算力信息。
- 若需了解具体资源开销，需查阅论文正文中的实验设置或补充材料。

## 5. 实验数量与充分性

- **实验组数维度**：摘要中可确认的实验维度至少包括——重建质量对比、检索性能对比、解码加速比验证，以及理论分析（包含特例恢复与专家维度指导原则）。
- **可能存在的消融实验**：摘要未明确提及是否针对 MoE 层数、专家数量、双流设计等进行消融实验，具体需以正文为准。
- **总体评价**：从已有信息看，实验覆盖了“性能”与“效率”两个关键维度，并有理论支撑；但**实验覆盖面是否完整**（如数据集多样性、与更多 SOTA 动态量化方法对比的数量）以及**公平性细节**（如是否统一硬件条件、是否同码率下比较）在摘要中无法完全判断。

## 6. 论文的主要结论与发现

- RQ-MoE 在重建和检索任务上达到 **state-of-the-art 或与最优方法相当** 的水平；
- 解码速度相比既有向量量化方法有显著提升，实测可达到 **6 倍至 14 倍加速**；
- RQ-MoE 统一了现有 RQ 与 QINCo 框架，说明其设计具有理论一般性；
- 输入相关的动态码本构造与并行解码可以同时实现，二者并不矛盾。

## 7. 优点

- **设计巧妙**：将 MoE 用于码本指令生成，而非直接用于量化本身，解耦了“指令”与“量化”过程，是一个有启发性的架构创新。
- **并行化友好**：直接针对现有动态量化器串行解码的痛点，对实际系统部署价值高。
- **理论完整**：不仅提出方法，还给出与已有方法（RQ、QINCo）的理论关系，并给出专家维度的设置原则，增强了方法的可信度与可用性。
- **工程可复现**：提供了公开的 GitHub 代码链接，有利于后续研究者复现与扩展。

## 8. 不足与局限

- **信息受限于摘要**：当前可获得的信息源有限，无法对算法细节（如双层 MoE 的具体交互机制、残差量化步长选取等）做更细的评估。
- **实验细节不透明**：摘要未列出具体数据集列表、基线数量、参数量/码率对齐方式等，实验的广度与公平性需在正文中进一步核实。
- **MoE 的计算代价**：MoE 常引入路由开销与更大的内存占用，论文强调了解码加速，但对训练开销与模型体积是否有增量、是否影响整体效率，摘要中未涉及。
- **应用边界**：方法设计针对“残差量化”范式，其是否能平滑迁移到其他类型量化（如乘积量化、无训练量化）仍有待验证；摘要中的理论分析也仅覆盖 RQ 与 QINCo 两个特例。
- **潜在偏差风险**：若对比实验中未严格统一比特率、码本规模或解码硬件环境，则 6×–14× 加速比结论可能存在偏差。

（完）
