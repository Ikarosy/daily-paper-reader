---
title: "Sherry: Hardware-Efficient 1.25-Bit Ternary Quantization via Fine-grained Sparsification"
title_zh: Sherry：基于细粒度稀疏化的硬件高效1.25比特三值量化
authors: "Hong Huang, Decheng Wu, Qiangqiang Hu, Guanghua Yu, Jinhai Yang, Jianchen Zhu, Xue Liu, Dapeng Wu"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.513.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 1.25比特三值量化结合细粒度稀疏，兼顾硬件效率
tldr: "现有三值量化在极低比特下要么存在位浪费，要么因不规则打包拖慢推理速度。Sherry提出3:4细粒度稀疏方法，将四个权重紧凑打包为五个比特，实现硬件友好的1.25比特规则宽度。实验证明Sherry在保持模型精度的同时显著提升推理效率，为边缘设备上的极低比特LLM部署提供了实用方案。"
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 713, \"height\": 551, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1543, \"height\": 563, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1564, \"height\": 478, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 718, \"height\": 552, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 702, \"height\": 543, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 724, \"height\": 556, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 708, \"height\": 542, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 723, \"height\": 549, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1489, \"height\": 719, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1499, \"height\": 855, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long513/fig-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 1459, \"height\": 826, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long513/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1447, \"height\": 962, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long513/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1497, \"height\": 858, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long513/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 611, \"height\": 225, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long513/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 881, \"height\": 470, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long513/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 686, \"height\": 469, \"label\": \"Table\"}]"
motivation: 三值量化虽能降低模型存储和计算开销，但现有实现与硬件不对齐，存在位浪费或推理变慢的问题。
method: "提出3:4细粒度稀疏模式，将四个权重压缩为五个比特，实现1.25比特的规则宽度，兼顾压缩率与推理速度。"
result: 在多个基准上验证了Sherry在极低比特下保持精度，并显著提升硬件端推理效率。
conclusion: Sherry通过稀疏化与规则打包，为极低比特量化提供了硬件友好的高效方案。
---

## Abstract
The deployment of Large Language Models (LLMs) on resource-constrained edge devices is increasingly hindered by prohibitive memory and computational requirements. While ternary quantization offers a compelling solution by reducing weights to -1, 0, +1 , current implementations suffer from a fundamental misalignment with commodity hardware. Most existing methods must choose between 2-bit aligned packing, which incurs significant bit wastage, or 1.67-bit irregular packing, which degrades inference speed. To resolve this tension, we propose Sherry, a hardware-efficient ternary quantization framework. Sherry introduces a 3:4 fine-grained sparsity that achieves a regularized 1.25-bit width by packing blocks of four weights into five bits, restoring power-of-two alignment. Furthermore, we identify weight trapping issue in sparse ternary training, which leads to representational collapse. To address this, Sherry introduces Arenas, an annealing residual synapse mechanism that maintains representational diversity during training. Empirical evaluations on LLaMA-3.2 across five benchmarks demonstrate that Sherry matches state-of-the-art ternary performance while significantly reducing model size. Notably, on an Intel i7-14700HX CPU, our 1B model achieves zero accuracy loss compared to SOTA baselines while providing 25% bit savings and 10% speed up. The code is available at https://github.com/Tencent/AngelSlim.

---

## 论文详细总结（自动生成）

## 1. 核心问题与整体含义

- **研究动机**：大语言模型（LLM）在边缘设备上的部署受到严格的存储和计算约束。三值量化（将权重限制为 {−1, 0, +1}）理论上能以极低比特表示权重，但现有实现与主流硬件（如 SIMD 指令）严重不匹配。
- **关键矛盾**：
  - **2 比特策略**：将每个三值权重对齐填充为 2 比特，保持硬件对齐，但浪费比特，相对 INT2 无存储优势；
  - **1.67 比特策略**：将 3 个权重打包进 5 比特，提高了密度，但 3 路分组不符合 2 的幂次对齐，导致 SIMD 向量化效率低下，实际推理速度反而慢于 2 比特方案。
- **核心目标**：解决“位宽”与“速度”之间的两难，同时实现低比特存储和高效率推理，真正发挥三值量化的理论优势。

## 2. 提出的方法论

- **核心思想**：将三值模型的固有稀疏性结构化，引入 **3:4 细粒度稀疏约束**：每个连续 4 个权重块中恰好有 3 个非零值（±1）、1 个固定为 0。
  - 该模式每个 4 权重块仅需 5 比特表示（4 位索引 + 1 位符号），实现 **1.25-bit 有效位宽**。
  - 4 权重块是 2 的幂，天然与 SIMD 向量通道对齐，可恢复规则化的硬件并行处理。
- **数学形式**：
  - 目标函数：最小化原权重 `W` 与稀疏三值表示 `Tα` 的 L2 重建误差，并施加 3:4 约束。
  - 最优解采用 **Sparse-AbsMean** 策略：每块中剪掉绝对值最小的元素，其余取符号作为三值；缩放因子 `α` 取非零权重绝对值的均值。
  - 理论上证明 3:4 格式是 LUT-based SIMD 引擎下的最优选择：恰好填满 32 个状态（4 选 3 × 2^3 = 32），对应 5 比特索引，无位浪费。
- **关键问题：Weight Trapping（权重陷阱）**：
  - 在朴素 3:4 稀疏三值训练中，梯度均质化（Gradient Homogenization）导致权重分布极化至类似二值状态，表示能力坍缩，有效秩（Effective Rank）下降。
- **Arenas 模块（退火残差突触）**：
  - 前向传播在 QAT 模块输出中加入一个随训练退火的全精度残差项：`Y = XTα + λ_t XW`，其中 `λ_t` 随训练进度从 1 退火至 0。
  - 该残差将连续权重 `W` 引入梯度反向传播，打破梯度均质化，维持权重分布的多样性；训练结束后 `λ_t = 0`，推理时完全移除，零额外开销。
  - 实现上不增加额外矩阵乘法：输出可重写为 `Y = X[Q(W) + W]`，仅需在伪量化中做元素级加法。

## 3. 实验设计

- **模型与数据集**：
  - 基础模型：LLaMA-3.2-1B 和 LLaMA-3.2-3B。
  - 训练数据：UltraFineWeb 抽取的 **10B tokens**。
  - 评估基准：5 个 zero-shot 推理任务——PIQA、ARC-Easy（ARC-e）、ARC-Challenge（ARC-c）、HellaSwag（HelS）、WinoGrande（WinG），使用 `lm-evaluation-harness`。
- **对比方法**：
  - 静态方法：TWN、Tequila（TequilaLLM）、AbsMedian、AbsMean（近 BitNet/Spectra 策略）。
  - 可学习方法：DLT（TernaryLLM）、LSQ、SEQ（ParetoQ）。
  - 另外与现有三元 LLM 系统对比：TernaryLLM、ParetoQ、LLM-QAT、BitNet、Spectra、TequilaLLM。
- **效率测试平台**：
  - LUT 引擎：Intel i7-14700HX CPU（x86），对比 BitNet.cpp 中的 1.67-bit（TL2）和 2-bit（I2_S）策略。
  - 乘法引擎：Apple M4 Pro（ARM），使用 llama.cpp，对比 TQ1_0（1.67-bit）和 TQ2_0（2-bit）。
- **其他实验**：
  - 不同量化粒度（per-tensor / per-channel / per-group 128）下的精度。
  - Arenas 消融（binary、1.25-bit、1.67-bit 三种方案 加/不加 Arenas）。
  - 不同退火调度（线性、余弦、指数，含/不含 warmup）。
  - 附加分析：有效秩变化、权重分布可视化。

## 4. 资源与算力

- 文中仅说明：**训练在 32 张 NVIDIA GPU 上进行**（“Training is conducted on 32 NVIDIA GPUs”）。
- **未提及** GPU 的具体型号（如 A100/H100）、训练时长（epoch 数或 wall-clock 时间）以及总 Token 处理量的详细开销。
- 仅在对比训练开销时提到：Arenas 模块每步 wall-clock 时间为 1.602s，朴素 QAT 为 1.593s，说明额外开销可忽略。

## 5. 实验数量与充分性

- **实验数量**：比较丰富，包括基础性能对比（表 1、表 2）、量化粒度影响（表 3）、LUT 引擎效率（表 4）、乘法引擎效率（表 5），以及多个消融图（图 6、7、8）和辅助可视化（图 10、11）。
- **充分性评价**：
  - 优点：覆盖了“精度 + 位宽 + 推理速度”三个核心维度；既有 SOTA 方法对比，也有消融和调度敏感性分析；效率测试涵盖 x86 和 ARM 两种平台。
  - 潜在不足：
    - 模型规模局限于 1B/3B，未验证大模型（如 70B）上的表现；
    - 只进行 weight-only 量化，未考虑激活和 KV-cache 量化；与这些方法的“可组合性”仅在附录中讨论，无实验支持；
    - 部分基线（如 TernaryLLM、ParetoQ）为作者复现，可能引入复现偏差。

## 6. 主要结论与发现

- Sherry 在 **1.25-bit 位宽**下，性能与 SOTA 1.67-bit 三值量化（Tequila）持平，同时获得 **25% 的位宽缩减**。
- 在 1B 模型中，Sherry 与 Tequila 平均准确率完全相同（0.519），在 ARC-Challenge 等推理密集型任务上甚至有微弱优势，与 BF16 基线差距小于 0.5%。
- 在 Intel i7-14700HX 上，Sherry 相比 1.67-bit 方案提速约 **10%（1B）和 18%（3B）**，同时降低模型体积。
- Arenas 模块有效解决了 3:4 稀疏训练中的权重陷阱问题，无论对 binary、1.25-bit 还是 1.67-bit 方案均有显著增益（分别提升 +2.67%、+4.59%、+2.98%）。
- 3:4 稀疏格式在 LUT 引擎下是最优的：SIMD 友好、状态饱和、且保持 25% 稀疏安全边际；在乘法引擎下也快于 1.67-bit 基线。

## 7. 优点与亮点

- **硬件对齐的创新设计**：通过 3:4 稀疏实现 1.25-bit 的规则打包，同时满足 SIMD 对齐、LUT 容量限制和位状态饱和，是“位宽—速度”权衡中的精巧平衡。
- **问题洞察深入**：明确提出并系统诊断了“权重陷阱 (weight trapping)”现象，并用有效秩（ER）分析和权重分布可视化佐证该机制。
- **训练机制优雅且低开销**：Arenas 模块在训练中提供残差梯度路径，训练后完全移除，推理时零额外成本，且实现上可融合为单次矩阵乘法。
- **实验验证全面**：精度、效率、消融、调度敏感性、多平台验证均有涉及，代码开源，可复现性强。

## 8. 不足与局限

- **模型规模限制**：仅在最大 3B 参数模型上评估，未验证 70B+ 级大模型上的行为和效果。
- **服务器级优化缺失**：实验面向边缘 CPU SIMD，未针对 NVIDIA Sparse Tensor Cores 等服务器硬件做优化，服务器场景潜力尚未挖掘。
- **平台基线不足**：LUT 引擎效率对比仅在 x86 架构上可行（受限于参考实现 TL2_0 的 x86 依赖），ARM 端仅提供了乘法引擎结果；完整 LUT 迁移尚未完成。
- **仅权重量化**：激活和 KV-cache 仍为 BF16，长上下文时内存瓶颈仍存在；虽附录了与激活/KV 量化的兼容性讨论，但缺乏联合实验证据。
- **训练资源信息不完整**：未详细报告 GPU 型号和训练时长，影响算力成本评估和可复现性。
- **潜在偏差风险**：极端 1.25-bit 量化可能压缩模型安全表示，使量化模型更容易被越狱或生成有害内容；离线部署缺少云端过滤器，且边缘设备难以快速更新安全补丁。

---

（完）
