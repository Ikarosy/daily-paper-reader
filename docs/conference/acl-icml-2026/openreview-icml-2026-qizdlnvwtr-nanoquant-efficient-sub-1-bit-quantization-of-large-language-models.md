---
title: "NanoQuant: Efficient Sub-1-Bit Quantization of Large Language Models"
title_zh: NanoQuant：大型语言模型的高效亚1比特量化
authors: "Hyochan Chong, Dongkyu Kim, Changdong Kim, Minseop Choi"
date: 2026-04-30
pdf: "https://openreview.net/pdf/c5df747263f5d256ee156e20438943db11965c35.pdf"
tags: ["query:wbv"]
score: 4.0
evidence: 通过低秩二元分解把LLM权重量化到二值/亚1比特，属于极低比特范畴但并非VQ/SQ码本方法的直接工作
tldr: 将大模型权重量化到1比特及以下时，现有方法要么依赖大量校准数据与较高计算，要么引入额外存储。NanoQuant给出一个后训练方案，把量化写成低秩二元矩阵分解问题，通过ADMM高效求解二元矩阵和尺度的初值，再对参数微调。实验表明NanoQuant能在二值和亚1比特权重量化上取得更好的精度与存储折中。这种低秩分解思路可被极低比特VQ或SQ方案吸收，进一步压缩LLM服务成本。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 现有大模型权重量化难以高效压缩到二值或亚1比特，既需要大量数据和计算，又可能引入额外存储开销。
method: 将量化问题构造成低秩二元矩阵分解任务，采用ADMM高效初始化低秩二元矩阵与尺度，再做参数微调。
result: 在大模型上实现了二值和亚1比特后训练量化的先进精度-压缩率结果，且不依赖大量校准数据或额外存储。
conclusion: 低秩二值分解为极低比特权重量化提供了高效且内存友好的新范式，可启发更复杂的VQ/SQ码本设计。
---

## Abstract
Weight-only quantization has become a standard approach for efficiently serving large language models (LLMs). However, existing methods fail to efficiently compress models to binary (1-bit) levels, as they either require large amounts of data and compute or incur additional storage. In this work, we propose NanoQuant, a post-training quantization (PTQ) method to compress LLMs to both binary and sub-1-bit levels. NanoQuant formulates quantization as a low-rank binary factorization problem, and compresses full-precision weights to low-rank binary matrices and scales. Specifically, it utilizes an efficient alternating direction method of multipliers (ADMM) solver to precisely initialize latent binary matrices and scales, and then tunes the initialized parameters through a block and model reconstruction process. Consequently, NanoQuant establishes a new Pareto frontier in low-memory post-training quantization, and enables sub-1-bit compression. NanoQuant makes large-scale deployment feasible on consumer hardware. For example, it compresses Llama-2-70B by 24$\times$ in just 13 hours on a single H100, enabling a 70B model to operate on a consumer 8 GB GPU.

---

## 论文详细总结（自动生成）

> **说明**：本次分析所依据的原始材料仅包含该论文的题录信息、元数据与摘要，未获取完整正文。因此，下述总结以现有信息为基础，部分实验细节（如具体数据集、对比方法、消融组数等）无法从已有材料中核实，特此指出。

## NanoQuant：大型语言模型的高效亚1比特量化

### 1. 核心问题与整体含义（研究动机与背景）

- **研究背景**：权重量化（weight-only quantization）已成为高效部署大型语言模型（LLM）的标准技术之一，其目标是在保持模型性能的前提下减少显存占用和推理成本。
- **核心问题**：尽管量化方法众多，现有技术在将模型压缩到**二值（1-bit）甚至低于1比特**的极限水平时效率低下——要么依赖**大量校准数据和高昂计算成本**，要么带来**额外的存储开销**，使得极低比特量化难以实用化。
- **整体意义**：若能在极低比特下实现高效、高精度的量化，将极大降低LLM的部署门槛，甚至让百亿级模型在消费级硬件上运行。NanoQuant正是面向这一目标提出的后训练量化（PTQ）方案。

### 2. 方法论：核心思想与技术细节

- **核心思想**：将量化问题重新形式化为**低秩二元矩阵分解**（low-rank binary factorization）问题，将全精度权重分解为低秩二元矩阵与尺度因子的组合，从而同时实现极端压缩与较好的精度保持。
- **技术流程**：
  1. **问题构造**：把权重压缩建模为低秩二元分解任务——用若干二元矩阵（元素为+1/-1）与对应尺度（scales）的乘积近似原权重矩阵。
  2. **ADMM求解器初始化**：提出一种高效的**交替方向乘子法（Alternating Direction Method of Multipliers, ADMM）** 求解器，用于精确地初始化潜在的二元矩阵和尺度参数，避免随机初始化带来的不稳定性。
  3. **块级重建与模型级调优**：在完成初始化后，通过**逐块（block-wise）重建**和**整体模型（model-level）重建**两个阶段对参数进行微调，进一步恢复量化带来的精度损失。
- **方法定位**：该方法属于后训练量化（PTQ），不需要从零训练或大规模重新训练，计算开销远小于量化感知训练（QAT）。

### 3. 实验设计

- **实验场景**：摘要中提及模型为 Llama-2-70B，显示方法在大规模LLM上做了验证；覆盖**二值（binary）** 与**亚1比特（sub-1-bit）** 两种量化级别。
- **Benchmark与数据集**：由于缺少完整原文，本文无法确认具体使用的下游任务基准（如困惑度、常识推理、MMLU 等）与校准数据集；需以论文正式版为准。
- **对比方法**：摘要未明确列出对比基线。元数据提示该工作并非基于向量量化（VQ）或标量量化（SQ）码本方法的直接延续，因此其对比对象可能包括其他极低比特PTQ方法，但具体清单无从核实。

### 4. 资源与算力

- **训练硬件**：文中明确提到了**单个 NVIDIA H100 GPU**。
- **压缩效率**：以 Llama-2-70B 为例，NanoQuant 在 **13 小时**内完成对该模型的压缩（推测为单卡 H100 上的总耗时），实现了**24× 压缩比**。
- **推理部署条件**：经压缩后，70B 模型可运行在**8GB 显存的消费级 GPU** 上。
- 需要注意的是，关于其他实验（如不同规模模型、消融研究）所需的算力总规模，现有材料未给出。

### 5. 实验数量与充分性

- **可确认的实验信息有限**：摘要仅明确提及 Llama-2-70B 上的端到端压缩验证。由于未提供完整正文，无法获知具体实验组数。
- **已知的分析维度**：
  - 方法涉及**二值**与**亚1比特**两种量化设置，暗示至少存在两组不同比特宽度的对照；
  - 算法设计了"初始化+块重建+模型重建"的流程，合理推测作者对每个组件的贡献做了消融分析，但现有材料中无法确认是否确实执行了系统性的消融实验。
- **总体评估**：从已有信息无法对实验充分性、公平性（如随机种子、校准数据量是否与基线一致等）做出可靠判断，该部分需结合完整论文进一步审核。

### 6. 主要结论与发现

- NanoQuant 在**低内存后训练量化**领域建立了新的 **Pareto 前沿**，即在压缩率与模型精度之间取得了优于现有方法的折中。
- 该方法成功实现了**亚1比特压缩**，突破了传统1比特量化的下限。
- 量化过程**不依赖大量校准数据**，也不引入**额外存储开销**，具备较好的实用性与内存友好性。
- 极端压缩效果展示：Llama-2-70B 经 13 小时压缩后在 8GB 消费级 GPU 上即可运行，验证了方法在大规模LLM上的工程可行性。

### 7. 优点与亮点

- **方法创新性强**：将权重量化与低秩二元分解结合，并用ADMM进行有效的初始化求解，在方法论上为极低比特量化提供了新思路。
- **效率与精度兼顾**：作为PTQ方法，相比于需要大量数据和算力的方案，NanoQuant在成本和效果之间表现出较优的平衡。
- **真正的亚1比特压缩**：多数量化工作停留在4-bit或2-bit，NanoQuant真正进入sub-1-bit领域，技术突破意义明显。
- **部署价值突出**：实现了24×压缩、消费级显卡运行70B模型，这一结果具有很强的工程落地说服力。
- **无额外存储开销**：现有某些极低比特方法依赖额外的码本或查找表，NanoQuant的设计避免了这一问题，提升了方法在不同硬件上的通用性。

### 8. 不足与局限

- **信息透明度受限**：根据现有摘要与元数据，无法完整验证其在各类任务（特别是复杂推理与多语言任务）上的泛化性能，需补充更多下游评测细节。
- **论文定位的适用范围有待明确**：元数据指出该方法并非VQ/SQ码本类方法的直接工作，但其低秩二元分解方案的性能上限是否受限于权重分布（例如对高精度敏感的小规模模型），需要原文进一步说明。
- **缺乏与主流强基线的系统对比**：未在可用材料中看到与 GPTQ、AWQ、QuIP#、BiLLM 等既有方法的实验对照表，公平性评估不完整。
- **部署评测维度单一**：摘要仅报告了显存占用，未提及吞吐量、延迟、功耗等推理效率指标。
- **硬件验证局限**：仅在 H100 上演示压缩耗时，未提供在不同 GPU（如 A100、消费级硬件）上的可扩展性数据。

（完）
