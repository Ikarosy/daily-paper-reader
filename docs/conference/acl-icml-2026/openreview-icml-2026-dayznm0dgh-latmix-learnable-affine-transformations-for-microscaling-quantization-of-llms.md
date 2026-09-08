---
title: "LATMiX: Learnable Affine Transformations for Microscaling Quantization of LLMs"
title_zh: LATMiX：面向LLM微缩放量化的可学习仿射变换
authors: "Ofir Gordon, Lior Dikstein, Arnon Netzer, Idan Achituve, Hai Victor Habi"
date: 2026-04-30
pdf: "https://openreview.net/pdf/d2dedffdfb1b38f9c8b46a10f1253169e4024603.pdf"
tags: ["query:wbv"]
score: 5.0
evidence: 面向MX微缩放低比特量化提出可学习仿射变换，可迁移到超低比特场景
tldr: 以往量化前的激活变换多为旋转或Hadamard形式，且较少考虑现代硬件支持的MX微缩放格式，两者结合还易出现性能退化。论文提出可学习的仿射变换LATMiX，在不加入额外变换假设的情况下重塑激活分布并适配MX格式，使微缩放低比特量化更稳健。该思路可作为硬件友好低比特量化中的可迁移组件。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 现有激活变换类型受限，且难以应用到现代硬件支持的MX微缩放数据格式，直接组合效果差。
method: 提出可学习仿射变换LATMiX，在保持模型功能前提下重塑激活分布，适配MX格式量化。
result: 无需额外变换假设即可改善微缩放量化下的激活鲁棒性并避免性能退化。
conclusion: 为激活变换与新型硬件数据格式的低比特量化提供了可迁移方法。
---

## Abstract
Post-training quantization (PTQ) is a widely used approach for reducing the memory and compute costs of large language models (LLMs). Recent studies have shown that applying invertible transformations to activations can significantly improve quantization robustness by reducing activation outliers; however, existing approaches are largely restricted to rotation or Hadamard-based transformations.
Moreover, most studies focused primarily on traditional quantization schemes, whereas modern hardware increasingly supports the microscaling (MX) data format. Attempts to combine both showed severe performance degradation, leading prior work to introduce assumptions on the transformations.
In this work, we take a complementary perspective. First, we provide a theoretical analysis of transformations under MX quantization by deriving a bound on the quantization error. Our analysis emphasizes the importance of accounting for both the activation distribution and the underlying quantization structure.
Building on this analysis, we propose LATMiX, a method that generalizes outlier reduction to learnable invertible affine transformations optimized using standard deep learning tools. 
Experiments show consistent improvements in average accuracy for MX low-bit quantization over strong baselines on a wide range of zero-shot benchmarks, across multiple model sizes.

---

## 论文详细总结（自动生成）

# 论文详细中文总结

## 1. 论文的核心问题与整体含义（研究动机和背景）

- **研究背景**：大语言模型（LLM）参数量庞大，部署时对内存和计算开销要求高。后训练量化（Post-training Quantization, PTQ）是降低这些开销的主流手段。
- **已有进展**：近期研究发现，对激活值施加可逆变换（如旋转或 Hadamard 变换）能够有效削弱激活值中的离群点（outliers），从而提升量化鲁棒性。
- **关键问题**：
  - 现有的激活变换方法几乎局限于旋转或 Hadamard 形式，灵活性有限。
  - 现代硬件越来越多地支持微缩放（Microscaling, MX）数据格式，但大多数研究仍聚焦传统量化方案。
  - 有工作尝试将两者结合，却出现严重性能退化，为此不得不在变换上引入额外假设。
- **研究含义**：论文试图在不依赖额外假设的前提下，将可逆变换推广到更一般形式，并使其适配 MX 格式下的低比特量化，从而提升 LLM 在硬件友好场景中的量化性能。

## 2. 论文提出的方法论：核心思想、关键技术细节、公式或算法流程（文字说明）

- **总体思想**：与先前研究“为适配 MX 量化而给变换增加假设”的思路不同，本文采取互补视角：从理论上分析 MX 量化下变换的作用机制，并据此设计一种可学习的、保功能的仿射变换，使得变换后的激活分布更适合 MX 格式。
- **理论分析**：作者推导了 MX 量化条件下量化误差的上界（bound），该误差界表明：变换效果同时依赖于激活分布形态和基础量化结构（如缩放因子、指数位/尾数位配置）。这一分析强调了只关注离群点削减或只关注量化格式皆是片面的。
- **核心方法 LATMiX**：
  - 提出可学习的可逆仿射变换（Learnable Affine Transformation），将离群点抑制推广到比旋转/Hadamard 更一般的变换族。
  - 变换参数通过标准深度学习工具（如梯度下降）端到端优化。
  - 变换为可逆保功能变换，不改变模型输出，仅作为量化前的预处理，可被融合或反演，不增加推理时的实际开销。
- **优势**：无需对变换的形式或功能做额外假设，学习过程能自动权衡“重塑分布”与“适配 MX 量化结构”两种需求。

## 3. 实验设计：数据集、场景、基准与对比方法

- **场景**：MX 格式下的低比特后训练量化。
- **模型规模**：实验覆盖多个不同规模的 LLM（具体模型名称在摘要中未列出）。
- **评测基准**：在多个零样本（zero-shot）下游任务数据集上进行评测，任务涵盖常识问答、语言理解等（具体数据集名称在摘要中未列出）。
- **对比方法**：
  - 强基线（strong baselines），包括旋转或 Hadamard 类激活变换方法，以及传统 MX 量化方案。
  - 对比目标为平均准确率（average accuracy）。
- **关键实验结果**：与强基线相比，LATMiX 在 MX 低比特量化下，跨多个模型规模和零样本基准均一致提升平均准确率。

## 4. 资源与算力

- 论文提供的文本中**没有明确说明**所使用的算力资源：包括 GPU 型号、数量、训练/微调时长、显存占用等信息均未给出。
- 由于方法依赖可学习变换的梯度优化，推测需要一定的训练开销（如少量迭代或调优），但这属于论文中未披露的信息。
- 若需要了解具体硬件配置，只能通过阅读原文的实验设置章节获得，本摘要不包含相关内容。

## 5. 实验数量与充分性

- **可确认的实验维度**：
  - 多组模型规模（说明覆盖了不同参数量级）。
  - 多个零样本 benchmark（说明覆盖了多种下游任务）。
  - 与“强基线”的对比，并在 MX 低比特量化下衡量平均准确率。
- **实验充分性判断**：
  - 从摘要看，实验覆盖面较广，能体现方法跨模型和任务的普适性。
  - 但受限于文本信息，**无法判断是否有消融实验**（如对变换维度的选择、不同 MX 配置、不同比特宽度、量化参数灵敏度等）。
  - 也**无法确认实验重复次数、方差显著性检验、以及是否只在特定 MX 配置（如 MXFP4/MXFP8）下测试**。
  - 总体而言，现有摘要呈现的证据足以支撑“方法有效”的初步结论，但充分性细节需要看原论文实验部分。

## 6. 论文的主要结论与发现

- 旋转/Hadamard 等固定变换不足以充分适配 MX 量化；同时忽略激活分布和量化结构会导致性能退化。
- 通过理论误差界分析，可以发现 MX 量化误差同时受激活分布与量化格式结构影响。
- 提出的 LATMiX 方法采用可学习仿射变换，无需额外假设即可在 MX 低比特量化下稳定提升模型的平均准确率。
- 实验结果证明该方法在多个模型规模和零样本评测中均优于强基线，表现出良好的鲁棒性和可迁移性。

## 7. 优点：方法或实验设计上的亮点

- **理论驱动**：先对 MX 量化变换推导误差上界，为方法设计提供理论依据，减少了经验调参的盲目性。
- **空间更广**：将激活变换从固定旋转/Hadamard 族推广到可学习仿射族，更具表达力。
- **硬件相关性强**：针对现代硬件支持的 MX 格式进行专门设计，贴近实际部署场景。
- **无需额外假设**：相较于此前需要给变换形式增加限制的工作，LATMiX 的方法更普适、更优雅。
- **使用标准工具优化**：利用深度学习框架直接学习变换参数，易于实现并集成到现有 PTQ 流程中。
- **实验证据直接**：在“多规模模型 + 多 zero-shot 数据集 + 强基线对比”下观察到一致的准确率提升，说明方法稳健。

## 8. 不足与局限

- **文本可见信息有限**：本摘要仅基于论文的 Abstract 和元数据；缺少方法细节、理论推导具体步骤、超参数设置等，无法深入评估技术稳健性。
- **可学习参数开销**：尽管变换在推理时可逆或融合，但训练阶段需要为每层激活调整参数，可能增加额外的调优与校准负担。
- **实验细节缺失**：
  - 未列出具体的模型名称、参数量范围、MX 格式（MXFP4/MXFP6/MXFP8 等）和比特位宽。
  - 未说明消融实验，无法确认各组分（如仿射 vs. 旋转+scale，可学习 vs. 固定变换）的具体贡献。
  - 未报告资源算力信息，复现难度较大。
- **基准多样性**：仅报告零样本任务的平均准确率，未涉及生成式任务、指令微调模型、长文本或多模态模型。
- **潜在偏差风险**：作者提出的误差上界可能依赖于特定分布假设，对实际非高斯激活的适用度需进一步检验；对比基线选择的具体实现版本也无法判断是否处于最优状态。
- **应用限制**：方法主要针对重量化期间的激活变换；若激活变换为不可反演或与 MX 缩放机制冲突，则可能失效，但作者声称已通过可变换避免该问题。

---

（完）
