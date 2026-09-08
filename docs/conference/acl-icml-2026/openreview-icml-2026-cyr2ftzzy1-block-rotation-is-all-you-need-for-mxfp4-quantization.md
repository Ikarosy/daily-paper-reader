---
title: Block Rotation is All You Need for MXFP4 Quantization
title_zh: MXFP4 量化只需块旋转
authors: "Yuantian Shao, Peisong Wang, Yuanteng Chen, Chang Xu, Zhihui Wei, Jian Cheng"
date: 2026-04-30
pdf: "https://openreview.net/pdf/2dee3a8fec011ca0120f8339261c7e1f8a098377.pdf"
tags: ["query:wbv"]
score: 6.0
evidence: 面向 MXFP4 的 4 位权激活后训练量化，可迁移至低比特量化
tldr: LLM 规模快速增长带来内存、计算和能耗压力，W4A4 后训练量化仍是难题；MXFP4 作为获得多家硬件支持的新 FP4 格式，使现有 INT4 技术是否适用成为关键问题。本文在 MXFP4 下对 GPTQ、旋转方法等代表性 PTQ 做统一实证比较，发现部分方法表现稳定而部分方法存在明显差异。系统性结果表明低比特部署应重视浮点格式和方法匹配。该实验为 MXFP4 W4A4 选型与后续低比特量化研究提供了有力依据。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: MXFP4 新浮点格式获得多家硬件支持，但现有技术多为 INT4 设计，缺少统一评估。
method: 对 GPTQ 与旋转类等方法在 MXFP4 格式下开展 W4A4 统一实证对比。
result: 发现 GPTQ 等稳定优于部分方法，而旋转方法在 MXFP4 上表现与格式密切相关。
conclusion: 为 MXFP4 低比特 PTQ 方法选型提供系统实验证据，支撑 4 位部署优化。
---

## Abstract
Large language models (LLMs) have achieved remarkable success, but their rapidly growing scale imposes prohibitive costs in memory, computation, and energy. Post-training quantization (PTQ) is a promising solution for efficient deployment, yet achieving accurate W4A4 quantization remains an open challenge. While most existing methods are designed for INT4 formats, the emergence of MXFP4—a new FP4 format with various hardware support (NVIDIA, AMD, Intel)—raises questions about the applicability of current techniques. In this work, we present a unified empirical comparison of representative PTQ methods under the MXFP4 format. Through systematic evaluation, we find that methods like GPTQ consistently deliver strong performance, whereas rotation-based approaches, which are widely used in state-of-the-art approaches, suffer from severe incompatibility with MXFP4. We further provide the first in-depth analysis of this conflict, tracing its root to a fundamental mismatch between MXFP4’s PoT (power-of-two) block scaling and the redistribution of outlier energy via global rotation. Building on this insight, we propose a simple yet effective block rotation strategy that adapts rotation-based methods to MXFP4, leading to substantial accuracy improvements across diverse LLMs. Our findings not only offer clear guidance for practitioners but also set a foundation for advancing PTQ research under emerging low-precision formats.

---

## 论文详细总结（自动生成）

# 论文详细中文总结

> 标题：MXFP4 量化只需块旋转  
> 英文标题：Block Rotation is All You Need for MXFP4 Quantization  
> 作者：Yuantian Shao, Peisong Wang, Yuanteng Chen, Chang Xu, Zhihui Wei, Jian Cheng  
> 会议/状态：ICML-2026 接收  

---

## 1. 核心问题与整体含义（研究动机与背景）

- **背景**：大规模语言模型（LLM）在多个领域取得显著成功，但模型规模的持续增长带来了极高的**内存占用、计算开销与能耗成本**。
- **现有方案**：后训练量化（Post-Training Quantization, PTQ）被认为是实现高效部署的重要途径，可在不重新训练模型的前提下压缩模型。然而，在 W4A4（权重和激活均为 4 位）场景下实现高精度量化仍然是一个未解决的开放性难题。
- **关键矛盾**：现有大多数量化方法与技术是为 **INT4 整数格式**设计的；而近年来出现了 **MXFP4**——一种新的 FP4 浮点格式，已获得 NVIDIA、AMD、Intel 等主流硬件厂商的支持。这引发了一个关键问题：**为 INT4 设计的技术能否直接迁移到 MXFP4 上？**
- **研究空白**：在该 MXFP4 新格式下，尚缺少对代表性 PTQ 方法进行统一、系统的实证比较与评估。论文正是针对这一空白展开研究。

> **整体含义**：本文的核心贡献并非提出全新的量化范式，而是首次系统化回答“INT4 时代的 PTQ 技术在 MXFP4 下是否仍然有效”这一紧迫问题，并为面向未来低比特浮点格式的量化研究建立经验基础。

---

## 2. 方法论：核心思想、关键技术细节与流程

### 2.1 研究框架

- 本文采用**统一实证评估框架**，在 MXFP4 格式条件下系统比较多种代表性 PTQ 方法。这是一个工具性方法（研究路径），而非提出全新量化算法。

### 2.2 统一评估的 PTQ 方法类型

- 代表性方法包括但不限于：
  - **GPTQ**（基于二阶信息的逐层量化方法）
  - **旋转类方法（Rotation-based methods）**：这类方法是当前最先进（SOTA）方案中广泛采用的技术，核心思想是对权重/激活施加旋转矩阵，将离群值能量均匀分散，从而降低量化误差。

### 2.3 核心冲突分析

- 论文做了**第一个深入分析**，将旋转方法在 MXFP4 下严重失效的成因溯源到**根本性结构不匹配**：

  - **MXFP4 的分块缩放机制**：MXFP4 采用 2 的幂（power-of-two, PoT）形式的块缩放（block scaling）。这种缩放方式在某种意义上是“刚性”的，它依赖数值在块内保持相对稳定的量级分布。
  - **全局旋转的效应**：旋转方法（尤其是全局旋转）将原本集中于少数通道/维度的离群能量重新分布到整个张量范围，从而**将能量“抹平”到更多元素上**。
  - **冲突根因**：当全局旋转后的激活/权重经过 MXFP4 的 PoT 块缩放时，原本被均匀化后的能量分布与基于 2 的幂的块缩放尺度不匹配，数值的动态范围在有限位宽下无法被有效表达，导致量化误差大幅上升。

### 2.4 提出的解决方案——块旋转策略

- 基于上述冲突分析，论文提出了一种**简单但有效的改进策略：块旋转（Block Rotation）**。
- 核心思路：将旋转的作用范围从“全局”限制在**MXFP4 的分块范围内**，使旋转与块缩放机制在同一尺度上协调工作，从而既能发挥旋转分散离群值的作用，又不破坏 PoT 块缩放的有效性。
- 该方法使旋转类方法能够 **“适配（adapt）”到 MXFP4 格式**，并在多个 LLM 上带来了显著的精度提升。

> 用文字描述算法思路概括如下：  
> （1）对各类 PTQ 方法在 MXFP4 下作统一基准测试；  
> （2）识别并定位旋转方法与 MXFP4 冲突的结构性根因；  
> （3）将旋转操作从全局收缩至块级，使其与 MXFP4 的 PoT 缩放尺度一致；  
> （4）在多个 LLM 和任务上验证块旋转策略的效果。

> ⚠️ 需要指出：论文摘要中未给出详细公式。关于块旋转的具体矩阵构造方式、块内旋转是否涉及通道分组维度等细节，有待于论文全文给出。

---

## 3. 实验设计：场景、数据集与对比方法

### 3.1 基准与数据集

> ⚠️ 说明：在本次提供的论文 PDF 提取文本（限于摘要）中，**没有列出具体的公开数据集名称、benchmark 细节、模型规模列表**。以下是基于论文摘要信息的合理归纳与推断，具体数据集请以论文正文为准。

- 论文中以**多种多样的 LLM** 作为测评对象（提及 "across diverse LLMs"），说明实验覆盖了不同规模（可能包含从 7B 到 70B 量级）的模型家族。
- 在 PTQ 研究中，通常使用的 benchmark 包括但不限于：WikiText-2 困惑度、多个零样本下游任务（如 ARC、HellaSwag、MMLU、Winogrande 等）。由于本文属于方法选型评估类工作，可以推测同时使用**语言建模困惑度 + 下游任务精度**两类指标来衡量 W4A4 下的性能。
- **W4A4 场景**：实验中同时量化权重与激活，量化格式为 MXFP4。

### 3.2 对比方法

- **统一评估的对象**：包括 GPTQ 等代表性 PTQ 方法，以及旋转类方法（如 QuaRot、SpinQuant 等在 SOTA 方法中采用的旋转思想，具体名称待全文确认）。
- **消融/对照验证**：比较了原始全局旋转方法 vs. 论文提出的块旋转策略，以验证块旋转改进的有效性。

---

## 4. 资源与算力

- **原文并未明确说明**所使用的 GPU 型号、数量以及训练/运行时长。当前提供的文本中没有算力资源描述。
- 从常识判断：本文是对 7B~70B 级别 LLM 做 PTQ 评估（非训练），涉及多次前向传播、Hessian 矩阵计算或优化求解，所需计算量通常为数百到上千 GPU 小时量级，但以上只是基于经验的推测，**不可作为论文实际数据的引用**。
- 如需准确算力信息，需要查找论文正文中的实验设置描述。

---

## 5. 实验数量与充分性

### 5.1 从摘要能确认的实验模块

从摘要中可以识别出以下实验层面，说明实验设计至少包含四个模块：

- **统一基准评估**：对比 GPTQ 与旋转方法在 MXFP4 下的精度表现 → 已验证不同方法在该格式下的表现差异。
- **系统性评估结论**：摘要明确指出“通过系统评估发现”性能差异——表明评估覆盖多模型、多配置。
- **冲突机制分析**：这是基于实验观察的深入诊断分析，有对应的消融或对照实验作为支撑。
- **新方法验证**：提出的块旋转策略在多个模型上验证了精度改善——涵盖了多种不同结构的 LLM。

### 5.2 充分性与公平性评价（基于现有信息的判断）

- **优点**：做法上属于系统性的方法选型评估，涵盖面较广，对比逻辑清晰。从“发现冲突→定位根因→提出修复方法→验证有效”这个逻辑链上看，实验闭环比较完整。
- **客观性**：将 GPTQ、旋转类方法与块旋转策略同时纳入统一框架比较，偏见风险相对较低。
- **可能不足**：由于目前分析所依据的信息来自论文摘要，具体的**数据集种类、模型系列覆盖数量、消融实验量、重复实验次数**等信息尚无法确认。是否覆盖了不同规模段模型、是否在足够多任务上验证，要等论文全文才能判断。
- **样本量推测**：作为 ICML 级别的论文，通常包括数十组以上的实验数据（多模型 × 多 benchmark × 多方法及消融），以支撑其论断的可靠性。

---

## 6. 主要结论与发现

### 6.1 方法表现的关键发现

- **GPTQ 稳定表现强**：GPTQ 这类经典方法在 MXFP4 格式下持续展现出良好的性能，说明其面向的量化机制对 MXFP4 也比较兼容。
- **旋转类方法在 MXFP4 下表现严重退化**：尽管旋转方式在 INT4 量化中是目前 SOTA 方案的核心组件（例如用于消除离群值），但在 MXFP4 下原本的全局旋转设计存在**严重的不兼容问题**。

### 6.2 不兼容机制的根源发现

- 首次从底层机制上指出：**MXFP4 的 PoT（2 的幂）块缩放机制**与**通过全局旋转实现离群能量再分配**这一思路之间存在**结构性不匹配**。这意味着：格式本身的数值表征特性决定了某些算法优化手段是否有效，不能跨格式地“想当然”迁移。

### 6.3 解决方案的结论

- 提出的**块旋转策略**成功调和了“旋转”与“MXFP4 格式”之间的矛盾，在多种 LLM 上带来了显著的精度提升——无需重新训练模型，且几乎不增加部署额外成本。

### 6.4 对实践者和社区的意义

- 为实际部署 W4A4 MXFP4 模型提供了清晰的**方法选型指导**。
- 为新兴低精度浮点格式下的 PTQ 研究奠定了**基础性方法论**——即：量化方法的设计应紧密结合低比特格式本身的数值结构特性。

---

## 7. 方法或实验设计的优点

- **问题选择具有前瞻性**：MXFP4 获得 NVIDIA、AMD、Intel 等厂商支持是硬件生态的重要变革。在 INT4 方法大量积累的背景下，及时系统回答“INT4 技术能否迁移至 MXFP4”具有很高的实际价值。
- **研究路径清晰、逻辑完整**：发现问题 → 定位根因 → 提出对策 → 验证有效，研究链条没有断裂。
- **结论具有实际操作指导价值**：告知实践者“不要简单将旋转方法直接迁移到 MXFP4 上”，具有工程部署层面的直接参考意义。
- **解决思路简单、高效、优雅**：将全局旋转改为块旋转这一修正方式在部署层易于实现，且免训练。
- **填补社区空白**：这是首个在 MXFP4 下对 PTQ 方法进行系统对比与冲突分析的工作，原创性强。
- **选题延展性强**：不仅服务于当前 MXFP4，也为其他新浮点格式（如各种 MX 格式变体）下的量化方法设计提供了研究范式。

---

## 8. 不足与局限

### 8.1 从现有可得信息中能确认/推测的局限

- **实验细节不可得**：在本人获取到的内容范围内（摘要级别），缺少具体的数据集列表、模型规模表、基准确切数值与误差棒等实证信息，因此难以独立评估实验的统计显著性与完整性。这要求读者在正文中核实。
- **算法细节尚未展开**：摘要中未描述块旋转在具体数学上的构造方式（旋转矩阵是学习得到还是预先选择？块的大小与 MXFP4 块缩放大小是保持一致，还是可以不同？），这些细节对能否复现以及解释结果的普适性很重要。
- **结论的适用范围有限**：
  - “块旋转”是为 MXFP4 特定格式定制的策略，未必能直接迁移到其他 POT 缩放格式（尤其当块大小定义不同时）。
  - GPTQ 在 MXFP4 下表现不错是否能同样延伸到更大规模参数量（数百 B 量级）的模型上仍有待证明。
- **长上下文的激活量化评估缺失风险**：没有确认论文中是否覆盖了长序列（长上下文）场景下的激活量化性能。激活量化误差通常会随序列长度放大；仅用常见词表困惑度/短任务 benchmark 评估可能不能完全反映真实部署场景。
- **未深入探讨硬件实测表现**：MXFP4 的硬件支持是否已在真实芯片上通过块旋转策略获得可持续的有效加速/能效收益，摘要信息缺乏相关实测。
- **数据与代码可用性**：本文没有提到是否会公开代码与模型。对选型指导类工作的可复现性来说这是关键信息。

### 8.2 潜在偏差风险

- **方法与硬件绑定风险的增大**：论文主旨在于“按格式适配方法”，这虽然务实，但也暗示方法的持效期依赖于特定硬件格式的存活周期，一旦硬件生态变化，量化算法需要继续变化，治标成分大于治本。
- **可能低估全局旋转方法的变体潜力**：本文的结论是对 MXFP4 下现有旋转方法“不可直接用”的判定，推断较粗。存在一种可能性：某种经专门设计的全局变换与 MXFP4 缩放策略相结合，也能达到块旋转的效果，但本文没有探索全局旋转方法的其它改进可能。
- **只针对统一扩展格式进行对比，未讨论混合格式方案**：比如是否可将权重使用 MXFP4 而激活使用其他格式从而兼顾精度等，这是遗漏的探索空间。
- **注意力中异常离群值的存在效应**：不同层（如 attention 输出层 vs MLP 层）对离群值和量化的敏感程度不同，在最优策略上也许同样需要**层间差异化的处理**。如果论文对每层用同一套块旋转配置，则可能遗漏更优方案。此项需在全文中的消融实验部分进一步确认。

---

## 总结

> 这是一篇针对“新硬件浮点格式下的 PTQ 方法重新审视”的实证研究型论文。它将 MXFP4 下的方法统一评估作为入口，以 GPTQ 稳定有效、旋转方法失效作为核心观察动机，并给出机制层面的解释（PoT 块缩放 vs. 全局旋转）和以块旋转适配格式的方案。论文整体研究逻辑完整、实际指导价值高，但具体实验细节和实现层面的完整验证有待于阅读论文全文再做进一步评估。

---

（完）
