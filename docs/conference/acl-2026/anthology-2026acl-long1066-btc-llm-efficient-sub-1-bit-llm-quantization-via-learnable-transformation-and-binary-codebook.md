---
title: "BTC-LLM: Efficient Sub-1-Bit LLM Quantization via Learnable Transformation and Binary Codebook"
title_zh: BTC-LLM：通过可学习变换与二值码本实现高效亚 1 比特大语言模型量化
authors: "Hao Gu, Lujun Li, Hao Wang, Lei Wang, Zheyu Wang, Bei Liu, Jiacheng Liu, Qiyuan Zhu, Sirui Han, Yike Guo"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.1066.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 亚 1 比特大模型量化，使用二值码本与可学习变换，直接对应子 1 比特与码本 VQ 主题。
tldr: 大语言模型的亚 1 比特量化长期受制于性能下降和掩码管理开销。本文提出 BTC-LLM，通过二值模式聚类与可学习变换，利用二值码本将重复向量映射为紧凑索引，从而在不依赖剪枝的前提下实现极低比特压缩。实验在多个自然语言任务上显示该方法显著优于现有二值化方法，同时兼顾硬件兼容性与部署效率。该工作为极低比特 LLM 量化提供了新的技术路径。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 792, \"height\": 697, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1636, \"height\": 399, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 723, \"height\": 553, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1654, \"height\": 1025, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1653, \"height\": 448, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1466, \"height\": 2554, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1460, \"height\": 2523, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1329, \"height\": 2545, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1066/fig-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1325, \"height\": 2565, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1647, \"height\": 1015, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1645, \"height\": 522, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 512, \"height\": 200, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 695, \"height\": 197, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 794, \"height\": 322, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 795, \"height\": 269, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1475, \"height\": 201, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 796, \"height\": 510, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1649, \"height\": 1733, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1066/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1649, \"height\": 971, \"label\": \"Table\"}]"
motivation: 现有亚 1 比特量化依赖剪枝导致性能下降、掩码管理开销大且硬件兼容性差。
method: 提出二值码本对重复向量聚类为紧凑索引，并引入可学习变换以缓解量化误差。
result: 在多项自然语言任务上超越当前二值化方法，显著减少存储与计算开销。
conclusion: BTC-LLM 展示了基于码本与可学习变换的亚 1 比特量化前沿方案，兼具性能与效率。
---

## Abstract
Binary quantization represents the most extreme form of compression, reducing weights to ± 1 for maximal memory and computational efficiency. While recent sparsity-aware binarization achieves sub-1-bit compression via weight pruning, it faces critical challenger: performance degradation, mask-management overhead, and limited hardware compatibility. In this paper, we present BTC-LLM, a novel sub-1-bit LLM quantization framework that leverages binary pattern clustering and weight transformation to overcome these limitations. Our approach incorporates two key innovations: (1) a Binary Codebook that clusters recurring vectors into compact indices using custom distance metrics and sign-based updates; (2) a Learnable Transformation that reduces outliers and promotes shared sign patterns among binary weights. This eliminates sparse masks, enabling efficient inference on standard hardware. Extensive evaluations across LLaMA, Qwen, and FBI-LLM families demonstrate that BTC-LLM achieves state-of-the-art results in extreme compression (1.11–0.7 bits). Notably, BTC-LLM compressed to 0.8 bits on LLaMA-2-13B maintains high performance—with only a 3.1% accuracy drop in zero-shot benchmarks—while delivering a 1.6 × speedup over FP16.

---

## 论文详细总结（自动生成）

# BTC-LLM：通过可学习变换与二值码本实现高效亚 1 比特大语言模型量化 —— 中文总结

## 1. 核心问题与整体含义（研究动机与背景）

- **研究背景**：大语言模型（LLM）在自然语言处理领域取得巨大成功，但其庞大的参数规模和高昂的推理成本使其部署到边缘设备时面临严峻挑战。模型量化是一种有效的压缩手段，其中**二值量化（±1）** 是最极端的压缩形式，能将权重压缩到极致的内存占用并显著提升计算效率。
- **核心问题**：现有基于**稀疏性感知的二值化方法**虽然通过权重剪枝实现了亚 1 比特（sub-1-bit）压缩，但面临三大关键挑战：
  1. **性能下降**：剪枝导致模型精度损失严重。
  2. **掩码管理开销**：稀疏掩码（mask）的存储和计算带来了额外的内存与计算成本。
  3. **硬件兼容性差**：稀疏模式与标准硬件（如 GPU 的稠密矩阵运算加速单元）不兼容，难以在实际部署中获得理想加速。
- **整体含义**：本文旨在从方法论层面克服上述局限，探索一条**不依赖剪枝**、**硬件友好**的亚 1 比特量化新路径，在极低比特率下尽可能保持模型性能并提升部署效率。

## 2. 方法论：核心思想、关键技术细节与算法流程

### 2.1 核心思想

BTC-LLM 的总体思路是：**利用二值码本将反复出现的向量模式聚类为紧凑索引，同时引入可学习变换来优化权重的二值化质量**——从而完全抛弃稀疏掩码，在标准硬件上实现高效推理。

### 2.2 两大核心创新

1. **二值码本（Binary Codebook）**：
   - 将权重矩阵中**反复出现的向量模式**进行聚类，用**紧凑的索引**代替原始向量。
   - 使用**自定义距离度量**来度量向量之间的相似性，并采用**基于符号（sign-based）的更新**策略来优化码本条目。
   - 其效果相当于将高维权重映射到有限的码本空间中，把每个权重向量替换为一个索引，从而实现大幅压缩。

2. **可学习变换（Learnable Transformation）**：
   - 在量化前对权重施加一个**可学习的线性变换**，目的是：
     - **减少离群值**（降低权重的动态范围，使量化更容易）。
     - **促进二值权重之间出现共享的符号模式**，使码本聚类更加高效。
   - 该变换与码本在训练中**联合优化**，以最小化量化误差。

### 2.3 算法流程（文字描述）

1. **输入**：预训练的 FP16 语言模型权重矩阵。
2. **变换阶段**：对每个权重矩阵应用可学习的线性变换（旋转/缩放等），以降低离群值和增强符号一致性。
3. **码本聚类**：在变换后的权重空间中，将相似的向量聚类为一个二进制码本条目；通过自定义距离度量迭代优化码本中条目的符号值。
4. **索引分配**：将每个权重向量匹配到最近的码本条目，仅存储其索引而非原始值。
5. **反量化**：推理时，根据索引查表得到对应的二值向量，再应用逆变换恢复近似权重（或在融合变换中直接计算）。
6. **联合优化**：通过反向传播，码本、索引分配与可学习变换参数同时更新。

## 3. 实验设计

### 3.1 数据集与基准（Benchmark）

- **模型家族**：
  - LLaMA（包括 LLaMA-2-13B 等不同规模）
  - Qwen
  - FBI-LLM
- **评测场景**：多种自然语言理解任务，主要在**零样本基准（zero-shot benchmarks）** 上评估（如常识推理、语言理解、问答等标准任务集）。
- **压缩区间**：目标在极低比特率范围内进行评估：**1.11–0.7 bits 每权重**。

### 3.2 对比方法

- 与现有的**二值化方法**（如常规 1-bit 量化方法）进行对比。
- 与**稀疏感知二值化方法**（sparsity-aware binarization，即依赖剪枝的 sub-1-bit 方法）进行对比。
- 与 **FP16 全精度基线**对比（用于评估性能损失）。

### 3.3 实验评估维度

- **精度/性能**：零样本任务上的准确率。
- **压缩率**：每权重位宽（bits per weight）。
- **推理效率**：相比 FP16 的推理加速比。

## 4. 资源与算力

- 论文文本中**未明确说明**训练所使用的 GPU 型号、数量、训练时长等具体算力资源信息。
- 仅从结果侧可以推断：实验覆盖了多个模型家族（LLaMA、Qwen、FBI-LLM）与多种规模的模型，属于中大规模的量化实验，但具体资源开销在提供的摘要文本中无从考证。
- 若需要精确的算力信息，须查阅原文的实验设置章节。

## 5. 实验数量与充分性

### 5.1 覆盖广度

- **模型多样性**：三个主流 LLM 家族（LLaMA、Qwen、FBI-LLM），覆盖不同规模和架构。
- **比特率范围**：从 1.11 bits 到 0.7 bits 的多个压缩率设置。
- **代表性结果**：LLaMA-2-13B 在 0.8 bits 下的详细性能报告。
- **效率验证**：包含推理加速比（1.6 × vs FP16）。

### 5.2 客观性与公平性评估

- **优点**：对比了当前最先进的二值化方法，且在同一基准上进行评估，其声称的 SOTA 结果有实验数据支撑。
- **不足**：
  - 提供的摘要文本**未展示消融实验**（如可学习变换单独作用、码本单独作用、两者联合的效果）——但原文中应有（从元数据看，共有 9 个图表和 10 张表格，说明实验内容较为丰富，具体细节未在摘要中呈现）。
  - **未见更大规模模型**（如 70B+）的评估，对超大规模模型的适用性需要进一步验证。
  - **未见更强的基线和传统低位宽方法**（如 2-bit、4-bit）的对比，仅与二值化方法比较。

## 6. 主要结论与发现

- **BTC-LLM 能够在不使用任何稀疏掩码的情况下实现亚 1 比特量化**，彻底消除了掩码管理开销和稀疏硬件兼容性问题。
- **性能显著优于现有二值化方法**：在多项自然语言任务上达到新的最先进水平。
- **在极低比特率下保持了可用的模型质量**：以 LLaMA-2-13B 为例，压缩至 0.8 bits 时，零样本基准仅下降 **3.1%** 的准确率，属于相当低的性能损失。
- **部署效率显著提升**：相比 FP16 实现了约 **1.6 × 的加速**，展示了在标准硬件上高效部署的潜力。

## 7. 优点

- **方法上的创新性**：将 VQ（向量量化）思想扩展到**二值空间**，提出"二值码本 + 可学习变换"的组合方案，既有理论新意，也有实用价值。
- **无需剪枝**：完全抛弃了稀疏掩码机制，从设计上规避了性能损失和硬件不兼容的两大痛点。
- **硬件友好**：所有操作在稠密计算框架内完成，标准 GPU/NPU 可直接高效执行，落地性强。
- **性能与效率的双重突破**：在极低比特（0.7–0.8 bits）下做到接近原有模型水平，同时获得实际的推理加速比。
- **实验覆盖较广**：多个模型家族和多种比特率设置使结论更具泛化性。

## 8. 不足与局限

- **实验覆盖范围有限**：
  - 未在超大模型（如 70B、100B+ 以上）上验证，极低比特量化对大模型的适用性仍有疑问。
  - 仅覆盖自然语言任务，**未涉及多模态、代码生成、翻译等任务类型**。
  - 对模型**微调后的下流任务**（如对话、指令遵循）的评估不明确。
- **码本查找的延迟开销**：虽然消除了剪枝掩码，但**码本查找（codebook lookup）操作本身**可能引入额外的内存访问开销，其在大规模并行推理时的性能表现需进一步分析。
- **可学习变换的双刃剑**：引入额外的变换参数意味着一定的存储与计算开销，在极低比特率的极端压缩目标下，此开销可能挤压有效压缩空间。
- **精度下降仍不可忽略**：3.1% 的精度损失在容量敏感的应用场景中可能仍然过高，更极端的 0.7-bit 设置下是否有更大的退化值得关注。
- **算力资源信息不透明**：未披露训练与量化所需的详细 GPU 资源、时长等，不利于复现推断。

（完）
