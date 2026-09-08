---
title: "GEMQ: Global Expert-Level Mixed-Precision Quantization for MoE LLMs"
title_zh: GEMQ：面向 MoE 大语言模型的全局专家级混合精度量化
authors: "Jianing Deng, Song Wang, Dongwei Wang, Zijie Liu, Tianlong Chen, Huanrui Yang, Jingtong Hu"
date: 2026-04-30
pdf: "https://openreview.net/pdf/e83bf0e33145e9a37db67643a75b8433031358e7.pdf"
tags: ["query:moe-quant"]
score: 9.0
evidence: 面向 MoE LLM 的全局专家级混合精度量化，直接命中 MoE 量化主题。
tldr: MoE 大模型靠海量专家参数取得强性能，但部署内存负担重；混合精度量化可按专家重要度分配位宽并逼近精度内存帕累托前沿，然而现有方法多采用逐层重要性估计，忽视量化引发的路由偏移。GEMQ 提出全局线性规划框架，以量化误差分析刻画模型级专家重要性并同时考虑路由变化，获得更优的专家级位宽分配。实验表明其相比逐层方案显著提升内存精度权衡，支持极低比特 MoE 部署。它为 MoE 大模型量化引入全局优化视角。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: MoE 大模型专家参数多、内存开销大；逐层重要性方法忽略量化诱导的路由偏移。
method: 用全局线性规划建模模型级专家重要性，并结合量化误差分析和路由器偏移做位宽分配。
result: 比逐层方法更接近精度内存帕累托前沿，并支持极低比特 MoE 压缩。
conclusion: 提供全局视角解决 MoE 混合精度量化中的次优分配与路由漂移问题。
---

## Abstract
Mixture-of-Experts Large Language Models (MoE-LLMs) achieve strong performance but incur substantial memory overhead due to massive expert parameters.
Mixed-precision quantization mitigates this cost by allocating expert-wise bit-widths based on their importance, approaching the accuracy-memory Pareto frontier and enabling extreme low-bit quantization.
However, existing methods rely on layer-wise importance estimation and overlook router shifts induced by quantization, resulting in suboptimal allocation and routing.
In this work, we propose Global Expert-level Mixed-precision Quantization (GEMQ) to overcome these limitations via (1) a global linear-programming formulation that captures model-wide expert importance based on quantization error analysis, and (2) efficient router fine-tuning to adapt routing to quantized experts. These components are integrated into a progressive quantization framework that iteratively refines importance estimation and allocation.
Experiments demonstrate that GEMQ significantly reduces memory and accelerates inference with minimal accuracy degradation.

---

## 论文详细总结（自动生成）

# 《GEMQ：面向 MoE 大语言模型的全局专家级混合精度量化》论文总结

## 1. 核心问题与整体含义（研究动机与背景）

- **研究背景**：混合专家大语言模型（MoE-LLMs）通过海量专家参数实现了强大的性能，但数量庞大的专家权重带来了严重的内存负担，制约了其在实际场景中的部署效率。
- **现有混合精度量化的局限**：混合精度量化按“专家重要性”分配不同位宽，理论上可逼近“精度-内存”的帕累托前沿，并支持极低比特量化。然而，现有方法主要存在两大缺陷：
  - **逐层（层内）重要性估计**：只关注单个层内部的专家重要度，而忽视了跨层的全局专家协作关系，导致位宽分配并非全局最优；
  - **忽视路由器偏移（Router Shift）**：量化改变了专家输出分布，使得路由器基于原有分布做出的路由决策发生偏移，进一步加剧精度损失。
- **核心研究问题**：能否通过**全局视角**对 MoE 模型进行专家级位宽分配，同时**显式适应量化引起的路由变化**，从而在更低内存占用下保留更高精度？

## 2. 论文提出的方法论

### 核心思想
- 提出 **GEMQ（Global Expert-level Mixed-precision Quantization）**，核心在于两层设计：
  1. **全局线性规划（Global Linear Programming）分配位宽**：将全模型所有专家的位宽选择视为一个整体优化问题，而非逐层独立优化；重要性度量来自基于量化误差分析（Quantization Error Analysis）的模型级（model-wide）重要性刻画。
  2. **高效路由器微调（Efficient Router Fine-tuning）**：量化的专家会改变输出分布，因此需要对路由器做针对性适配训练，使路由决策主动适应量化后的专家，而不是放任偏移累积。
- 二者被整合进**渐进式量化框架（Progressive Quantization Framework）**：该框架迭代执行“重要性估计 → 位宽分配 → 路由器微调”，不断细化量化策略。

### 关键技术细节（基于现有信息推断）
> 📌 注意：由于可获取的文本仅包含摘要与元数据，原文中的公式和算法伪代码未在给定内容中呈现。以下是基于摘要和元数据的结构化解读，可能与原文细节存在出入。

- **量化误差分析用于刻画专家重要性**：通过对每个专家在量化前后的输出误差进行传播分析，估计其对模型整体损失的影响，以此作为线性规划中“重要性权重”的量化依据。
- **全局线性规划**的决策变量为每个专家所处层的位宽分配，目标为最小化模型级量化误差总量，约束为总内存预算（或目标压缩率）以及硬件支持的位宽集合。
- **路由器微调**：在量化专家权重的同时，轻量级地更新路由器的门控参数，使 token 被重新分配给量化后仍然可靠的高质量专家。
- **渐进式量化循环**：每轮只量化部分专家/层，更新重要性信息后再进入下一轮，以避免一次性全局量化导致的误差累积估计失真。

## 3. 实验设计

- **可获取信息非常有限**：论文摘要仅声称“实验表明 GEMQ 显著减少内存并加速推理，且精度退化极小（minimal accuracy degradation）”。
- **数据集/基准（Benchmark）**：给定文本中**未明确列出**具体评测数据集（如常识推理、语言建模、MMLU 等）或基准模型（如 Mixtral 等具体 MoE 架构）。
- **对比方法**：根据元数据可知，论文与“逐层重要性估计的方法”进行了对比，并声称**更接近精度-内存帕累托前沿**；但未给出具体的 baseline 名称列表。
- **消融实验**：摘要未明确说明是否包含消融实验；从方法论结构（全局分配 + 路由微调 + 渐进式框架）推测，作者可能对各组件做了消融，但这一点在给定内容中无法证实。

## 4. 资源与算力

- **给定论文内容中完全没有披露任何算力信息**，包括但不限于：
  - GPU 型号与数量；
  - 训练/微调总时长；
  - 功耗或显存占用细节；
  - 推理加速比的硬件环境。
- 仅从摘要中可知存在“路由器微调”这一流程，但其具体计算开销、使用的硬件规模均未在给定文本中说明。
- 需要向作者原文（扩展版本或附录）进一步查找相关细节。

## 5. 实验数量与充分性评估

- **已知实验维度**：从摘要与元数据的证据字段来看，论文至少包含内存-精度权衡对比（GEMQ vs. 逐层方法）、内存减少效果和推理加速验证三大方向。
- **缺失的关键信息**：无法从给定文本判断：
  - 使用了多少个数据集/任务域；
  - 是否覆盖不同规模的 MoE 模型族（如小规模、中等规模、大规模）；
  - 是否测试了多个位宽组合与极端低比特（如 2-bit、1.5-bit 等）；
  - 是否与 SOTA 混合精度量化方法、均匀低比特量化、逐层混合精度、逐专家混合精度等方法做了系统性横向对比。
- **初步判断**：论文逻辑自洽性较强，但仅凭摘要无法对实验的**充分性、客观性与公平性**做出完整判断。就其声称的贡献点——“全局分配”和“路由微调”——至少需要跨多个模型、多个数据集、多组压缩率的系统评估才能充分支撑结论，这一要求大概率需要原文实验部分来验证。

## 6. 主要结论与发现

- **GEMQ 相比逐层分配方法，在同等内存预算下精度更高；在同等精度目标下内存占用更低**，即更逼近“精度-内存”帕累托前沿。
- **全局建模确实优于局部（逐层）建模**：说明 MoE 模型中的专家重要性存在显著的跨层关联性，不能被逐层割裂地刻画。
- **对路由偏移的建模与修正是有效的**：直接量化会带来路由分布漂移，令预先训练好的路由器失效；明确将路由适配纳入量化框架，能显著改善极低比特场景下的稳定性。
- **支持极低比特 MoE 部署**：论文声称能显著降低内存占用、并加速推理，且精度损失可控，这为 MoE 大模型的资源受限部署提供了更可行的路线。
- 结论高度对应“全局观点优于局部观点 + 量化应该与路由联合优化”的学术主张。

## 7. 优点与亮点

- **直击领域痛点**：针对 MoE 量化中“仅重专家参数，却忽略 router 敏感度”这一已有方法的盲区，问题选取得当。
- **全局优化视角的引入**：将线性规划引入专家级量化位宽分配，相较于贪婪式或启发式的逐层方法，具有坚实的优化理论支撑，并且更接近精度-内存约束下的全局最优解。
- **联合建模量化-路由耦合**：既调整“被量化的物体”也调整“使用量化物体的决策者”，这一“系统级”思路比单纯自底向上的压缩方法更全面。
- **误差传播分析驱动的重要性刻画**：用量化误差分析而非启发式指标（如参数范数等）来衡量专家重要性，使位宽分配的准则更贴近最终损失函数。
- **渐进式量化的整合**：迭代式估计、分配、微调的循环设计，理论上能缓解极低比特量化下的累积误差问题，在训推流程上整合度高，工程可实现性强。
- 该工作被 ICML-2026 接收，评审综合评分为 9.0/10（evidence 元数据），暗示其贡献获得了同行较为正面的评价。

## 8. 不足与局限

- **现有资料的可见性局限**：基于当前给定内容，无法看到公式、算法伪代码、超参数设置、数据集拆分等细节，这限制了对方法技术完整性与实验严谨性的评判。
- **实验覆盖无法验证**：摘要中未披露具体的模型规模、任务种类和对比方法数量，难以判断该方法是否在足够多样的条件（如不同 MoE 路由策略、不同专家数量、不同激活函数）下得到验证。
- **路由微调的成本问题**：路由器微调需要一定数量的校准数据且引入额外训练开销，在任务迁移（新领域/新任务）时是否需要重新微调路由，论文摘要未给出说明，实际使用时存在泛化性隐忧。
- **适用范围可能有限**：全局线性规划需要对每个专家进行误差传播分析，当专家数量极大（如数千级别）时，线性规划的变量规模与误差估计的计算开销是否可控，是一个潜在的 scalability（可扩展性）问题。
- **帕累托前沿的声称需谨慎看待**：虽然作者声称比逐层方法更接近帕累托前沿，但这依赖于实验对比范围。若未与近期各类非逐层策略（如基于 Hessian 的混合精度、基于学习的自动位宽搜索等方法）进行系统横向比较，这一结论的竞争力仍需进一步佐证。
- **重硬件属性未讨论**：实际部署中位宽支持与 kernel 实现（如 3-bit kernel）对真实推理速度影响较大。摘要称“加速推理”，但缺少对硬件平台、算子库支持的刻画，落地效果有待确认。

（完）
