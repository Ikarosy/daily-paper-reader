---
title: "ECO: Quantized Training without Full-Precision Master Weights"
title_zh: ECO：无全精度主权重的量化训练
authors: "Mahdi Nikdan, Amir Zandieh, Dan Alistarh, Vahab Mirrokni"
date: 2026-04-30
pdf: "https://openreview.net/pdf/3954f06cbb4a2080139c90408a409f051f0848e9.pdf"
tags: ["query:moe-quant"]
score: 8.0
evidence: 面向稀疏 MoE 的无主权重量化训练，属于 MoE 量化主题的组成部分
tldr: 量化训练虽能提高 LLM 训练效率，但现有方法仍依赖高精度主权重缓冲来累积更新，尤其在稀疏 MoE 模型中参数与优化器状态占用内存极大。ECO 错误补偿优化器直接对量化参数施加更新，去掉全精度主权重：每步量化权重并将量化误差注入优化器动量以维持收敛。实验结果说明 ECO 可以在无主权重条件下稳定训练量化模型并显著降低内存。该思路为 SMoE 的低内存量化训练提供了新方案。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 全精度主权重在 SMoE 量化训练中带来巨大内存开销，尤其参数与优化状态占内存。
method: ECO 直接对量化权重更新，每步将量化误差注入优化器动量以替代主权重补偿。
result: 无需高精度主权重仍可稳定训练量化 SMoE 模型，显著降低内存占用。
conclusion: 证明误差补偿优化器可支撑无主权重的稀疏 MoE 量化训练范式。
---

## Abstract
Quantization has significantly improved the compute and memory efficiency of Large Language Model (LLM) training. However, existing approaches still rely on accumulating their updates in high-precision: concretely, gradient updates must be applied to a high-precision weight buffer, known as $\textit{master weights}$. This buffer introduces substantial memory overhead, particularly for Sparse Mixture of Experts (SMoE) models, where model parameters and optimizer states dominate memory usage. To address this, we introduce the Error-Compensating Optimizer (ECO), which eliminates master weights by applying updates directly to quantized parameters. ECO quantizes weights after each step and carefully injects the resulting quantization error into the optimizer momentum, forming an error-feedback loop with no additional memory. We prove that, under standard assumptions and a decaying learning rate, ECO converges to a constant-radius neighborhood of the optimum, while naive master-weight removal can incur an error that is inversely proportional to the learning rate. We show empirical results for pretraining small Transformers (30--800M), a Gemma-3 1B model, and a 2.1B parameter Sparse MoE model with FP8 quantization, and fine-tuning DeepSeek-MoE-16B in INT4 precision. Throughout, ECO matches baselines with master weights up to near-lossless accuracy, significantly shifting the static memory vs validation loss Pareto frontier.

---

## 论文详细总结（自动生成）

# ECO：无全精度主权重的量化训练——论文总结

## 1. 核心问题与整体含义

- **研究动机**：量化技术能显著提升大语言模型（LLM）训练的算力与内存效率，但现有量化训练方法仍然依赖一个**高精度主权重缓冲区（master weights）**，用来累积每次梯度更新。该缓冲区在参数规模巨大、优化器状态占主导的**稀疏混合专家模型（SMoE）**中引入了显著的内存开销，成为训练效率的瓶颈。
- **核心问题**：能否在**完全不使用全精度主权重**的前提下，对量化参数直接执行更新，同时保持模型收敛并达到与有主权重的基线相当的精度？
- **整体含义**：若该问题得到解决，将极大降低量化训练的内存占用，尤其有利于 SMoE 这类大参数模型的训练与微调，进一步推动低内存、大规模 LLM 训练的实用化。

## 2. 方法论：ECO（Error-Compensating Optimizer，误差补偿优化器）

- **核心思想**：摒弃传统“高精度主权重 → 更新 → 再量化”的流程，改为**将优化器更新直接施加到量化参数上**。每一步对权重进行量化，并把量化误差**反馈注入优化器的动量项**，形成一种**无需额外内存的误差反馈回路（error-feedback loop）**。
- **关键技术细节**：
  - 每步训练后，将当前权重量化到低精度（如 FP8、INT4），记录量化前后的误差。
  - 该误差不是被丢弃，而是被“记住”——被注入到优化器的动量/状态中，从而在下一次更新时对累积的量化误差进行补偿。
  - 通过这种方式，即使没有全精度主权重持续保真地累积更新，误差信息也不会丢失，优化过程仍能稳定收敛。
- **理论保证**：
  - 论文证明了，在**标准假设**和**衰减学习率**下，ECO 能够收敛到最优解附近的**常数半径邻域**。
  - 对比之下，若**朴素地移除主权重**，所产生的误差会与学习率成反比，可能导致发散或严重不收敛。这一对比从理论上说明了 ECO 的误差补偿机制是不可或缺的。

## 3. 实验设计

- **训练场景与模型规模**：
  - 预训练小型 Transformer，参数量范围 **30M 到 800M**。
  - 预训练 **Gemma-3 1B** 模型。
  - 预训练 **2.1B 参数的稀疏 MoE 模型**，采用 **FP8** 量化。
  - 微调 **DeepSeek-MoE-16B** 模型，采用 **INT4** 精度。
- **基准与对比**：
  - 对比对象是使用全精度主权重的传统量化训练基线。
  - 评估指标为静态内存大小与验证损失（validation loss）之间的 **Pareto 前沿**，说明 ECO 在同等验证损失下能节省内存，或在同等内存下取得更低验证损失。
- **Benchmark 特点**：覆盖了从密集小模型到大规模稀疏 MoE，从预训练到微调，从 FP8 到 INT4 多种低精度设置，能检验方法在不同规模、架构和精度下的普适性。

## 4. 资源与算力

- 论文摘要和提供的元数据中**未明确报告 GPU 型号、数量、训练时长等具体算力信息**。
- 仅能推断实验涉及 30M–800M 密集模型、1B Gemma、2.1B SMoE 和 16B MoE 微调，训练总计算量较大，但具体硬件配置无从得知。

## 5. 实验数量与充分性

- **实验组数**：摘要中明确列出了 3 类预训练（小 Transformer 系列、Gemma-3 1B、2.1B SMoE）和 1 类微调（DeepSeek-MoE-16B），共 4 大类实验场景。
- **充分性分析**：
  - **优点**：覆盖了不同规模、不同架构（密集与 MoE）、不同精度（FP8 与 INT4）、不同任务（预训练与微调），整体覆盖面较广，能增强结论的普适性。
  - **局限**：由于仅提供摘要，**无法获知每类实验的详细设置、重复次数、消融实验数量**。例如，是否对误差注入强度、动量系数、不同量化粒度做了敏感性分析未知。
  - **公平性判断**：从摘要描述看，ECO 与有主权重基线对比验证损失和内存，属于直接替换关键组件的对照。但缺少对基线调优程度、超参数预算、计算量匹配等细节的说明，因此无法完全确认对比的公平性。

## 6. 主要结论与发现

- ECO 可以在**完全不使用全精度主权重**的情况下完成量化训练，并达到与使用主权重的基线**接近无损（near-lossless）**的精度。
- ECO 显著降低静态内存占用，并在“内存 vs 验证损失”的 Pareto 前沿上取得明显改进。
- 理论分析表明：无主权重时，简单的移除会让误差随学习率减小而增大，而 ECO 的误差补偿保证了稳定的收敛性质。
- 实证结果在从 30M 到 16B 的多种模型（包括 SMoE）和多种低精度格式下验证了 ECO 的有效性。

## 7. 优点

- **内存节省显著**：直接消除全精度主权重缓冲区，在 SMoE 这类优化器状态与参数占内存主导的模型上收益巨大。
- **设计简洁且无需额外内存**：误差反馈机制复用优化器的动量项，不引入额外的缓冲结构，改动工程上易于实现。
- **理论严谨**：不仅给出经验结果，还分析了无主权重时朴素方法的误差上界，并证明了 ECO 的收敛半径，研究思路完整。
- **覆盖面广**：实验横跨 30M–16B 参数、FP8/INT4 精度、预训练/微调，验证了方法的普适性。
- **贴合实际场景**：以存储内存与验证损失的 Pareto 关系作为衡量标准，具有实际工程价值。

## 8. 不足与局限

- **实验细节缺失**：论文正文信息不足，无法评估所有实验的具体超参数、训练步数、重复次数及方差，难以判断结果的稳健性。
- **未报告算力与时间成本**：没有说明训练所使用的 GPU 类型、数量、总耗时，不利于评估该方法在实际部署中的总体代价。
- **量化精度范围有限**：摘要仅报告 FP8 和 INT4，未涉及更低位宽（如 INT2、INT3）或其他量化格式（如 NF4、INT8），对极限量化下的表现未知。
- **理论假设与真实训练的差距**：收敛保证基于“标准假设和衰减学习率”，实际 LLM 训练中优化器、调度器、混合精度等复杂因素可能使理论边界不完全适用。
- **应用范围限制**：结果主要针对语言模型预训练和微调，对多模态、扩散模型等任务是否适用没有说明。
- **对比公平性存疑**：由于缺少基线超参数预算与调优细节，无法明确 ECO 的增益是否部分来自基线的次优设置。

（完）
