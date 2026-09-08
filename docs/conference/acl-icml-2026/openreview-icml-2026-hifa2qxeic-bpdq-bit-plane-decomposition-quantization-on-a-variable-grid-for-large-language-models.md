---
title: "BPDQ: Bit-Plane Decomposition Quantization on a Variable Grid for Large Language Models"
title_zh: BPDQ：可变网格上的位平面分解量化用于大语言模型
authors: "Junyu Chen, Jungang Li, Jing Xiong, Wenjie Wang, Qingyao Yang, He Xiao, Zhen Li, Taiqiang Wu, Mengzhao Chen, Zhen Peng, Chaofan Tao, Long Shi, Hongxia Yang, Ngai Wong"
date: 2026-04-30
pdf: "https://openreview.net/pdf/1dd5925af57c4c2dac081fc597dc929b6dcc35a2.pdf"
tags: ["query:wbv"]
score: 8.0
evidence: 直接针对2-3比特LLM量化退化，提出变网格位平面分解量化
tldr: PTQ在4比特表现良好，但降到2-3比特时因固定均匀量化网格限制误差最小化而严重退化。BPDQ使用位平面和标量系数构造可变量化网格，并通过二阶信息迭代修正和逐步误差补偿来逼近更优解。该方法在2-3比特超低位宽下可望提升大模型量化精度，为极低比特量化提供了新的网格设计思路。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 固定均匀量化网格严重限制2-3比特PTQ误差最小化的可行域，导致低比特性能退化。
method: 基于位平面和标量系数构造可变量化网格，结合二阶信息迭代细化并逐步补偿量化误差。
result: 在2-3比特下提供更灵活的网格表示，降低低比特量化误差。
conclusion: 为超低位宽LLM量化提供变网格误差最小化框架。
---

## Abstract
Large language model inference is often bounded by memory footprint and bandwidth in resource-constrained deployments, making quantization fundamental to efficient serving. 
While post-training quantization (PTQ) maintains high fidelity at 4-bit, it deteriorates at 2-3 bits. 
In essence, existing methods enforce a shape-invariant quantization grid (e.g., the fixed uniform intervals of UINT2) for each group, severely restricting the feasible set for error minimization. 
To address this, we propose Bit-Plane Decomposition Quantization (BPDQ), which constructs a variable quantization grid via bit-planes and scalar coefficients, and iteratively refines them using second-order information while progressively compensating for quantization errors to minimize output discrepancy.
In the 2-bit regime, BPDQ enables serving Qwen2.5-72B on a single RTX 3090 with 83.85\% GSM8K accuracy (vs. 90.83\% at 16-bit).
Moreover, we theoretically show that the variable grid expands the feasible set, and that the quantization process consistently aligns with the optimization objective in Hessian-induced geometry.
The code is available at github.com/KingdalfGoodman/BPDQ.

---

## 论文详细总结（自动生成）

# 论文详细中文总结

## 一、核心问题与整体含义

- **研究背景**：大语言模型（LLM）在资源受限设备上的推理常受内存占用和带宽瓶颈制约，量化是高效服务的基础技术。
- **核心问题**：虽然后训练量化（PTQ）在 4-bit 精度下能保持较高保真度，但当比特数降至 2–3 bit 时，模型性能显著退化。
- **问题根源**：现有方法对每个量化组施加“形状不变”的量化网格（如 UINT2 的固定均匀间隔），严重限制了误差最小化时的可行解域，导致无法在超低位宽下充分逼近最优量化。
- **整体意义**：论文提出了一种新的量化网格构造思路，旨在突破固定均匀网格对超低位宽 LLM 量化的性能约束，为极低比特量化部署提供可能。

## 二、论文提出的方法论

- **方法名称**：BPDQ（Bit-Plane Decomposition Quantization，位平面分解量化）。
- **核心思想**：不再使用固定均匀间隔的量化网格，而是通过**位平面（bit-planes）**与**标量系数（scalar coefficients）**来构造一个**可变量化网格（variable quantization grid）**，从而扩大误差最小化的可行域。
- **关键技术细节**：
  1. 将权重或激活分解为多个位平面，每个位平面由独立的标量系数控制幅度，组合后形成灵活的非均匀网格。
  2. 利用**二阶信息（Hessian）**对位平面和系数进行**迭代细化（iterative refinement）**。
  3. 逐步对量化误差进行**误差补偿（progressive compensation）**，以最小化模型输出差异。
- **理论分析**：
  - 证明可变网格比固定网格具有更大的可行解集合。
  - 证明该量化过程在**Hessian 诱导的几何空间**中与优化目标保持一致。

## 三、实验设计

> 注意：由于仅提供了摘要，完整实验细节（数据集列表、对比方法、具体配置）未在给定文本中展开，以下基于摘要中可见信息及常规推断进行总结。

- **实验场景**：LLM 超低位宽后训练量化（PTQ），重点考察 2-bit 和 3-bit 下的端到端任务性能。
- **Benchmark 示例**：GSM8K（数学推理任务）。
- **关键结果**：在 2-bit 量化下，BPDQ 可以在单张 RTX 3090 上部署 Qwen2.5-72B 模型，GSM8K 准确率达到 **83.85%**，与之对比 16-bit 全精度为 **90.83%**。
- **对比基线**：摘要中未明确列出具体对比方法，但隐含与现有 PTQ 方法（如固定均匀网格的 UINT2 量化）以及全精度模型进行对比。

## 四、资源与算力

- 摘要明确提到：**单张 RTX 3090**（24GB 显存）即可运行 2-bit 量化后的 Qwen2.5-72B。
- 未提及具体训练/量化耗时、GPU 数量、使用的分布式配置或计算总开销。
- 未提供与基线方法的算力对比（如是否在相同硬件环境、相同延迟下评测等）。

## 五、实验数量与充分性

- 摘要中仅展示了 GSM8K 一个数据集的示例结果，未列出多层任务（如常识推理、代码、多语言）、多种模型规模与架构、以及消融实验的完整清单。
- 理论上证明了可行域扩大和 Hessian 几何一致性等，但缺少对算法收敛行为、位平面数量/系数敏感度的实验支撑。
- **客观评价**：现有信息不足以全面判断实验的充分性与公平性。由于该文为 ICML-2026 接收论文，完整版本中可能包含更全面的实验，但当前给出的摘要文本缺少细节。

## 六、主要结论与发现

- 固定均匀量化网格是 2–3 bit 下 PTQ 性能退化的关键限制因素。
- 通过位平面分解与标量系数构造的**可变量化网格**可以扩大误差最小化的可行域，从而缓解超低位宽下的精度损失。
- 2-bit 量化下，BPDQ 能将 Qwen2.5-72B 部署于单卡 RTX 3090，并保持较高的 GSM8K 准确率，展示了实用价值。
- 理论上说明在 Hessian 诱导的几何下，BPDQ 的优化过程与量化目标对齐，提供了可解释性。

## 七、优点

- **思想创新**：直接挑战“固定均匀量化网格”这一默认假设，提出可变网格，为超低位宽量化提供新设计空间。
- **理论支撑**：不仅给出方法，还从可行域和 Hessian 几何角度提供理论分析，增加了方法可信度。
- **实用性**：2-bit 下将 72B 模型部署到单张 RTX 3090 上，显著降低显存需求，对资源受限场景有直接价值。
- **问题针对性**：明确针对 2–3 bit 这一 PTQ 方法退化严重的区间，而非重复 4-bit 已有成果。

## 八、不足与局限

- **实验可见性不足**：摘要中仅报告了 GSM8K 单一指标，缺乏对多任务、多模型家族、多语言/代码数据集的系统评测。
- **对比基线不明确**：未列出与现有强基线（如 GPTQ、AWQ、OmniQuant、QuIP# 等）的定量对比，难以判断相对优势。
- **资源报告缺失**：未给出具体量化时间、额外计算开销、迭代次数、收敛条件等，无法评估运行效率。
- **硬件覆盖有限**：仅演示了 RTX 3090，未覆盖其他 GPU 架构或 CPU/边缘设备。
- **潜在局限**：位平面分解配合变网格可能增加量化过程的计算成本；对 Hessian 二阶信息的依赖在大模型上的近似误差与计算开销需进一步说明（原文未展开）。
- **信息完整性**：本文提供的文本仅为摘要级，所有对方法细节、实验充分性的判断均受限于此。

（完）
