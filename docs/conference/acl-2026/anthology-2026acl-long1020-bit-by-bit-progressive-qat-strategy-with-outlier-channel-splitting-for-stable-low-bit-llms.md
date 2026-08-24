---
title: "Bit-by-Bit: Progressive QAT Strategy with Outlier Channel Splitting for Stable Low-Bit LLMs"
title_zh: 逐位量化：带离群通道分裂的渐进式QAT策略实现稳定低位LLM
authors: "Binxing Xu, Hao Gu, Lujun Li, Hao Wang, Bei Liu, Jiacheng Liu, Qiyuan Zhu, Xintong Yang, Chao Li, Sirui Han, Yike Guo"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.1020.pdf"
tags: ["query:wbv"]
score: 8.0
evidence: 面向稳定低位LLM的渐进式量化感知训练，采用整数量化网格支持多位标量量化
tldr: 直接在超低精度下进行量化感知训练常因收敛不稳、离群通道噪声和层间误差累积而失效。为此提出Bit-by-Bit，采用逐块渐进式训练逐级降低精度，配合离群通道分裂和嵌套整数量化网格，实现训练一次即可部署任意位宽。实验显示该方法显著提升低位LLM的训练稳定性和最终性能。这项工作为低位标量量化提供了通用且稳定的训练方案。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1020/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 799, \"height\": 745, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1020/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1654, \"height\": 374, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1020/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1655, \"height\": 297, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1020/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1663, \"height\": 479, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1020/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 810, \"height\": 388, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1020/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 779, \"height\": 579, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1020/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1646, \"height\": 1139, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1020/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 722, \"height\": 565, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1020/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1644, \"height\": 557, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1020/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 807, \"height\": 384, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1020/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 761, \"height\": 581, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1020/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1645, \"height\": 670, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1020/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 766, \"height\": 249, \"label\": \"Table\"}]"
motivation: 超低位量化训练面临收敛不稳定、离群通道噪声和误差累积问题，影响低比特LLM性能。
method: 提出逐位渐进QAT框架，逐块降低精度并采用离群通道分裂，配合嵌套整数网格支持多精度部署。
result: 在低比特LLM上实现更稳定的收敛和更优的精度，支持多种位宽部署而无需重新训练。
conclusion: 该方法为低位标量量化提供了一种稳健的渐进式训练范式，提升了低比特LLM的实用性与灵活性。
---

## Abstract
Training LLMs at ultra-low precision remains a formidable challenge. Direct low-bit QAT often suffers from convergence instability and substantial training costs, exacerbated by quantization noise from heavy-tailed outlier channels and error accumulation across layers. To address these issues, we present Bit-by-Bit , a progressive QAT framework with outlier channel splitting. Our approach integrates three key components: (1) block-wise progressive training that reduces precision stage by stage, ensuring stable initialization for low-bit optimization; (2) nested structure of integer quantization grids to enable a "train once, deploy any precision" paradigm, allowing a single model to support multiple bit-widths without retraining; (3) rounding-aware outlier channel splitting, which mitigates quantization error while acting as an identity transform that preserves the quantized outputs. Furthermore, we follow microscaling groups with E4M3 scales, capturing dynamic activation ranges in alignment with OCP/NVIDIA standards. To address the lack of efficient 2-bit kernels, we developed custom operators for both W2A2 and W2A16 configurations, achieving up to 11 × speedup over BF16. Under W2A2 settings, Bit-by-Bit significantly outperforms baselines like BitDistiller and EfficientQAT on both Llama2/3, achieving a loss of only 2.25 WikiText2 PPL compared to full-precision models.

---

## 论文详细总结（自动生成）

## 1. 核心问题与整体含义

- **研究背景**：大语言模型规模不断增长，为降低存储与计算开销，低比特量化成为关键手段。传统 PTQ 在 ≤4-bit 超低位区间性能急剧下降；而 QAT 虽然将量化过程融入训练，但在超低位（如 2-bit）下仍面临严重的训练不稳定、收敛困难和高昂训练成本。
- **核心挑战**：
  - 低比特化导致 loss landscape 变得崎岖不连续（Figure 1），易陷入差的局部最优；
  - 训练过程中出现明显的 loss spike（Figure 2a）；
  - 重尾离群通道放大量化误差；
  - 深层 block 误差累积严重（Figure 2b）；
  - 低比特权重表示能力受限，存在表示坍缩（Figure 3）。
- **论文提出的问题**：如何缓解量化误差并实现稳定的超低位 QAT？
- **整体回答**：提出 **Bit-by-Bit** 框架，通过渐进式逐位降精度、嵌套整数量化网格、以及「舍入感知的离群通道分裂」，显著提升超低位 LLM 的训练稳定性、最终精度和多精度部署灵活性。

## 2. 方法论

### 2.1 量化基础
- 对除 LM head 与 embedding 外的所有线性层做分组量化。
- 采用非对称量化（含 zero-point）以最大化 2-bit 表示能力：
  - \( q = \text{round}((x/z)s + z) \)，再 clip 到 \([0, 2^n-1]\)
  - 尺度 \( s = (Max-Min)/(2^n-1)\)，zero-point \( z = -\text{round}(Min/s)\)
- 反向传播使用 STE（Straight-Through Estimator）；scale 与 zero-point 由闭式解直接得出，无额外剪枝或启发式调整。

### 2.2 渐进式逐位 QAT（Progressive Bit-by-Bit QAT）
- **核心观察**：低位网格天然嵌套在高位网格中；高位网格可作为低位表示的平滑细化，形成从粗到细的优化路径。
- **渐进策略**：从较高精度（如 w8a16）出发，逐步降到 w4a16、w2a16；对激活同理，先稳定低比特权重，再逐步降低激活精度（weights 先于 activations）。
- **逐块策略**：借鉴 BRECQ / EfficientQAT，使用 block-wise 损失缓解误差累积：
  - \( \text{MSE}[(x^{(i)}_{w(k+\Delta)a16} W^{(i)}_{wka16}) - (x^{(i)}_{w16a16} W^{(i)}_{w16a16})] \)
  - 用高比特 block 激活作为更精确的教师信号。

### 2.3 Once-for-any-precision（一次训练，任意精度部署）
- **关键思想**：利用低比特网格是高比特网格的子集关系，使用**位移动**实现精度切换。
- 例如已量化到 h-bit 的整数码 \( q^{(h)} \)，可通过右移得到 l-bit 码：\( q^{(l)} = q^{(h)} \gg (h-l) \)，反量化时左移回原尺度。
- **课程式多目标训练**：依次训练目标集合 \( Bit = \{(8); (8,4); (8,4,2)\} \)，共同优化：
  - \( L = \sum_{b \in Bit} \lambda_b \cdot \text{MSE}(x W_b, y) \)
- **部署**：只保留 master checkpoint，推理时按需通过位移动获得任意精度，无需重训或多个模型副本。

### 2.4 舍入感知的离群通道分裂（Rounding-Aware Outlier Channel Splitting, OCS）
- **问题**：离群通道扩大动态范围、放大量化误差；直接裁剪会损失重要语义特征。
- **机制**：将一个离群通道分裂成两个幅度减半的分支，以恒等变换保持输出不变：
  - \( x_m w_m = x_m \cdot \frac{w_m + s/2}{2} + x_m \cdot \frac{w_m - s/2}{2} \)
  - 该分裂是**舍入感知**的：两个分支的舍入误差能相互抵消，使得量化后输出保持不变。
- **离群通道检测指标**：\( \text{metric}_i = \|X_i\|_2 \cdot \max_{1\le j\le n}|W_{ij}| \)（结合激活范数与权重最大幅值）。
- **深度相关分裂比例**：按层深线性增加分裂比例 \( r_b = r_{\min} + \frac{b-1}{B-1}(r_{\max}-r_{\min}) \)，为更深层分配更多分裂，以匹配误差累积规律。

### 2.5 Microscaling 格式
- 采用每 32 个元素一组的分组缩放，每组尺度用 **FP8 E4M3** 存储，而不是标准 MX 的 E8M0，以提供更精细的步长调整。
- 额外存储开销仅 \( 8/32 = 0.25 \) bits/weight。

### 2.6 自定义 2-bit Kernel
- 开发了 **W2A2** 与 **W2A16** 的 CUDA kernel：
  - W2A2：2-bit 打包，用 `lop3.b32` 解包，用 `dp4a` 做整数累加；
  - W2A16：基于 Marlin 框架扩展，支持 tensor-core MMA、异步拷贝、FP32 累加。

## 3. 实验设计

### 3.1 Benchmark 与数据集
- **语言建模**：WikiText2、C4 的困惑度（PPL）。
- **零样本推理**：PIQA、ARC-Easy、ARC-Challenge、HellaSwag、Winogrande。
- **附录额外评测**：GSM8k、MathQA、MMLU、IFEval（复杂推理与指令跟随）。
- 校准/训练数据：RedPajama 4096 样本子集（seq len 2048），部分 baseline 用 Alpaca 子集。

### 3.2 对比方法
- **PTQ 基线**：GPTQ、AWQ、OmniQuant、SmoothQuant、MatQuant、SpinQuant。
- **QAT 基线**：EfficientQAT、ParetoQ、BitDistiller。
- 将 QAT baseline 扩展激活量化（EfficientQAT 用动态缩放，BitDistiller 用非对称裁剪，ParetoQ 用 2-bit SEQ）。

### 3.3 主要设置
- 模型：LLaMA-2 7B / 3.2-1B / 3.2-3B / 3-8B、Mistral-7B、Qwen2.5（附录）。
- 两种目标模式：w2a16（仅权重）与 w2a2（权重+激活）。
- 渐进阶段：w8a16→w4a16→w2a16，每两 epoch 切换一次；w2a2 先降权重后降激活。

### 3.4 资源与算力
- 文中明确 **所有实验在单张 H800 GPU 上完成**；GEMV kernel 测速在单张 RTX 4090 上完成。
- 训练数据量很小：Bit-by-Bit 仅用 4096 样本 RedPajama 子集，训练 token 量远小于 ParetoQ 原版（原文对比中 ParetoQ 被限制为 2 epochs，4096 RedPajama + 4096 Alpaca）。
- 未明确指出总 GPU 时数，仅说明每个精度阶段 2 epochs，整体训练时长没有精确数值。

## 4. 实验数量与充分性

- **主实验（Table 1）**：在 4 个模型 × 2 个数据集 × 2 种量化模式上报告 PPL，覆盖 w2a16 与 w2a2，并有多个 QAT 与 PTQ 基线对比。
- **零样本评测（Table 2）**：LLaMA-3.2-3B 上 5 个任务，w2a16 与 w2a2 各一组，验证通用能力。
- **Once-for-any-precision 对比（Table 4）**：Mistral-7B 上 w8a16/w4a16/w2a16 与 OmniQuant、MatQuant 对比。
- **消融实验（Table 3 & Table 6）**：
  - w2a16 设置：逐个消融 block-wise loss、progressive、OCS，并对比不同离群指标（kurtosis、wmax、xmax、联合指标）和不同 group size（32/64/128）；
  - w2a2 设置：1 epoch 训练下验证组件有效性、指标选择、校准集（WikiText2/RedPajama/C4）与 group size 影响。
- **附录补充**：GSM8k/MathQA/MMLU/IFEval 评测、kernel latency（Table 7）、端到端吞吐（Table 8）、不同精度调度策略（A/B/C/D）的观察、Muon optimizer 的实验。
- **充分性与公平性**：
  - 训练预算已尽量对齐：EfficientQAT 用 Block-AP+E2E、BitDistiller 用 Alpaca KD、ParetoQ 限制为 2 epochs；
  - 消融覆盖了关键组件与超参；
  - 但主实验只报告了少量模型规模（最大 8B），未覆盖更大模型（如 70B）的 QAT 结果，仅在 kernel 测速中提到 Llama3-70B 的形状。

## 5. 主要结论与发现

- **Bit-by-Bit 在超低位量化下显著优于基线**：
  - w2a16 下 LLaMA-3.2-3B WikiText2 PPL 为 11.02，明显低于 EfficientQAT（13.31）与 BitDistiller（12.80）；
  - w2a2 下 LLaMA-2 7B 达到 7.72 PPL，仅比 FP16 高 2.25，而 EfficientQAT 为 9.71、BitDistiller 为 29.66。
- **零样本任务上稳健**：LLaMA-3.2-3B w2a2 平均 accuracy 51.52，比最强 baseline BitDistiller（46.28）高 5 分以上。
- **一次训练多精度部署可行**：Mistral-7B 上单次 QAT 即可适配 w8a16/w4a16/w2a16，w2a16 达到 65.37 平均任务精度，接近 MatQuant，远超 OmniQuant。
- **OCS 有效且开销极小**：权重矩阵内存从 0.33GB 仅增至 0.36GB。
- **自定义 kernel 加速明显**：W2A2 在较大矩阵上对比 BF16 达到超过 10× 加速；Llama3-8B 端到端解码吞吐从 49 tokens/s 提升到 76 tokens/s（1.5×）。

## 6. 优点与亮点

1. **渐进式训练设计巧妙**：利用嵌套量化网格的粗到细结构，显著缓解超低位训练的不稳定性，并且自然导出 once-for-any-precision 能力。
2. **舍入感知 OCS 理论支撑**：附录 C 给出误差分析，显示 RA split 的期望绝对误差为 naive split 的一半，MSE 降低 4×，且有恒等变换保证量化输出不变。
3. **block-wise loss 设计合理**：用高比特 block 输出作为教师，有效抑制层间误差累积。
4. **离群指标有效**：结合激活 \( \ell_2 \) 范数与权重最大幅值的检测指标，比单用 kurtosis/wmax/xmax 效果更好。
5. **自定义 2-bit kernel 实用**：解决硬件不支持 2-bit 的痛点，并实测了多种形状与端到端吞吐。
6. **训练成本极低**：仅用 4096 样本即可取得大幅超越其他 QAT 基线的结果，比 ParetoQ 的 token 需求降低 3600×。

## 7. 不足与局限

1. **训练时间增加**：渐进式分阶段训练相比一次性 QAT 总时长更长（论文 Limitation 中已承认）。
2. **仅支持权重/激活量化**：尚未扩展到 KV-cache 量化，长上下文场景的内存压力缓解有限。
3. **分布式训练不友好**：block-wise 训练在分布式环境下需要额外的负载均衡与通信工程。
4. **模型覆盖有限**：主实验最大为 8B，未验证 70B 级别的 QAT；附录也指出 Qwen 系列量化难度更高、性能下降更大。
5. **对超参数敏感**：不同的渐进顺序、epoch 切换策略、OCS 分裂比例需要手工设定；Muon 优化器在低比特 QAT 下无一致增益。
6. **潜在偏差风险**：评测主要集中于英文零样本任务与 PPL 类指标，复杂指令跟随和数学推理只在附录小范围评测；未涉及更广泛的安全、偏见评估。

## 8. 总结

Bit-by-Bit 为超低位 LLM 量化提供了一套统一的渐进式训练框架，有效解决了收敛稳定性、误差累积和多精度部署三大问题。其在 w2a16/w2a2 上的性能、训练 token 效率和硬件加速方面均展现了明显优势，是一篇方法成熟、实验充分（尤其是消融与 kernel 工程）的高质量工作；但仍需在更大模型、分布式训练、KV-cache 扩展等方面进一步完善。

（完）
