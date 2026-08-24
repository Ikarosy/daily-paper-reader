---
title: Reliable Evaluation Protocol for Low-Precision Retrieval
title_zh: 低精度检索的可靠评估协议
authors: "Kisu Yang, Yoonna Jang, Hwanseok Jang, Kenneth Choi, Isabelle Augenstein, Heui-Seok Lim"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-short.33.pdf"
tags: ["query:wbv"]
score: 4.0
evidence: 低精度检索评估协议
tldr: 低精度检索中由于数值粒度降低会产生虚假平局，导致评估结果随平局处理方式而剧烈波动。本文提出更稳健的评估协议，包含高精度打分（HPS）和感知平局的检索指标（TRM），在最小化计算成本的同时降低分数方差。实验表明该协议能提供更可靠、可解释的低精度检索评估。该工作为低比特量化检索系统的公平评测提供了重要方法支持。
source: ACL-2026-Short
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-short/anthology-2026acl-short33/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 804, \"height\": 439, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-short/anthology-2026acl-short33/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 822, \"height\": 294, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-short/anthology-2026acl-short33/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 796, \"height\": 455, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-short/anthology-2026acl-short33/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 771, \"height\": 311, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-short/anthology-2026acl-short33/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1630, \"height\": 1852, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-short/anthology-2026acl-short33/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1633, \"height\": 1852, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-short/anthology-2026acl-short33/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 798, \"height\": 654, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-short/anthology-2026acl-short33/fig-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 795, \"height\": 639, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-short/anthology-2026acl-short33/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 795, \"height\": 241, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-short/anthology-2026acl-short33/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1653, \"height\": 838, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-short/anthology-2026acl-short33/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 798, \"height\": 301, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-short/anthology-2026acl-short33/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 799, \"height\": 263, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-short/anthology-2026acl-short33/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 403, \"height\": 313, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-short/anthology-2026acl-short33/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1495, \"height\": 540, \"label\": \"Table\"}]"
motivation: 低精度打分引起的虚假平局使检索评估结果不稳定，亟需更可靠的评估协议。
method: 提出高精度打分提升最终计分精度，并设计平局感知指标报告期望分数、范围与偏差。
result: 新协议显著降低分数方差，使低精度检索评估更可靠且计算开销小。
conclusion: 为低精度或量化检索系统提供标准化的稳健评测方法。
---

## Abstract
Lowering the numerical precision of model parameters and computations is widely adopted to improve the efficiency of retrieval systems. However, when computing relevance scores between the query and documents in low-precision, we observe spurious ties due to the reduced granularity. This introduces high variability in the results based on tie resolution, making the evaluation less reliable. To address this, we propose a more robust retrieval evaluation protocol designed to reduce score variation. It consists of: (1) High-Precision Scoring (HPS), which upcasts the final scoring step to higher precision to resolve tied candidates with minimal computational cost; and (2) Tie-aware Retrieval Metrics (TRM), which report expected scores, range, and bias to quantify order uncertainty of tied candidates. Our experiments test multiple models with three scoring functions on twelve retrieval datasets to demonstrate that HPS dramatically reduces tie-induced instability, and TRM accurately recovers expected metric values. This combination enables a more consistent and reliable evaluation system for lower-precision retrieval.

---

## 论文详细总结（自动生成）

## 1. 核心问题与整体含义（研究动机与背景）

- **研究动机**：低精度技术（如量化、压缩）被广泛用于提升检索系统的效率和可扩展性，同时降低计算成本。将模型参数和计算从 FP32 降到 BF16/FP16 等低精度格式已成为常态，尤其在 RAG（检索增强生成）管线的检索阶段。
- **核心问题**：低精度数值格式因尾数位减少，导致数值粒度变粗，使原本不同的相关度分数被量化到同一值，产生**虚假平局（spurious ties）**。当查询与文档之间的相关度分数计算在低精度下进行时，平局大量出现且如何打破平局缺乏统一约定，现有的主流评估系统（如 MTEB）按任意内部顺序（如文档 ID）截断排名列表，导致**评估结果高度不稳定、方差大、甚至出现模型排名反转**。
- **整体含义**：论文首次系统性地指出现有低精度检索评估协议存在根本性缺陷，并提供一个可靠、可复现的评估协议，将评估结果从"依赖随机平局处理顺序"中解放出来，为低精度检索系统的公平比较和未来发展建立更可靠的基础。

## 2. 方法论（核心思想、技术细节、算法流程）

作者提出双管齐下的可靠评估协议，包含两个核心组件：

### 2.1 High-Precision Scoring (HPS) — 高精度打分

**核心思想**：只在打分阶段（score computation）将低精度 logits 上转（upcast）为 FP32，其余计算仍保持低精度，以极低成本消除大部分虚假平局。

**技术细节**：
- 替换低精度打分函数：\( \hat{s}_i = \phi(\text{upcast}(z_i)) \)，其中 \( z_i \) 是低精度模型输出的 logits（如 sigmoid/softmax 的输入或双编码器的嵌入向量）。
- 每个 FP16/BF16 值在 FP32 中均可被精确表示，因此上转保留了原始数值真实值，无损信息。
- 实现极其简单（如图 2 所示），通常只需修改一行代码，将 logits 在打分前转换为 FP32。
- 相比全 FP32 推理，HPS 只上转最终 logits 张量，额外内存开销小和时间开销可忽略（见附录 E）。

### 2.2 Tie-aware Retrieval Metric (TRM) — 平局感知检索指标

**核心思想**：不再依赖任意的平局打破规则，而是基于所有可能的平局内部排列，对评测指标计算**精确期望值**，并额外报告**范围（Range）**和**偏差（Bias）**，从而量化平局带来的排列不确定性。

**技术细节**：
- **期望分数**：对按分数降序排列的平局组 \( G_1, \dots, G_N \)，利用每组大小 \( |G_n| \) 和相关项目数 \( r_n \)，闭式求解各指标期望（如 Hits、Recall、Precision、F1、nDCG、RR、AP），公式见附录 D。
- **Score Range**：计算每例上 \( M_{\max} - M_{\min} \) 后取平均，用于衡量仅由平局内部排序不确定性造成的指标波动区间。
- **Score Bias**：定义为平局忽略（tie-oblivious）分数与期望分数之差 \( M_{obl,i} - \mathbb{E}[M]_i \)，可揭示实现中固有顺序带来的系统性高估或低估。
- **复杂度**：TRM 在线性时间 \( O(k + N) \) 内完成，远低于前向传播和排序的代价。

## 3. 实验设计

- **模型**：共 5 个模型，覆盖三种流行打分函数——
  - Softmax：Qwen3-Reranker-0.6B（596M）
  - Sigmoid：bge-reranker-v2-m3（568M）、gte-multilingual-reranker-base（306M）
  - Pairwise Product：Qwen3-Embedding-0.6B（596M）、multilingual-e5-large（560M）
- **数据集**（共 12 个）：
  - **MIRACLReranking**：多语言重排数据集（英文测试集 717 条查询，每查询 100 个候选）
  - **AskUbuntuDupQuestions**：375 条查询，每查询 20 个候选
  - **MTEB-R（10 个数据集）**：ArguAna、ClimateFEVERHard-Negatives、CQADupstackGamingRetrieval、CQADupstackUnixRetrieval、FEVERHard-Negatives、FiQA2018、HotpotQAHardNegatives、SCIDOCS、Touche2020Retrieval.v3、TRECCOVID（各取 BM25 检索 top-1K 候选）
- **评估指标**：nDCG、MRR、MAP、Recall（覆盖不同 cutoff）
- **精度设置**：全 FP32、BF16、FP16，以及 BF16→FP32（+HPS）、FP16→FP32（+HPS）
- **对比方法**：无 HPS 的平局忽略基线（依赖框架内预定义索引顺序） vs 有 HPS；替代策略（随机平局打破、确定性启发式、原始 logits、温度缩放、全精度）在附录 G 中对比。

## 4. 资源与算力

- **明确说明的**：HPS 的额外计算开销极低——在 NVIDIA H200 上，将 1,000,000（batch）× 1,024（hidden size）的 FP16 元素转换为 FP32 仅需约 5ms；峰值额外内存约 2MB（k=1,024, d=1,024）。
- **未明确说明的**：全文未给出完整实验所需的 GPU 型号/数量、总训练（或推理）时长、能耗等整体算力信息，只提及 HPS 上转操作耗时，因此无法从文中获得整体算力消耗的全貌。

## 5. 实验数量与充分性

- **实验数量**：主表（表 1，2 个主数据集 × 2~3 个指标 × 5 模型 × 3 种精度设置）+ 表 6（MTEB-R 上 10 个数据集 × 5 个模型 × 2 个指标 × 3 种精度设置），外加附录中的图 5/6 展示全 cutoff 曲线、表 3/4/5 展示精确度相关量化分析（唯一分数数、平局组大小、Spearman 秩相关）。整体共覆盖 12 个数据集、5 个模型、3 种打分函数、多种精度模式和 4 类指标，实验量比较充足。
- **充分性评价**：整体较充分——覆盖了重排模型和嵌入模型两类主要架构、三种主流打分函数、西方语言与多语言数据集，并对 HPS 与替代方案进行了系统性比较（附录 G）。但所有数据集均为文本检索场景，未覆盖多模态检索/代码检索等；所有实验在 H200 级别 GPU 上完成，未进行跨硬件/框架的复现验证。

## 6. 主要结论与发现

- **BF16 下虚假平局导致严重不稳定**：以 Qwen3-Reranker（softmax）为例，MRR@10 的范围高达 38.03%p，nDCG@10 的范围达 25.59%p，远超模型间性能差异的典型幅度。
- **平局忽略评估产生系统性偏差**：所有 BF16 实验中 Bias 均为正值（最高 +9.08%p），说明平局忽略指标系统性高估性能；且会引发排名反转（如 Qwen3 在平局忽略指标下看似优于 gte，但期望分数翻转）。
- **HPS 大幅降低不稳定范围**：BF16 加 HPS 后，softmax 模型 MRR@10 的 range 从 38.03 降到 1.21%p，sigmoid 模型约降低一个数量级，pairwise product 模型完全确定性（range = bias = 0）。
- **TRM 准确反映真实性能**：期望分数将 BF16 正确置于 FP32 之下，与真实模型质量一致。
- **结论**：结合 HPS 与 TRM 的协议可在保留低精度计算效率的同时，恢复接近全 FP32 的稳定性与排序一致性，为低精度检索提供可靠的评测基础。

## 7. 优点

- **方法轻量且实用**：HPS 只需一行代码修改，无重训练要求，仅上转最终打分张量，时间/内存开销可忽略；TRM 线性时间复杂度，不增加 log 因子。
- **理论保证**：证明使用原始 logits 替代 HPS 无排序收益（通过中值定理证明区分度阈值远超 16 位精度网格），为方法提供严谨性。
- **提供诊断工具**：TRM 的期望值+范围+偏差三个维度不仅给出更准确的分数，还量化了平局不确定性并揭示数据构建中相关文档更靠前的系统性偏差。
- **广泛的实验验证**：覆盖多语言、多模型、多打分函数、多精度格式、多指标，结果一致支持协议有效性。
- **易落的代码与可复现性**：提供了开源代码，增强可复现性。

## 8. 不足与局限

- **仅针对推理阶段**：论文未研究低精度训练对排名稳定性的影响，也未探索混合精度训练与 HPS 推理结合的效果。
- **未测试下游 RAG 影响**：未实证测量协议对 RAG 生成质量的最终影响（尽管作者论证了二者相关性已有理论依据和文献支持）。
- **数据集覆盖以英文为主**：MTEB-R 的 10 个数据集均为英文，虽包含 MIRACL 多语言集，但对比广度仍有限。
- **FP32 并不绝对真实**：以 FP32 作为 ground truth，但 FP32 本身同样存在微小量化误差，在某些极端敏感场景下仍可能误判。
- **未探索更极端量化**：BF16/FP16 之外，INT8/FP8 等更低比特格式下该方案是否仍有效未作测试。
- **批量大小依赖未充分讨论**：文中提到批量大小影响低精度推理表示，仅固定 batch size=16，未分析不同 batch size 的影响。

（完）
