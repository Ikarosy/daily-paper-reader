---
title: "LiftQuant: Continuous Bit-Width LLM via Dimensional Lifting and Projection"
title_zh: LiftQuant：通过维度提升与投影实现连续位宽大模型量化
authors: "Liulu He, Xuan Ang Liu, Juntao Liu, Taolue Feng, Ting Lu, Chunsheng Gan, ZHIYV PENG, Yuan Du, Huanrui Yang, Yijiang Liu, Li Du"
date: 2026-04-30
pdf: "https://openreview.net/pdf/431db6782d1e844292d1b485fd3e1bdea0956900.pdf"
tags: ["query:wbv"]
score: 8.0
evidence: 通过提升空间投影实现 2/3 位附近的连续位宽，直接面向极低比特部署间隙
tldr: 常规量化方法只能使用 2 位、3 位等固定整数位宽，使大模型难以精确适配任意内存预算，形成所谓的部署间隙。LiftQuant 提出先提升再投影机制：把低维权重向量映射到高维空间，用高维空间中简单 1 位格点的投影来近似，而有效位宽由提升维度与原维度之比决定，因此可准连续调节。这样可在任意给定预算下做帕累托最优部署。它为连续位宽量化提供了新颖的几何构造。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 固定 2/3 位整数位宽导致部署间隙，模型无法精确匹配给定内存预算。
method: 先提升权重维度并在高维空间用 1 位格点投影近似，以维度比调节有效连续位宽。
result: 实现准连续位宽调节，可按任意预算取得帕累托最优部署。
conclusion: 突破整数位宽限制，为极低比特部署打开连续位宽量化新路径。
---

## Abstract
Existing quantization methods are fundamentally limited by rigid, integer-based bit-widths (e.g., 2, 3-bit), resulting in a "deployment gap" where Large Language Models cannot be optimally fitted to specific memory budgets. To bridge this gap, we introduce LiftQuant, a novel framework that enables continuous bit-width control for true Pareto-optimal deployment.  The core innovation is a "lift-then-project" mechanism which approximates low-dimensional weight vectors by projecting a simple 1-bit lattice from a higher-dimensional ``lifted" space.  Crucially, the effective bit-width is determined simply by the ratio of the lifted dimension to the original dimension, which allows the bit-width to be tuned quasi-continuous as the dimension is a flexible structural parameter. This projection generates a structured yet non-uniform codebook, capturing the expressive power of Vector Quantization (VQ).  While beneficial over VQ, LiftQuant's decoding path relies solely on linear transformations and 1-bit uniform quantizers, retaining hardware-friendly nature.  This flexibility is transformative: LiftQuant enables a 70B LLM to be compressed to 2.4 bits to precisely fit a 24GB GPU, where its performance significantly surpasses state-of-the-art 2-bit models fitted on the same device.  Our code and ckpt is available at \url{https://github.com/Heliulu/LiftQuant}.

---

## 论文详细总结（自动生成）

# 论文总结：LiftQuant——通过维度提升与投影实现连续位宽大模型量化

## 1. 核心问题与研究背景

- **现有量化的根本性局限**：主流量化方法只能支持刚性的整数位宽（如 2 位、3 位、4 位），权重被逐位地离散到固定比特数上。这种离散性使得模型压缩程度无法精确匹配实际的内存预算。
- **"部署间隙"（Deployment Gap）**：由于浮点模型需要自适应地塞入容量固定的硬件（如特定显存的 GPU），而整数位宽提供的选择是跳跃的——实际可行的位宽选择（如 2 位或 3 位）往往与给定预算之间存在浪费或超限，模型无法以“恰好塞满”的最优方式部署。
- **问题本质**：如何突破整数限制，让 LLM 的位宽可以在任意给定预算附近实现精细调节，从而获得真正的帕累托最优部署方案。

## 2. 方法论：LiftQuant 框架

- **核心思想（Lift-then-Project，先提升、再投影）**：
  - 不直接对低维空间中的原始权重向量做量化，而是先将权重向量**映射/提升**到更高维的空间；
  - 在高维空间中选取简单的 **1 位格点（1-bit lattice）**，然后用该格点向低维原空间做投影，用投影结果来近似原始权重；
  - 这个投影产生的是 **结构化但非均匀的码本（structured yet non-uniform codebook）**，从而继承了向量量化（VQ）的表达能力。
- **连续位宽的关键机制**：
  - 有效位宽由 **提升维度与原始维度之比** 决定；
  - 由于维度本身是一个可灵活调整的结构参数，只要调整该比值，位宽就能实现**准连续（quasi-continuous）** 地调节——例如做出 2.4 位、2.7 位之类的任意接近实际需求的选择。
- **硬件友好性设计**：
  - 虽然效果上优于传统 VQ，但 LiftQuant 的解码路径只依赖 **线性变换 + 1 位均匀量化器**，避免了复杂的非线性/查找表运算，因此保留了硬件部署上的可行性。

## 3. 实验设计（基于摘要与元数据可知的部分）

- **任务与 Benchmark**：摘要本身未列出完整的实验设置（如具体评测数据集），论文被标注为 ICML-2026 接收，属于大模型量化方向的系统论文。
- **对比方法与基线**：主要对比对象是**最先进的 2 位量化模型**，以及隐含的现有整数位宽量化框架。
- **具体应用场景**：以一个明确的部署场景为核心示例——将 70B 参数的大语言模型压缩到约 **2.4 位**，以精确适配 **24GB GPU** 的显存预算。
- **其他细节**：由于正文未在输入中提供，具体语言建模任务、下游任务评测集等无法归纳。

## 4. 资源与算力

- 摘要与元数据中**未明确说明**训练/评估所用的 GPU 型号、数量、运行时长、能耗等算力信息。
- 仅可作为参考的是：作者用 70B 量级的模型做了端到端压缩与部署验证，暗示实验至少涉及多卡高性能 GPU 集群，但具体规模无从考证。
- 若需要深入了解算力开销（例如在多大的 GPU 集群上完成 70B 模型的量化与评测），应从论文正文的实验设置部分获取，此处存在信息缺失。

## 5. 实验数量与充分性

- 由于只能看到摘要，无法判断论文实验的**总量**（如做了多少个数据集、多少组消融、是否做了不同模型规模/不同位宽点的扫描等）。
- 从摘要提供的描述看，作者至少完成了关键的“定位型”验证：以 70B/2.4 位适配 24GB GPU 为典型场景并显著超越同设备上的 2 位 SOTA 模型，这构成了**核心主张的直接证据**。
- 对系统论文而言，仅这一组结果作为公开摘要层次的证据是说明性的，但不足以下结论说实验“全面充分”。需看正文中是否包含多规模模型（如 7B、13B、70B）、多任务、多位宽扫描、以及消融（对提升维度的敏感性、不同码本粒度等）来综合评估公平性与客观性。

## 6. 主要结论与发现

- **结论一**：LiftQuant 成功打破了传统量化对整数位宽的硬性约束，实现了准连续的位宽控制。
- **结论二**：连续位宽带来了真·帕累托最优部署的可能——权重压缩率可以不再跳跃式变更，而是能精确贴合任意给定硬件预算。
- **结论三**：在“占满显存”的前提下压缩更狠（70B 模型只给 2.4 位），仍能显著优于同显存约束下采用标准 2 位量化的现有最佳模型，说明维度提升+投影的编码方式比传统低比特量化保留了更多有效信息。

## 7. 优点与亮点

- **概念新颖**：通过“升维后在子空间投影做 1 位格点近似”这一几何视角，重新构造了量化码本，突破了位宽必须取整的思维定式；
- **理论优雅性**：把连续位宽的实现回归到一个可解释的数学关系——“提升维度与原维度之比”，模型设计师可以像旋钮一样微调压缩率；
- **工程价值直接**：目标定位在极低比特部署间隙这一落地痛点，直指显存受限场景下如何榨干每一 MB 空间的问题；
- **不做取舍**：声称在取得优于 VQ 的量化表达能力的同时，解码路径仅用线性运算与 1 位均匀量化，保持了 ASIC/FPGA/GPU 友好性——即不看低内存精度反而过高计算复杂度；
- **可复现性**：论文公开了代码和模型权重，为后续研究提供了实际可用的基准实现。

## 8. 不足与局限

- **信息可得性局限（本文总结层面）**：由于被分析素材仅含摘要与元数据，关于数据集覆盖、对比方法的调优公平性、消融实验设计、误差条/方差报告等实验细节缺失，无法作出全面的充分性评价；
- **任务范围风险**：摘要仅给出 LLM 压缩示例，未呈现该方法在不同模型家族（如仅 decoder-only 或含多模态结构）、不同任务类型（如数学推理、代码生成、长上下文）上的普适性证据；
- **低比特固有风险**：即使位宽连续，作者仍未展示该方法在 2 位以下（如 1.5 位、1.2 位）时性能如何极速衰减——极低比特区域的退化边界值得探索；
- **系统开销未量化**：总结中未提到维度提升带来的运行时内存/访存开销、端到端吞吐损失，以及“线性变换 + 1 位量化”解码在真实硬件上相对现有 Kernel 的加速比数据；
- **客观性隐忧**：对“显著超越 SOTA 2 位模型”的说法，需要确认对比模型是否在同等的训练后量化（PTQ）设定下公平对比，而非差异化的校准/微调预算。

---

（完）
