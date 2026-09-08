---
title: Distilling Large Embeddings via Hyperspherical Householder Quantization
title_zh: 通过超球 Householder 量化蒸馏大规模嵌入
authors: "Yihang Wang, Bin Wu, Yueyang Su, Tianfu Zhang, Yiqi Du, Lei Yu, Jiafeng Guo (嘉丰 郭), Xueqi Cheng (程学旗)"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.482.pdf"
tags: ["query:wbv"]
score: 4.0
evidence: 嵌入向量的超球矢量量化，与极低比特大模型量化主题关联较弱
tldr: 大规模嵌入模型在检索系统中存储与计算开销很高；近期方法把嵌入量化为离散文档标识用于生成式检索，但常依赖与角度语义不匹配的欧氏量化并需要较长标识序列。本文提出超球 Householder 量化这一几何感知蒸馏方法，在单位超球面通过迭代 Householder 变换把大嵌入压缩成短的离散表示。结果显示该方法能够以较短序列保持语义保真并降低存储成本。这为检索场景下的低比特向量离散化提供了可借鉴的几何量化工具。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long482/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 693, \"height\": 530, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long482/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1644, \"height\": 639, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long482/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 761, \"height\": 579, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long482/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 773, \"height\": 822, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long482/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 781, \"height\": 1214, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long482/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 786, \"height\": 1266, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long482/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1493, \"height\": 1246, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long482/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1493, \"height\": 629, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long482/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1636, \"height\": 470, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long482/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1214, \"height\": 222, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long482/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 573, \"height\": 429, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long482/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 793, \"height\": 177, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long482/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 514, \"height\": 539, \"label\": \"Table\"}]"
motivation: 大规模嵌入存储开销大；欧氏量化与语义角度度量不匹配，且需要较长标识序列。
method: 提出超球 Householder 量化，在单位超球上迭代施加正交变换，将嵌入蒸馏成短离散表示。
result: 以更短序列保持语义保真并降低存储，适配生成式检索等下游任务。
conclusion: 说明几何感知的向量量化有助于嵌入压缩，但并非面向极低比特权重量化。
---

## Abstract
Large embedding models have become the backbone of modern retrieval systems, offering strong semantic representations at the cost of substantial storage and computation. While recent work explores quantizing embeddings into discrete document identifiers for generative retrieval, most existing approaches rely on Euclidean quantization, which is poorly aligned with the angular geometry induced by contrastive embedding training and often requires long identifier sequences to preserve semantic fidelity. In this work, we propose Hyperspherical Householder Quantization (HHQ), a geometry-aware distillation method that compresses large embeddings into short discrete representations via iterative Householder transformations on the unit hypersphere. By explicitly preserving cosine similarity at each step, HHQ distills semantic structure into compact identifiers that remain faithful to the original embedding space. To support reliable generation of these identifiers, we introduce constrained supervised fine-tuning and tree-aware dynamic masking to enforce structural validity during training and inference. Experiments on NQ and MS MARCO show that HHQ achieves competitive or superior retrieval performance using only five tokens per document, substantially reducing decoding cost while retaining strong semantic retrieval accuracy.

---

## 论文详细总结（自动生成）

# 详细中文总结

## 一、核心问题与整体含义（研究动机与背景）

大规模嵌入模型在现代检索系统中承担核心角色，但带来巨大的存储与计算开销。生成式信息检索（GenIR）尝试通过让模型直接生成文档标识（docid）来替代传统稠密索引，从而规避大规模向量存储与召回-排序不一致等问题。

然而，现有将连续嵌入量化为离散文档标识的方法（如 Product Quantization、Residual Quantization 等）存在两个结构性缺陷：

1. **几何度量不一致**：主流嵌入模型通过对比学习优化余弦相似度，语义信息主要编码在向量方向上；但传统量化方法基于欧氏距离（L2）设计，与超球面几何不匹配，破坏了嵌入的语义结构。
2. **标识长度过长或码本利用率不足**：为覆盖语料库，传统方法往往需要很长的 token 序列或极大的码本，导致解码开销高且易产生无效标识。

本文提出 **Hyperspherical Householder Quantization (HHQ)**，一种几何感知的嵌入蒸馏方法：在单位超球面上用一系列 Householder 反射将高维嵌入逐步量化为紧凑离散标识，从而在保持余弦相似性的前提下，以极短标识（通常 5 个 token）实现高效生成式检索。

整体含义在于：**离散标识的设计应与嵌入空间的几何结构对齐**，这既能提升量化精度与代码利用率，也能显著压缩标识长度、降低推理成本，为大规模检索系统提供更高效的索引与生成方案。

## 二、方法论

### 2.1 总体框架

HHQ 由两阶段组成：

- 训练一个 L 层超球量化器，将文档嵌入转换为离散标识；
- 基于这些标识，通过约束微调训练一个生成式检索器，使模型给定查询能直接生成对应文档的标识序列。

### 2.2 超球 Householder 量化机制

- 所有向量均归一化到单位超球面：\(x \leftarrow x/\|x\|_2\)，每层码本 \(V_i=\{v_{i,1},...,v_{i,K}\}\) 中的方向向量也满足单位范数。
- **第 1 层 token 选择**：选择与输入嵌入 \(x\) 余弦相似度最高的码字：

  \[
  idx_1 = \arg\max_k \langle x, v_{1,k}\rangle
  \]

  并将该码字作为初始近似 \(\hat{x}_1 = v_{1,idx_1}\)。

- **后续迭代**：对第 \(i>1\) 层，从码本中选择使 Householder 反射后与目标嵌入角度偏差最小的方向：

  \[
  idx_i = \arg\max_k \langle H(\hat{x}_{i-1}; v_{i,k}), x\rangle
  \]

  其中 Householder 反射定义为：

  \[
  H(z;v)=z-2\langle z,v\rangle v
  \]

  随后应用反射更新当前近似：

  \[
  \hat{x}_i = \hat{x}_{i-1} - 2\langle \hat{x}_{i-1}, v_{i,idx_i}\rangle v_{i,idx_i}
  \]

- Householder 变换是正交、范数保持且对合的；因此整个量化过程始终停留在单位超球面上，每一步 token 都代表一个方向性调整，逐步逼近原始嵌入。

### 2.3 码本初始化与端到端优化

- **初始化**采用分层 K-means：
  - 全局层：对文档嵌入做聚类，得到第一层码本；
  - 局部层：对当前近似与目标嵌入的归一化残差做聚类，初始化更深层方向码本。
- **训练目标**为余弦相似度重建损失：

  \[
  \mathcal{L} = 1 - \frac{1}{B}\sum_{j=1}^{B}\langle \hat{x}_L^{(j)}, x^{(j)}\rangle
  \]

  该损失直接优化最终的近似方向与原始嵌入方向的一致性，而非欧氏重建误差。

### 2.4 生成检索器的约束训练

为避免模型生成无效标识路径，论文引入：

- **Codebook Tree 构建**：从语料中提取所有有效标识路径，统计 token 间条件概率，构建层级树；
- **约束有监督微调（cSFT）**：在训练时根据已生成前缀，将非有效子节点的 logits 置为 \(-\infty\)，只允许在合法子节点上做 softmax 与交叉熵；
- **树感知动态掩码**（训练/解码中的概念）确保模型只输出真实存在的标识路径，显著加快收敛并提高结构有效性。

## 三、实验设计

### 3.1 数据集与指标

- **NQ320K**：基于 Natural Questions 的 320K 文档检索设置；
- **MS MARCO**：
  - Relevant 300K：包含至少一条相关查询的文档子集；
  - Random 300K：随机抽样的 300K 文档子集。

- 指标：Recall@1、Recall@10、MRR@10。

### 3.2 基线与比较对象

- 词法检索：BM25、DocT5Query；
- 稠密检索：Qwen3-Embedding（256-d）、DPR、RepBERT、Sentence-T5；
- 生成式检索（标题/文本标识）：SEAL、DynamicRetriever、WebUltron (TU)、ROGER (TU)；
- 生成式检索（结构化 ID）：DSI、DSI-QG、NCI、WebUltron (SI)、ROGER (SI)、MINDER、LTRGR、DDRO。

### 3.3 实现配置

- 生成器：T5-base；
- 嵌入：Qwen3-Embedding-8B + MRL，截断至 512 维；
- 标识长度：5 个 token；
- 码本大小：NQ 上每层 256，MS MARCO 上每层 1024；
- 训练：两阶段 SFT（伪查询阶段 + 真实查询阶段），各 10 epoch，学习率 1e-3。

## 四、资源与算力

**论文没有明确报告完整的训练算力清单**（如 GPU 型号、数量、总训练时长）。但从附录信息可知：

- 解码效率 benchmark 在单张 RTX 5090 GPU 上完成；
- 训练过程采用 T5-base 两阶段微调，量化器本身作为预处理开销可忽略；
- 作者指出总训练成本主要由生成模型微调主导。

因此，关于具体 GPU 卡时、显存使用或能耗，论文并未给出透明量化说明。

## 五、实验数量与充分性

实验覆盖较广，主要包括：

- 三个主实验数据集/子集上的完整检索效果对比（NQ320K、MS MARCO Relevant/Random）：
  - 超过 15 个基线；
  - HHQ 与所有主要范式（词法、稠密、生成式）对照。
- 大量消融与分析：
  - 伪查询阶段有无的对比（表 3，不同深度/维度共多组）；
  - cSFT 有无的训练动态对比（附录图 5）；
  - 代码利用率分析（附录 C），HHQ vs RQ-KMeans；
  - PQ 在相同 pipeline 下的受控对比（附录 E）；
  - 不同 MRL 嵌入维度影响（附录 B）；
  - 标识长度对解码吞吐的影响（附录 F，token 1~24 的 QPS/延迟逐项对比）。

总体而言，实验数量充分，消融设计较好。不过存在一些局限：

- 在 MS MARCO Relevant 300K 上 HHQ 明显弱于 DDRO，论文将其归因于嵌入空间的区分度不足；
- 主结果中 HHQ 的嵌入模型是 Qwen3-Embedding-8B (512-d)，而稠密基线取 256-d，对比口径并非完全一致；
- 未包含与更强 decoder-only 生成模型或更大 T5 系列的适配实验；
- 相关性与公平性仍需读者谨慎判断。

## 六、主要结论与发现

1. HHQ 在 **NQ320K** 上取得与 DDRO 竞争的结果（R@1 略低，R@10 和 MRR@10 更高），但仅需 5 个 token，显著降低解码成本。
2. 在 **MS MARCO Random 300K** 上，HHQ 用 5-token 标识接近使用 24-token 标识的生成式检索基线，吞吐量可提升约 4 倍。
3. **几何对齐是有效的**：在单位超球面上执行 Householder 反射比欧氏量化更适配对比学习嵌入，代码利用率接近 100%，远高于 RQ-KMeans/PQ。
4. **cSFT 至关重要**：无 cSFT 时模型难以学会有效标识映射；有 cSFT 后训练收敛更快、最终指标明显更高。
5. **伪查询预训练带来稳定收益**：在多种深度/维度配置下均提升 R@1 约 4~8 个点。
6. 标识长度是生成式检索“精度与效率”权衡中的关键因素。

## 七、优点

- **创新性强**：将 Householder 反射用于超球面量化，将离散标识生成与嵌入几何对齐，优于传统欧氏量化机制。
- **标识紧凑高效**：5-token 标识即可达到较好精度，显著缩短解码序列，在吞吐和延迟上优势明显。
- **训练流程设计严谨**：cSFT + 树感知掩码使生成模型与码树结构对齐，兼顾有效性与收敛速度。
- **分析较全面**：提供了代码利用率、与 PQ 的受控对比、不同 MRL 维度、伪查询与 cSFT 消融等多角度分析。
- **普适性**：HHQ 的标识序列不依赖特定生成器架构，可扩展到 decoder-only 模型。

## 八、不足与局限

- **数据集上的不稳定性**：在 MS MARCO Relevant 300K 上效果明显下降，显示 HHQ 依赖底层嵌入空间的语义区分度；在低多样性或紧密耦合语料中可能失效。
- **码本退化风险**：深层码字可能出现 “codebook collapse”，实际可用的有效码字减少。
- **固定码树扩展性**：标识空间与给定语料绑定，无法天然处理流式新文档；新文档加入可能需要码树扩展与生成器重训。
- **假设限制**：HHQ 假设语义可由余弦/方向关系表示，不适用于语义相关性不依赖角度结构的任务。
- **碰撞问题**：短标识存在少量碰撞，论文未充分讨论在更大语料或高相似文档场景下的影响。
- **算力报告不透明**：没有给出训练所用 GPU 数量、时长和总资源消耗。
- **对比公平性存在瑕疵**：部分基线的嵌入维度/标识长度与 HHQ 不一致，例如稠密 Qwen3 只用 256 维，而量化器使用 512 维；Relevant 300K 上性能差距的解释偏向定性归因。
- **实验规模有限**：仅在 300K 级语料与 T5-base 上验证，未扩展到更大规模语料或更强生成模型。

（完）
