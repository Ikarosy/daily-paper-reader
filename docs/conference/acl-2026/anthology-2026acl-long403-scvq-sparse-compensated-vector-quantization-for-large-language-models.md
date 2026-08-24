---
title: "SCVQ: Sparse-Compensated Vector Quantization for Large Language Models"
title_zh: 稀疏补偿向量量化：面向大语言模型的高效压缩
authors: "Zixuan Zhou, Yujun Diao, Zicheng Kong, Dehua Ma, Zhenbo Xu, Pei Pei Li, Zhaofeng He"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.403.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 面向大语言模型的向量量化方法，聚焦超低位宽部署
tldr: 现有向量量化方法在大语言模型超低位宽场景下存在码本存储大、索引查找开销高以及性能明显下降的问题。为此提出SCVQ框架，采用显著性感知的加权K均值聚类与对称约束来缩小码本并降低索引成本，并借助统一的稀疏补偿结构恢复量化损失。实验表明该方法在保持高压缩率的同时有效缓解了超低位宽下的性能退化。该工作为LLM的极低比特向量量化提供了新的高效方案。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long403/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1658, \"height\": 596, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long403/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1572, \"height\": 831, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long403/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 791, \"height\": 1548, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long403/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1432, \"height\": 328, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long403/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 795, \"height\": 380, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 817, \"height\": 311, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 735, \"height\": 321, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1302, \"height\": 741, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1490, \"height\": 628, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 613, \"height\": 742, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 678, \"height\": 398, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 685, \"height\": 357, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 614, \"height\": 342, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 780, \"height\": 656, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 710, \"height\": 413, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 1009, \"height\": 885, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-012.webp\", \"caption\": \"\", \"page\": 0, \"index\": 12, \"width\": 828, \"height\": 650, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-013.webp\", \"caption\": \"\", \"page\": 0, \"index\": 13, \"width\": 840, \"height\": 473, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-014.webp\", \"caption\": \"\", \"page\": 0, \"index\": 14, \"width\": 582, \"height\": 412, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-015.webp\", \"caption\": \"\", \"page\": 0, \"index\": 15, \"width\": 1076, \"height\": 705, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long403/table-016.webp\", \"caption\": \"\", \"page\": 0, \"index\": 16, \"width\": 1092, \"height\": 1020, \"label\": \"Table\"}]"
motivation: 现有VQ方法码本开销大且在超低位宽下性能退化明显，影响LLM部署效率。
method: 提出SCVQ，以显著性感知加权K均值聚类和对称约束压缩码本，并用统一结构化稀疏补偿减小量化误差。
result: 在超低位宽场景下显著降低码本与索引开销，同时改善模型量化后的性能表现。
conclusion: SCVQ为LLM的极低比特向量量化提供了高压缩且低开销的有效框架，具有实用价值。
---

## Abstract
Large Language Models (LLMs) are primarily constrained by memory and bandwidth bottlenecks during deployment. Although Vector Quantization (VQ) has emerged as a promising solution, existing methods incur inference overhead due to massive codebook storage and intensive index lookups. Moreover, these methods typically suffer from non-negligible performance degradation under ultra-low bitwidth regimes. To bridge this gap, we propose Sparse-Compensated Vector Quantization (SCVQ), a novel framework designed for high-efficiency LLM vector quantization. SCVQ introduces a salience-aware weighted K-means clustering scheme with symmetry constraints to reduces codebook size and indexing costs. Central to our approach is a unified structured representation that consolidates outliers, salient weights, and quantization residuals into a single sparse compensation matrix. This design effectively preserves critical model information while leveraging VQ-specific properties to enable efficient custom kernels. Extensive experiments across multiple benchmarks demonstrate SCVQ’s superior performance. Specifically, SCVQ achieves a perplexity of 5.78 on WikiText-2 for LLaMA-2-7B at 2-bit quantization, while delivering a 1.4× end-to-end inference speedup over existing baselines.

---

## 论文详细总结（自动生成）

# 论文详细中文总结

## 1. 核心问题与研究动机

**背景**：大语言模型（LLM）在推理部署时面临严重的内存和带宽瓶颈。后训练量化（PTQ）技术是缓解该瓶颈的关键手段，其中向量量化（VQ）通过将权重按子向量分组并映射到码本质心，比标量量化具有更高的重构精度。

**现有方法的缺陷**：
- **忽略权重不均等重要性**：标准VQ对所有权重平等对待，而实际LLM性能主要由极少数显著权重（salient weights）决定；
- **码本存储与索引开销大**：显式码本依赖查表（LUT）操作，大尺寸码本与频繁索引查找消耗大量内存带宽；
- **隐式码本兼容性差**：如QuIP#依赖Hadamard变换抑制异常值，推理时需要额外计算，部署流水线复杂。

**核心目标**：在极低比特宽度（2–3 bit）下，同时实现高模型质量与硬件高效的推理。

---

## 2. 方法论

### 2.1 整体框架

SCVQ建立在标准K-means向量量化框架之上，以"显式隔离并补偿关键权重分量，从而换取更紧凑、更精确的表示"为核心思路。完整流程见论文Algorithm 1。

### 2.2 关键模块

**（1）双归一化（Bi-Normalization）**
- 对行和列分别独立重新缩放，使权重分布逼近各向同性高斯分布，符合K-means球形聚类假设。
- 公式：`¯Wij = Wij / (ri·cj)`，其中ri和cj分别是从行/列方向计算得到的缩放因子。
- 附录A的SQNR实验证明双归一化相比无归一化或仅行归一化有显著提升。

**（2）复合显著性因子（Salience Factor）**
- 由局部显著性与全局显著性两路组成：
  - **局部显著性**：基于校准数据集上激活特征列的L2范数，捕捉权重-激活交互；
  - **全局显著性**：基于小规模数据集上损失对权重的梯度均值，捕捉端到端信息。
- 合成方式：`Sij = Slocal·Sglobal`。
- 发现显著权重在空间上沿行连续聚集，形成"显著向量"，与VQ的块式分组天然契合。

**（3）统一稀疏补偿矩阵 C**
- 融合三类分量：
  - **异常值（Woutlier）**：按子向量L2范数挑选偏离球状分布的向量；
  - **显著向量（Wsalient）**：按聚合显著性得分S_v保留关键向量；
  - **残差补偿（R）**：按混合度量 `M = (S_v)^α·‖W−Q‖²` 选定量化残差，α=0.25。
- 三者合并后形成单一稀疏矩阵，且不同选择标准之间存在大量重叠，使得聚合稀疏率远低于算术和。
- 表1显示S的99.99百分位仅覆盖数值范围的28.5%，证实高度重尾分布，约1%的向量足以恢复性能。

**（4）增强K-means聚类**
- **显著性加权K-means**：子向量按显著性加权参与聚类，并采用加权K-means++初始化策略（新质心采样概率正比于 `S_i·D(v_i)²`），确保重要权重对质心初始化和迭代更新有更大影响力。
- **对称约束K-means**：通过Kolmogorov-Smirnov（KS）检验找出最接近轴对称的d̄个维度，将这些维度上的值取绝对值参与聚类，将码本大小从k压缩为 k/2^d̄（符号保存在bitmask中），从而在保持表示能力的同时大幅降低码本存储。
- **固定零向量质心**：对已被稀疏矩阵提取的向量，强制码本中包含零向量以保证精确重构。
- **码本量化**：码本条目采用INT8对称逐行量化，进一步减小内存占用（附录G证明精度损失可忽略）。

**（5）微调阶段**
- 采用知识蒸馏，以全精度模型为教师，使用Confidence-Aware KL散度（BitDistiller）作为目标。
- 仅训练两个可学习组件：缩放向量和稀疏补偿矩阵的非零元素，仅占模型参数的约2–3%。
- 附录L消融发现：同时微调码本和稀疏矩阵存在优化冲突，因此排除码本。

**（6）硬件优化（VSR格式与CUDA内核）**
- 提出**Vector Sparse Row（VSR）**稀疏存储格式：相比CSR在每个非零元素存列索引，VSR只在每个子向量存一个索引，元数据开销减少d倍（附录C证明）。
- 定制CUDA SpMV内核利用连续非零元素的**完全合并内存访问（coalesced memory access）**特性减少DRAM访问。
- 按子向量均匀分配负载以缓解负载不均衡。
- 实现VSR格式的自定义PyTorch autograd算子支持微调阶段的反向传播。

---

## 3. 实验设计

### 3.1 数据集与基准

| 用途 | 数据集 |
|---|---|
| 困惑度评估 | WikiText-2、C4（验证集） |
| 零样本准确率 | WinoGrande、PIQA、ARC-Easy、ARC-Challenge |
| 校准 | RedPajama-Data-1T（局部显著性）、C4 128样本（全局显著性）、WikiText-2（微调） |

### 3.2 模型与对比方法

- **模型**：LLaMA-2系列（7B/13B/70B）、LLaMA-3.1-8B、LLaMA-3.2-3B、Qwen3系列（4B/8B/14B/32B）。
- **基线方法**：AQLM、QuIP#、VPTQ（2-bit VQ对比）、SqueezeLLM（稀疏量化）、GPTQ、AWQ（无微调PTQ）、SpQR、GPTVQ等。
- **主要指标**：BPW（每权重比特数）、困惑度、零样本准确率、解码吞吐量（tokens/s）。

### 3.3 核心实验结果

- **主实验**（表3）：2-bit下，SCVQ在LLaMA-2-7B上WikiText-2困惑度5.87，优于AQLM（6.14）、QuIP#（6.19）和VPTQ（6.13）；13B和70B上同样全面领先。
- **吞吐量实验**（表2）：7B模型2.04 BPW下达235.4 tokens/s，相比FP16基线2.3×加速，相比AQLM（165.9）提升1.4×；3.20 BPW下188.5 tokens/s，超过SqueezeLLM的154.2。
- **无微调对比**（表15）：SCVQ在3.10 BPW达到5.38困惑度，优于AQLM（3.04 BPW, 5.46），展示出不依赖微调的竞争力。
- **跨架构验证**（附录J）：LLaMA-3、Qwen3系列上SCVQ同样优于基线。

---

## 4. 资源与算力

- **GPU**：NVIDIA A100（80GB）。
- **规模**：1至8张A100，取决于模型规模。
- **推理基准**：单A100，batch size=1。
- **微调阶段**：使用WikiText-2的1024个样本，上下文长度1024。
- **说明**：论文**未明确报告**各实验的具体训练时长、GPU小时数等算力消耗细节。

---

## 5. 实验数量与充分性

### 5.1 实验类型统计

- **主测试**：3个模型规模 × 5个数据集（困惑度+零样本）的完整矩阵，覆盖2-bit/3-bit多种BPW配置。
- **消融实验**（表4、8、9、10、13、14）：
  - 六大组件消融（对称约束、码本量化、残差矩阵、显著矩阵、异常值矩阵、细调/加权K-means）；
  - 码本量化精度（INT4/INT8/FP16、对称/非对称）；
  - 稀疏比率（单组件 vs 联合）；
  - 超参数α敏感性；
  - 微调可训练组件组合；
  - 推理吞吐量消融（VSR vs CSR、码本精度、对称轴数量）；
  - 附录I中归一化方案比较（None/Row-norm/Bi-norm × 多种维度和码本大小）。
- **跨架构泛化**：LLaMA-2系列、LLaMA-3系列、Qwen3系列共9个模型规模。
- **附录分类**：BPW公式推导、理论动机分析（PCA可视化）、KS检验示例、加权K-means算法伪代码。

### 5.2 充分性评价

**优点**：实验覆盖面广，从7B到70B统一验证，且包含无微调场景的公平对比；消融粒度细，各组件贡献清晰。

**不足**：所有实验均在A100平台进行，缺少边缘/移动端等更贴近实际部署场景的验证；最大仅覆盖70B模型，未验证更大规模（如百亿以上）行为。

---

## 6. 主要结论

1. **SCVQ在超低位宽（2–3 bit）量化下达到SOTA性能**，在LLaMA-2-7B/13B/70B上均优于AQLM、QuIP#、VPTQ。
2. **稀疏补偿与VQ的结合是有效且高效的**：统一稀疏矩阵设计使得推理延迟开销可忽略，同时有效恢复量化性能。
3. **对称约束码本压缩在不损失精度的情况下大幅降低码本内存**，是吞吐量提升的关键因素。
4. **结构化稀疏（VSR）显著优于非结构化稀疏（CSR）**，在推理吞吐上有明显收益。
5. 微调、显著性加权K-means和异常值补偿是**对模型性能影响最大的三个组件**。
6. SCVQ实现了**算法与硬件协同设计**，验证了VQ+稀疏补偿范式的实际部署潜力。

---

## 7. 优点

- **方法创新性**：首次将VQ与稀疏补偿统一在同一框架内，三个补偿项（异常值、显著权重、残差）合并为单一稀疏矩阵，设计巧妙。
- **代码可部署性**：VSR格式专为LLM中向量稀疏模式定制，既减少元数据开销又实现coalesced memory access，避免了cuSPARSE BSR对非方形块的低效支持。
- **消融实验完整**：每个设计决策都有系统性的实验支撑，包括硬件层的吞吐量消融和算法层的性能消融。
- **跨模型泛化验证**：在LLaMA-2、LLaMA-3、Qwen3三个家族上验证方法的通用性。
- **诚实报告**：披露了无微调场景的结果，表明即使不做微调SCVQ也具竞争力。
- **理论支撑**：提供了双归一化的概率理论基础（附录A）和对称性检测的非参数统计方法（KS检验）。

---

## 8. 不足与局限

- **理论完备性欠缺**：作者自述稀疏子向量选择依赖启发式排序指标，α超参数通过线性搜索确定，缺乏理论指导。
- **方法边界受限**：
  - 仅实现了基于K-means的VQ，未扩展到格子量化（lattice-based）等其他VQ方案；
  - 受维度灾难限制，实验仅采用d=8的子向量维度，高维VQ（如d=16/32）未验证。
- **稀疏指标的选择敏感性**：表9显示单组件实验下异常值矩阵最有效，但全量（2%）表现最优，各稀疏比率的联合最优配置依赖经验搜索。
- **极低位宽的边界效应**：2-bit下虽然领先基线，但困惑度退化（5.12→5.87）仍远超FP16，量化损失依然显著。

---

（完）
