---
title: Layer-Wise High-Impact Parameter Ratio Optimization in Post-Training Quantization for Large Language Models
title_zh: 大语言模型后训练量化中的逐层高影响参数比例优化
authors: "Cuong Pham, Anh Dung Hoang, Cuong C. Nguyen, Trung Le, Gustavo Carneiro, Thanh-Toan Do"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.2092.pdf"
tags: ["query:wbv"]
score: 4.0
evidence: 极低比特后训练量化，逐层优化高影响参数比例
tldr: 大模型后训练量化在极低比特下精度损失严重，现有方法用固定比例保留FP16高影响参数，忽视层间敏感度差异。该工作提出二次优化框架，为每层自适应决定高影响参数保留比例。实验验证该方法在极低比特量化下优于固定比例方案，减少精度下降。该框架可推广至其他低比特量化模型压缩任务。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long2092/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1656, \"height\": 547, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long2092/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1662, \"height\": 1188, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long2092/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1659, \"height\": 1475, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long2092/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1640, \"height\": 627, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1483, \"height\": 745, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1487, \"height\": 576, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1571, \"height\": 351, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1406, \"height\": 449, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 767, \"height\": 196, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 740, \"height\": 304, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 807, \"height\": 220, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long2092/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1450, \"height\": 973, \"label\": \"Table\"}]"
motivation: 固定比例保留高影响参数忽视层间敏感度，极低比特下精度损失大。
method: 提出二次规划框架优化各层高影响参数的FP16保留比例。
result: 实验显示在极低比特量化下优于固定比例方案。
conclusion: 为低比特PTQ提供了层间自适应的高影响参数分配策略。
---

## Abstract
Large language models (LLMs) have advanced natural language processing, but their massive parameter counts create computational and memory challenges during deployment. Post-training quantization (PTQ) has emerged as a promising approach to mitigate these challenges. While existing PTQ methods can effectively quantize LLMs, they experience substantial accuracy loss at extremely low bit-widths due to high-impact parameters. Several approaches address this by retaining high-impact parameters in FP16 format, but they apply fixed ratios across all layers, overlooking layer-wise sensitivity variations. We propose a quadratic optimization framework that determines layer-specific ratios of high-impact parameters while considering inter-layer dependencies. We quantize high-impact parameters to moderate bit-widths while the remaining parameters are quantized to extremely low bit-widths. Under the same resource budget, this preserves more high-impact parameters than methods retaining a few in FP16 format. Our framework enables leveraging advanced quantization methods for high-impact parameters while applying lightweight computational quantization methods to the rest, achieving an effective balance between computational efficiency and accuracy during quantization process.

---

## 论文详细总结（自动生成）

## 1. 论文的核心问题与整体含义（研究动机和背景）

- **核心问题**：大语言模型（LLM）参数规模巨大，部署时面临显存和计算压力。后训练量化（PTQ）是缓解该问题的有效手段，但在极低比特（如 2-bit）下，高影响参数（high-impact parameters）会引发严重的精度下降。
- **已有方法的不足**：现有方法（如 AWQ、CherryQ、SqueezeLLM 等）通常使用固定的高影响参数比例（如固定保留 1% 的 FP16 参数），未考虑不同层对参数重要性的敏感度差异；同时，将高影响参数保留为 FP16 会占用较多预算，限制了可保留的参数数量，导致次优的资源分配。
- **本文目标**：提出一种逐层自适应的、基于二次优化的高影响参数比例分配框架，在给定内存预算下更科学地决定每一层应当保留多少高影响参数，并采用“高影响参数用中等比特、普通参数用极低比特”的混合精度策略，从而在极低比特量化下显著降低精度损失。

## 2. 论文提出的方法论：核心思想、关键技术细节、公式或算法流程

- **核心思想**：
  1. 高影响参数并非均匀分布在各层，不同层的高影响参数比例差异显著，因此应以层为单位自适应分配保留比例。
  2. 在相同资源预算下，将高影响参数量化为中等比特（如 3-bit 或 4-bit）比保留为 FP16 能覆盖更多的参数，从而更好地保护模型性能。
  3. 对高影响参数采用计算成本较高的先进量化方法（如 AdaRound），对普通参数采用轻量量化方法（如 OmniQuant 的可学习权重裁剪），实现精度与效率的平衡。

- **技术细节与公式**：
  - 使用 Fisher Information 近似 Hessian 矩阵的对角元，作为每个参数的影响分数：  
    \( H_{i,i} \approx F_{i,i} = E[g g^\top]_{i,i} \)
  - 将量化导致的损失变化用二阶泰勒展开近似：  
    \( L(\theta^{FP}+\Delta) - L(\theta^{FP}) \approx \frac{1}{2}\Delta^\top H \Delta \)
  - 对每一层定义候选的高影响参数比例集合 \( B \)，用 one-hot 向量 \( \delta_l \) 表示该层选择哪个比例；全网络的选择向量为 \( \delta \)。
  - 将量化误差变化转化为二次型：\( \frac{1}{2}\Delta^\top H \Delta = \frac{1}{2}\delta^\top M \delta \)，其中 \( M = D H D^\top \)。
  - 矩阵 \( M \) 的元通过实际计算量化前后的损失差来近似：
    - 对角元：\( M_{ll} \approx 2 [L(\theta^{FP}+\Delta_{l,m}) - L(\theta^{FP})] \)
    - 非对角元（同 block 内层间交互）：通过组合扰动计算，不同 block 的层间项设为 0（认为跨 block 交互可忽略）。
  - 最终优化问题为带约束的二次规划：
    - 目标：最小化 \( \delta^\top M \delta \)
    - 约束：总比特数不超过目标预算 \( C_{target} \)；每层只能选择一个比例；\( \delta \) 为 one-hot 向量。
  - 求解得到最优比例向量 \( \delta \) 后，对每层的高影响参数（按 Fisher 分数排序的 top 比例）采用 AdaRound 学习可舍入权重矩阵 \( V^H \)，对普通参数采用 OmniQuant 的可学习裁剪量化。
  - 算法流程（Algorithm 1）：初始化矩阵 M → 对每层每个候选比例计算对角元 → 对同 block 内层对计算非对角元 → 求解二次规划得到 δ。

## 3. 实验设计：数据集、基准、对比方法

- **模型**：LLaMA-2-7B、LLaMA-2-13B；附录中额外使用 OPT-125M。
- **量化设置**：2-bit 和 3-bit 的权重量化（weight-only），激活保持 FP16；包括无分组、g128、g64 三种粒度。高影响参数在 2-bit 任务中使用 3-bit，在 3-bit 任务中使用 4-bit。
- **校准数据**：WikiText-2 中随机采样的 128 条序列，每条 2048 token；附录也报告了用 C4 校准的结果。
- **评估基准**：
  - 语言建模：WikiText-2 和 C4 的困惑度（PPL）。
  - 零样本下游任务：HellaSwag、PIQA、WinoGrande、ARC-easy、ARC-challenge。
- **对比方法**：GPTQ、AWQ、OmniQuant、SqueezeLLM、CBQ（均为当前 SOTA PTQ 方法）。

## 4. 资源与算力

- 论文在实验设置部分说明所有实验在 NVIDIA A100 GPU 上进行，但**未明确给出 GPU 数量、训练/优化时长、总计算量等具体数据**。
- 仅提到优化高影响参数的 AdaRound 轮次为 5,000 次迭代，优化器为 Adam，学习率 \(10^{-3}\)，L2 正则 \(10^{-5}\)。
- 时间复杂度分析：由于只考虑同 block 内层间依赖，整体复杂度为 \(O(B L_b (L_b-1))\)，随 block 数线性增长。

## 5. 实验数量与充分性

- **实验组数**：
  - 2-bit 量化在 4 个设置（W2A16、W2A16g128、W2A16g64）× 2 个模型（7B、13B）× 2 个数据集（C4、Wiki2）的主实验。
  - 3-bit 量化类似，共 12 组结果主实验。
  - 零样本任务在 W2A16g128 和 W3A16g128 两个设置上对比 5 个任务。
  - 消融实验：固定比例 vs 最优比例；是否使用混合量化策略（4 种组合）。
  - 附录补充实验：候选比例集合敏感性、OPT-125M 上的实验、不同校准数据集的鲁棒性、高影响参数位宽选择对比（3/4/16 bit 在相同预算下）。
- **充分性**：
  - 实验覆盖了多种 bit-width、分组方式、模型规模以及下游任务，且有对比 SOTA 方法，整体较为充分。
  - 消融实验清晰地验证了“最优比例”和“混合量化”各自的贡献。
  - 但实验仅在 LLaMA-2 系列和 OPT-125M 上进行，未覆盖更多架构（如 Mistral、Gemma、Qwen 等）或更大规模（如 30B+）模型；也未进行与其他混合精度方法的系统对比（如 SqueezeLLM 在部分配置下未报告）。
  - 对零样本任务只报告了 LLaMA-2-7B，缺少 13B 的下游任务结果。

## 6. 论文的主要结论与发现

- 在 2-bit 权重量化下，本文方法显著优于现有 PTQ 方法。例如在 LLaMA-2-7B W2A16 设置下，WikiText-2 困惑度从 OmniQuant 的 37.37 降到 9.40；在 W2A16g64 下比 CBQ 在 Wiki2 上降低 0.24、在 C4 上降低 0.48。
- 在 3-bit 量化下，本文方法也持续领先，接近 SqueezeLLM 等非均匀量化方法的性能，同时保持了均匀量化的硬件友好性。
- 零样本任务上，W2A16g128 平均准确率 49.04%（比 OmniQuant 高 1.45%）；W3A16g128 平均准确率 60.87%，与 Full-precision 差距缩小到约 4%。
- 消融实验表明，逐层优化比例优于固定比例（平均准确率 +2.4%，PPL -0.15）；混合量化策略进一步带来提升（在最优比例基础上平均准确率 +0.48，PPL -0.40）。
- 相同资源预算下，使用中等比特（如 3-bit 或 4-bit）保留高影响参数比保留 FP16 效果更好，验证了“不一定要 FP16”的假设。
- 该方法能在极低比特下保持较好性能，为 LLM 高效部署提供了可行方案。

## 7. 优点

- **创新点清晰**：从“固定比例”扩展到“逐层优化比例”，并且将离散选择问题建模为二次规划，借助 Hessian/Fisher 信息提供了理论依据。
- **考虑层间依赖**：不仅关注每层单独的影响，还显式建模同一 block 内层与层之间的交互，比独立逐层优化更精确。
- **硬件友好**：高影响参数按 channel 粒度划分，优于 CherryQ 的逐元素划分；普通参数使用均匀量化，避免 SqueezeLLM 非均匀码本的硬件不友好问题。
- **灵活的资源分配**：通过“中等比特 + 极低比特”的组合，在预算内最大化高影响参数的覆盖范围，比“FP16 + 极低比特”更有效。
- **混合量化策略实用**：将 AdaRound 应用到少量高影响参数上，避免全模型 AdaRound 的巨大计算开销，同时保留其精度优势；普通参数使用轻量方法，兼顾效率和精度。
- **实验验证较充分**：包含多个量化位宽、分组粒度、两个数据集和下游任务，并有消融研究，结论较可靠。

## 8. 不足与局限

- **位宽选择仍需人工设定**：论文明确指出，高影响参数的比特宽度（例如 2-bit 时设为 3-bit）是预先手工指定的，未在训练中动态调整，可能不是给定预算下的最优选择。
- **候选比例集合有限**：默认集合 \( B = \{0.02, 0.05, 0.1, 0.15, 0.2\} \) 仅有 5 个离散选项，粒度有限；更细的集合效果稍好但计算成本增加（|M| 随 |B|² 增长）。
- **实验模型规模有限**：只在 7B/13B/0.125B 上验证，未涉及更大规模（如 70B）或其他主流架构，泛化性有待进一步检验。
- **零样本任务评估覆盖不完整**：仅报告了 LLaMA-2-7B 的下游任务结果，未给出 13B 的零样本准确率；部分对比方法（如 SqueezeLLM）在零样本任务中的结果未列出，对比公平性略有不足。
- **计算代价未完全透明**：未报告实际 GPU 数量和总耗时，优化过程中需要计算大量损失差（对每个候选比例和同 block 层对），虽然复杂度近似线性于 block 数，但对 13B 以上模型仍可能较耗时。
- **Hessian 近似假设的局限**：使用 Fisher 信息近似 Hessian，且假设跨 block 层间交互为零，这些假设在大模型复杂损失景观下不一定完全成立，可能导致次优解。

（完）
