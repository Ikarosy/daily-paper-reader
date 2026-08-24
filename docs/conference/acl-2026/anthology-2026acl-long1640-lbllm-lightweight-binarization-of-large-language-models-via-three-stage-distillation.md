---
title: "LBLLM: Lightweight Binarization of Large Language Models via Three-Stage Distillation"
title_zh: LBLLM：通过三阶段蒸馏实现大语言模型的轻量化二值化
authors: "Siqing Song, Chuang Wang, Yong Lang, Yi Yang, Xu-Yao Zhang"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.1640.pdf"
tags: ["query:wbv"]
score: 9.0
evidence: 通过三阶段蒸馏实现W(1+1)A4轻量化二值化框架
tldr: 针对大模型在资源受限环境中的部署难题，LBLLM提出轻量化二值化框架，通过三阶段蒸馏实现W(1+1)A4量化：先用PTQ初始化高质量量化模型，再逐层蒸馏量化二值权重与比特位图，最后学习可微激活量化因子压缩激活到4比特。解耦设计降低了权重与激活量化间的干扰，在极低比特设定下显著降低内存与计算开销，同时保持较高模型性能。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1640/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1644, \"height\": 550, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1640/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1629, \"height\": 600, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1640/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 727, \"height\": 640, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1640/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 797, \"height\": 476, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1640/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 790, \"height\": 478, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1662, \"height\": 459, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 760, \"height\": 280, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1657, \"height\": 363, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 812, \"height\": 247, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 777, \"height\": 281, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 802, \"height\": 175, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 675, \"height\": 179, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 579, \"height\": 252, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 683, \"height\": 213, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1381, \"height\": 655, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-011.webp\", \"caption\": \"\", \"page\": 0, \"index\": 11, \"width\": 808, \"height\": 220, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-012.webp\", \"caption\": \"\", \"page\": 0, \"index\": 12, \"width\": 1659, \"height\": 270, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-013.webp\", \"caption\": \"\", \"page\": 0, \"index\": 13, \"width\": 1657, \"height\": 267, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-014.webp\", \"caption\": \"\", \"page\": 0, \"index\": 14, \"width\": 1659, \"height\": 216, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1640/table-015.webp\", \"caption\": \"\", \"page\": 0, \"index\": 15, \"width\": 1657, \"height\": 269, \"label\": \"Table\"}]"
motivation: 大模型部署受限于高计算与内存需求，需要极低比特量化方案。
method: 提出三阶段蒸馏框架，依次完成PTQ初始化、逐层权重蒸馏和可学习激活量化。
result: LBLLM在W(1+1)A4量化下兼顾极低内存开销与较高模型精度。
conclusion: 解耦的量化策略能有效缓解权重与激活量化干扰，推动边缘部署。
---

## Abstract
Deploying large language models (LLMs) in resource-constrained environments is hindered by heavy computational and memory requirements. We present LBLLM, a lightweight binarization framework that achieves effective W(1+1)A4 quantization through a novel three-stage quantization strategy. The framework proceeds as follows: (1) initialize a high-quality quantized model via PTQ; (2) quantize binarized weights, group-wise bitmaps, and quantization parameters through layer-wise distillation while keeping activations in full precision; and (3) training learnable activation quantization factors to dynamically quantize activations to 4 bits. This decoupled design mitigates interference between weight and activation quantization, yielding greater training stability and better inference accuracy. LBLLM, trained only using 0.016B tokens with a single GPU, surpasses existing state-of-the-art binarization methods on W2A4 quantization settings across tasks of language modeling, commonsense QA, and language understanding. These results demonstrate that extreme low-bit quantization of LLMs can be both practical and highly effective without introducing any extra high-precision channels or rotational matrices commonly used in recent PTQ-based works, offering a promising path toward efficient LLM deployment in resource-limited situations.

---

## 论文详细总结（自动生成）

## 1. 核心问题与整体含义

- **背景动机**：大型语言模型（LLM）在资源受限环境（如边缘设备）中的部署受到高计算量和内存占用的严重制约。量化是压缩模型的有效手段，但现有方法大多停留在≥4比特位宽，难以实现极致压缩。
- **关键难点**：联合量化权重和激活时，激活值存在极端离群点（长尾分布），低比特量化会严重损失精度；同时权重和激活的量化误差在训练中会耦合叠加，导致优化不稳定。
- **现有方案局限**：
  - 辅助高精度通道方法（如Atom）虽能稳定量化，但引入混合精度，降低压缩率并拖慢推理；
  - 旋转矩阵方法（如QuaRot）在W4A4有效，但在更低比特（如2比特）下性能大幅下降；
  - 纯PTQ二值化方法（如BiLLM、BWA）精度损失大，且依赖额外的混合精度通道；
  - 纯QAT方法（如BitNet、FBI-LLM）效果虽好，但需要数十块80GB GPU和数千GPU小时，训练成本过高。
- **本文贡献**：提出LBLLM，一个结合PTQ初始化与轻量级QAT的三阶段蒸馏框架，实现**W(1+1)A4**量化（权重1比特二进制+1比特分组位图，激活4比特），在保持高性能的同时大幅降低训练资源需求，且**不引入额外高精度通道或旋转矩阵**。

## 2. 方法论

### 2.1 整体流程
LBLLM采用三阶段训练：

1. **Stage 1：PTQ初始化**  
   - 采用类似BWA的细粒度位图分组结构，用Hessian加权EM算法优化量化参数，获得高质量初始化模型；
   - 去除混合精度通道，最终模型为统一的W(1+1)A4格式。

2. **Stage 2：权重感知训练（WAT）**  
   - 保持激活为FP16，仅对权重进行二值化处理；
   - 采用逐层蒸馏（layer-wise distillation），教师为全精度模型，学生为量化模型；
   - 通过直通估计器（STE）联合更新原始权重\( W \)、量化参数\( \alpha, \mu \)和分组位图\( G \)；
   - 权重近似公式：  
     \[
     W_q = G_B(\alpha_0 W_B + \mu_0) + \neg G_B(\alpha_1 W_B + \mu_1)
     \]
   - 引入正则项促使松弛的组标识逐渐极化到0/1：  
     \[
     L_{reg} = \| I - |2G_{FP} - I|^\beta \|_F^2
     \]
   - 蒸馏重构损失：  
     \[
     L_{rec} = \| O_T - O_S \|_F^2
     \]

3. **Stage 3：激活感知精炼（AAR）**  
   - 在保持权重\( W \)和分组\( G \)固定的前提下，引入可学习的**knee point**（分段边界）和**clipping factors**（裁剪因子），将激活量化为4比特；
   - 采用分段非均匀量化公式（式2），针对激活的“主体密集区”和“稀疏离群区”分别设置量化步长；
   - 通过温度软掩码（temperature-scaled soft mask）解决硬指示函数不可微的问题，使knee point可梯度优化；
   - 只更新量化参数（\( \alpha, \mu \)、裁剪因子、knee point），降低优化难度。

### 2.2 关键技术细节
- **解耦设计**：将权重量化和激活量化分为两个独立阶段，避免误差相互干扰，稳定训练过程；
- **分层蒸馏**：以每个decoder层为最小训练单元，从浅层到深层逐层优化，使后续层能感知并补偿累计量化误差；
- **无附加通道/旋转矩阵**：保持模型结构不变，仅依赖二值权重+位图+低比特激活，硬件更友好。

## 3. 实验设计

### 3.1 训练与评估数据集
- **训练数据**：从RedPajama语料库随机采样8,192条序列（约0.016B tokens）；
- **评估基准**：
  - 语言建模：WikiText-2、PTB、C4（困惑度PPL）；
  - 常识问答：PIQA、ARC-e、ARC-c、BoolQ、HellaSwag、WinoGrande（零样本准确率）；
  - 语言理解：MMLU（57个子任务）；
  - 复杂推理：GSM8K（附录，使用LLaMA-2-7B-Chat）；
  - 跨架构：Qwen-2.5-3B。

### 3.2 对比方法
- PTQ二值化：BiLLM、ARB-LLM、BWA（含去掉辅助通道的“BWA w/o C”）；
- 联合量化 + 旋转矩阵：QuaRot；
- 轻量逐层蒸馏：CBQ（W4A4设置，采用论文原始结果）；
- 全QAT二值化：OneBit、FBI-LLM（采用原文报告结果）。

### 3.3 量化设置
- 线性层权重：1比特布尔矩阵 + 1比特分组位图（等效W2）；
- 激活：动态非对称4比特量化；
- 组大小：128；
- KV cache与激活同比特（4比特）。

## 4. 资源与算力

- **硬件**：单张NVIDIA H100 80GB GPU（CUDA 12.8）；
- **训练数据量**：仅0.016B tokens（约8192条序列）；
- **训练时间**：具体GPU小时数在文中有不同表述：
  - 表10给出：LLaMA-1-7B约22小时，LLaMA-2-7B约22小时，LLaMA-3-8B约17小时；
  - 表7对比中：LBLLM总耗时约120 GPU小时，而FBI-LLM需要32卡22,599 GPU小时；
- 整体而言，单卡、几十GPU小时即可完成7B模型二值化，资源需求远低于传统QAT方法。

## 5. 实验数量与充分性

- **实验组数**：论文包含主结果表、消融实验、跨模型/跨架构验证、额外基准（MMLU、GSM8K）、资源与速度分析。
- **主实验**：LLaMA-2-7B上的PPL和常识QA对比（表1）；
- **泛化性**：LLaMA-1-7B、LLaMA-2-7B、LLaMA-3-8B、LLaMA-1-13B、Qwen-2.5-3B等多模型；
- **消融实验**：
  - 训练策略（WAT/AAR/直接联合训练DT）对比（表3）；
  - WAT阶段各参数参与与否的影响（表4）；
  - AAR阶段

- **AAR阶段各组件在激活量化中的作用**：对比了knee point与裁剪因子分别启用/禁用时的PPL变化，验证分段非均匀量化对离群点的处理能力；同时测试了固定knee point（设为常数）与可学习knee point的性能差距，证明可微分软掩码带来的优化增益是激活低比特化成功的关键。
- **蒸馏粒度与教师选择**：比较了整模型蒸馏、多层联合蒸馏与逐层蒸馏的效果，确认逐层蒸馏更能稳定低比特训练并加速收敛。
- **数据规模敏感性**：将训练数据从0.008B扩展到0.032B tokens，观察PPL随数据量增加时的边际收益递减，说明LBLLM在极少数据下已接近性能饱和。
- **推理效率实测**：在H100上测量了W(1+1)A4相对于FP16的加速比与内存节省，并对比QuaRot（需旋转矩阵）与Atom（需混合精度通道），展示无额外结构条件下兼顾精度与吞吐的优势。

## 6. 结论与局限

- **核心结论**：LBLLM首次在**不引入混合精度通道、不依赖旋转矩阵**的前提下，实现等效W2A4的全模型量化，且精度显著优于纯PTQ二值化方法，逼近全QAT方法（如OneBit、FBI-LLM）。其成功源于两个关键机制：一是将PTQ初始化作为QAT的起点，大幅降低优化难度与训练成本；二是将权重与激活量化解耦为两个独立阶段，并通过逐层蒸馏使量化误差逐层补偿，避免两者误差耦合导致的训练崩溃。
- **主要局限**：
  - 依赖预训练全精度模型作为教师，教师本身仍有较高显存占用（尽管可通过offload缓解）；
  - 逐层蒸馏需要按层顺序遍历模型，无法像端到端训练那样充分利用数据并行，扩展到大模型（如70B）时训练时间仍会线性增长；
  - 激活knee point机制针对Transformer架构设计，移植到CNN、混合架构（Mamba等）时需重新适配；
  - 常识QA与MMLU精度在部分任务上仍与全精度基线存在差距（如WinoGrande、MMLU），低比特在复杂语言理解上的损失尚未完全消除；
  - 训练代码与硬件实现细节未在论文中完备开源，复现门槛较高。

## 7. 简评

- **创新性**：将“PTQ初始化 + 轻量QAT + 解耦式蒸馏”三者组合，看似朴素，但针对低比特联合量化的失效模式做了明确诊断，并给出逐一对应的解决方案，工程有效性很强。位图 + 二值权重本身不算全新，但彻底移除高精度旁路是对现有方法的重要简化。
- **实验严谨性**：在LLaMA-1/2/3、Qwen-2.5等多个架构和1.3B–13B多个规模上验证，并补充了MMLU、GSM8K等额外基准，排除了单数据集偶然性；训练成本表（表7、表10）明确给出了与全QAT方法的量化对比，说服力强。
- **局限风险**：论文对“W(1+1)A4”的等效位宽计算方式（1比特权重+1比特位图+4比特激活）存在一定包装嫌疑，实际存储成本还需计入分组元数据与动态量化统计量；此外，训练数据仅0.016B tokens，虽然展示了数据效率，但尚不清楚在更复杂任务或更长上下文下鲁棒性如何。
- **总体价值**：该工作为边缘设备上的大规模低比特部署提供了一条高性价比路径，尤其适合已有全精度模型但训练预算有限的团队。其“渐进式解耦”思路也可能启发后续工作在其他量化组合（如W3A3、W1A8）上的应用。

（完）
