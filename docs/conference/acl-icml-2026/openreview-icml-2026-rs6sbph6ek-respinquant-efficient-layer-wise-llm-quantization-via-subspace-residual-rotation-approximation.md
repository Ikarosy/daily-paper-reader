---
title: "ReSpinQuant: Efficient Layer-Wise LLM Quantization via Subspace Residual Rotation Approximation"
title_zh: ReSpinQuant：基于子空间残差旋转近似的高效逐层LLM量化
authors: "Suyoung Kim, Sunghyun Wee, Hyeonjin Kim, Kyomin Hwang, Hyunho Lee, Nojun Kwak"
date: 2026-04-30
pdf: "https://openreview.net/pdf/45980850254f4f9bfcdc15faf301bac9325c86b8.pdf"
tags: ["query:wbv"]
score: 6.0
evidence: 逐层旋转近似的LLM量化框架，对低比特量化精度提升有方法贡献
tldr: 旋转后训练量化能减少大模型激活离群值，但全局旋转表达力受限、逐层旋转变换又无法融合进权重而带来在线计算负担。ReSpinQuant提出用子空间残差旋转近似逐层旋转信息，既能保留逐层精度，又可维持旋转融合的高效推理形式。该方法为低比特LLM量化提供了新的逐层自适应框架。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 全局旋转方法表达力受限，逐层方法精度高但无法融合旋转矩阵进权重，推理在线开销大。
method: 提出ReSpinQuant，以子空间残差旋转近似逼近逐层变换，同时保留融合到块的推理优势。
result: 该方法预期在提升低比特量化精度的同时避免逐层在线变换开销。
conclusion: 为LLM量化在逐层自适应与高效推理间提供新平衡。
---

## Abstract
Rotation-based Post-Training Quantization (PTQ) has emerged as a promising solution for mitigating activation outliers in the quantization of Large Language Models (LLMs). Global rotation methods achieve inference efficiency by fusing activation rotations into attention and FFN blocks, but suffer from limited expressivity as they are constrained to use a single learnable rotation matrix across all layers. To tackle this, layer-wise transformation methods emerged, achieving superior accuracy through localized adaptation. However, layer-wise methods cannot fuse activation rotation matrices into weights, requiring online computations and causing significant overhead. In this paper, we propose **ReSpinQuant**, a quantization framework that resolves such overhead by leveraging offline activation rotation fusion and matching basis using efficient residual subspace rotation. This design reconciles the high expressivity of layer-wise adaptation with only negligible inference overhead. Extensive experiments on W4A4 and W3A3 quantization demonstrate that ReSpinQuant achieves state-of-the-art performance, outperforming global rotation methods and matching the accuracy of computationally expensive layer-wise methods with minimal overhead.

---

## 论文详细总结（自动生成）

好的，我将严格按照你给出的要点，对这份论文的元数据及摘要内容进行分析归纳。由于本次提取的论文正文内容非常有限（仅有标题、摘要及元数据），以下总结将在摘要信息的基础上尽量做出客观推断，并明确区分哪些是原文明确信息，哪些是基于上下文的合理推论。

---

# ReSpinQuant：基于子空间残差旋转近似的高效逐层LLM量化——论文总结

## 1. 论文的核心问题与整体含义（研究动机和背景）
- **研究背景**：基于旋转的后训练量化（Rotation-based PTQ）是近年来大语言模型（LLM）低比特量化中最有前景的思路之一。其核心动机在于：激活值中存在显著的离群点（outliers），严重制约低比特量化的精度表现。通过引入酉旋转（rotation）对激活分布进行变换，可有效抑制离群点的影响，提升量化友好性。
- **核心矛盾**：现行的旋转方法存在两条技术路线，各有牺牲：
  - **全局旋转方法（Global Rotation）**：所有层共享一个可学习的旋转矩阵。这是优点是旋转可以在离线阶段融合进 attention 和 FFN 块的权重中，推理时零额外开销；缺点是单矩阵表达力有限，无法逐层适配不同层激活分布的差异性，精度受限。
  - **逐层变换方法（Layer-wise Transformation）**：逐层独立施加旋转，表达力强、精度高。但这种矩阵无法离线融合进权重，必须在推理时在线计算，引入显著的内存访问与计算延迟开销。
- **论文核心问题**：如何在保留**逐层高表达能力**的同时，牺牲尽量小的推理效率，即打破“算法精度”与“推理开销”之间看似固有的取舍。

## 2. 论文提出的方法论：ReSpinQuant
- **核心思想**：不直接在线执行逐层旋转，而是离线利用**残差子空间旋转（residual subspace rotation）**对逐层变换进行近似逼近，从而在**离线权重融合**的前提下重建逐层变换的精度收益。
- **方法论名称出处**：**Spin** 指代旋转操作，Re（Residual）加 **Spin** 的结合意指对旋转残差进行子空间近似。
- **关键技术流程（基于摘要与元数据的文字重建）**：
  1. **离线激活旋转融合**：以逐层变换为目标参照，先离线将旋转矩阵融合到权重中，保证推理部署时权重已经变换完毕，不额外引入在线计算。
  2. **子空间残差近似**：由于完整的逐层旋转不可直接融合（或融合破坏结构），ReSpinQuant 将该旋转表达为**可融合的基准算子 + 残差修正**，且残差在低维子空间内近似，以减少自由参数和计算复杂度。
  3. **匹配基（Matching Basis）**：通过对子空间旋转的基进行匹配或对齐，使得近似的逐层变换与理想逐层变换之间的误差最小化。
  4. **训练范式**：属于后训练量化（PTQ），无需从头训练完整模型或对全模型进行梯度重训。
- **设计效果**：理论上该方法既获得了近似逐层变换的表达力和精度优势，同时保持了全局旋转“可融合进块”的推理优势，将在线开销降到可忽略的水平。

## 3. 实验设计
- **量化场景**：低比特后训练量化，具体包括两个具有代表性的高难度设置：
  - **W4A4**（权重4比特，激活4比特）
  - **W3A3**(权重3比特，激活3比特）
- **对比方法**：
  - **全局旋转方法**：代表如 QuaRot、SpinQuant 等在旋转后训练量化领域的SOTA方法，作为该策略的基准对照。
  - **逐层变换方法**：代表高精度但计算开销大的方法。
- **未在摘要中明确提及的信息**：
  - 具体使用的LLM模型家族（如 LLaMA 等）未见说明；
  - 具体测评数据集（如 WikiText-2、C4 或 Zero-shot 任务集）未曾列出。
  - 这是基于提取文本不可见的缺失项，不代表论文原文一定缺失。判断时应予以区分。

## 4. 资源与算力
- **原文未提及任何训练或推理算力的详细信息**，例如 GPU 型号（A100/H100等）、卡数、训练时长等字眼在提取的元数据与摘要中没有出现。
- **论文类型推断**：作为 ICML-2026 接收的论文，其正文中通常会有实验环境部分，但该细节不在本次可检索的文本范围内。
- **评价**：基于当前材料，无法对该论文的计算资源成本或可获得性做任何定量判断。

## 5. 实验数量与充分性
- **可见实验范围**：摘要明确报告了 W4A4 和 W3A3 两种低比特设置下的结果，并与两类关键基准（全局旋转法、逐层法）进行对照。
- **实验规模推断**：依据该领域惯例（如 SpinQuant、QuaRot 系列工作），除了主精度表外，正文很可能还包含以下消融内容（但这部分是推测而非直接可见内容）：
  - 不同模型规模（如 7B、13B、70B）下的扩展性测试；
  - 子空间维数选择的敏感性分析；
  - 在线开销的延迟与吞吐测试；
  - 端到端任务性能（常识推理、复杂问答）与困惑度（PPL）的交叉验证。
- **客观性与公平性评估**：摘要称**精度上全面超过全局旋转方法且与逐层法精度相当**、开销却很小，这个声明本身非常有说服力，且基准选择的针对性较强。但判断是否完全客观，需要看到被对比方法的超参设置、量化校准流程有无统一标准，这些细节当前文本不可见。
- **总体判断**：摘要中直接披露的实验**完整度有限、但方向准确**，实验设计的信息在逻辑上与主张一致；然而实验充分性的有力证据需要依赖原文数据。

## 6. 论文的主要结论与发现
- **结论一**：ReSpinQuant 在 W4A4 与 W3A3 设定下均达到当前最优（SOTA）性能。
- **结论二**：相比**全局旋转法**，ReSpinQuant 通过逐层级别精细适配实现了更高的量化精度。
- **结论三**：相比**逐层变换法**，ReSpinQuant 以**近乎可以忽略不计的在线开销**取得了与后者同等的精度，成功打破了此前“逐层高精度必须以高推理开销为代价”的认知瓶颈。
- **总括**：该框架为旋转后训练量化提供了一种新的**折中机制**，在离线旋转可融合性与逐层旋转表达力之间取得了更好的交集，为低比特LLM量化提供了一种层级自适应新范式。

## 7. 优点
- **核心思路新颖**：与过往直接对立“全局 vs 逐层”的思路不同，ReSpinQuant 利用**残差子空间近似的数学桥接**实现两条路线优势的统一，这个思想切入点有较强的技术贡献。
- **实际问题驱动**：该论文瞄准工业部署中真实存在的痛点——低比特量化不仅要让模型跑起来，还要让它跑得与未量化时一样快；提出“精准但可用”的解法，有很强的实用意义。
- **结果声明很有力**：声称“与逐层精度相同但开销接近为零”，若能复现，是一种帕累托改善（Pareto Improvement），而非简单性能与开销权衡。
- **动机清晰**：从全局轮换的表达力缺陷切入，从逐层融合的结构障碍切入，问题结构逻辑严密。
- **元数据可信度**：ICML-2026 接收、评审分数6.0，在该领域有中等以上的质量背书。

## 8. 不足与局限
- **信息可见性受限的局限（文本层面的解释）**：本次分析基于提取的简要摘要与元数据，论文的全文技术细节、公式推导和完整实验表格难以查阅；以下局限既包含原文推断中的不足，也包含可见信息不足的局限性风险。
- **评估场景范围存疑**：仅 W4A4 与 W3A3 两个设置对LLM量化而言还不是最严苛的范围，若实际底线较低（如 W2A2 或更极端情况），需另行验证其有效性，但这在摘要中不可见。
- **没有透露模型/任务覆盖多样性**：若只在数种同架构模型上验证，面对不同训练范式（如 MoE、多模态LLM）的通用性有待商榷。
- **近似误差理论保障问题**：子空间残差旋转近似是否存在严格的理论误差上界？在低比特极低表达力下，近似损失的累积效应可能被放大。该点在摘要中没有明确理论保证。
- **对特定硬件结构的适配敏感度**：低比特在推理时的高效性通常高度依赖硬件对特定矩阵分解与算子的支持情况（是否支持混合精度的快速算子内核等），该方法在这些真实硬件约束下的可移植性需要通过正文中具体实验才能进一步确认。
- **潜在偏差问题**：论文本身声称精度与逐层法持平，实验中作为基准的逐层实现在超参数、旋转迭代次数上是否做到了最大化公平配置，需要原文对比细节才能下结论。

---

（完）
