---
title: "WUSH: Near-Optimal Adaptive Transforms for LLM Quantization"
title_zh: WUSH：大模型量化的近似最优自适应变换
authors: "Jiale Chen, Vage Egiazarian, Roberto L. Castro, Torsten Hoefler, Dan Alistarh"
date: 2026-04-30
pdf: "https://openreview.net/pdf/e7e6ac3d59a279c67636b5371d44d9472885847d.pdf"
tags: ["query:wbv"]
score: 6.0
evidence: 面向权激活 INT/FP 量化的近似最优自适应变换，通用支撑低比特标量量化
tldr: 在量化 LLM 权重和激活时，少数极端离群值会拉伸动态范围并放大低比特误差；哈达玛旋转等预定义变换是数据无关且缺乏量化最优性。本文在标准 RTN AbsMax 块量化下推导了联合权激活量化的闭式最优线性分块变换，将哈达玛主结构与数据相关二阶矩结合形成非正交但可处理的 WUSH 变换。理论证明该变换在 INT 与 FP 量化下都近似最优，实验显示可有效抑制离群值影响。它为低比特量化提供了理论支撑的自适应变换工具。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 极端离群值拉大动态范围并加剧低比特误差，固定旋转等变换缺乏量化最优保证。
method: 在 AbsMax 块量化下推导闭式最优线性变换，以哈达玛主结构和二阶矩构成 WUSH。
result: WUSH 对 INT 和 FP 量化均近似最优，能压缩动态范围并抑制离群值影响。
conclusion: 为低比特权激活联合量化提供有理论保障的数据自适应变换工具。
---

## Abstract
Quantizing LLM weights and activations is a standard approach for efficient deployment, but a few extreme outliers can stretch the dynamic range and amplify low-bit quantization errors. Prior transform-based mitigations (e.g., Hadamard rotations) are fixed and data-agnostic, and their optimality for quantization has remained unclear. We derive closed-form optimal linear blockwise transforms for joint weight-activation quantization under standard RTN AbsMax-scaled block quantizers, covering both integer and floating-point formats. The resulting construction, WUSH, combines a Hadamard backbone with a data-dependent second-moment component to form a non-orthogonal transform that is provably near-optimal for FP and INT quantizers under mild assumptions while admitting an efficient fused GPU implementation. Empirically, WUSH improves W4A4 accuracy over the strongest Hadamard-based baselines (e.g., on Llama-3.1-8B-Instruct in MXFP4, it gains +2.8 average points with RTN and +0.7 with GPTQ) while delivering up to 5.8$\times$ per-layer throughput over BF16 via FP4 MatMul. Source code is available at https://github.com/IST-DASLab/WUSH.

---

## 论文详细总结（自动生成）

### 1. 核心问题与整体含义
- **研究动机**：在大语言模型（LLM）的低比特权激活联合量化（如 W4A4）场景中，权重和激活中少数极端离群值（outliers）会大幅拉伸量化动态范围，从而显著放大低比特量化误差。尽管基于变换的缓解方法（如 Hadamard 旋转）能缓解这一问题，但这些变换是固定且数据无关的，对量化任务本身并不具备任何最优性保障。
- **待弥补的空白**：此前缺乏能够针对量化误差给出可证明的最优性保证、同时兼顾效率的变换设计方法。
- **整体意义**：本文首次将“线性变换设计”与“量化误差最小化”在闭式理论上结合起来，为低比特 LLM 量化提供了一条有理论依据、有可复现实现的自适应变换路径。

### 2. 方法论
- **核心思想**：在标准 RTN（Round-to-Nearest）AbsMax 缩放的分块量化框架下，同时优化权重和激活的线性变换，使变换后的张量在低比特标量量化（INT 与 FP）中最大化保留原始信息并最小化量化误差。
- **推导内容**：作者推导了联合权激活量化下线性分块变换的**闭式最优解**。该结果是针对 INT 和 FP 两种量化格式分别推出的，而不是仅凭经验设计或者事后调参。
- **WUSH 变换的结构**：由两个部分构成：
  - **Hadamard 主结构（backbone）**：负责能量均衡（energy equalization）；
  - **数据相关的二阶矩成分**：负责对权重-激活的低阶统计特性进行自适应适配。
  - 最终形成一种**非正交但可高效分解的变换**，在数值性质和实现复杂度之间取得平衡。
- **可证明性**：在温和假设下，该方法被证明对 FP 和 INT 量化器都是**近似最优**的。
- **工程实现**：WUSH 支持**融合 GPU 内核**，可在实际推理中高效执行，避免显式的张量变换带来的额外内存与带宽开销。

### 3. 实验设计
- **主要评估场景**：W4A4 联合量化部署，量化格式包括 MXFP4（FP 量化）以及 INT4 场景。
- **核心 benchmark**：使用 Llama-3.1-8B-Instruct 模型，评估模型在量化前后任务精度上的损失和恢复情况。
- **对比方法**：以最强 Hadamard 变换类基线为参照，包括：
  - 直接使用 Hadamard 旋转 + RTN 的量化路径；
  - Hadamard 旋转 + GPTQ 误差校正路径。
- **衡量指标**：
  - 平均精度提升（average accuracy points）；
  - 与标准 BF16 推理对比的单层吞吐率（per-layer throughput）。

### 4. 资源与算力
- 论文**摘要和 PDF 提取文本中未明确披露** GPU 型号、数量、训练或推理时长以及总算力消耗。
- 研究性质属于后训练量化（PTQ），因此推测没有大规模训练预算，但目前无法从材料中核实；若需复现，仍需补充资源信息。

### 5. 实验数量与充分性
- **实验数量**：材料中只明确引述了一组核心对比实验（Llama-3.1-8B-Instruct + MXFP4），外加一项效率分析（FP4 MatMul vs BF16）。
- **充分性评估**：
  - 体现了**方法在不同量化器类型（RTN 和 GPTQ）上的有效性**，表明插件的通用性；
  - 但模型规模和任务范围较窄（单模型单格式实验是明显的基础证据）；
  - 缺少多模型、多数据集、多层分布内外的泛化性实验；缺少消融分析（如去除 Hadamard 结构或二阶矩成分的效果）；
  - 文章能以接收版本存在，逻辑上应具备较完整正文实验，但从目前提供的 PDF 提取结果来看，证据仅来自摘要，**完整性评估受限于输入材料的不足**。

### 6. 主要结论与发现
- 变换确实可以做到**对量化器最优**：WUSH 在数学上给出了比数据无关 Hadamard 旋转更加合理的变换方向。
- **精度收益显著**：在 Llama-3.1-8B-Instruct + MXFP4 场景，WUSH 相对最强 Hadamard 基线的平均精度提升为：
  - RTN 路径：**+2.8 点**；
  - GPTQ 路径：**+0.7 点**。
- **性能收益明显**：通过 FP4 MatMul，WUSH 对比 BF16 可实现最高 **5.8 倍**的单层吞吐提升。
- 从而证明了 WUSH 能够在**精度和延迟两个维度上同时改善**低比特 LLM 部署的效率边界。

### 7. 优点
- **理论首创性强**：首次在标准低比特块量化分解下推导了适用于联合权激活自适应线变换的闭式最优形式，超越以往依赖经验、数据无关的变换选择。
- **格式通用性好**：同时覆盖 INT 与 FP 两类主流量化格式，具有现实推广价值。
- **工程友好性**：尽管变换形式非正交，仍设计了高效融合 GPU kernel，并非停留在理论层面。
- **与现有工具链兼容**：可直接叠加在 RTN 与 GPTQ 两种已有工作流上，具备较强的即插即用特性。
- **结果可复现**：开放源码（github），有利于后续研究建立基准。

### 8. 不足与局限
- **实验证据单薄**：当前展示中只给出单模型（Llama-3.1-8B-Instruct）上的精度情况，未证明在更大模型、更小位宽或者不同参数量级下的表现。
- **任务覆盖不足**：未明确提到完整的自然语言理解、生成、常识推理、多语言等标准 bench 集合（如 WikiText、MMLU、GSM8K 等），影响泛化能力的判断。
- **硬件与计算条件未披露**：无法评估复现成本和实际部署中变换实时计算的开销影响，尤其缺乏超长序列（KV cache 等动态场景）的基准测试。
- **理论假设的约束性**：“近似最优”依赖于温和假设，若有违反假设的数据分布，需要说明其失效边界，且材料中未见相关分析。
- **缺乏消融和敏感性分析**：对 Hadamard backbone 的必要性、二阶矩计算精度（例如对低精度场景的依赖）等缺乏系统验证；对 WUSH 在非 Transformer 结构适用的外推性也没有专门讨论。

（完）
