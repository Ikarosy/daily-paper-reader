---
title: "You Had One Job: Per-Task Quantization Using LLMs’ Hidden Representations"
title_zh: 你只有一个任务：利用大模型隐表示进行任务级量化
authors: "Amit LeVi, Raz Lapid, Rom Himelstein, Chaim Baskin, Ravid Shwartz-Ziv, Avi Mendelson"
date: 2026-01-10
pdf: "https://openreview.net/pdf/02f398996002f663fceb29bc661b3033f58184ad.pdf"
tags: ["query:wbv"]
score: 4.0
evidence: 基于隐表示的任务级位分配，与 MoE/极低比特主题相关性弱
tldr: 很多 LLM 应用只需要某种窄能力，通用 PTQ 却按整层重要性分配精度，容易在无关层浪费比特。本文提出按任务混合精度 PTQ：输入少量无标注目标任务提示，用隐藏表示的信息稳定性或几何指标估计层重要性，并在位预算内把高精度给任务相关层。TAQ 与 TAQO 等任务感知信号构成一个通用层排名工具。实验显示按任务分配位宽可以更充分地利用有限量化预算，提升下游任务性能。
source: ICML-2026-Rejected-Public
selection_source: conference_retrieval
motivation: 通用 PTQ 按整层重要性分配精度，不考虑目标任务窄能力，容易浪费位数。
method: 用少量目标任务提示提取隐表示几何，以任务感知信号在位数预算下分配层精度。
result: 任务相关层获得更高精度，任务导向部署优于常见全局分配。
conclusion: 证明按任务和隐表示信息做混合精度分配能提高有限预算下的有效性能。
---

## Abstract
Many applications of large language models (LLMs) require only a narrow capability, yet common post-training quantization (PTQ) pipelines assign precision largely without regard to the target task. As a result, they may spend bits on layers that are less relevant to the task. We propose per-task mixed-precision PTQ guided by hidden representations. Given a small set of unlabeled calibration prompts from the target task, we estimate layer importance and allocate higher precision to task-relevant layers while lower to the rest, under a bits allocation budget. We introduce three task-aware allocation signals: \textbf{TAQ}, which scores layers using an information-stability criterion derived from activation geometry; \textbf{TAQO}, which ranks layers by direct sensitivity to single-layer quantization; and \textbf{TAQ-KL}, which measures output sensitivity via KL divergence under a noise proxy for quantization error. Together, these methods provide a simple, post-training framework that connects mechanistic signals to quantization decisions, enabling task-aligned compression without additional training. A reference implementation is available at https://anonymous.4open.science/r/TAQ-9217.

---

## 论文详细总结（自动生成）

## 1. 论文的核心问题与整体含义

- **研究背景**：大型语言模型（LLM）的很多实际应用场景只依赖模型某一项窄能力（如特定任务的处理），而非全面的通用能力。然而，现有主流的训练后量化（Post-Training Quantization, PTQ）流水线在分配各层精度时，很少考虑目标任务的需求。
- **核心问题**：通用 PTQ 按照层的整体重要性分配量化精度，可能将宝贵的比特（bit）预算花费在与目标任务无关的层上，造成精度资源的浪费。在有限位宽预算下，如何让压缩资源服务于目标任务，是一个未充分解决的问题。
- **论文主张**：提出“任务级（per-task）”的混合精度 PTQ 方案，根据目标任务动态决定每一层的量化精度，让任务相关层获得更多比特、无关层获得更少比特，从而在压缩规模受限的情况下提升目标任务的实际性能。
- **整体定位**：本文是一个面向任务导向部署的、无需额外训练的后训练量化框架，试图把模型隐表示中的机制性信号与量化决策直接连接起来，属于 ICML-2026 被拒稿件（评审分数 4.0）。

---

## 2. 论文提出的方法论

- **核心思想**：给定一小批来自目标任务的、无标注的校准提示（calibration prompts），提取模型的隐表示（hidden representations）并据此估计每层对目标任务的重要性；在给定比特预算约束下，将较高精度分配给任务相关层，较低精度分配给其余层。
- **技术细节**：论文提出三种“任务感知”（task-aware）的分配信号，作为层重要性排名工具：
  - **TAQ**：利用激活向量的几何结构计算一种信息稳定性准则（information-stability criterion），以此给各层打分。
  - **TAQO**：直接度量单层量化对输出的敏感度（direct sensitivity to single-layer quantization），以敏感度高低决定该层应获得的精度。
  - **TAQ-KL**：在量化误差的噪声代理模型下，通过 KL 散度衡量输出分布的变化，从而度量各层对量化噪声的敏感性。
- **算法流程（文字描述）**：
  1. 采样少量目标任务的未标注提示；
  2. 前向传播，提取各层隐表示；
  3. 用 TAQ / TAQO / TAQ-KL 三种信号之一对各层重要性打分并排序；
  4. 在总比特预算约束下做混合精度分配：重要层用高位宽，次要层用低位宽；
  5. 对分配结果执行 PTQ，得到任务导向的压缩模型。
- **适用约束**：全程无需重新训练，是一种轻量级后训练框架；参考实现已在匿名平台公开。

---

## 3. 实验设计

- **可用信息**：在给定文本中，论文摘要没有提供实验部分的具体信息，包括：
  - 使用了哪些数据集；
  - 实验场景与 benchmark 设置；
  - 对比了哪些基线方法。
- **可推断的范围**：由于方法涉及“目标任务校准”和“与通用 PTQ 分配的比较”，实验应该涵盖多种下游任务场景，并比较本文方法（TAQ / TAQO / TAQ-KL）与统一的全局位宽分配或按层重要性分配的常见 PTQ 方案；但具体数据集与基线列表**无法从提供的内容中确认**。

---

## 4. 资源与算力

- 给定摘要与元数据中**未提到**任何关于 GPU 型号、数量、训练/校准时长、显存消耗等硬件与算力信息。
- 仅能推断：由于方法的定位是“后训练量化”，主要成本来自少量校准样本的前向传播与层敏感性估计，但这只是合理推测，论文实际使用的算力规模需以全文为准。

---

## 5. 实验数量与充分性

- **基本判断**：仅凭 Abstract 无法统计实验组数、消融数量或任务覆盖范围。论文提出了三种信号（TAQ、TAQO、TAQ-KL），合理的实验设计应当包含：
  - 三种信号之间的对比；
  - 与等预算下均匀位宽分配、启发式层重要性分配等基线对比；
  - 多个下游任务和多种位宽预算的敏感性分析。
- **充分性评价**：由于缺少方法细节与实验章节，无法客观评估实验的公平性与充分性；从元数据看，该论文被 ICML-2026 拒稿（评分 4.0），且有审稿意见指出其与 MoE / 极低比特主题相关性偏弱，这可能暗示其实验设计在问题定位或对比框架上存在不足。

---

## 6. 论文的主要结论与发现

- 按任务分配层精度是可行的：在有限的量化比特预算下，让任务相关层获得更高精度、无关层获得更低精度，能够比常见的全局统一分配更有效地提升目标任务性能。
- 隐表示中蕴含的任务信号（几何稳定性、逐层敏感度、输出 KL 变化）能够作为层重要性排名的有效依据。
- 三种任务感知信号（TAQ、TAQO、TAQ-KL）共同构成了一个简单的、可用于后训练量化决策的通用层排名工具。
- 总体证明“按任务 + 按隐表示信息”做混合精度分配，能够提高有限位宽预算下的任务导向压缩效果。

---

## 7. 优点

- **问题切入有现实价值**：抓住了“LLM 部署往往面向单一窄能力”这一实际应用特征，质疑通用 PTQ 按整层重要性分配精度的合理性，思路贴近生产环境需求。
- **方法轻量、实用**：只需要少量无标注目标任务提示，不需要训练或微调，适合后训练快速部署。
- **提出多个可比较的分配信号**：TAQ / TAQO / TAQ-KL 分别从激活几何、单层敏感度和输出噪声三个角度度量层重要性，既有机制解释力，又形成了统一框架下的系列方法。
- **代码开源**：提供了匿名参考实现，利于复现与后续研究。
- **语言表述清晰**：Abstract 对问题、方法与结果的概括紧凑、易读。

---

## 8. 不足与局限

- **核心内容缺失/覆盖不足**：摘要与元数据所提供的信息过少，实验设计、数据集、baseline、消融等关键内容均无法确认，这本身构成一种局限（评审可能也会因信息呈现不充分而给出偏低分数）。
- **评审反馈的相关性质疑**：元数据中的审稿意见指出其与 MoE/极低比特主题相关性较弱，说明论文在选题定位或与主题领域的衔接上存在偏差，可能削弱其在目标会议中的说服力。
- **任务范围局限**：方法的前提是“目标任务已知且有少量校准提示”，对于真正的通用场景或任务动态切换场景，其适用性受限。
- **校准数据依赖**：虽然不需要标注，但仍依赖一定量的目标任务分布内文本，若目标任务分布与校准提示分布偏移较大，层重要性估计可能失真。
- **缺乏算力与规模信息**：未报告模型规模（如 7B / 13B / 70B 等）、不同模型族上的泛化情况，以及实际量化带来的吞吐/内存收益，无法从摘要层面判断其可扩展性与实际收益规模。
- **潜在过拟合风险**：将精度专门配给目标任务相关层，可能带来对单一任务过拟合式分配，牺牲模型在其他任务上的可用性；论文是否讨论了这种“任务专用化”的代价，在给定文本中未能体现。

---

（完）
