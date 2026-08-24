---
title: Task-Stratified Knowledge Scaling Laws for Post-Training Quantized Large Language Models
title_zh: 训练后量化大语言模型的任务分层知识缩放定律
authors: "Chenxi Zhou, Pengfei Cao (鹏飞 曹), Jiang Li, Bohan Yu, Jinyu Ye, Jun Zhao, Kang Liu"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.findings-acl.1165.pdf"
tags: ["query:wbv"]
score: 8.0
evidence: 跨比特宽度的训练后量化缩放定律
tldr: 现有训练后量化（PTQ）缩放定律只关注整体性能，忽略了不同知识能力的细粒度退化。本文提出任务分层知识缩放定律，将能力划分为记忆、应用与推理，统一建模模型规模、比特宽度、分组大小与校准集大小。在293种PTQ配置上验证了强拟合与跨架构一致性，揭示了各知识能力对量化的不同敏感性。该框架为低比特量化配置选择提供了理论指导。
source: ACL-2026-Findings
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1165/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 789, \"height\": 549, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1165/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1551, \"height\": 494, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1165/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1554, \"height\": 498, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1165/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 807, \"height\": 458, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1165/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 713, \"height\": 590, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1165/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1655, \"height\": 513, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1165/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1652, \"height\": 612, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1664, \"height\": 339, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1648, \"height\": 394, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 818, \"height\": 271, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1667, \"height\": 975, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1657, \"height\": 704, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 765, \"height\": 349, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1597, \"height\": 518, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1599, \"height\": 520, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1603, \"height\": 2362, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1608, \"height\": 2511, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1165/table-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 1630, \"height\": 1328, \"label\": \"Table\"}]"
motivation: 现有PTQ缩放定律忽略细粒度能力差异，无法指导不同知识场景的量化配置。
method: 将能力分层为记忆、应用、推理，建立统一缩放定律，涵盖模型规模、比特宽度、分组与校准集大小。
result: 在293种PTQ配置上验证强拟合和跨架构一致性，揭示各能力差异量化敏感度。
conclusion: 该框架可用于预测不同知识能力的量化损失，指导低比特量化部署。
---

## Abstract
Post-Training Quantization (PTQ) is a critical strategy for efficient large language models (LLMs) deployment. However, existing scaling laws primarily focus on general performance, overlooking crucial fine-grained factors and how quantization differentially impacts diverse knowledge capabilities. To address this, we establish Task-Stratified Knowledge Scaling Laws. By stratifying capabilities into memorization, application, and reasoning, we develop a framework that unifies model size, bit-width, and fine-grained factors: group size and calibration set size. Validated on 293 diverse PTQ configurations, our framework demonstrates strong fit and cross-architecture consistency. It reveals distinct sensitivities across knowledge capabilities: reasoning is precision-critical, application is scale-responsive, and memorization is calibration-sensitive. We highlight that in low-bit scenarios, optimizing these fine-grained factors is essential for preventing performance collapse. These findings provide an empirically-backed foundation for designing knowledge-aware quantization strategies.

---

## 论文详细总结（自动生成）

### 1. 论文的核心问题与整体含义（研究动机和背景）

- **背景**：训练后量化（Post-Training Quantization, PTQ）是大语言模型（LLM）高效部署的关键技术之一，能够压缩模型体积、提升推理速度。
- **现有问题**：已有的量化缩放定律（scaling laws）主要关注模型**整体性能**的平均退化趋势，忽略了两个重要方面：
  - 量化对不同**细粒度知识能力**（如记忆、应用、推理）的差异化影响；
  - 量化配置中**细粒度因素**（分组大小、校准集大小）对性能的调控作用。
- **研究动机**：在低比特量化场景下，不同知识能力对量化的敏感度不同，若不加以区分，可能导致某些关键能力（如推理）严重退化甚至崩溃，而现有理论无法指导“面向知识能力”的量化配置选择。
- **整体含义**：本文试图建立一套**任务分层知识缩放定律**，将知识能力分层建模，统一纳入模型规模、比特宽度、分组大小、校准集大小等因子，为知识感知的 PTQ 策略提供经验性的理论基础。

### 2. 论文提出的方法论：核心思想、关键技术细节、公式或算法流程

- **核心思想**：将 LLM 的知识能力划分为三个层次——**记忆（Memorization）**、**应用（Application）** 与 **推理（Reasoning）**，分别对应不同认知复杂度。针对每一层建立单独的缩放定律，揭示不同知识能力在量化过程中的退化规律。
- **统一建模框架**：将四个关键变量纳入同一数学框架：
  - 模型规模（模型参数量）
  - 比特宽度（bit-width）
  - 分组大小（group size）
  - 校准集大小（calibration set size）
- **公式/算法流程（文字说明）**：文中提出的缩放定律本质上是一个**多变量参数回归模型**，将每一知识能力层次的性能损失（或保留率）表示为上述四个变量的幂律组合形式。作者基于大量 PTQ 配置下的实测数据拟合出各变量的指数项，形成可预测不同配置下各能力退化程度的经验公式。整体流程为：
  1. 对模型执行 PTQ（设定不同的比特宽度、分组大小、校准集大小）；
  2. 分别评测模型在记忆、应用、推理三类任务上的性能；
  3. 收集全部配置下的三维性能数据；
  4. 对每一知识能力分别拟合缩放定律函数；
  5. 验证拟合优度和跨架构（不同模型族）的迁移一致性。

### 3. 实验设计：使用的数据集 / 场景、benchmark、对比方法

- **数据集/任务类型**：文中并未点名具体基准数据集（如 MMLU 等），而是将评测任务按认知层次归为三类：
  - 记忆类任务：考察模型对事实性知识的复现能力；
  - 应用类任务：考察模型运用知识解决具体问题的能力；
  - 推理类任务：考察模型进行逻辑推导、多步推理的能力。
- **PTQ 配置规模**：共使用 **293 种不同的 PTQ 配置**进行验证，覆盖不同模型规模、不同比特宽度、不同分组大小和校准集大小的组合。
- **跨架构验证**：研究覆盖了多种主流 LLM 架构（具体架构名称未在摘要中列出），以检验缩放定律的跨架构一致性。
- **对比方法**：主要对照对象为**传统整体性能缩放定律**（仅以平均精度为指标），本文通过分知识能力的细粒度拟合体现优势。

### 4. 资源与算力

- 原文摘要和元数据中**未明确说明**所使用的 GPU 型号、数量、训练（或量化拟合）时长、总算力开销等具体信息。
- 由于实验涉及 293 种量化配置在多个模型规模上的评测，推断需要较多 GPU 资源用于推理评测，但论文文本中未披露详细硬件配置。

### 5. 实验数量与充分性

- **实验数量**：293 种 PTQ 配置，覆盖四个变量（模型规模、比特宽度、分组大小、校准集大小）的广泛组合，实验规模可观。
- **充分性分析**：
  - **优势**：覆盖了多维度变量组合，且进行了跨架构验证，能够支撑“强拟合”和“跨架构一致”的结论；包含 8 组图表和 11 张表格，附录材料丰富；
  - **潜在不足**：评测任务是否覆盖足够多样的数据集未能明确；具体模型种类和参数量范围未在摘要中说明，可能对结论的普适性存在一定限制；各类知识能力任务的标注和划分依据未在摘要中细化，可能引入主观偏差。

### 6. 论文的主要结论与发现

- **三种知识能力对量化的敏感度不同**：
  - **推理能力（Reasoning）对精度最敏感**——在低比特下最先出现显著退化，属于 precision-critical 能力；
  - **应用能力（Application）对模型规模更敏感**——增大模型规模能够更好地补偿量化带来的应用能力损失，属于 scale-responsive 能力；
  - **记忆能力（Memorization）对校准集大小最敏感**——校准数据的质量和数量对记忆能力的保持有决定性影响，属于 calibration-sensitive 能力。
- **低比特场景下的重要警示**：当位宽很低时，仅调整比特宽度远远不够，必须同时优化分组大小和校准集大小等细粒度因素，否则容易引发**性能崩溃（performance collapse）**。
- **框架应用价值**：该缩放定律能够预测不同 PTQ 配置下各知识能力的退化程度，为部署者在给定资源约束下选择最优量化配置提供理论指导。

### 7. 优点：方法或实验设计上的亮点

- **细粒度视角**：首次将缩放定律从整体性能拓展到多维度知识能力层次，揭示不同认知能力的量化退化差异，填补了该方向空白。
- **统一建模框架**：同时纳入模型规模、比特宽度、分组大小、校准集大小四个变量，构建多因素联合缩放定律，显著增强理论表达能力。
- **大规模实验验证**：293 种配置的验证规模在同领域研究中较为充分，且验证了跨架构一致性，提升了结论的普适性。
- **实践指导性强**：结论直接服务于低比特量化部署中的配置选择问题，具有明确工程价值。

### 8. 不足与局限

- **实验细节披露不足**：未明确列出具体评测数据集、模型系列名称、参数量范围，以及各类知识能力任务的评测方式，影响结果的可复现性。
- **资源信息缺失**：未报告算力投入（GPU 型号与数量），难以评估实验成本。
- **知识能力分层可能存在主观性**：将任务划分为记忆/应用/推理三个层次，缺乏严格的心理学或认知科学依据，任务归类可能影响拟合结果的解释。
- **公式的工程适用性**：缩放律公式的具体形式和参数值未在摘要中给出，实际部署中使用的可操作性尚需阅读全文确认。
- **跨架构一致性的范围有限**：虽验证了跨架构一致性，但未明确涵盖的架构范围，对极低比特（如 2-bit）可能仍存在不确定的崩溃边界。
- **缺乏实际任务绩效验证**：结论主要基于回归拟合，未在真实部署场景中验证该定律指导下的性能提升幅度。

（完）
