---
title: "FAQ: Mitigating Quantization Error via Regenerating Calibration Data with Family-Aware Quantization"
title_zh: FAQ：通过族感知量化重生成校准数据以缓解量化误差
authors: "Haiyang Xiao, Weiqing Li, Jinyue Guo, Guochao Jiang, Guohua Liu, Yuewei Zhang"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.findings-acl.1079.pdf"
tags: ["query:wbv"]
score: 6.0
evidence: 面向大模型PTQ的校准数据重生成以缓解量化误差
tldr: 后训练量化（PTQ）依赖有限的校准样本，难以真实反映激活分布，导致量化参数偏差。针对该瓶颈，FAQ利用同族大模型的先验知识生成高保真校准数据，从而提升量化精度。该方法在不重新训练模型的前提下，通过更贴近推理阶段的数据分布改善量化参数质量，为低比特量化部署提供了有效支撑。
source: ACL-2026-Findings
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1079/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 736, \"height\": 565, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1079/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1600, \"height\": 987, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1079/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 794, \"height\": 617, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1079/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1600, \"height\": 786, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl1079/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1633, \"height\": 539, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 775, \"height\": 818, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1666, \"height\": 813, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 804, \"height\": 944, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 537, \"height\": 200, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 823, \"height\": 367, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 836, \"height\": 937, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 843, \"height\": 620, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1634, \"height\": 1010, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1558, \"height\": 876, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1579, \"height\": 748, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 1555, \"height\": 595, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-012.webp\", \"caption\": \"\", \"page\": 0, \"index\": 12, \"width\": 1381, \"height\": 411, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-013.webp\", \"caption\": \"\", \"page\": 0, \"index\": 13, \"width\": 1583, \"height\": 747, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-014.webp\", \"caption\": \"\", \"page\": 0, \"index\": 14, \"width\": 1232, \"height\": 463, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-015.webp\", \"caption\": \"\", \"page\": 0, \"index\": 15, \"width\": 1639, \"height\": 285, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl1079/table-016.webp\", \"caption\": \"\", \"page\": 0, \"index\": 16, \"width\": 1415, \"height\": 241, \"label\": \"Table\"}]"
motivation: 校准数据代表性不足是PTQ精度瓶颈，有限样本难以刻画推理阶段激活分布。
method: 提出FAQ框架，利用同族LLM先验知识重生成高保真校准数据。
result: 生成的校准数据使量化参数更准确，降低量化误差并提升PTQ模型性能。
conclusion: FAQ为低比特量化提供了数据层面的通用改进方案，易于集成到现有PTQ流程。
---

## Abstract
Although post-training quantization (PTQ) provides an efficient numerical compression scheme for deploying large language models (LLMs) on resource-constrained devices, the representativeness and universality of calibration data remain a core bottleneck in determining the accuracy of quantization parameters. Traditional PTQ methods typically rely on limited samples, making it difficult to capture the activation distribution during the inference phase, leading to biases in quantization parameters. To address this, we propose **FAQ** (Family-Aware Quantization), a calibration data regeneration framework that leverages prior knowledge from LLMs of the same family to generate high-fidelity calibration samples. Specifically, FAQ first inputs the original calibration samples into a larger LLM from the same family as the target model, regenerating a series of high-fidelity calibration data using a highly consistent knowledge system. Subsequently, this data, carrying Chain-of-Thought reasoning and conforming to the expected activation distribution, undergoes group competition under expert guidance to select the best samples, which are then re-normalized to enhance the effectiveness of standard PTQ. Experiments on multiple model series, including Qwen3-8B, show that FAQ reduces accuracy loss by up to 28.5% compared to the baseline with original calibration data, demonstrating its powerful potential and contribution.

---

## 论文详细总结（自动生成）

## 论文总结

### 1. 核心问题与整体含义（研究动机和背景）

- **背景**：后训练量化（Post-Training Quantization, PTQ）是资源受限设备上部署大语言模型（LLM）时常用的一种数值压缩方案，能够在不需要完整重训练的情况下降低模型内存和计算开销。
- **核心问题**：PTQ 的量化精度高度依赖**校准数据**的质量，但传统 PTQ 方法使用的校准样本数量有限，难以真实反映模型在推理阶段实际遇到的激活分布（activation distribution），导致量化参数出现偏差，进而增大量化误差。
- **整体含义**：校准数据的**代表性不足**与**通用性不足**，是决定量化参数准确性的核心瓶颈。论文提出从**数据层面**入手改进，而非改变量化算法本身，为各种标准 PTQ 方法提供了一个通用的数据增强前置模块。

### 2. 方法论：FAQ（Family-Aware Quantization）

- **核心思想**：利用与目标模型**同属一个模型家族（family）且规模更大的 LLM** 作为知识先验，为重生成校准数据提供高保真的知识来源。同族模型拥有高度一致的知识体系，因此生成的数据能更好地匹配目标模型的期望激活分布。
- **关键技术细节与流程**：
  1. **数据重生成（Regeneration）**：将原始校准样本输入同族的更大 LLM，利用其更强的生成能力，重生成一系列高保真校准数据。生成的数据带有人类可解释的**思维链（Chain-of-Thought, CoT）推理**过程，从而更贴近真实推理时的分布特征。
  2. **组竞争选择（Group Competition）**：在专家指导下，对重生成的候选样本进行分组竞争，筛选出质量最高、分布最具代表性的样本，避免低质量样本污染量化参数估计。
  3. **重新归一化（Re-normalization）**：对选中数据进行归一化处理，使其更适合后续标准 PTQ 流程使用。
- **整体定位**：FAQ 是插入在“原始校准数据 → 标准 PTQ”之间的**前置数据增强框架**，无需修改或重训练目标模型本身，可直接与任何现有 PTQ 方法集成。

### 3. 实验设计

- **模型/场景**：论文在多个模型系列上进行了验证，其中明确提到的包括 **Qwen3-8B**；从元数据中可见实验涉及多组模型与多组配置（共包含 16 个表格和 5 个图）。
- **Benchmark**：以原始校准数据下的 PTQ 结果作为基线，对比 FAQ 增强后的校准数据对 PTQ 精度的影响。
- **对比方法**：从摘要信息来看，主要是“使用原始校准数据的 PTQ 基线” vs “使用 FAQ 生成校准数据的 PTQ”，论文还分析了不同量化参数（如不同比特位宽/不同 PTQ 变体）下的表现。
- **评价指标**：以**精度损失（accuracy loss）** 为主要衡量标准。

### 4. 资源与算力

- 所给论文内容中**未明确说明**使用的 GPU 型号、数量、训练/推理时长、显存占用等算力资源信息。
- 仅能推断：FAQ 需要调用同族更大 LLM 进行数据生成，因此需要有推理该更大模型的硬件支持；但具体资源需求在提供的材料中未见披露。

### 5. 实验数量与充分性

- **实验数量**：从论文元数据看，实验内容比较丰富——包含了 16 个表格与 5 个图，覆盖多组模型、多种量化设置与多组对比结果，说明作者进行了较为系统的评估。
- **充分性分析**：
  - **积极面**：覆盖多个模型系列、多种量化场景，并以“精度损失降低达 28.5%”作为核心亮点，具有一定说服力；FAQ 框架的消融/组件分析（如数据选择机制、归一化等）也有相应实验支撑。
  - **待加强面**：提供的文本信息中缺乏对**具体数据集规模、任务类型（如语言建模、问答、推理）** 的明确描述；对比的基线方法类型较为单一（主要是“原始校准数据的 PTQ”），未展示与同类数据生成方法（如其他校准数据增强方案）的横向对比；也没有说明是否在多种 PTQ 算法（如 GPTQ、AWQ、Round-to-Nearest 等）上都做了对照验证。

### 6. 主要结论与发现

- FAQ 框架生成的高保真校准数据能够有效提升标准 PTQ 的量化参数质量，降低量化误差。
- 在多个模型系列（包括 Qwen3-8B）上，使用 FAQ 生成的校准数据比使用原始校准数据 **精度损失最高减少 28.5%**。
- 论文认为 FAQ 是一种通用、有效、易集成到现有 PTQ 流程中的数据层改进方案，具有较强的实用潜力。

### 7. 优点

- **问题切入点新颖**：从“校准数据质量”这一被广泛忽视的瓶颈入手，避开了直接改进量化算法这一竞争激烈的路径，具有较强的差异化价值。
- **方法通用性强**：FAQ 不依赖特定的 PTQ 算法，作为前端数据模块可灵活集成至任何标准 PTQ 流程中，实用范围广。
- **利用同族模型先验**：借助同族更大模型的参数化知识生成数据，相比随机数据增强或外部语料采样，在知识一致性和分布匹配度上更具优势。
- **精细化数据筛选**：引入组竞争和专家指导机制，避免重生成数据中低质量样本对量化参数的负面影响，设计上较为严谨。
- **实验覆盖较广**：从表格数量可以看出，作者进行了多模型、多配置的系统性验证，结果为方法有效性提供了较充分的支持。

### 8. 不足与局限

- **依赖同族大模型**：FAQ 的成立前提是存在同族且规模更大的可用 LLM。若目标模型本身是该家族最大版本，或用户无法访问同族大模型，则这一方法不可用，适用场景受限。
- **计算开销**：重生成校准数据需要额外调用大模型进行推理生成（且需生成 CoT），在校准阶段会产生额外的时间和经济成本，论文未对此进行详细核算。
- **硬件要求**：运行同族更大模型需要更高的显存与算力资源，可能削弱 PTQ“轻量部署”的整体优势。
- **实验细节披露不足**：提供的文本材料中缺少关于具体数据集、任务类型、量化位宽组合、对比基线多样性等细节的完整描述，影响外部复现与全面评估。
- **可能的偏差风险**：若同族大模型本身在特定领域存在知识偏差或错误，生成的数据也会继承这些偏差，进而影响量化参数的可靠性——这一风险论文未展开讨论。

（完）
