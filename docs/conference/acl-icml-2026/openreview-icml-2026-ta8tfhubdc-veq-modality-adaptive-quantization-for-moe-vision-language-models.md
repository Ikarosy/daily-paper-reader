---
title: "VEQ: Modality-Adaptive Quantization for MoE Vision-Language Models"
title_zh: VEQ：面向MoE视觉-语言模型的模态自适应量化
authors: "Guangshuo Qin, Zhiteng Li, Zheng Chen, Weihang Zhang, Linghe Kong, Yulun Zhang"
date: 2026-04-30
pdf: "https://openreview.net/pdf/ae769cfebbcececb4bf928a477e3ecc963af3896.pdf"
tags: ["query:moe-quant"]
score: 9.0
evidence: 面向MoE视觉语言模型的模态与专家双重感知后训练量化，直接命中MoE量化主题
tldr: MoE视觉-语言模型在表达能力强的同时带来很大的显存与计算开销，而不同视觉/语言令牌的信息密度以及不同专家的贡献都存在异质性。VEQ提出模态与专家双重感知的低比特后训练量化框架，一方面为视觉令牌和语言令牌分配差异化量化策略，另一方面按专家的非均匀贡献进行量化。在低比特MoE-VLM实验中，VEQ显著降低内存和计算消耗，同时较好维持多模态精度，为MoE多模态模型部署提供了统一且有效的量化方案。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: MoE视觉语言模型性能强但部署成本高，已有PTQ忽视视觉/语言令牌差异与专家贡献异质性，导致低比特精度损失。
method: 提出模态级与专家级双重感知的量化框架，分别对视觉与语言令牌以及不同专家进行差异化位分配。
result: 在低比特MoE-VLM量化中大幅降低显存与计算开销，同时保持更好的多模态任务精度。
conclusion: 考虑令牌模态多样性与专家异质性是MoE多模态量化的关键，VEQ为这类模型提供了统一的低比特部署路径。
---

## Abstract
Mixture-of-Experts(MoE) Vision-Language Models(VLMs) offer remarkable performance but incur prohibitive memory and computational costs, making compression essential. Post-Training Quantization (PTQ) is an effective training-free technique to address the massive memory and computation overhead. Existing quantization paradigms fall short as they are oblivious to two critical forms of heterogeneity: the inherent discrepancy between vision and language tokens, and the non-uniform contribution of different experts. To bridge this gap, we introduce Visual Expert Quantization (VEQ), a dual-aware quantization framework designed to simultaneously accommodate cross-modal differences and heterogeneity between experts. Specifically, VEQ incorporates 1)**Modality-expert-aware Quantization**, which utilizes expert activation frequency to prioritize error minimization for pivotal experts, and 2)**Modality-affinity-aware Quantization**, which constructs an enhanced Hessian matrix by integrating token-expert affinity with modality information to guide the calibration process. Extensive experiments across diverse benchmarks verify that VEQ consistently outperforms state-of-the-art baselines. Specifically, under the W3A16 configuration, our method achieves significant average accuracy gains of 2.04\% on Kimi-VL and 3.09\% on Qwen3-VL compared to the previous SOTA quantization methods, demonstrating superior robustness across various multi-modal tasks.

---

## 论文详细总结（自动生成）

## 论文总结：VEQ（面向 MoE 视觉-语言模型的模态自适应量化）

### 1. 核心问题与整体含义
- **研究背景**：Mixture-of-Experts（MoE）视觉-语言模型（VLM）虽然性能强劲，但显存和计算开销巨大，迫切需要进行模型压缩。
- **现有量化方法的不足**：已有后训练量化（PTQ）没有考虑两类重要的异质性：
  - 视觉 token 与语言 token 之间存在本质差异；
  - 不同专家的贡献并不均匀，存在显著的“专家异质性”。
- **研究意义**：VEQ 提出了一种「模态-专家双重感知」的量化框架，试图在低比特部署场景下兼顾压缩效率与多模态任务精度。

### 2. 方法论
- **核心思想**：在量化过程中同时适应跨模态差异和专家间差异，不依赖训练，属于后训练量化（PTQ）路线。
- **两大关键模块**：
  1. **模态-专家感知量化（Modality-expert-aware Quantization）**
     - 利用专家的激活频率来识别“关键专家”；
     - 对这些关键专家优先进行误差最小化处理；
     - 即不同专家按重要程度采用不同的量化策略或位宽分配。
  2. **模态-亲和感知量化（Modality-affinity-aware Quantization）**
     - 将“token-专家”亲和度与模态信息结合；
     - 构建增强型 Hessian 矩阵；
     - 用该矩阵引导量化校准过程，从而更精确地降低量化误差。
- **技术特征**：文中没有给出具体公式或逐层算法流程，但可判断其本质上属于“基于校准数据的位宽敏感度分析 + 混合精度量化”思路，且加入了模态维度与专家维度的双重调制。

### 3. 实验设计
- **评测模型**：Kimi-VL 和 Qwen3-VL。
- **评测配置**：低比特配置，至少包含 **W3A16**（权重 3-bit、激活 16-bit）。
- **对比方法**：与已有 SOTA 量化方法进行对比。
- **评测范围**：原文仅表述为“多样化的多模态 benchmark”，没有给出具体数据集名称（如 VQAv2、MMBench 等）。
- **主要结果**：
  - 在 W3A16 配置下，相比此前 SOTA 量化方法：
    - Kimi-VL 上平均准确率提升 **2.04%**；
    - Qwen3-VL 上平均准确率提升 **3.09%**。

### 4. 资源与算力
- 原文提供的摘要内容中**没有明确说明**训练/校准过程使用的 GPU 型号、数量、时长或显存占用等算力信息。
- 也未提供压缩后模型的实际推理时延、显存下降幅度等部署数据。
- 因此，关于算力与部署资源开销只能判断为“声称有效降低显存与计算成本”，但缺乏量化数据支撑。

### 5. 实验数量与充分性
- 从可见信息看：
  - 实验覆盖了两个具有代表性的 MoE-VLM 模型；
  - 使用了“多样化 benchmark”，表明任务类型较为广泛；
  - 至少进行了低比特 W3A16 下的对比实验。
- **充分性评估**：
  - 实验数量是有限的；摘要中未给出多组具体任务的多组表格、消融实验或额外位宽实验；
  - 未报告“模态级”和“专家级”两种模块各自贡献的消融分析；
  - 未比较不同位宽组合（如 W2/W4、A8 等）下的表现；
  - 论文自称“extensive experiments”，但由于公开信息有限，无法判断其统计显著性与公平性细节。
- 总体来看：实验方向正确，但目前只能确认验证了核心主张；**完整实验充分性尚不可见**。

### 6. 主要结论与发现
- 视觉 token 与语言 token 的差异、不同专家的非均匀贡献是 MoE-VLM 量化误差的重要来源；忽视这两点会造成低比特精度损失。
- VEQ 的“模态-专家双重感知”量化方案能够在低比特条件下显著降低 MoE-VLM 的显存与计算开销。
- 同时，该方案在多模态任务上能保持较稳健的精度，超过现有 SOTA 量化方法，为 MoE-VLM 的低比特部署提供了统一有效的路径。

### 7. 优点
- **问题切入精准**：针对 MoE-VLM 中“跨模态 token 差异”和“专家异质性”两个被既有量化方法忽略的关键点展开研究。
- **模块设计创新**：
  - 用“专家激活频率”识别关键专家，较以往仅按权重分布判断重要性更贴合 MoE 实际运行行为；
  - 构造“增强 Hessian 矩阵”并把 token-专家亲和度与模态信息写入校准过程，校准目标更加细粒度。
- **实用性较强**：PTQ 无需重训练，适合实际部署场景。
- **效果明确**：在两种主流 MoE-VLM 上都相对 SOTA 有稳步提升，且改善幅度超过 2~3 个百分点，具备一定说服力。

### 8. 不足与局限
- **信息可见性不足**：当前公开信息主要来自摘要，具体 benchmark、数据集、消融实验和详细方法公式尚未呈现，难以全面评估。
- **模型覆盖有限**：仅报告了 Kimi-VL 和 Qwen3-VL，缺少对更大规模或不同 MoE 架构（如不同 router 机制、非对称 MoE）的验证。
- **位宽覆盖有限**：只明确看到 W3A16 一档；没有显示 W2/W4/混合位宽或不同激活量化场景的表现。
- **部署收益缺乏实测**：摘要声称降低显存和计算开销，但没有给出具体的压缩率、吞吐或提升时间数据。
- **校准成本未讨论**：生成 token-专家亲和度并构造增强 Hessian 矩阵会引入额外校准时间，论文中未说明此开销是否可控。

> 注：以上分析基于论文提取文本及其 Markdown 元数据；由于原始 PDF 实际内容未能完整获取，部分细节属于基于摘要的推断，而非论文全文信息。

（完）
