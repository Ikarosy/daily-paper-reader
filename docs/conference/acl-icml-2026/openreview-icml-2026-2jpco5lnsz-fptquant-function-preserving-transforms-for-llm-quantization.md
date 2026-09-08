---
title: "FPTQuant: Function-Preserving Transforms for LLM Quantization"
title_zh: FPTQuant：用于LLM量化的保函数变换
authors: "Boris van Breugel, Yelysei Bondarenko, Paul N. Whatmough, Markus Nagel"
date: 2026-04-30
pdf: "https://openreview.net/pdf/84a2a646b8b2f823742a7a1c8d1b60f2b3f85d2c.pdf"
tags: ["query:wbv"]
score: 5.0
evidence: 保函数变换压低激活离群值，可迁移至低比特LLM量化
tldr: 量化大模型时常因离群激活导致精度骤降，而现有方法对变换要求苛刻。FPTQuant设计了三个轻量保函数变换：可合并的预RoPE Q/K变换、值变换和廉价动态缩放变换，利用Transformer自身的等变与独立结构维持模型输出不变，同时压低激活离群值。该机制能够在不改函数语义的前提下为后续低比特量化创造更友好的激活分布。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 朴素量化大模型会因大幅离群激活而显著退化，需要不改变模型功能的激活整形方法。
method: 提出三类可合并且保函数的变换，包括RoPE前Q/K变换、值变换与动态缩放变换。
result: 在维持模型函数的同时重塑中间激活，降低低比特量化误差。
conclusion: 为通用Transformer量化提供可迁移、函数保持的预处理工具。
---

## Abstract
Large language models (LLMs) require substantial compute, and thus energy, at inference time. While quantizing weights and activations is effective at improving efficiency, naive quantization of LLMs can significantly degrade performance due to large magnitude outliers. This paper describes FPTQuant, which introduces three novel, lightweight, and expressive function-preserving transforms (FPTs) to facilitate quantization of transformers: (1) a mergeable pre-RoPE transform for queries and keys, (2) a mergeable transform for values, (3) a cheap, dynamic scaling transform. By leveraging the equivariances and independencies inherent to canonical transformer operation, we designed these FPTs to maintain the model’s function while shaping the intermediate activation distributions to be more quantization friendly. FPTQuant requires no custom kernels and adds virtually no overhead during inference. The FPTs are trained both locally to reduce outliers, and end-to-end such that the outputs of the quantized and full-precision models match. FPTQuant enables static INT4 quantization with minimal overhead and shows SOTA speed-up of up to 3.9x over FP. Empirically, FPTQuant has an excellent accuracy-speed trade-off—it is performing on par or exceeding most prior work and only shows slightly lower accuracy compared to a method that is up to 29% slower.

---

## 论文详细总结（自动生成）

## 1. 核心问题与研究动机

- 大型语言模型（LLM）在推理阶段需要大量计算资源与能耗；权重-激活量化是提升推理效率的有效手段。
- 然而，LLM 中普遍存在的大幅值**激活离群点**会导致朴素量化方案的精度严重下降。
- 因此，FPTQuant 的目标是：在不改变模型功能的前提下，重塑中间激活分布，使其对量化（尤其静态 INT4 量化）更友好，从而兼顾精度与推理速度。这一思路避免了在量化后再进行复杂补偿或依赖额外运行时开销。

## 2. 方法论：FPTQuant

- **核心思想**：利用标准 Transformer 推理中固有的**等变性（equivariance）**与**独立性（independency）**结构，设计一组"保函数变换"（Function-Preserving Transforms, FPTs），使得变换后的模型输出与原始模型完全（或近似）一致，但同时使中间激活的离群程度降低，为后续低比特量化创造更好条件。
- 三个关键变换：
  1. **可合并的 Pre-RoPE Q/K 变换**：在旋转位置编码（RoPE）之前对查询（Q）和键（K）施加线性/仿射变换，该变换可以合并进后续参数矩阵，从而在推理时不引入额外计算。
  2. **可合并的 V 值变换**：对值（Value）施加类似的可合并变换，同样可合并到相邻层/投影参数中。
  3. **廉价动态缩放变换**：引入轻量的逐通道或逐 token 动态缩放机制，以进一步压制离群激活的动态范围。
- **训练方式**：
  - 局部训练（Local training）：以降低离群值为直接目标，单独训练变换参数；
  - 端到端训练（End-to-end training）：进一步优化，使量化模型与全精度模型输出对齐。
- **推理开销**：无需定制算子（custom kernels），变换可合并到现有参数中，推理时近乎零额外开销。

## 3. 实验设计

- 由于当前仅可获得论文摘要与元数据，正文实验细节（如具体数据集、任务类型、模型规模）未在提供内容中出现。
- 从摘要可以确认的信息包括：
  - **量化设置**：静态 INT4 量化；
  - **硬件/基准**：以 FP 全精度推理为基线进行加速比对比；
  - **对比方法**：与多数先前量化方法进行了准确率-速度权衡对比，其中包含一个比 FPTQuant 慢 29% 的 SOTA 方法（该方法精度略高）。
- 摘要未明确列出所用数据集，但鉴于该文被 ICML-2026 接收，通常实验会覆盖常见 LLM benchmark 集（如 WikiText、下游零样本任务等）——具体需阅读原文确认。

## 4. 资源与算力

- 提供的元数据和摘要中**未提及** GPU 型号、数量、训练时长、模型参数量范围等具体算力信息。
- 仅能确认：FPTQuant 的变换本身参数量极少，训练是"局部 + 端到端"结合，因此额外训练开销推测有限，但作者未给出定量说明。

## 5. 实验数量与充分性评估

- 可见的实验结论包括：
  - FPTQuant 在静态 INT4 下实现最高达 **3.9 倍于 FP 的加速比**；
  - 准确率与多数先前方法持平或更优；
  - 相比某一（更慢 29% 的）SOTA 方法，精度略低，但速度优势明显。
- 从摘要角度，实验覆盖了**精度**与**速度**两个核心维度，并有与 prior work 的横向对比；但缺少了数据集数量、模型规模、消融实验细节。
- 在材料有限的前提下，不能完全判断实验的充足性与公平性——但 FPTQuant 通过 ICML-2026 评审，且同时报告了正/反两方面结果（有方法比它精度高），说明对比相对诚实客观；完整评估仍需依赖全文。

## 6. 主要结论与发现

- FPTQuant 提出的三类保函数变换能够在**保持模型输出语义**的同时有效抑制激活离群值；
- 该机制可泛化地服务于不同 Transformer 架构的低比特量化；
- 使**静态 INT4 量化**成为可能，且几乎不增加延迟，实现了"精度-速度"上的 SOTA 权衡。

## 7. 优点与亮点

- **函数保持性**：变换不改模型功能，理论保障清晰，避免了为此引入较大的精度误差。
- **低成本、可部署**：无需自定义 kernel、变换可合并、推理开销趋近于零，实用性强。
- **组合性**：多个互补变换可叠加使用，比单一方案更灵活、表达力更强。
- **两阶段优化策略**（局部降离群 + 端到端对齐）兼顾了训练的稳定性和最终的量化性能。
- **对通用 Transformer 的泛化潜力**：由于设计依赖的是 Transformer 操作中的内在结构（如 RoPE 的旋转等变性、注意力输出中的独立投影），方法理论上可迁移至大多数主流 LLM 架构。

## 8. 不足与局限性

- **可获取信息有限**：基于当前摘要与元数据，无法核实数据集、模型覆盖范围等详细实验信息；论文的具体 benchmark 完备性需以全文为准。
- **精度并非全面最优**：摘要明确指出，FPTQuant 比某一方法（慢 29%）的精度略低，说明其在极低比特下与其他专用方法相比仍有微小性能差距。
- **动态缩放变换**虽"廉价"，但涉及动态操作时仍需实际硬件验证其与静态 INT4 流水线的兼容性。
- 未提供不同模型规模、不同量化位宽（如 2-bit/3-bit）以及更长上下文等场景的讨论，适用范围边界有待进一步明确；可合并变换对长序列训练/推理中 RoPE 位置信息的影响也值得深入评估。

---

（完）
