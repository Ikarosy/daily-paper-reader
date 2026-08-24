---
title: "BWLA: Breaking the Barrier of W1AX Post-Training Quantization for LLMs"
title_zh: BWLA：突破大语言模型W1AX后训练量化的壁垒
authors: "Zhixiong Zhao, Zukang Xu, Dawei Yang"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.880.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 利用正交Kronecker变换实现1比特权重与低比特激活的后训练量化
tldr: 现有二值化方法难以处理激活重尾分布，不得不保持高精度激活，无法真正端到端加速。BWLA提出首个后训练量化框架，通过正交Kronecker变换（OKT）学习正交映射，将单峰权重转换为对称双峰分布，从而在1比特权重下同时使用低比特激活（如6比特）。实验表明该方法在高精度下突破了W1AX量化瓶颈，为LLM部署提供了真正的端到端加速路径。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 730, \"height\": 612, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1516, \"height\": 636, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1585, \"height\": 745, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1256, \"height\": 577, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1502, \"height\": 606, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1503, \"height\": 550, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1660, \"height\": 1065, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1504, \"height\": 1072, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1614, \"height\": 2304, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long880/fig-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1616, \"height\": 2159, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long880/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1651, \"height\": 740, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long880/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 801, \"height\": 449, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long880/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 797, \"height\": 457, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long880/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1402, \"height\": 640, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long880/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 816, \"height\": 729, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long880/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1640, \"height\": 2513, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long880/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1640, \"height\": 2513, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long880/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 993, \"height\": 265, \"label\": \"Table\"}]"
motivation: 激活重尾分布阻碍二值化模型使用低比特激活，限制端到端加速。
method: 提出OKT正交Kronecker变换，通过EM最小化学习映射以适配1比特权重和低比特激活。
result: BWLA在1比特权重加6比特激活设定下保持高精度并实现端到端加速。
conclusion: 该工作首次在PTQ中实现W1AX，为极低比特部署开辟了新路径。
---

## Abstract
Large language models (LLMs) have driven major progress in NLP, yet their substantial memory and compute demands still hinder practical deployment. Binarization can compress weights to 1 bit, fundamentally lowering compute and bandwidth cost. However, existing methods cannot address activation heavy tails and thus must keep activations in high precision, preventing true end-to-end acceleration. To overcome this limitation, we propose BWLA, the first post-training quantization framework that preserves high accuracy while achieving 1-bit weight quantization together with low-bit activations (e.g., 6 bits). The Orthogonal-Kronecker Transformation (OKT) learns an orthogonal mapping via EM minimization, converting unimodal weights into symmetric bimodal forms while suppressing activation tails and incoherence. The Proximal SVD Projection (PSP) then performs lightweight low-rank refinement through proximal SVD projection, further enhancing quantizability with minimal overhead. On Qwen3-32B, BWLA reaches a Wikitext2 perplexity of 11.92 under 6-bit activations (vs. 38 from SOTA), improves five zero-shot tasks by more than 70%, and delivers 3.26× inference speedup, demonstrating strong potential for real-world LLM compression and acceleration. The code will be available at [BWLA](https://github.com/Kishon-zzx/BWLA).

---

## 论文详细总结（自动生成）

## 1. 核心问题与整体含义（研究动机与背景）

- **背景**：大语言模型（LLM）参数量不断增大，带来巨大的内存与计算开销，部署困难。量化是重要的模型压缩手段，而二值化可将权重压缩至 1 bit，从根本上降低存储与计算成本。
- **痛点**：现有二值化方法（如 BiLLM、ARB-LLM）只关注权重二值化，无法有效处理激活值中的离群点与重尾分布，因此不得不将激活值保留为高精度（如 FP16）。这导致推理时仍需权重反量化，无法实现真正的端到端加速。
- **核心挑战**：在无重训练的后训练量化（PTQ）框架下，同时实现 1-bit 权重与低 bit 激活（W1AX，如 W1A6），面临两大障碍：
  1. 权重分布常为单峰（准高斯分布），与二值码本 {−1, +1} 严重不匹配，二值化误差大；
  2. 激活值呈现显著的重尾分布与极端离群值，在低 bit 量化下主导量化失真。
- **整体含义**：本文为 W1AX PTQ 这一难点提供了首个可行的解决方案，使 LLM 在极低比特量化下兼顾精度与推理加速，为边缘部署和端到端加速开辟了新路径。

## 2. 方法论：核心思想、关键技术细节与算法流程

### 2.1 核心思想

- 通过正交变换同时实现两个目标：
  1. 将单峰权重分布重塑为对称双峰（double-bell）分布，使其天然对齐二值码本；
  2. 抑制激活值的重尾离群点，降低激活低比特量化的难度。
- 由于正交矩阵满足 R⁻¹ = R⊤，变换可逆且前向传播等价性得以保持——同一变换应用于权重与激活时，模型输出不变。

### 2.2 Orthogonal–Kronecker Transformation（OKT）

- **理论基础**：Theorem 1 证明对高斯型权重矩阵 W，存在正交变换 R 使变换后权重收敛于对称双峰高斯混合分布（πN(μ,σ²)+(1−π)N(−μ,σ²)），从理论上保障了正交双峰化的可行性。
- **Kronecker 分解**：完整 m×m 正交矩阵开销为 O(m²)，不切实际。OKT 将 R 拆为 R₁⊗R₂（n₁n₂=m），计算复杂度降至 O(m^{3/2})，存储开销指数级降低。
- **优化目标**：对每个行向量建模为对称双分量高斯混合模型（GMM），最小化负对数似然，并引入正则项防止模式坍缩、鼓励正负分量均衡分配。
- **优化策略**：交替优化——
  - 固定 R 时，用闭式 EM 步骤更新 GMM 参数 Θ（中心 cᵢ 与方差 σ²ᵢ）；
  - 固定 Θ 时，用 Majorization–Minimization（MM）将目标分解为加权正交 Procrustes 问题，通过 SVD 闭式更新 Kronecker 因子 R₁ 与 R₂。

### 2.3 Proximal SVD Projection（PSP）

- **动机**：OKT 的全局正交旋转无法完全消除与目标中心 ±cᵢ 错位的结构化残差。
- **机制**：引入低秩残差矩阵 M = AB（rank k ≪ min{oc, ic}），修正权重为 W_res = W − M；在 OKT 变换后的坐标空间中构造近端上界（proximal majorizer），通过截断 SVD 闭式更新 M。
- **保证**：每次更新保证目标函数单调下降，无需人工调整步长，参数开销极小（如 rank ratio = 0.005）。

### 2.4 算法流程概述

1. 用 Algorithm 1 将隐藏维度 n 分解为接近 √n 的因子对 (n₁, n₂)；
2. 初始化 R₁、R₂，M₀=0，GMM 参数；
3. 迭代约 60 轮（40 轮 OKT + 20 轮 PSP）：
   - EM 更新 GMM 参数（责任计算、闭式更新 cᵢ 与 σ²ᵢ）；
   - 计算梯度 G、形成近端点 Y_t，做 rank-k 截断 SVD 更新 M；
   - 交替 Procrustes 更新 R₁、R₂；
4. 最终在 OKT+PSP 坐标空间内按行中心化、计算行列缩放因子并执行 Sign 二值化。

## 3. 实验设计：数据集、基准与对比方法

### 3.1 数据集与评测场景

- **困惑度**：WikiText2、C4；
- **零样本任务（7项）**：ARC-Challenge、ARC-Easy、HellaSwag、LAMBADA-openai、LAMBADA-standard、PIQA、WinoGrande；
- **复杂推理任务**：MMLU（多领域知识）、GSM8K（数学推理）、HumanEval（代码生成）；
- **指令微调模型**：Qwen3-32B-Instruct 上的 MMLU / HumanEval / GSM8K。

### 3.2 对比方法

- **二值化 PTQ 方法**：BiLLM、ARB-LLM、DBellQuant（当前 SOTA）；
- **低比特 PTQ 方法**：RTN、GPTQ、OSTQuant（非二值基线，使用 2-bit 权重对比）。

### 3.3 模型规模

- LLaMA2-7B/13B/70B、LLaMA3-8B、Qwen3-8B/14B/32B（基础版与指令微调版）。

### 3.4 实现细节

- 激活采用 per-token 非对称量化，权重采用 per-channel 对称量化；
- 校准数据：WikiText2 中随机采样 128 段文本；
- 总迭代 60 轮（OKT 40 轮 + PSP 20 轮）；
- 推理效率测试：NVIDIA RTX A6000 GPU，batch size=4、1024-token prefill、256-token decoding。

## 4. 资源与算力

- **GPU 型号**：NVIDIA A6000（文中唯一明确提及的硬件）。
- **GPU 数量**：未明确说明。
- **量化耗时**（表 7）：
  - LLaMA2-7B：约 0.10h（对比 OstQuant 0.3h，OmniQuant 1.6h）；
  - LLaMA3-8B：约 0.12h；
  - LLaMA2-13B：约 0.25h；
  - LLaMA2-70B：约 1.4h。
- **加速效果**：BWLA 比 OstQuant 快约 3.0–3.9 倍。整体属于极低开销的轻量离线过程，无需训练。

## 5. 实验数量与充分性评估

### 5.1 实验数量

- **主实验**：覆盖 7 个基础模型 × 2 种激活位宽（A16、A6），报告困惑度与多个零样本任务精度；
- **指令微调实验**：Qwen3-32B-Instruct 在 A16 与 A6 下的 MMLU / HumanEval / GSM8K；
- **A4 极端位宽实验**：LLaMA2-7B、LLaMA3-8B、Qwen3-14B 上的 7 项零样本任务；
- **模块消融**：OKT、PSP 单独及联合对比（A16 与 A6 两个设置）；
- **超参数消融**：Kronecker 维度 n₁/n₂ 与 PSP rank ratio 的开销-性能权衡；
- **校准数据敏感性**：不同校准样本数与随机种子下的困惑度稳定性；
- **效率实验**：吞吐量与内存对比、量化时间对比；
- **损失曲线**：Q/K/V/O/Up/Gate/Down 投影在多层上的收敛过程。

### 5.2 充分性与客观性

- **优势**：实验覆盖模型家族广、规模跨度大（7B–70B）、激活位宽梯度完整（A16/A6/A4）、含指令微调场景，并有消融与敏感性分析，比较充分。
- **可改进处**：
  - A4 实验只覆盖 3 个中等规模模型，未覆盖 70B 级；
  - 表 1 中 DBellQuant 在多个模型/设置下缺少数据，对比完整性略受影响；
  - 图 5(a) 中 OSTQuant 的配置为 W4A4，BWLA 为 W1A8，位宽不同，效率对比的公平性需谨慎解读；
  - 所有实验在单一 GPU 型号（A6000）上完成，缺少跨硬件验证。

## 6. 主要结论与发现

1. **首次实现高精度 W1AX PTQ**：BWLA 在无重训练条件下同时实现 1-bit 权重与 6-bit 激活，突破了现有方法的瓶颈。
2. **显著优于现有方法**：
   - 在 Qwen3-32B 上，W1A6 设置下 WikiText2 困惑度 11.92，远低于 SOTA 的约 38；
   - 零样本任务平均精度比最优二值方法提升超过 50%（部分模型上）;
   - 在权重-only（A16）设置下相比 BiLLM/ARB-LLM 平均精度提升约 13%，困惑度降低约 28%。
3. **极端位宽下的鲁棒性**：在 W1A4 下，对比方法几乎全部坍缩（困惑度 >1e4），而 BWLA 仍保持可用精度。
4. **指令微调模型上的稳健性**：Qwen3-32B-Instruct 在 W1A6 下仍保持 FP16 性能的约 94%（相对 W1A16 设置）。
5. **显著效率收益**：LLaMA2-13B 上实现 3.26× 推理加速（vs FP16），参数内存从 23.7GB 降至 3.94GB。
6. **校准数据鲁棒**：对校准集大小与采样种子不敏感（困惑度波动 <1%）。

## 7. 优点

- **问题定位准确**：清晰识别出 W1AX 的两大根本障碍（权重-码本错配、激活重尾），针对性设计解决方案。
- **理论支撑扎实**：Theorem 1 从理论上保证正交变换诱导双峰分布的可行性；附录提供完整的 EM、MM、Procrustes、近端 SVD 推导与单调性保证。
- **方法设计优雅**：利用正交矩阵可逆性（R⁻¹=R⊤）同时解决权重双峰化和激活平滑问题，维持前向等价；Kronecker 分解大幅降低开销。
- **轻量高效**：纯 PTQ 无需训练，仅约 60 轮轻量迭代，量化时间远短于 training-based 方法；
- **实验系统全面**：多模型家族、多位宽设置、多种任务、消融与敏感性分析齐备，附录中有详尽的分布可视化与收敛曲线。

## 8. 不足与局限

- **W1A4 性能仍不理想**：作者自述在 W1A4 下精度下降明显，激活平滑与离群抑制能力在更极端位宽下尚显不足。
- **OKT 的线性变换局限**：正交旋转为线性变换，可能无法充分捕捉现代 LLM 权重空间的非线性几何特征，轻量非线性变换可能带来进一步提升。
- **量化格式有限**：当前仅面向标准整数格式（INT4/INT6），未覆盖 MXFP4 等低精度浮点格式或混合精度方案。
- **实验覆盖的局限**：
  - 未在更大规模（如 70B 以上）或更多模型家族（如 Mistral、Phi 等）上验证；
  - 指令微调实验仅覆盖 Qwen3-32B-Instruct 一个模型；
  - 效率实验在单一 GPU 平台上进行，缺少端到端系统级部署验证。
- **对比公平性**：与其他方法的对比中，有效权重位宽略有差异（BWLA 约 1.16 bits vs 其他约 1.06–1.10 bits），虽有说明但在极致压缩场景下需注意。

---

（完）
