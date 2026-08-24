---
title: Benchmarking Post-Training Quantization of Large Language Models under Microscaling Floating Point Formats
title_zh: 微缩放浮点格式下大语言模型训练后量化基准评测
authors: "Manyi Zhang, Ji-Fu Li, Zhongao Sun, Haoli Bai, Hui-Ling Zhen, Zhenhua Dong, Xianzhi Yu"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.1854.pdf"
tags: ["query:wbv"]
score: 6.0
evidence: 系统评测 MXFP 格式下的多种训练后量化算法，提供低比特格式的先进实验结论。
tldr: 微缩放浮点（MXFP）是新兴的低精度格式，但其与主流整数 PTQ 算法的适配尚未系统研究。本文对 7 种以上 PTQ 算法、15 个评测基准和 3 个模型家族进行系统评测，发现 MXFP8 几乎无损而 MXFP4 仍有明显退化。研究还表明 PTQ 的效果强依赖于格式与算法的兼容性。该基准为低比特量化格式选择提供了重要参考。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1854/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 791, \"height\": 347, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1854/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 639, \"height\": 465, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1854/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1646, \"height\": 280, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1854/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1644, \"height\": 439, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1244, \"height\": 1273, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1241, \"height\": 1273, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1320, \"height\": 1116, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 799, \"height\": 167, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 802, \"height\": 264, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 798, \"height\": 150, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1459, \"height\": 1035, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 798, \"height\": 486, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1642, \"height\": 1387, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1641, \"height\": 2078, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1854/table-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 1644, \"height\": 2080, \"label\": \"Table\"}]"
motivation: 现有 PTQ 算法聚焦整数量化，MXFP 格式下的行为与适用性尚未充分探索。
method: 对多种 PTQ 算法在 MXFP4/8 格式下进行大规模系统基准评测与分析。
result: MXFP8 近乎无损，MXFP4 仍有精度挑战，格式兼容性显著影响 PTQ 性能。
conclusion: 为 MXFP 低精度量化在 LLM 部署中的应用提供了系统性实验依据。
---

## Abstract
Microscaling Floating-Point (MXFP) has emerged as a promising low-precision format for large language models (LLMs). Despite various post-training quantization (PTQ) algorithms being proposed, they mostly focus on integer quantization, while their applicability and behavior under MXFP formats remain largely unexplored. To address this gap, this work conducts a systematic investigation of PTQ under MXFP formats, encompassing over 7 PTQ algorithms, 15 evaluation benchmarks, and 3 LLM families. The key findings include: 1) MXFP8 consistently achieves near-lossless performance, while MXFP4 introduces substantial accuracy degradation and remains challenging; 2) PTQ effectiveness under MXFP depends strongly on format compatibility, with some algorithmic paradigms being consistently more effective than others; 3) PTQ performance exhibits highly consistent trends across model families and modalities, in particular, quantization sensitivity is dominated by the language model rather than the vision encoder in multimodal LLMs; 4) The scaling factor of quantization is a critical error source in MXFP4, and a simple pre-scale optimization strategy can significantly mitigate its impact. Together, these results provide practical guidance on adapting existing PTQ methods to MXFP quantization.

---

## 论文详细总结（自动生成）

## 论文总结：微缩放浮点（MXFP）格式下大语言模型训练后量化（PTQ）的系统性基准评测

**论文标题**：Benchmarking Post-Training Quantization of Large Language Models under Microscaling Floating Point Formats  
**作者**：Manyi Zhang, Ji-Fu Li, Zhongao Sun, Haoli Bai, Hui-Ling Zhen, Zhenhua Dong, Xianzhi Yu（华为）  
**发表**：ACL 2026 Long Papers

---

### 1. 论文的核心问题与整体含义（研究动机和背景）

- **背景**：大语言模型（LLM）规模不断增长，对内存和计算资源提出了极高要求，量化成为关键的模型压缩与加速手段。近年来，微缩放浮点（Microscaling Floating Point, MXFP）作为一种块级（block-level）低精度数值格式逐渐兴起，它通过共享缩放因子更好地保留全精度模型的动态范围，并已获得 AMD、NVIDIA 等主流硬件的支持。
- **核心问题**：现有训练后量化（Post-Training Quantization, PTQ）算法大多针对整数（INT）格式设计与优化，而这些算法在 MXFP 格式下的适用性、有效性和失败模式尚未被系统探索。
- **研究目标**：对多种主流 PTQ 算法在 MXFP 格式下进行大规模、多维度的实证评测，回答四大研究问题（RQ1–RQ4）：
  - RQ1：不同 MXFP 位宽（MXFP8/MXFP4）对模型精度的影响
  - RQ2：各类 PTQ 算法与 MXFP 的兼容性差异
  - RQ3：模型家族（LLM vs MLLM）和模态对量化效果的影响
  - RQ4：MXFP4 量化中各组件的误差来源和优化策略

### 2. 论文提出的方法论：核心思想、关键技术细节

本文不提出新的量化算法，而是建立了系统化的评测框架，将现有 PTQ 方法划分为四类并逐一评测：

- **四类 PTQ 方法分类**：
  - **通道级变换**（Channel-wise Transformation）：SmoothQuant（逐通道缩放，将激活量化难度迁移到权重）、AWQ（保护关键权重）
  - **误差补偿**（Error Compensation）：GPTQ（利用 Hessian 逆矩阵逐层更新权重以最小化量化误差）、MR-GPTQ（专门针对 FP4 格式优化的 GPTQ 扩展，引入块级 Hadamard 变换）
  - **旋转变换**（Rotational Transformation）：QuaRot（随机正交旋转）、SpinQuant（校准阶段可学习旋转）
  - **仿射变换**（Affine Transformation）：FlatQuant（通过轻量块级训练学习逐层最优仿射变换，使分布更平坦）

- **MXFP 格式技术细节**：
  - MXFP 采用块大小 32，每块共享一个 UE8M0 数据类型缩放因子
  - MXFP8 采用 E4M3 变体（3 位尾数）；MXFP4 采用 E2M1
  - 量化公式定义为：$W_q := \text{nearest}(\lfloor W/s \rceil, \mathcal{C}_{FP}) \cdot s$，其中 $s$ 为缩放因子，$\mathcal{C}_{FP}$ 为可表示的浮点值集合
  - 针对 MXFP4 动态范围有限导致的系统裁剪偏差，引入 **Pre-scale 策略**：在量化前先将输入乘以 3/4，防止裁剪同时保留相对量级

### 3. 实验设计：数据集、Benchmark 与方法对比

- **量化配置（Quantization Settings）**：
  - 仅权重量化（Weight-Only）、权重-激活量化（Weight-Activation）、KV Cache 量化
  - 主要位宽配置：W8A8、W4A8、W4A4；另有补充配置 W4A16、W4A8KV8

- **评测基准（15 个以上）**：
  - 语言建模质量：WikiText2（PPL）
  - 非推理零样本任务：PIQA、Winogrande、HellaSwag、ARC-Easy、ARC-Challenge
  - 推理基准：MATH-500、AIME24、AIME25
  - 多模态基准：OCRBench、MMBench、MMBench CN、TextVQA、ChartQA、MME、MMMU
  - 补充实验：RULER 长上下文基准（4K–128K token）

- **评测模型（3 个模型家族、4 个模型）**：
  - LLM：Llama-3.1-8B-Instruct、openPangu-Embedded-7B-V1.1（双系统推理模型）
  - MLLM：Qwen2.5-VL-7B、openPangu-VL-7B

- **对比方法（8 种以上）**：RTN（基线）、QuaRot、SpinQuant、FlatQuant、AWQ、SmoothQuant、MR-GPTQ、GPTQ，以及各方法与 GPTQ 集成的变体（带 * 标记）

- **性能分级标准**：依据相对 BF16 的恢复率划分三档：无损（≤1% 下降）、尚可（1%–3% 下降）、高风险（≥3% 下降）

### 4. 资源与算力

- **论文未明确报告**所使用的 GPU 型号、具体数量或训练/评测时长
- 仅说明使用 microxcaling 库（微软开源）模拟 MXFP 量化，评测时以 vLLM 作为推理后端
- 这是一个值得注意的信息缺失，评测的算力成本无法从文中直接估算

### 5. 实验数量与充分性

- **实验规模较大且维度丰富**：
  - 主实验覆盖 3 种位宽配置 × 8 种以上 PTQ 方法 × 4 个模型 × 十余个基准
  - 附录补充了 W4A16、W4A8KV8、推理任务（表 7）、openPangu-VL-7B 完整结果（表 8）、长上下文 RULER 评测（表 11）
  - 组件级消融：缩放因子误差分析（图 4）、Pre-scale 策略消融（表 6）
  - 多模态组件分解：LLM vs ViT 分别量化的贡献分析（表 4）
  - 文本 token vs 视觉 token 量化敏感性对比（表 5）
- **充分性评估**：
  - **优点**：实验矩阵相当全面，涵盖多种模型架构、模态、位宽、方法和任务类型，足以支撑论文的主要结论；跨模型相关性分析（平均皮尔逊相关系数 0.917）增强了结论的稳健性
  - **不足之处**：所有模型均在 7B/8B 规模，未见更大规模（如 30B+）验证；部分方法（如 MR-GPTQ）在 W4A16/W4A8KV8 配置下缺失数据；RULER 评测使用了 100 samples/task 而非官方标准的 500 samples/task（作者已声明）

### 6. 论文的主要结论与发现

- **发现 1（MXFP8 vs MXFP4）**：W8A8 在所有模型和任务上均近乎无损，可安全部署且稳健于 PTQ 方法选择；W4A8 是性能拐点，经算法优化后可接近无损，但推理任务上仍处于风险区间；W4A4 则对几乎所有方法都构成高风险（恢复率最低至 86.37%），4-bit 权重或激活量化仍是开放挑战
- **发现 2（算法兼容性）**：
  - 误差补偿方法（GPTQ、MR-GPTQ）整体优于通道级变换方法（SmoothQuant、AWQ）
  - 旋转变换（QuaRot、SpinQuant）在 MXFP4 下显著损害精度，甚至不如 RTN 基线——原因是全局旋转破坏了 MXFP 分组量化的局部统计特性
  - 仿射变换（FlatQuant）在 4-bit 量化下最稳健，因其可调制绝对量级
  - RTN 仍是强基线，说明现有方法多为 INT 格式定制，不能直接迁移到 MXFP
- **发现 3（跨模型与模态一致性）**：
  - 各模型间 PTQ 性能曲线高度一致（平均相关系数 0.917）
  - 多模态模型中，量化敏感度主要由 LLM 组件主导（LLM 4-bit 量化导致约 3% 下降，ViT 同样量化仅约 1% 下降），建议采用 LLM 保精度、ViT 激进量化的混合精度策略
  - 视觉 token 在 MXFP 下比 INT 格式更鲁棒，降低视觉 token 位宽几乎无精度损失（归因于 MXFP 指数-尾数解耦对宽动态范围的适应性）
- **发现 4（缩放因子是 MXFP4 关键误差源）**：E8M0 缩放因子受限于 2 的幂次，导致量化误差显著；高精度缩放因子可明显改善 PPL；Pre-scale（乘 3/4）策略简单有效，将平均准确率从 52.39% 提升至 56.76%，PPL 从 104.42 降至 49.33

### 7. 优点：方法与实验设计的亮点

- **填补研究空白**：首次系统性地将主流 PTQ 算法迁移到 MXFP 格式下进行评测，为 MXFP 时代的量化方法设计提供了重要参考基线
- **评测框架系统化**：将 PTQ 方法按核心原理分为四类，评测不同类别的适用性，而非简单罗列结果，便于提炼规律性结论
- **多维度交叉验证**：同时覆盖 LLM 与 MLLM、推理与非推理任务、多种位宽配置，通过跨模型相关性分析增强了结论的普适性
- **细粒度组件分析**：不仅报告端到端精度，还深入剖析缩放因子误差、ViT/LLM 分别量化、文本/视觉 token 差异等细粒度问题，提供了可操作的部署指导
- **实用性强的建议**：如"LLM 保 8-bit、ViT 可 4-bit"的混合精度策略、"Pre-scale 优化"以及 8-bit KV cache 的非零风险提示，均具有直接工程价值
- **诚实报告局限性**：明确标注了模型规模范围、未评估 NVFP 等边界条件

### 8. 不足与局限

- **模型规模覆盖有限**：评测集中于 7B/8B 参数规模的模型，未能验证结论在 30B 以上更大模型上的适用性；作者也承认这一点
- **格式覆盖不完全**：未评测 NVIDIA 专属的 NVFP4/NVFP8 等其他微缩放格式变体，结论的跨格式泛化性未验证
- **个别数据缺失**：MR-GPTQ 在 W4A16 和 W4A8KV8 配置下未提供结果；部分表格中个别方法条目为空白
- **RULER 长上下文评测使用非标准采样数**：100 samples/task 与官方 500 samples/task 不一致，可能影响与外部结果的直接可比性（作者对此做了说明）
- **量化模拟依赖特定库**：实验全部基于 microxcaling 库，未说明该库与实际硬件上 MXFP 实现（如 AMD CDNA4、NVIDIA Blackwell）在细节上是否完全一致，可能引入模拟偏差
- **缺少推理效率与内存收益的量化分析**：论文关注精度表现，未报告量化后实际的内存节省、吞吐提升等部署收益，无法直接进行精度-效率权衡分析

---

（完）
