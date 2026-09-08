---
title: "Preserve-Then-Quantize: Balancing Rank Budgets for Quantization Error Reconstruction in LLMs"
title_zh: 先保形再量化：为LLM量化误差重构平衡秩预算
authors: "Yoonjun Cho, Dongjae Jeon, Soeun Kim, Moongyu Jeon, Albert No"
date: 2026-04-30
pdf: "https://openreview.net/pdf/81544add9ba73493ad6b417ba2d6f8735d3acef9.pdf"
tags: ["query:wbv"]
score: 4.0
evidence: 用秩预算分配在量化前保留主方向并量化残差以重构误差，是可结合任意VQ/SQ的超低位PTQ使能思路
tldr: 现有量化误差重构方法常把全部低秩预算都用于补偿量化噪声，但当权重本身有内在低秩结构且量化破坏主方向时，这样做不够优。论文提出结构化残差重构，在量化前先保留激活加权权重的前k个主奇异方向，只量化残差，再用剩余秩预算做误差重构，并给出理论选择准则。在LLM低比特量化实验上，该方法比全秩误差重构方案更有效地减少精度损失。由于该方法不限定具体量化器，可被2比特VQ等码本方法采用以改善超低位性能。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 量化误差重构把全部秩用于补偿噪声，忽视了权重自身低秩主方向被量化破坏的问题，需更合理的秩预算分配。
method: 提出结构化残差重构，先保留激活加权权重的top-k奇异子空间，再量化残差，并将剩余秩用于重构量化误差。
result: 在LLM低比特量化中相比全秩误差重构取得更高精度，理论选择准则带来稳定的秩分配。
conclusion: 秩预算应同时兼顾保形与误差重构，该框架可嵌入各类量化器以提升极低比特PTQ性能。
---

## Abstract
Quantization Error Reconstruction (QER) reduces accuracy loss in Post-Training Quantization (PTQ)
by approximating weights as $\mathbf{W} \approx \mathbf{Q} + \mathbf{L}\mathbf{R}$, using a rank-$r$ correction to reconstruct quantization error.
Prior methods devote the full rank budget to error reconstruction,
which is suboptimal when $\mathbf{W}$ has intrinsic low-rank structure and quantization corrupts dominant directions.
We propose Structured Residual Reconstruction (SRR),
a rank-allocation framework that preserves the top-$k$ singular subspace of the activation-scaled weight before quantization,
quantizes only the residual, and uses the remaining rank $r-k$ for error reconstruction.
We derive a theory-guided criterion for selecting $k$ by balancing quantization-exposed energy 
and unrecoverable error under rank constraints.
We further show that resulting $\mathbf{Q}+\mathbf{L}\mathbf{R}$ parameterization naturally supports Quantized Parameter-Efficient Fine-Tuning (QPEFT),
and stabilizes fine-tuning via gradient scaling along preserved directions.
Experiments demonstrate consistent perplexity reductions across diverse models and quantization settings in PTQ,
along with a 5.9 percentage-point average gain on GLUE under 2-bit QPEFT.
The project page is available at https://ai-isl.github.io/srr.

---

## 论文详细总结（自动生成）

# 论文中文深度总结：先保形再量化——为LLM量化误差重构平衡秩预算

#### 1. 核心问题与研究动机（背景与问题含义）

量化误差重构（QER）是后训练量化（PTQ）中的一种重要技术，其核心思想是将权重近似分解为 $\mathbf{W} \approx \mathbf{Q} + \mathbf{L}\mathbf{R}$，其中 $\mathbf{Q}$ 为量化后的权重矩阵，$\mathbf{L}\mathbf{R}$ 为秩为 $r$ 的低秩校正项，用以补偿量化带来的精度损失。

本文指出了一个被此前方法普遍忽视的关键问题：**既有QER方法将全部秩预算（rank budget）投入到量化误差重构中，但当权重矩阵 $\mathbf{W}$ 本身具有内在低秩结构、且量化过程破坏了其主方向（dominant directions）时，这种"全部用于补偿误差"的策略并非最优。**

由此引出了一个更本质的秩预算分配问题——在秩预算有限的情况下，应当如何在以下两个方面之间分配：
- **保形（preserve）**：避免量化破坏权重中固有的、对任务有关键意义的主奇异方向；
- **重构（reconstruct）**：补偿量化后残余误差。

> 核心洞察：秩预算不应全部用于"事后补救"的误差重构，而应部分前移，用于"事前保护"权重主方向，从而在源头上减少不可恢复的量化误差。

#### 2. 方法论：结构化残差重构（SRR）

**核心思想**：先量化"保护好的残差"，再做误差重构，实现秩预算的结构化分配。

**关键技术步骤**：

1. 计算激活加权后的权重矩阵（activation-scaled weight）；
2. 对该矩阵做SVD分解，提取其前 $k$ 个主奇异方向（top-$k$ singular subspace）作为需要被保护的子空间；
3. 将这些主方向从权重中分离出来后，仅对残差部分执行量化；
4. 将剩余的秩预算 $r-k$ 用于重构此轮量化产生的误差。

**公式表达（对应于 $\mathbf{W} \approx \mathbf{Q} + \mathbf{L}\mathbf{R}$）**：
- 传统方法：$\mathbf{Q}$ = 直接量化的全矩阵 $\mathbf{W}$，$\mathbf{L}\mathbf{R}$ 补偿误差；
- SRR 方法：将 $\mathbf{W}$ 拆分为"主成分子空间 + 残差"，只量化残差成 $\mathbf{Q}$，再用 $\mathbf{L}\mathbf{R}$ 去补偿残差量化误差，同时保留未量化的主方向。

**理论指导的秩分配准则**：
- 作者推导了一个理论准则用于选择 $k$；
- 在给定秩约束下 **平衡两方面的能量损失**：
  - 量化暴露的能量（quantization-exposed energy）——被量化过程损伤的能量；
  - 不可恢复误差（unrecoverable error）——超出秩预算无法由低秩校正恢复的误差。

**额外的延伸发现**：
- 该 $\mathbf{Q} + \mathbf{L}\mathbf{R}$ 参数化形式**天然支持量化参数高效微调（QPEFT）**；
- 沿保留方向进行梯度缩放（gradient scaling）可稳定微调过程。

**模型无关性**：SRR 不限定具体量化器，方法具备良好的通用性和可嵌入性。

#### 3. 实验设计

**场景**：
- 后训练量化（PTQ）与量化参数高效微调（QPEFT）；
- 不同模型架构与不同量化精度设置。

**Benchmark**：
- PTQ：困惑度（Perplexity）评估；
- QPEFT：GLUE 基准。

**对比方法**：
- 以"全秩误差重构"（full rank budget error reconstruction）方案为主要对比对象，即传统的QER方法（如将全部预算用于低秩补偿误差的策略）。

**数据集信息**：摘要中未具体说明所用的全部数据集名称，提及以困惑度（perplexity）为PTQ的指标，以GLUE为QPEFT的指标。

#### 4. 资源与算力

**论文摘要与元数据中未明确披露**：
- GPU 型号与数量；
- 训练/微调时长；
- 总计算量或 FLOPs 估计。

> 需要指出：原文提供的信息中缺乏算力相关披露，无法对此做出准确总结。若需要，可进一步查阅论文正文的附录或实验环境说明。

#### 5. 实验数量与充分性评估

基于摘要可得：
- PTQ 场景覆盖了多个模型与多种量化设置（表明有一定的实验广度）；
- QPEFT 场景报告了 GLUE 上 2-bit设置的5.9个百分点**平均提升**；
- 与全秩误差重构进行了对比，能体现方法改进的有效性；
- 理论准则的效果检验：通过比较不同秩分配策略可说明选择性准则的稳定性。

评估：
- 从文章 claims 来看覆盖了 "diverse models" 与不同的量化设置，具备一定的说服力；
- 但从可用信息看，实验呈现为**摘要层的总体结论**，无法确认消融实验的具体分组数量、每个模型/数据集的结果明细，由此判断：摘要层面呈现的实验数量大体符合顶会论文的规范，**因未提供正文细节，无法对公平性给出完全有据的评价**——好的方面是建立在同一秩预算下与新方法比，天然具备可比性；需要确认原始超参、秩预算在各方法间完全公平设定才能确定公平性。

#### 6. 主要结论与贡献

核心结论：
- **秩预算分配应当兼顾"保形"与"重构"双重目标**；仅将全部秩用于量化误差重构的做法存在次优性；
- 在 $\mathbf{W}$ 具有内在低秩结构时，先保持奇异方向再量化残差，比直接量化后全秩补偿能更有效降低性能损失；
- 理论推导的选择准则为 $k$ 的选择提供了稳定性保证；
- 该方法在不同模型与量化设置下均获一致的困惑度降低；
- 额外收益：该方法自然延伸至 QPEFT，在 2-bit 条件下于 GLUE 基准取得了平均5.9个百分点的提升；
- 方法在量化器层面具有通用性，可作为各种VQ/SQ量化器的外部框架引入。

#### 7. 方法优点与亮点

- **视角创新**：将秩预算从"误差补偿"扩展到"结构维护+误差补偿"双目标，避免了量化破坏主方向后依靠有限秩低秩校正难以恢复的根本问题；
- **框架设计普适性强**：SRR 是一种插件式框架，不依赖具体的量化器选择，理论上可以与任意VQ/SQ量化器结合；
- **理论+实践结合**：不只凭经验调 $k$，而提出基于能量平衡的理论准则，具有良好的可迁移性；
- **超低位场景增益显著**：在2-bit QPEFT下带来巨大的精度提升，说明在极低比特条件下"保形"更为重要——这正好印证了它的动机合理性；
- **对 QPEFT 的天然支持**：参数化自然兼容 PEFT，兼顾量化压缩和下游任务高效微调，扩展了技术的应用面；
- 论文附带了项目主页（https://ai-isl.github.io/srr），促进可复现性和传播。

#### 8. 不足与局限

- **研究报告范围有限**：
  - 没明确列出参与实验的全部模型与量化方法名称；
  - PTQ 的具体数据集明细缺失；
  - 理论准则的推导过程与应用条件在摘要中未展示；
- **秩预算选择的敏感性**：依赖理论准则选择 $k$ 与 $r$，在非常深或结构特殊的网络层中，最优 $k$ 的选择可能与简单启发式规则存在偏离，还需要凭正文实验分析或调参经验来确定取值逻辑的适用边界；
- **低秩前提假设的限制**：本方法的增益逻辑依赖于 $\mathbf{W}$ 本身具有较显著的内在低秩结构；
  - 若某一层或某一任务下的权重主方向分布相对均匀（矩阵近似满秩）时，"保形"的边际收益可能会明显下降，此时方法可能退化为传统全秩误差重构方案的水平，该局限性在文中未能得到充分讨论；
- **QPEFT 评估维度有限**：仅报告了 GLUE 上的结果，对于生成式任务（如指令微调、对话模型）的表现未作验证；
- **资源效率未给出数据**：保形步骤需要做 SVD 分解，涉及额外预处理开销，论文并未报告基础模型尺度（如7B、13B还是70B /更多参数规模）下的额外耗时，模型内SVD成本在超大宽度层上值得关注；若在量化前先进行SVD分解的话，增加的预计算成本也需在部署层面加以考量；
- 若模型参数量进一步增至数百亿甚至千亿规模，"先 SVD 后量化"的顺序在内存上的中间态开销也值得仔细审视。

---

（完）
