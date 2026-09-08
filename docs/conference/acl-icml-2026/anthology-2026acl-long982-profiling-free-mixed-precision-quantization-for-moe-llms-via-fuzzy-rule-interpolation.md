---
title: Profiling-Free Mixed-Precision Quantization for MoE LLMs via Fuzzy Rule Interpolation
title_zh: 无画像MoE大语言模型混合精度量化：基于模糊规则插值的方法
authors: "Huachen Qi, Ruiyu Zhuo, Bowen Shi, Xiang Chang, Fei Chao, Changjing Shang, Qiang Shen"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.982.pdf"
tags: ["query:moe-quant"]
score: 9.0
evidence: 直接对应MoE大语言模型的量化与混合精度配置问题
tldr: MoE大模型虽只激活部分专家，但不同专家及其内部线性层对量化的敏感度差异显著，现有MxMoE等混合精度方法需要逐项评估专家-层-位宽组合的量化损失，画像成本过高。该文提出FRI-MxMoE，利用模糊规则插值免去全配置损失计算，直接预测敏感度并分配精度。该方法在相近精度下大幅降低MoE混合精度量化配置成本，便于MoE模型的低比特部署。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long982/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 809, \"height\": 386, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long982/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1639, \"height\": 611, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long982/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 810, \"height\": 486, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long982/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 811, \"height\": 555, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1642, \"height\": 1718, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1644, \"height\": 335, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 793, \"height\": 290, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 792, \"height\": 308, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 796, \"height\": 242, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1647, \"height\": 435, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1645, \"height\": 538, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 797, \"height\": 469, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1662, \"height\": 303, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1663, \"height\": 884, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long982/table-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 1661, \"height\": 270, \"label\": \"Table\"}]"
motivation: MoE模型量化敏感性不均匀，现有混合精度框架的逐配置损失评估带来高昂画像成本。
method: 提出FRI-MxMoE，通过模糊规则插值免去配置级量化损失评估，直接预测专家-层-位宽的最佳精度。
result: 在保持混合精度量化精度的同时避免冗余画像，显著降低MoE量化配置成本。
conclusion: 为MoE大模型量化提供低成本、可扩展的混合精度分配框架。
---

## Abstract
Large Language Models continue to scale in size and capability, driving substantial computational and memory demands.Mixture-of-Experts (MoE) architectures alleviate this cost by activating only a sparse subset of experts per token, enabling efficient scaling without proportional increases in inference compute.However, quantization in MoE models remains challenging due to heterogeneous sensitivity across experts and their internal linear layers.Existing mixed-precision frameworks such as Mixed-precision Quantization for MoE (MxMoE) require full quantization-loss evaluation for expert–layer–and-bit configurations, incurring prohibitive profiling cost.To address this, we propose **FRI-MxMoE**, a **profiling-free** mixed-precision quantization framework built on Fuzzy Rule Interpolation, designed as a drop-in replacement for the loss estimation component in MxMoE. By constructing a fuzzy rule base in the intra-expert layer feature space (bit-width, activation variance, parameter scale), our method predicts quantization error from only sparse samples, eliminating the need for dense profiling.Extensive experiments demonstrate that FRI-MxMoE accelerates the profiling phase by up to 15.7× (on DeepSeek-V2) while achieving comparable or slightly superior zero-shot accuracy (e.g., +1.04% on DeepSeekV2-Lite) compared to the baseline.This enables continuous sensitivity modeling, preserves accuracy under mixed-precision allocation, and reduces offline computation by orders of magnitude.

---

## 论文详细总结（自动生成）

# FRI-MxMoE：基于模糊规则插值的 MoE 大模型混合精度量化

## 1. 研究动机与核心问题

- **背景**：大语言模型规模持续扩大，带来巨大算力和内存开销。Mixture-of-Experts（MoE）架构通过稀疏路由（每 token 只激活少量专家）缓解了推理计算压力，使模型容量扩展的同时推理代价不至于等比增长。
- **核心问题**：MoE 模型的量化面临多层级"敏感性异质性"挑战——
  - 不同专家因功能分化和激活频率不均，对量化噪声的容忍度差异显著；
  - 同一专家内部的线性子层（Gate、Up、Down）在函数角色、参数规模和激活统计上差异大，量化敏感度不均；
  - 专家路由频率高度倾斜，频繁被激活的专家对模型整体质量影响远大于罕见激活的专家。
- **现存方案的痛点**：MxMoE 等混合精度量化框架需要逐项评估"专家 × 子层 × 位宽"全组合的量化损失（profiling），成本随专家数量线性增长，即 C_profiling ∝ L × E × |B| × N_calib，在大规模/细粒度 MoE 模型上开销不可接受。
- **研究含义**：本文提出 **FRI-MxMoE**，将量化配置校准从"全量枚举"转化为"稀疏锚点 profiling + 模糊规则插值"，在不牺牲精度的情况下大幅削减混合精度配置成本。

## 2. 方法论：核心思想与关键技术细节

### 2.1 整体框架

FRI-MxMoE 包含两个并行的模糊规则插值模块，分别预测**量化损失（Error-FRI）**和**运行时延迟（Latency-FRI）**，随后在语言建模误差与资源预算的双重约束下求解最优混合精度配置。

**三段式流程**：

1. **稀疏锚点采样与规则库构建**：使用深度自适应分层采样（Depth-Adaptive Stratified Sampling），将模型按深度分为浅层/中层/深层并差异化抽样；对选中的锚点专家，逐个profile其 Gate、Up、Down 投影在多个关键位宽下的实际量化误差与延迟，每条样本被转换为一条模糊规则（IF-THEN 形式）。
2. **全空间性能预测**：通过 FRI 推理为未被 profile 的所有（专家、子层、位宽）配置预测量化误差与延迟，从而构建连续的敏感度曲面。
3. **频率感知的拉格朗日分配**：以专家激活频率加权目标函数，使用二分搜索求解拉格朗日乘子，获得满足资源预算的最优位宽分配 b*。

### 2.2 模糊化与稀疏规则库

- 输入变量分为**连续变量**（位宽、M、N、K、FLOPs、激活方差等）和**类别变量**（子层类型 type、融合标志等）。
- 连续变量采用**三角形隶属函数**：μ_Ak(x) = max(0, 1 − |x − c_k| / w_k)，类别变量使用单点（one-hot）隶属函数。
- 规则库大小 = 锚点专家数 × 3 个子层 × 候选位宽数。例如 profile 约 417–833 个锚点专家即可形成 5k–10k 条规则，远小于全遍历规模。

### 2.3 FRI 推理机制（核心公式）

采用**基于逆距离加权（IDW）的插值**，对未知配置 x_q 预测输出 ŷ：

- **异构距离度量**：连续特征用归一化欧氏距离，类别特征用海明距离：

  D(x_q, R_i) = √[D_cont(x_q, R_i) + D_cat(x_q, R_i)]

  D_cont(x_q, R_i) = Σ_{j∈cont} ((x_q,j − c_i,j)/σ_j)²

  D_cat(x_q, R_i) = Σ_{j∈cat} I(x_q,j ≠ c_i,j)

- **K 近邻加权平均**：

  ŷ = (Σ_{R_i∈N_K(x_q)} w_i·y⁽ⁱ⁾) / (Σ_{R_i∈N_K(x_q)} w_i)，其中 w_i = 1/(D(x_q, R_i) + ε)

- **理论性质**（文中附录 F 给出证明草图）：IDW-FRI 的预测是邻域输出的凸组合（有界性）、对锚点噪声鲁棒（|δŷ| ≤ max_i|δ_i|）、且预测对输入局部 Lipschitz 连续（平面光滑）。

### 2.4 计算感知增强

- 标准位宽插值难以捕捉硬件效率的"不连续悬崖"（如 L2 cache 与 DRAM 的性能差），因此把 M、N、K、FLOPs 等物理维度显式纳入距离度量，区分计算密集层与访存密集层。

### 2.5 拉格朗日资源分配

- **频率感知目标**：min_b Σ_i f_i·L̂_i(b_i)，约束 Σ_i Ĉ_i(b_i) ≤ C_target。其中 f_i 为第 i 个量化单元的归一化激活频率。
- **拉格朗日松弛**：将硬约束并入目标函数，固定 λ 后问题解耦为各单元的独立选择：b*_i(λ) = argmin_{b∈B} (f_i·L̂_i(b) + λ·Ĉ_i(b))。
- 总成本关于 λ 单调非增，用二分搜索高效求得满足预算的 λ*。
- 复杂度 O(N_iter · U)，U = L × E × C 为总分配单元数；所谓"O(1) profiling"指校准成本与专家数 E 无关。

## 3. 实验设计

### 3.1 数据集与评估基准

- **校准数据**：Wikitext-2 随机采样 128 条序列，序列长度 4096。
- **零样本评估**：7 个标准基准——ARC-Challenge (AC)、ARC-Easy (AE)、HellaSwag (HS)、LAMBADA-openai (LO)、LAMBADA-standard (LS)、PIQA (PQ)、WinoGrande (WG)，并报告平均准确率（Avg.）。
- **困惑度**：在 Wikitext-2 上报告 PPL。

### 3.2 被评估模型

- DeepSeekV2-Lite、Qwen1.5-MoE、Qwen2-MoE、Mixtral-8×7B；
- profiling 效率对比额外考察 Mixtral-8×22B、DeepSeek-V2 等大/细粒度版本。

### 3.3 对比方法

- FP16 全精度基线（Baseline）；
- GPTQ*（随机 Hadamard 变换版本）；
- QuaRot（W4A4 激活量化）；
- MxMoE（当前 SOTA 混合精度方法，ILP 求解器）；
- 学习式回归基线（Ridge、SVR、RF/GBDT、MLP）——在同一锚点监督下比较预测质量。

### 3.4 主要评估维度

1. **零样本准确率与 PPL**（表 1）：在 3.25-16／2.25-16／5-5 三种混合精度配置下与基线对比；
2. **Profiling 时间与加速比**（表 2）：覆盖 6 种模型规模变体；
3. **规则库规模影响**（表 3、附录 E）：1k–10k 规则下的预测误差与秩相关；
4. **预测器性能对比**（表 4）；
5. **分配粒度对比**（表 5）：linear-block vs. expert 级分配；
6. **消融实验**（表 6）：Full Traversal + ILP / Full Traversal + Lagrangian / FRI + ILP / FRI + Lagrangian 四种组合；
7. **特征工程鲁棒性分析**（附录 G）：去除激活统计或权重尺度特征的退化程度，以及替换等价统计量的效果。

## 4. 资源与算力信息

- 论文仅说明实验在 **NVIDIA A800 GPU** 服务器上完成，**未明确说明使用 GPU 的数量、卡时总消耗或训练时长**。
- 但报告了各模型的 profiling 墙钟时间（表 2）：
  - Mixtral-8×7B：MxMoE 1h41m vs FRI 1h01m（1.7×）；
  - Qwen2-MoE：MxMoE 11h45m vs FRI 2h48m（4.2×）；
  - DeepSeek-V2：MxMoE 194h30m（估计）vs FRI 12h22m（15.7×）。
- 可以看出实验在 profiling/校准阶段非常耗时，尤其 DeepSeek-V2 全遍历估计超 190 小时，但这属于离线校准成本而非训练成本。

## 5. 实验数量与充分性评估

**实验数量方面**：论文工作量很充实——

- 主表覆盖 4 个模型 × 3 种量化配置 × 7 个零样本任务 + PPL；
- 效率对比覆盖 6 种模型规模；
- 加上规则库规模、预测器对比、粒度对比、算法消融、特征鲁棒性补充实验，数量可观。

**充分性方面**：

- **优点**：文中的消融设计干净清晰。表 6 的 2×2 组合（profiling 方式 × 分配求解器）清楚隔离了 FRI 插值和 Lagrangian 分配各自的贡献，并能揭示"近似求解器在预测噪声面下反而比精确 ILP 更鲁棒"的非平凡结论。
- **局限**：所有实验均基于 A800 GPU 的离线校准与评估，缺少真实推理部署端到端延迟/吞吐验证；评估集中于英文任务，未涉及多语言或更复杂的指令跟随/对话评估场景。此外，与 GPTQ*、QuaRot 等方法的对比只是"参考对照"，因为它们本身不做混合精度搜索，其对照配置（W4A4）在公平性上不同于其他方法。

总体判断：**实验是充分且整体客观的**，在"量化质量不下降甚至略升 + profiling 成本大幅下降"这一核心主张上证据链完整。

## 6. 主要结论

- FRI-MxMoE 在保持与 MxMoE 可比的零样本精度（甚至在 DeepSeekV2-Lite 上平均准确率提升 1.04 个百分点）前提下，将 profiling 阶段加速最高达 **15.7×**。
- 在 Qwen1.5-MoE 上 2.25-16 低比特下同样取得更低的 PPL（8.67 vs 8.79）和更高平均准确率。
- FRI 生成的平滑连续敏感度曲面相比 MxMoE 的离散测量更能捕捉底层趋势，配合 Lagrangian 全局搜索可有效规避 ILP 在预测表面的噪声敏感问题。
- 频率感知加权机制确保高使用率专家获得更精细的位宽分配，低使用率专家被激进压缩，整体质量受损小。
- 非线性模糊建模具备可解释性，算子以物理先验（参数规模、激活频率）驱动。

## 7. 方法亮点

1. **首创性**：将模糊规则插值（FRI）引入神经网络量化，以稀疏锚点构建低维敏感度流形替代高成本全枚举 profiling。
2. **理论支撑完整**：对 IDW-FRI 给出有界性、噪声鲁棒性和 Lipschitz 连续性证明，不是简单的启发式拼装。
3. **粒度精细**：分解到 expert 内部的 Gate/Up/Down 子层级量化决策，优于更粗的专家级或整层级分配。
4. **频率感知**：直接以激活频率加权目标函数，使资源向高价值专家倾斜。
5. **Lagrangian 求解器与 FRI 预测面的巧妙协同**：消融证明其比"精确 ILP + 预测面"组合更抗噪，结果更具泛化能力。
6. **可扩展性与可迁移性**

6. **可扩展性与可迁移性**：FRI 的 profiling 成本不随专家数线性增长，而规则库的构建与插值推理仅涉及近邻搜索与加权求和，计算量极小。只要候选硬件发生切换，只需重新执行稀疏锚点采样与规则库构建即可适配新的延迟曲面，无需修改模型结构或目标函数；同时模糊规则的连续曲面天然支持任意候选位宽插值（如 4-bit 到 8-bit 之间的非整数位宽），为未来混合精度方案（甚至非对称位宽分配）提供了灵活接口。

## 8. 潜在不足与局限性

尽管 FRI-MxMoE 在文中展示出亮眼效果，仍存在若干值得关注的问题：

1. **锚点选择与规则库质量的高度耦合**。深度自适应分层采样虽然相比均匀采样更优，但其分层比例和每层的锚点数量仍属于人工设定的超参数。若模型架构（层数、专家数）大改，分层策略是否仍然最优缺乏自适应机制，规则库的覆盖质量取决于此。
2. **类别特征的泛化能力受限**。将子层类型（Gate/Up/Down）作为 one-hot 类别变量意味着 FRI 无法跨类型共享插值信息——比如训练好的规则库里没有 Down 投影的样本，就无法对新的 Down 子层配置做推理。对于结构新颖的 MoE 变体，需重新收集各类别的锚点数据。
3. **鲁棒性验证集中于插值域**。理论分析保证了预测在有界凸包内的平滑性与噪声抑制，但锚点稀疏时对“外推”（extrapolation）场景（如设定超出规则库覆盖范围的极低位宽）没有性质保证，实际使用中对极端配置的安全性需要额外约束。
4. **端到端真实部署验证缺失**。所有 latency 数据来自 profiling 阶段对单算子/子层的计时，不是完整的推理管线实测；在真实系统层面，内存带宽竞争、kernel 融合、张量并行/专家并行下的通信开销等因素会显著影响分配结果的实际收益，论文没有提供端到端推理吞吐对比作为支撑。
5. **频率信息来自校准集的静态统计**。以固定校准集统计出的激活频率代表专家真实使用分布，在分布漂移（如不同领域、语言的输入下路由模式改变）时，频率加权策略可能偏离最优分配。在线自适应或鲁棒加权是更贴近生产环境的改进方向。
6. **量化配置定义的局限**。文中实验主要围绕位宽（precision）做离散搜索，未覆盖更丰富的量化自由度，如激活量化策略、分组大小、通道排列、异常值裁剪方式等。若将该框架推广至这些维度的联合搜索，规则库的变量空间将迅速膨胀。

## 9. 改进方向与未来工作展望

- **规则库的主动学习与动态更新**：根据 FRI 预测的不确定性（如近邻平均距离或预测方差）迭代选取信息量最大的新锚点，可进一步压缩所需 profiling 样本数量，同时提升敏感度曲面的精度。
- **与可微搜索结合**：将 FRI 预测面的梯度信息注入搜索空间，用可微 NAS（Differentiable NAS）或强化学习方式替代离散拉格朗日二分搜索，支持更深层级的超参数（如分组大小、排布方案）联合优化。
- **支持多硬件自适应与在线量化部署**：在真实推理引擎（vLLM、TensorRT-LLM 等）中做 profiling-floor 到部署 floor 的映射校准，将 FRI 直接嵌入 serving 框架，使其面向运行时的动态负载做周期性重配置。
- **全面扩展评估**：加入多语言基准（如 MMLU 多语子集）、指令跟随评测（如 MT-Bench、IFEval）、长文本推理评测；同时报告量化后的端到端生成吞吐与首 token 延迟，使“延迟预算约束”的主张在真实场景下得到验证。
- **把模糊规则替换为可学习的基函数**：现有 FRI 本质是硬编码的加权近邻回归器；可引入少量可训练参数对隶属宽度、近邻权重指数或距离度量进行学习（few-shot meta-learning），在保持可解释性的同时进一步提高预测精度。

## 10. 综合评价与定位

**FRI-MxMoE 的贡献是“应用式创新”而非“原理式创新”**。它没有引入全新的量化算法或分配理论，而是抓住 MoE 量化的结构化特点，将成熟的模糊逻辑插值工具首次适配到混合精度搜索中，并给出了完整的工程化路径与必要的理论性质支持。其研究价值体现在三个层面：

1. **问题意识清晰**：准确指出了混合精度量化框架在大规模 MoE 上 scaling 的核心瓶颈不是求解算法而是 profiling 成本，这在部署实践中极具现实意义；
2. **方法形成闭环**：从稀疏采样、模糊规则构建、插值预测到频率感知分配，每个环节都有对应的实验或理论验证，整体逻辑严密；
3. **结果有说服力**：15.7× profiling 加速且零样本精度不降反升，使其核心主张具有很强的可信度。

从学术定位上，该工作属于“面向大模型推理系统的模型压缩 + 自动化配置”交叉方向，与 LLM.int8()、GPTQ、AWQ、QuaRot 等位宽量化方法互补，而与 MxMoE、LLM-MQCA 等混合精度搜索方法是直接的同赛道竞争者。审稿人角度最可能挑战的仍是真实部署收益验证的缺失，以及规则库在新架构上的可迁移性。

总体而言，**FRI-MxMoE 是一个立意明确、验证扎实、实践导向较强的优秀系统工作**。它在不牺牲模型质量的前提下将昂贵的混合精度 profiling 从“数小时~数十小时”压缩到“分钟~小时”级，为超大 MoE 模型在实际算力约束下的轻量化量身定制了一条务实可行的新路径。

（完）
