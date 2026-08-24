---
title: "CoopQ: Cooperative Game Inspired Layerwise Mixed Precision Quantization for LLMs"
title_zh: CoopQ：受合作博弈启发的LLM逐层混合精度量化
authors: "Junchen Zhao, Ali Derakhshan, Jayden Hyman, Junhao Dong, Sangeetha Abdu Jyothi, Ian Harris"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.findings-acl.373.pdf"
tags: ["query:wbv"]
score: 7.0
evidence: 低于4比特的混合精度量化，用Shapley方法建模层间交互
tldr: 针对混合精度量化低于4比特时现有方法忽略层间交互而性能退化的问题，CoopQ将逐层量化建模为合作博弈，提出Shapley渐进式量化估计（SPQE）以高效计算层敏感性与交互关系。基于估计结果指导逐层比特分配，实验表明该方法在低比特混合精度设置下显著优于已有方案，为LLM极低比特部署提供了有效途径。
source: ACL-2026-Findings
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl373/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1708, \"height\": 973, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl373/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 737, \"height\": 362, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl373/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1706, \"height\": 847, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-findings/anthology-2026findings-acl373/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1707, \"height\": 851, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl373/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 830, \"height\": 369, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl373/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1648, \"height\": 634, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-findings/anthology-2026findings-acl373/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 801, \"height\": 133, \"label\": \"Table\"}]"
motivation: 现有混合精度量化在平均精度低于4比特时，基于孤立层指标的方法忽略了层间交互，导致性能下降。
method: 将逐层量化问题建模为层间合作博弈，用Shapley值高效估计每层敏感性与层间交互，指导逐层比特分配。
result: 实验证明CoopQ在低比特混合精度设置下优于已有量化方案，改善了LLM在资源受限场景下的部署效果。
conclusion: CoopQ揭示了层间交互在低比特混合精度量化中的重要性，并为极低比特量化提供了新思路。
---

## Abstract
Large Language Models (LLMs) promise impressive capabilities, yet their multi-billion parameter scale makes on-device or low-resource deployment prohibitive. Mixed precision quantization offers a compelling solution, but existing methods struggle when the average precision drops below four bits, as they rely on isolated, layer-specific metrics that overlook critical inter-layer interactions affecting overall performance. To address these limitations, we first frame the mixed-precision quantization problem as a cooperative game among layers and introduce Shapley-based Progressive Quantization Estimation (SPQE) to efficiently obtain accurate Shapley estimates of layer sensitivities and inter-layer interactions. Leveraging the SPQE estimates, we propose Cooperative Game Inspired Mixed-Precision Quantization (CoopQ) which translates these Shapley estimates into a binary quadratic optimization formulation, assigning either 2 or 4-bit precision to layers under strict memory constraints. Comprehensive experiments conducted on Llama-3, Gemma-2, and Qwen models across three independent PTQ backends (Quanto, HQQ, GPTQ) demonstrate CoopQ’s scalability and consistently superior performance compared to methods relying solely on isolated metrics. Across average precisions spanning 4 bit down to 2 bit, CoopQ cuts Perplexity by 20 – 80 % relative to the best baseline, with the margin growing as the bit-width tightens.

---

## 论文详细总结（自动生成）

# CoopQ论文详细中文总结

## 1. 论文的核心问题与整体含义（研究动机和背景）

大型语言模型（LLM）在文本生成、推理、问答等任务上展现出强大的能力，但其动辄数十亿甚至数千亿的参数规模，使得在移动设备、边缘传感器和标准 GPU 等资源受限环境下的部署变得极其困难。量化（Quantization）是解决这一挑战的有效手段，其中训练后量化（PTQ）因无需重新训练、压缩和加速效率高而备受关注。

然而，现有的混合精度量化方法普遍存在一个关键缺陷：**当平均精度低于 4 比特时，基于隔离的、逐层独立的敏感性指标（如权重分布、余弦相似度、激活范数、Hessian 信息等）进行比特分配的方法性能严重退化**。这些方法忽略了量化误差在网络中的传播效应以及层与层之间的交互作用，导致高精度资源分配不当，从而损害整体模型性能。

针对上述问题，本文首次将混合精度量化问题形式化为**层间合作博弈（cooperative game）**，利用 Shapley 值（Shapley value）分析来同时量化每一层在量化过程中的个体敏感性和层间交互效应，进而指导最优比特分配，实现低比特（2~4 比特）条件下的高质量模型压缩。

## 2. 论文提出的方法论

### 2.1 核心思想

论文的核心思想是：LLM 的每一层 Transformer 可以被视为合作博弈中的一个"玩家"，量化精度从高到低的转变相当于该玩家的"退出"或"被移除"。通过 Shapley 值来评估每个层在所有可能联盟中的边际贡献，可以同时捕捉个体层敏感性和层间交互效应，从而为混合精度量化提供比传统孤立指标更准确的依据。

### 2.2 SPQE：Shapley-based Progressive Quantization Estimation

**动机**：传统基于剪枝（pruning）的 Shapley 估计方法在移除层时会导致模型性能急剧退化，产生高方差、不可靠的估计值。为此，SPQE 采用**渐进式量化**替代突变的层剪枝：

- 首先将模型所有层统一量化到中等基准精度（4 比特）；
- 然后按随机排列的顺序，逐层将精度从 4 比特降低到 2 比特；
- 在每一步记录由该层精度降低引起的价值函数（即负对数似然 NLL）的即时变化，作为该层的边际贡献；
- 通过蒙特卡洛置换采样（M 次随机排列）平均边际贡献，得到每个层的 Shapley 值估计。

**关键公式**：

- 价值函数：$v_{NLL}(S) = \mathbb{E}_{(x,t)\sim D}[-\log p(x_{t+1}|x_{\le t}; S)]$，即验证集上的平均每 token 负对数似然。
- 边际贡献：$\Delta v_\ell = v(S_\ell) - v(S_{\ell+1})$，表示将层 $\ell$ 从 4 比特降到 2 比特时的即时损失变化。
- Shapley 值估计：$\hat{\phi}_i = \frac{1}{M}\sum_{m=1}^{M} \Delta v_i^{(m)}$，对所有排列取平均。

**优势**：渐进式量化使得模型性能变化平滑、可控，避免了剪枝方法导致的性能发散问题，从而获得低方差、高准确度的 Shapley 估计。

### 2.3 CoopQ：Cooperative Game Inspired Mixed-Precision Quantization

在 SPQE 估计的基础上，CoopQ 将比特分配构建为**带约束的二元二次优化问题**：

- **二阶泰勒展开**：量化层 $i$ 引入扰动 $\epsilon_i$，损失变化近似为 $\Delta L \approx \sum_i g_i^\top \epsilon_i + \sum_i \sum_j \epsilon_i^\top H_{ij} \epsilon_j$，其中 $g_i$ 为一阶敏感性，$H_{ij}$ 为成对交互 Hessian。
- **经验估计**：由于直接计算 $g_i$ 和 $H_{ij}$ 不可行，CoopQ 使用 SPQE 得到的经验 Shapley 值偏差构造协方差矩阵 $C$，再通过对角收缩（shrinkage）得到稳定的交互矩阵：$K = (1-\alpha)C + \alpha \text{diag}(C)$，超参数 $\alpha=0.5$。
- **一阶敏感性分离**：$a_i = \hat{\phi}_i - \sum_{j \ne i} K_{ij}$，从 Shapley 值中剥离交互项，获得个体敏感性。
- **优化目标**：$\min_{q \in \{0,1\}^L} \Delta L(q) = a^\top q + q^\top K q$，满足内存约束 $\sum_i c_i(1-q_i) \le B$，其中 $q_i=1$ 表示层 $i$ 保持在低精度（2 比特），$q_i=0$ 表示提升到高精度（4 比特）。
- **求解**：通过标准的二元线性化技巧（引入辅助变量 $y_{ij}$ 表示 $q_i q_j$），将二次目标转化为等价的混合整数线性规划（MILP），使用 SCIP 求解器获得全局最优比特分配。

### 2.4 内存约束

对任意目标平均比特宽度 $b_{avg} \in [2,4]$，通过线性插值定义内存预算：$B(b_{avg}) = B_{low} + \frac{b_{avg}-2}{4-2} \times (B_{high} - B_{low})$，其中 $B_{low}$ 为全 2 比特模型内存占用，$B_{high}$ 为全 4 比特内存占用。所有方法在相同预算下进行公平比较。

## 3. 实验设计

### 3.1 数据集

- **Shapley 值估计（校准）**：使用 C4（Colossal Clean Crawled Corpus）训练集，用于 SPQE 校准和最终比特分配优化。
- **最终评估**：使用 WikiText-2 验证集，提供无偏的语言建模性能比较，评估指标为困惑度（Perplexity）。

### 3.2 基准与对比方法

**模型**：Gemma-2（2B、9B）、Llama-3（3.2B、8B）、Qwen3（4B、8B），共 6 个模型。

**PTQ 后端**：Quanto、HQQ、GPTQ 三种独立框架。SPQE 估计使用 Quanto（因其高效的原位权重量化和快速层处理）。

**对比基线**（4 种）：

| 基线方法 | 核心思想 |
|---------|---------|
| LLM-MQ Sensitivity | 一阶泰勒近似计算层敏感性，以整数规划分配比特 |
| LIM（Layer Input Modification） | 基于层输入输出嵌入的负余弦相似度 |
| Z-Score（ZD） | 基于层中异常值权重的比例（无需校准数据） |
| Activation-based Scoring | 基于层激活的 Frobenius 范数 |

### 3.3 实验设置

- 每个层分配 2 比特或 4 比特精度；
- 对角线收缩超参数 $\alpha = 0.5$；
- MILP 求解器使用 SCIP（默认配置）；
- 所有实验在固定随机种子的两台 NVIDIA A40 GPU 上进行。

## 4. 资源与算力

- **硬件**：两台 NVIDIA A40 GPU（单卡 48GB 显存）。
- **SPQE 估计开销**：对于 Llama-3.1-8B 模型，执行 100 次 SPQE 蒙特卡洛采样需约 **18 小时**（单张 A40 GPU）。
- 作者指出，这是一次性分析成本，可摊销到该模型后续的多次部署中，且消融实验表明较少采样数（如 10~50 次）也能获得有意义的层重要性信号。

## 5. 实验数量与充分性

### 实验总量

- **主实验**：6 个模型 × 3 个 PTQ 后端 × 4 个对比基线 + CoopQ，每个配置跨越 2~4 比特多个精度档位（如图 1、图 3、图 4 和表 1 所示，按比特范围离散化为 4 个区间）。
- **消融实验**（3 组）：
  1. **SPQE 采样数量消融**（10~100 次，Llama 3.1-8B + Quanto）；
  2. **SPQE 对比层剪枝方法**的 Shapley 估计稳定性（Llama 3.1-8B + Quanto）；
  3. **对角收缩超参数 $\alpha$ 消融**（$\alpha=0.0, 0.5, 1.0$，Llama 3.2-3B + Quanto）。

### 充分性与公平性评价

- **充分性较好**：覆盖了 3 个模型家族、6 个不同规模的模型、3 个独立 PTQ 后端、4 个代表性基线，以及多个比特精度区间，实验矩阵较为丰富。
- **公平性较好**：所有方法使用相同的校准数据（C4）和相同的内存预算约束；Quanto 和 HQQ 使用统一缩放因子（calibration-free），GPTQ 的资源消耗更高但所有方法公平对比；Z-Score 无需校准数据，LIM 使用相同数量（1000 样本）的 C4 校准数据。
- **潜在不足**：SPQE 估计本身仅基于 Quanto 后端进行，虽然评估覆盖了三个后端，但 SPQE 估计与 HQQ/GPTQ 之间的后端迁移可能存在一定偏差；表 1 中的结果进行了区间离散化，可能损失部分连续性信息。

## 6. 论文的主要结论与发现

1. **CoopQ 显著优于所有基线**：在 2~4 比特平均精度范围内，CoopQ 相对最强基线将困惑度降低 **20%~80%**，且比特宽度越紧、优势越明显。
2. **交互建模是低比特量化的关键**：当平均精度低于 4 比特时，层间误差传播最为严重，显式建模层间交互的效果远优于孤立指标方法。
3. **在极端低比特（2.01~2.5 bits）下优势最突出**：例如 Gemma-2-2B 在 GPTQ 下 CoopQ 困惑度 233.98，而 Sensitivivity 为 1.12×10³、LIM 为 1.25×10³，相对降低 79%~81%。
4. **跨后端稳健性**：CoopQ 在 GPTQ、HQQ、Quanto 三种 PTQ 后端上均表现一致的最优性能，证明了方法的通用性和可扩展性。
5. **SPQE 渐进式量化优于层剪枝式 Shapley 估计**：剪枝方法在移除少量层后困惑度即发散至无穷大，而 SPQE 保持平滑、受控的性能退化，Shapley 估计方差显著更低。
6. **当采样数达到 50 次时性能趋于收敛**，100 次为实践中的最佳性价比选择。
7. **$\alpha=0.5$ 为最优**，说明交互项（协方差矩阵的非对角元素）包含有价值的信息，但 SPQE 对 $\alpha$ 的取值具有鲁棒性。

## 7. 优点

1. **问题建模新颖**：首次将混合精度量化形式化为层间合作博弈，突破了传统逐层孤立分析的局限，为低比特量化提供了新的理论视角。
2. **SPQE 方法设计巧妙**：以渐进式量化替代层剪枝，有效解决了 Shapley 估计中性能骤降和高方差问题，使得交互效应可以被稳定地估计。
3. **优化框架完备**：从经验 Shapley 值出发，经由协方差矩阵构造、对角收缩到 MILP 求解，形成了从估计到分配端到端的完整流程，可求得全局最优解。
4. **实验验证充分**：跨模型家族（3 个）、模型规模（2B~9B）、PTQ 后端（3 个）、基线方法（4 个）的广泛评估，且消融研究覆盖了采样数、交互项、超参数等多个关键因素。
5. **实践意义明确**：在 2~4 比特极低精度下显著优于现有方法，对 LLM 在资源受限设备上的部署具有实用价值。

## 8. 不足与局限

1. **计算开销较大**：SPQE 的 Shapley 值估计需要约 18 小时（Llama-3.1-8B，单 A40 GPU，100 次采样），虽然是一次性成本，但对快速原型验证或频繁更新的模型不够友好。
2. **估计后端依赖**：SPQE 估计仅在 Quanto 后端上进行，而最终评估涵盖三个后端，可能存在估计与部署后端不一致带来的偏差风险。
3. **比特分配粒度有限**：目前仅支持二元的 2 比特/4 比特选择，未覆盖更细粒度的比特配置（如 3 比特、混合多档位），更细粒度可能带来额外收益，但会增加优化复杂度（作者已在未来工作提及）。
4. **超参数调整**：对角收缩超参数 α 需要人工设定（本文取 0.5），虽有一定鲁棒性，但最优值可能随模型和量化配置变化。
5. **评估指标单一**：主要以困惑度（Perplexity）为指标，未涵盖下游任务（如常识推理、问答等）的端到端评估，困惑度的改善是否完全转化为下游任务性能提升仍需进一步验证。
6. **语言覆盖有限**：实验仅使用英文数据集（C4、WikiText-2），多语言场景下的有效性尚未验证。

（完）
