---
title: "TileQ: Efficient Low-Rank Quantization of Mixture-of-Experts with 2D Tiling"
title_zh: TileQ：基于二维分块的 MoE 高效低秩量化
authors: "Hongyaoxing Gu, Xinzhe Chen, Lijuan Hu, Liu fangfang"
date: 2026-04-30
pdf: "https://openreview.net/pdf/490a88a84bc940365f24a2e699c7d4d35bb1dfe4.pdf"
tags: ["query:moe-quant"]
score: 9.0
evidence: 二维分块低秩量化 MoE 专家，且免微调，直接命中 MoE 量化
tldr: MoE 模型通过稀疏激活专家获得高性能，但专家参数体积庞大，给部署带来压力；低秩量化虽有前景，原有方法仍留下可观内存和延迟开销。TileQ 提出免微调后训练量化法，利用二维分块结构使低秩因子在专家输入、输出两个方向共享，并在此基础上设计一次性融合多专家低秩计算的推理算子。实验显示该方法显著压缩 MoE 低秩量化的存储和推理成本。该工作为 MoE 模型的低秩高效部署提供了易用、免训练的解决方案。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: MoE 专家参数庞大，现有低秩量化仍遗留明显的显存与推理时延开销。
method: TileQ 用二维分块结构在专家输入/输出维共享低秩因子，并设计多专家单趟融合算子。
result: 免微调即可显著压缩 MoE 存储和推理成本，适合部署。
conclusion: 显示结构化低秩共享与算子融合能有效降低 MoE 低秩量化部署开销。
---

## Abstract
Mixture-of-Experts (MoE) models achieve remarkable performance by sparsely activating specialized experts, yet their massive parameters in experts pose significant challenges for deployment. While low-rank quantization offers a promising route to compress MoE models, existing methods still incur nonnegligible memory overhead and inference latency. To address these limitations, we propose TileQ, a fine-tuning-free post-training quantization (PTQ) method that employs 2D-tiling structured low-rank quantization to share low-rank factors across both input and output dimensions of MoE experts. Furthermore, we introduce an efficient inference technique for TileQ that fuses multiple low-rank expert computations into a single-pass operation, significantly improving hardware utilization. Experiments show that TileQ cuts down additional memory usage up to 10x and reduces inference latency to 5% while preserving state-of-the-art accuracy.

---

## 论文详细总结（自动生成）

好的，我明白了。你在上一轮中请求分析论文 `TileQ: Efficient Low-Rank Quantization of Mixture-of-Experts with 2D Tiling`，但我提供的文本实际上是 OpenReview 的浏览器验证页面（CAPTCHA），并且其中包含的“论文 Markdown 元数据”部分已经是对论文的中文整理摘要——里面包含的 `method`、`result`、`conclusion` 等信息非常简略，并不包含完整论文的正文、实验细节等内容。

基于这一情况，我无法针对“完整论文”进行详细的综述总结，只能基于我目前已经掌握的有限内容，在尽可能不编造的前提下给出一个**基于该元数据信息的推断性总结**，同时明确标注哪些内容是原文确证、哪些内容是合理的推断。

请你确认：如果你有这篇论文的完整 PDF 或详细的文本内容，请发送给我，我可以给出更充分的总结。否则，我将按以下方式撰写一个**基于现有信息的结构性叙述**：

---

# TileQ 论文简要总结（基于现有信息）

## 1. 论文的核心问题与整体含义（研究动机和背景）

- Mixture-of-Experts (MoE) 模型通过稀疏激活不同专家（expert）的方式在保持较低计算成本的同时大幅提升模型容量和性能，是目前大规模语言模型的主流架构之一。
- 然而，MoE 的专家总数通常非常庞大，导致其**总显存占用极大**，部署困难。
- 低秩量化（Low-rank Quantization）被视为压缩 MoE 模型的一种可行路径，它可以同时利用量化（节省位宽）和低秩近似（压缩参数维度）来降低存储。
- 但作者指出，**现有的 MoE 低秩量化方法仍然存在不小的额外内存开销和推理时延**。

> 整体含义：这篇论文要解决的核心问题是 **如何进一步压低 MoE 模型低秩量化后的显存占用与推理延迟**，目标是实现更轻量、更高效的 MoE 部署。

## 2. 论文提出的方法论：核心思想与关键技术细节

- **方法名称**：TileQ
- **方法类型**：免微调的后训练量化方法（fine-tuning-free post-training quantization，即 PTQ）
- **核心思想**：采用 **二维分块（2D Tiling）结构化低秩量化** 方式，在 MoE 专家的**输入维度和输出维度**两个方向上共享低秩因子。
- 这样做的好处是可以**突破传统低秩量化只在一个方向上压缩的局限**，使压缩后的表示更紧凑、结构化程度更高。
- 此外，论文还提出了一个为 TileQ 定制的 **推理算子**：可将多个专家的低秩计算**融合成一次单趟（single-pass）操作**，从而显著提升 GPU 等硬件的利用率，降低推理时延。

## 3. 实验设计（基于现有信息的推断）

> ⚠️ 注意：因缺少完整论文文本，以下关于实验设计的表述大部分属于**合理推断**，而非论文原文的直接事实。

根据元数据中的 `result` 与 `evidence` 描述可以知道：

- **场景**：MoE 模型的部署评测（可能涉及语言建模、常识推理、问答等常见 benchmark，如 WikiText、MMLU、GSM8K 等）。
- **对比方法**：应与现有最先进的 MoE 压缩或低秩量化方法（例如 QuaMoE、MoE-Quant、LoRA 结合量化等）进行对比。
- **核心评价指标**：额外内存占用、推理延迟、精度保持（zero-shot 或其他任务精度）三类指标。

## 4. 资源与算力

- 在目前掌握的文本中，**没有明确说明具体的 GPU 型号、数量或训练时长**。
- 但考虑到这是一种 **PTQ（免训练）** 方法，可以推断其**不需要大规模计算资源来重训模型**，主要成本在于校准集上的量化参数求解和推理性能测试。
- 这一点需要在原始论文中进一步确认。

## 5. 实验数量与充分性

- 现有信息中未列出具体的实验组数、数据集数量、模型规模（如 Mixtral-8x7B、DeepSeek-MoE）或消融实验设置。
- 但根据 "state-of-the-art accuracy" 的描述，合理的推测是：
  - 在多个任务上验证了 **精度保持**；
  - 做了关于 **内存压缩倍数** 和 **推理延迟降低比例** 的测试；
  - 可能包含与现有方法的对比实验。
- **充分性尚无法客观判断**，需要参考论文原文的完整实验章节。

## 6. 论文的主要结论

- TileQ 可以**在不进行微调的前提下**实现显著的存储与推理开销降低：
  - **额外内存使用降低最多可达 10 倍**；
  - **推理延迟可降低到原始方法的 5%（即减少至约 1/20）**；
  - 同时仍能保持**最先进的模型精度（state-of-the-art accuracy）**。
- 结论：**结构化低秩共享（2D tiling）+ 算子融合** 是进一步压缩 MoE 部署成本的有效方向。

## 7. 优点

- **免微调**：无需对模型进行额外的梯度训练或微调，可以直接应用在训练好的开放模型上，部署友好。
- **结构化程度高**：在输入/输出二维方向上同时共享低秩因子，具备更高的参数共享效率。
- **推理优化针对性强**：不只关注压缩率，还专门设计了适合 GPU 的融合算子，能够实际降低延迟，具备较强的工程价值。
- **效率指标突出**：在存储与延迟两个维度上都展示了数量级级别的改善。

## 8. 不足与局限（基于现有信息的推测）

- **实验细节不足**：由于手头仅有摘要和少量元数据，无法辨别其应用于多大规模 MoE（如 7B、8x7B、MoE-170B 等）时的表现。
- **PTQ 的固有局限**：免微调的方式通常对权重分布敏感，在小规模校准集或极端低比特（如 2-bit / 1-bit）下精度保持能力可能受限。
- **硬件依赖**：单趟融合推理算子可能依赖于特定的 GPU 架构或底层 Kernel 优化，跨硬件平台（如 CPU、移动端、NPU）的迁移性未知。
- **可能缺乏对“稀疏路由 + 超大规模专家数”的系统消融分析**，例如专家数量增加时低秩因子共享是否仍然高效等。
- **未见关于实际算子落地性能（如 kernel 时间拆解、显存带宽瓶颈分析）的详细展示**。

## 结语

TileQ 是一项极具实用导向性的 MoE 模型压缩工作，其主要贡献在于：结合 **2D 结构化低秩共享** 与 **多专家一次单趟计算的融合算子**，在免微调的前提下大幅降低了 MoE 低秩量化的部署成本。但由于目前未能获取论文全文，许多实验细节和结论需以原文为准。

（完）
