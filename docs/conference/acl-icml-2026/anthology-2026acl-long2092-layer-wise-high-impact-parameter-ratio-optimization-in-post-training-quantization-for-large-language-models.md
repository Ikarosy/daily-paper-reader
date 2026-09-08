---
title: Layer-Wise High-Impact Parameter Ratio Optimization in Post-Training Quantization for Large Language Models
title_zh: 大语言模型后训练量化的逐层高影响参数比例优化
authors: "Cuong Pham, Anh Dung Hoang, Cuong C. Nguyen, Trung Le, Gustavo Carneiro, Thanh-Toan Do"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.2092.pdf"
tags: ["query:wbv"]
score: 7.0
evidence: 逐层优化高影响参数的FP16比例，面向极低比特后训练量化
tldr: 现有PTQ在极低比特下会因高影响参数而大幅掉点，按层使用固定FP16保留比例会忽略各层敏感度差异。该文提出二次规划优化框架，逐层决定高影响参数保留比例，并考虑整体压缩损失。该方法能在超低位宽下更好分配混合精度，从而缓解精度崩溃问题。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long2092/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1656, \"height\": 547}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long2092/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1662, \"height\": 1188}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long2092/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1659, \"height\": 1475}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long2092/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1640, \"height\": 627}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1483, \"height\": 745}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1487, \"height\": 576}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1571, \"height\": 351}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1406, \"height\": 449}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 767, \"height\": 196}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 740, \"height\": 304}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 807, \"height\": 220}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1450, \"height\": 973}]"
motivation: 极低比特PTQ因高影响参数损失严重，固定FP16比例忽略层间敏感度差异。
method: 用二次规划优化每层高影响参数的FP16保留比例，同时纳入整体量化误差约束。
result: 获得逐层最优保留比例，在极低比特下改善量化精度与内存开销的折中。
conclusion: 为极低比特PTQ提供更细粒度、层自适应的混合精度方案。
---

## Abstract
Large language models (LLMs) have advanced natural language processing, but their massive parameter counts create computational and memory challenges during deployment. Post-training quantization (PTQ) has emerged as a promising approach to mitigate these challenges. While existing PTQ methods can effectively quantize LLMs, they experience substantial accuracy loss at extremely low bit-widths due to high-impact parameters. Several approaches address this by retaining high-impact parameters in FP16 format, but they apply fixed ratios across all layers, overlooking layer-wise sensitivity variations. We propose a quadratic optimization framework that determines layer-specific ratios of high-impact parameters while considering inter-layer dependencies. We quantize high-impact parameters to moderate bit-widths while the remaining parameters are quantized to extremely low bit-widths. Under the same resource budget, this preserves more high-impact parameters than methods retaining a few in FP16 format. Our framework enables leveraging advanced quantization methods for high-impact parameters while applying lightweight computational quantization methods to the rest, achieving an effective balance between computational efficiency and accuracy during quantization process.

---

## 论文详细总结（自动生成）

# 论文总结：Layer-Wise High-Impact Parameter Ratio Optimization in Post-Training Quantization for Large Language Models

## 1. 核心问题与研究动机
- **背景**：大语言模型（LLM）参数规模庞大，部署时面临严重的内存与计算开销。后训练量化（PTQ）是缓解该问题的有效手段，能在无需充分训练数据与大量训练成本的情况下压缩模型。
- **核心挑战**：在极低比特（如 2-bit、3-bit）权重量化下，现有 PTQ 方法会因“高影响参数”（对量化误差影响显著的部分权重）而产生严重精度下降。
- **已有方案不足**：已有方法（如 AWQ、CherryQ、SqueezeLLM 等）尝试将部分高影响参数保留为 FP16 或更高精度，但这些方法通常在所有层使用**固定保留比例**，忽略了不同层对高影响参数的敏感度差异。此外，逐元素稀疏保留或非均匀量化不利于硬件部署。
- **论文立意**：提出一个**逐层二次优化框架**，在统一资源预算下，自动确定每层高影响参数的最优比例，从而更精细地分配量化精度，缓解极低比特下的精度崩溃问题。

## 2. 方法论

### 核心思想
- 与“保留少量高影响参数为 FP16”不同，本文主张将这些高影响参数量化为**中等比特（如 4-bit 或 3-bit）**，从而在相同内存预算下能保留**更多**高影响参数。
- 剩余普通参数量化为极低比特（如 2-bit）。
- 在量化过程中，对高影响参数采用 **AdaRound** 这类高精度但计算量大的优化方法，对普通参数采用 **OmniQuant** 的轻量级可学习裁剪方法，从而实现精度与计算效率的平衡。

### 关键技术细节
- **参数影响度量**：利用 Fisher Information 近似 Hessian 矩阵的对角元素，作为每个参数在量化扰动下的敏感度（impact score）。
- **通道级粒度**：与逐元素稀疏方法相比，论文以通道（hidden dimension）为单位识别高影响参数，更利于硬件加速。
- **最优比例求解**：
  - 定义每一层、每个候选比例的 one-hot 选择向量 δ。
  - 通过二阶泰勒展开近似量化损失：L(θ_FP + Δ) - L(θ_FP) ≈ (1/2) Δᵀ H Δ。
  - 将模型整体权重变化表示为 Δ = Dᵀδ，从而将目标转化为二次形式 δᵀ M δ，其中 M = D H Dᵀ。
  - 利用“层间依赖主要集中在同一 block 内”的假设，将 M 中不同 block 的交叉项近似为 0，对角元和非对角元分别通过单层/双层扰动下的损失差计算。
- **约束优化**：在总资源预算（bit 数）约束下，以最小化 δᵀ M δ 为优化目标，每个层只能选择一个候选比例。该问题可由二次规划求解。
- **混合量化策略**：
  - 高影响参数：采用 AdaRound 的可学习 rounding 矩阵，并加入正则项使其趋于二值。
  - 普通参数：采用 OmniQuant 的可学习权重裁剪（weight clipping）。

## 3. 实验设计

### 数据集 / 评估场景
- **校准数据**：WikiText-2 随机采样 128 条序列，每条 2048 token。
- **语言建模评估**：WikiText-2 和 C4 上的困惑度（PPL，越低越好）。
- **零样本下游任务**：HellaSwag、PIQA、WinoGrande、ARC-easy、ARC-challenge 的准确率。
- **模型**：LLaMA-2-7B、LLaMA-2-13B，另在 OPT-125M 上做了补充实验。

### 对比方法
- GPTQ、AWQ、SqueezeLLM、CBQ、OmniQuant，以及全精度 FP16 基线。
- 量化设置包括 W2A16、W3A16，以及带 group size（g64/g128）的配置。

## 4. 资源与算力
- 论文仅说明 **“所有实验基于 NVIDIA A100 GPU”**。
- **未明确说明** GPU 数量、具体训练/量化时长、总计算量等细节。

## 5. 实验数量与充分性

### 主要实验组数
- **语言建模困惑度**：分别在 LLaMA-2-7B、LLaMA-2-13B 上对 2-bit 和 3-bit 进行 C4 / WikiText-2 评测（表 1、表 2）。
- **下游零样本任务**：表 3 展示了 LLaMA-2-7B 在 W2A16g128 与 W3A16g128 下的 5 个任务平均准确率。
- **消融研究**：
  - 固定比例 vs. 最优比例；
  - 是否启用混合量化策略；
  - 候选比例集合 B 的敏感性分析；
  - OPT-125M 上的补充实验；
  - 不同校准数据集的稳定性分析；
  - 同一资源约束下不同高影响参数位宽（b_H）的对比实验。
- **可视化分析**：展示了多层 Fisher Information 分布及优化后每层高影响参数比例 δ。

### 充分性评价
- 实验**覆盖面较广**：包含两种模型尺寸、两种低比特宽度、多种 group size、语言建模与推理任务、多种消融。
- 但仍有改进空间：未报告 C4 上所有对比方法的完整结果（个别条目缺失用“–”表示）；未做更大规模模型（如 30B/70B）的验证；下游任务仅集中在常识推理，缺少编码、数学等能力评估。
- 整体设计较客观：与多处 SOTA 方法对齐了实验设置，并引用已发表结果进行对比；消融实验能清楚区分每个设计组件的贡献。

## 6. 主要结论与发现
- 逐层优化高影响参数比例，相比固定比例能更有效分配精度资源，明显提升极低比特量化性能。
- 在**相同平均比特数**下，将高影响参数量化为中等位宽（如 3-bit/4-bit）比保留为 FP16 能保留更多关键参数，从而获得更低困惑度和更高下游准确率。
- 混合量化策略（对高影响参数用 AdaRound，对普通参数用 OmniQuant）能在可接受的计算开销内获得显著性能提升。
- 在 2-bit 和 3-bit 权重量化条件下，该方法在 LLaMA-2 系列模型中优于 GPTQ、AWQ、OmniQuant、SqueezeLLM、CBQ 等基线。
- 例如 LLaMA-2-7B W2A16 设置下，WikiText-2 困惑度由 OmniQuant 的 37.37 降至 9.40；零样本平均准确率在 W2A16g128 下达到 49.04%，超过 OmniQuant 约 1.5%。

## 7. 优点
- **方法新颖**：将“高影响参数比例分配”形式化为块级二次优化，考虑层间与块内依赖，比固定比例方式更合理。
- **硬件友好**：采用通道级粒度加标准均匀量化，避免了 CherryQ 的逐元素稀疏和 SqueezeLLM 的非均匀码本，更易部署。
- **资源分配高效**：在统一内存预算下，将高影响参数用量化为中等位宽而非 FP16，从而显著扩大可保留的高影响参数数量。
- **灵活的组合策略**：允许对不同重要性参数使用不同 PTQ 方法，兼顾精度与计算效率。
- **理论建模较充分**：从 Taylor 展开和 Fisher Information 出发推导损失敏感度，数学动机清晰。

## 8. 不足与局限
- **手动设定高位宽**：作者在 Limitation 中指出，论文目前需要人为预先指定高影响参数所采用的较高位宽（如 3-bit 或 4-bit），未必在任意资源约束下都是最优选择；未来可探索动态/可学习位宽。
- **计算开销仍然不低**：尽管采用块级近似降低了复杂度，但仍需多次前向传播计算扰动损失，且 AdaRound 部分需要 5000 步优化；对超大模型（如 70B 以上）的可行性还需验证。
- **实验规模有限**：只验证了 LLaMA-2-7B/13B 以及 OPT-125M，未涉及更主流的更大规模模型；下游任务范围局限于常识推理与部分世界知识。
- **依赖近似假设**：将层间依赖限制在同一 block 内、用 Fisher 近似 Hessian 等做法不可避免引入误差，难以保证所有网络结构下都最优。
- **未给出推理速度与硬件实测**：虽然声称硬件友好，但缺少端到端延迟、吞吐或内存占用的实际测量数据。

（完）
