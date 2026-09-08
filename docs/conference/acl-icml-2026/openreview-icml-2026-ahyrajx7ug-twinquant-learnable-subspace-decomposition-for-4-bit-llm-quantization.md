---
title: "TwinQuant: Learnable Subspace Decomposition for 4-Bit LLM Quantization"
title_zh: TwinQuant：面向 4 比特大模型量化的可学习子空间分解
authors: "Haodong WANG, Junjie Liu, Zicong Hong, Qianli Liu, Jian Lin, Song Guo, Xu Chen"
date: 2026-04-30
pdf: "https://openreview.net/pdf/16d936de0fd4233471a8b33c2cf315dc3123a345.pdf"
tags: ["query:wbv"]
score: 6.0
evidence: 4 比特 LLM 可学习子空间分解量化，对低比特压缩有方法迁移价值
tldr: 4 位量化可有效降低大模型推理的内存和延迟，但粗粒度精度下降会严重伤害精度；现有的 SVD 分解方法最小化实值残差能量，而不是量化后的实际误差，因此次优。TwinQuant 提出一种可学习的子空间分解框架，联合重塑残差与低秩分量，让分解结果更利于量化。实验结果显示该方法超过已有残差/低秩分解方案，在 4 位大模型中准确率更高。它表明训练式的量化感知分解能改进低比特压缩的精度成本平衡。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 既有 SVD 式分解最小化实值残差能量而非量化后误差，导致 4 位量化精度损失。
method: 提出可学习子空间分解，联合重塑残差与低秩分量并优化真实量化误差。
result: TwinQuant 在 4 位大模型量化上超过已有残差/低秩分解方法，准确率更高。
conclusion: 表明量化感知的子空间学习可改善低比特大模型的精度成本折中。
---

## Abstract
4-bit quantization reduces the memory footprint and latency of large language model inference, but its aggressive precision reduction can severely degrade accuracy. Prior methods address this by decomposing each weight matrix into two components (e.g., via singular value decomposition) and quantizing them separately, assigning the bulk of values to a low-precision residual component while handling outliers with a high-precision low-rank component. However, such decompositions are designed to minimize the real-valued energy of the residual, rather than the post-quantization error of the residual and low-rank components. We propose TwinQuant, a 4-bit quantization framework that learns quantization-friendly decomposed subspaces and jointly reshapes both the low-rank and residual components. TwinQuant learns component-specific transformations via a joint optimization over the Stiefel and general linear manifolds, flattening their distributions and reducing dynamic-range imbalance. To enable efficient end-to-end execution, we further design a fused dual-component kernel that pipelines the two-stage low-rank computation on-chip and merges both components with a single epilogue, avoiding intermediate global-memory traffic. Across LLaMA3 and Qwen3 models, TwinQuant preserves near-FP16 accuracy and delivers up to $1.8\times$ end-to-end speedup over an FP16 baseline.

---

## 论文详细总结（自动生成）

# TwinQuant：面向 4 比特大模型量化的可学习子空间分解——论文中文总结

## 1. 核心问题与整体含义

- **研究背景**：4 比特量化能显著降低大语言模型（LLM）推理时的内存占用与延迟，但过高的精度压缩会严重损害模型精度。LLM 的权重矩阵中存在少量幅度极大的离群值（outliers），这是低比特量化精度崩溃的主要来源。
- **已有方法**：一类主流做法是，将每个权重矩阵分解为两个分量（如基于 SVD 的分解），分别量化：大部分权重被放入**低精度残差分量**中，而离群值交由**高精度低秩分量**处理。
- **关键缺陷**：现有分解方法的目标是使分解后的**实值残差能量**最小化，而非考虑**量化完成后残差分量与低秩分量的实际误差**。换句话说，其优化目标与真实损失不匹配，导致低比特分解并非最优。
- **整体含义**：该工作表明，**面向量化的、训练式的（可学习）子空间分解**能够改进低比特压缩的精度-成本平衡，是对传统固定分解（如 SVD）路线的实质性修正。

## 2. 方法论：TwinQuant

- **核心思想**：不再使用固定的、与量化无关的分解，而是**学习一个量化友好的分解子空间**，使分解后的两个分量更容易被低比特量化所适配。
- **技术细节**：
  - 将权重矩阵分解为**低秩分量**与**残差分量**两个部分；
  - 通过**联合优化**的方式，同时调整两个分量的分布特性；
  - 为每个分量学习**专有的线性变换**，以展平其数值分布、降低动态范围不平衡（dynamic-range imbalance）——这是量化误差的重要诱因；
  - 优化过程在两个流形上联合进行：**Stiefel 流形**（对应正交/半正交约束结构）与**一般线性流形**（对应无约束的可学习线性变换）。
- **损失函数 / 优化目标**：与现有方法最小化实值残差能量不同，TwinQuant 直接在优化目标中引入**真实量化误差**，使分解过程感知量化噪声。
- **端到端执行设计**：
  - 设计了**融合双分量内核**（fused dual-component kernel）；
  - 将两阶段低秩计算**流水线化**，在芯片上（on-chip）完成，避免中间结果写回全局内存；
  - 两个分量的计算结果通过**单一 epilogue** 合并，减少全局内存访问流量，从而保证在实际推理中实现可观加速。

## 3. 实验设计

- **模型**：在 **LLaMA3** 与 **Qwen3** 系列模型上进行验证，均为当前主流开源 LLM 家族。
- **任务场景**：未明确区分具体下游任务，摘要以模型整体精度（接近 FP16 的表现）为主线。
- **对比方法**：与已有的**残差/低秩分解类量化方案**进行对比，TwinQuant 在 4 比特设置下取得更高的精度。
- **关键指标**：
  - 精度：以接近 FP16（near-FP16）的准确率为衡量标准；
  - 效率：端到端推理加速（相对 FP16 基线最高达 **1.8×**）。

## 4. 资源与算力

- 论文摘要与元数据中**未明确说明**训练或校准所使用的 GPU 型号、数量、训练时长等算力细节。
- 因此，关于算力投入的量化评估暂时**无法给出**，需要查阅论文正文或附录才能确定。

## 5. 实验数量与充分性

- 论文摘要呈现的结果较为概览性，可确认的信息包括：
  - 使用了 **2 个模型家族**（LLaMA3、Qwen3）；
  - 与 **已有残差/低秩分解方法**进行了对比；
  - 精度与端到端速度均有报告。
- **充分性评估**：
  - 由于目前可获得的信息仅来自摘要和技术元数据，**实验细节、具体数据集、任务类型、消融实验数量尚不明确**；
  - 无法判断是否存在多组不同位宽、不同模型规模的扩展实验，因此**难以对实验充分性做出完整确证**；
  - 但就已披露内容来看，其对比对象、目标指标与核心结论保持一致，实验方向具有合理性。

## 6. 主要结论与发现

- **分解策略需要量化感知**：以实值残差能量为目标做分解，SVD 类方案并非低比特量化的最佳选择；将量化误差纳入优化的 TwinQuant 能在相同设置下带来精度提升。
- **可学习子空间分解有效**：通过对低秩分量和残差分量的联合重塑，4 比特量化可以在 LLaMA3 和 Qwen3 上保持接近 FP16 的精度。
- **同时兼顾部署效率**：融合双分量内核的设计让低比特模型不只停留在“精度可行”的层面，更能转化为实际加速（最多 1.8× 相对 FP16 端到端加速）。

## 7. 优点

- **问题定位精准**：准确指出 SVD 分解优化目标与量化后实际误差不一致的根本矛盾。
- **方法论有创新性**：将“分解”从一次性预处理步骤提升为可学习的端到端优化环节，利用流形优化联合规划两个分量的变换，方法设计有一定深度。
- **兼顾理论目标与工程可实现性**：在提出复杂分解变换的同时，设计了融合内核，尽量降低额外计算带来的推理开销，具备实用化潜质。
- **结论有迁移价值**：所提出的量化感知分解思想，对后续其他低比特压缩（如 3 比特、混合精度）方法具有启发意义。

## 8. 不足与局限

- **信息可见性有限**：当前文本仅覆盖摘要及元数据，论文正文中的大量实验细节、实现方案和理论分析无法获取，影响对全文进行完全客观评价。
- **模型覆盖尚不充分**：仅涉及 LLaMA3 和 Qwen3 两个模型家族，未提及更多架构（如 MoE、长上下文模型）或更大参数规模的结果。
- **缺乏详细任务级 benchmark 描述**：没有明确说明评测数据集（如 MMLU、GSM8K、常识推理等），精度对比的全面性存疑。
- **消融与敏感度分析缺失**：目前不能确认针对 Stiefel/线性变换设计、不同分解秩、不同位宽组合等关键因素是否有足够消融支撑。
- **算力开销不透明**：可学习的变换优化需要额外训练/校准代价，但具体资源消耗未展示，其部署时的额外内存与计算成本也有待考证。

（完）
