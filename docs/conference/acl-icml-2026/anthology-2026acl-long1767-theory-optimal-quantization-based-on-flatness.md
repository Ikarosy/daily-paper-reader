---
title: Theory-optimal Quantization Based on Flatness
title_zh: 基于Flatness的理论最优量化
authors: "Xiusheng Huang, Zhe Li, Xuanwu Yin, Lu Wang, Yequan Wang, Dong Li, Emad Barsoum, Kang Liu"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.1767.pdf"
tags: ["query:wbv"]
score: 4.0
evidence: 面向低比特LLM量化中的离群点引入Flatness理论指标，与极低比特VQ/SQ主题仅弱相关
tldr: 现有低比特LLM量化主要被激活离群点拖累，且特征维线性变换后离群分布仍然集中。论文先建模量化误差与离群点之间的关系，定义刻画离群集中程度的Flatness指标，并据此推导理论最优的量化方案。在LLM低比特实验上，该方法比缩放、旋转等已有变换进一步降低精度损失。该工作为超低位标量/矢量量化提供了误差分析和理论下界方面的参考。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1767/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1616, \"height\": 462, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long1767/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1473, \"height\": 903, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1651, \"height\": 471, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1652, \"height\": 1401, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1649, \"height\": 204, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1501, \"height\": 250, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 1658, \"height\": 564, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1650, \"height\": 1626, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 744, \"height\": 354, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1516, \"height\": 199, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long1767/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 706, \"height\": 256, \"label\": \"Table\"}]"
motivation: LLM低比特量化中的激活离群点是精度下降主因，已有线性变换不能充分消除集中的离群模式，需要更系统的理论刻画。
method: 建模量化误差与离群点的数学关系，提出Flatness指标量化离群分布集中程度，并据此推导理论最优的量化变换。
result: 在LLM低比特实验中，相较仅做旋转或缩放的方案取得更好的精度保持效果。
conclusion: 以Flatness为导向的理论最优量化有助于从原理上降低离群点对超低位量化精度的损害。
---

## Abstract
Post-training quantization has emerged as a widely adopted technique for compressing and accelerating the inference of Large Language Models (LLMs). The primary challenges in LLMs quantization stem from activation outliers, which significantly degrade model performance especially at lower bit precision. While recent approaches attempt to mitigate outliers through linear transformations across feature dimensions, our analysis reveals that the transformed weights and activations still exhibit persistent outlier patterns with concentrated magnitude distributions. In this paper, we first model the mathematical relationship between quantization error and outliers, and then introduce a new metric Flatness to quantify the distribution of outliers. Based on this, we derive the theoretical optimal solution with respect to Flatness. Building on these insights, we propose Bidirectional Diagonal Quantization (BDQ), a novel post-training quantization framework that effectively disperses outlier patterns through optimized matrix transformations. BDQ strategically distributes outlier magnitudes across matrix dimensions via learned diagonal operations. Extensive experiments demonstrate that BDQ establishes a new quantization benchmark. It achieves less than 1% accuracy drop in W4A4 quantization on the LLaMA-3-8B model. In the more challenging W2A4KV16 experiment, compared to state-of-the-art approaches, BDQ reduces the performance gap by 39.1% on the DeepSeek-R1-Distill-LLaMA-70B model.

---

## 论文详细总结（自动生成）

## 1. 论文的核心问题与整体含义

论文聚焦 LLM 部署中的后训练量化（Post-Training Quantization, PTQ）问题。核心困难是激活离群点（activation outliers）使量化精度下降，尤其在低位宽设置下更为明显。作者指出已有方法（如随机旋转 QuaRot、学习旋转 SpinQuant 等）虽能在一定程度上缓解离群问题，但在特征维度上的线性变换并不能真正消除离群模式，量化后数据仍会集中到少数区间。

论文从两个层面提出了贡献：
- **理论层面**：首次将量化误差与离群点的数学关系显式建模，证明了离群值会以平方级放大误差；进一步提出 **Flatness** 这一评价指标，用于衡量离群点在矩阵中分布的集中程度，并导出使 Flatness 最优的矩阵变换形式。
- **方法层面**：基于理论最优解设计了 **BDQ（Bidirectional Diagonal Quantization）**，配合 **Recursive Cross-Entropy（RCE）损失**，在极低比特（如 W2A4KV16、W4A4KV4）下大幅减小了量化带来的性能衰退。

## 2. 论文提出的方法论

**核心思想**：将离群点问题从“缩放/旋转”启发式修复，转变成“对离群点集中程度的可量化建模 + 找到 Flatness 最优变换”。

技术路线可以分为四个关键部分：

- **量化误差与离群点的数学建模**：设权重/激活中存在少数极大离群值。受其影响，量化 scale 对应变大，普通值的量化间隔也被放大；论文通过推导（式 5/6/9/10）说明：当离群值远大于正常量化范围时，总量化误差满足约 \( E[\epsilon^2] \approx p \cdot w_{\text{outlier}}^2 \cdot x \)，即误差随离群值增长呈**平方关系**，因此抑制离群值对低比特量化具有决定性意义。

- **Flatness 指标**：受信息熵启发，定义
  \[
  F=\sum_{i,j} \frac{W_{ij}^2}{\alpha_i\beta_j}\ln\left(\frac{W_{ij}^2}{\alpha_i\beta_j}\right)
  \]
  其中 \(\alpha_i\)、\(\beta_j\) 为行、列方向的能量系数。通过约束 \(\sum W_{ij}^2/(\alpha_i\beta_j)=1\) 以及能量正则项 \(\sum \alpha_i W_{ij}^2 \beta_j=C\)，极小化 F 使能量在矩阵内部更均匀地分散，从而减少少数极端值主导量化范围的现象。

- **理论最优解**：用拉格朗日乘子法求导后发现，最优的 \(\alpha_i\) 只依赖第 i 行数据，最优的 \(\beta_j\) 只依赖第 j 列数据。由此推导出对角变换结构 \(V=d_1 W d_2\) 是理论最优形式（\(d_1,d_2\) 为对角矩阵）。这与 FlatQuant 等用 Kronecker 分解的方法形成鲜明对比：论文用参数独立性和更紧的误差界说明双向对角缩放比 Kronecker 结构更优（见附录）。

- **BDQ 框架**：在 transformer 的每个 block 中放置 4 组等价变换对（对应注意力/FFN 中不同线性层），每组内含两个可学习对角矩阵和一个可学习旋转矩阵。前向过程被重写为：
  \[
  y = Q(\Lambda_1 x \Lambda_2 R)\cdot Q(R^T \Lambda_2^{-1} W \Lambda_1^{-1})
  \]
  当不量化时，该变换等价于原模型输出；量化时则能先将离群能量分散到两个维度上，并用 Hadamard 旋转进一步抹平列间相关性。对角矩阵、旋转矩阵通过少量校准数据训练得到。

- **RCE 损失**：量化通常只用 128 条校准样本，传统交叉熵会使模型强烈过拟合校准数据，表现为训练集 PPL 下降但下游任务精度下降，Flatness 反而变大。RCE 同时拟合真实标签分布 q 与量化模型预测分布 p，形式如下：
  \[
  L_{\text{RCE}}=-\sum_{i=0}^{n} (q_i\log p_i - p_i\log(\delta p_i+(1-\delta) q_i))
  \]
  \(\delta\) 平衡对标签分布和预测分布的拟合程度，在实验中取 0.5 最优。

## 3. 实验设计

**模型规模与家族**：
- LLaMA-2（7B/13B/70B），LLaMA-3（8B/70B）；
- DeepSeek-R1-Distill-LLaMA（8B/70B）；
- 论文说明还应用于整个 Llama 家族，覆盖参数量从 7B 到 70B。

**量化设置**：采用 GPTQ 作为统一量化器；测试的位宽组合包括：
- W4A4KV4（主流常用）；
- W3A3KV3（更低比特）；
- W2A4KV16（挑战性设置，权重 2bit / 激活 4bit / KV cache 16bit）。

**评估基准与数据集**：
- 语言建模质量：WikiText2 与 C4 上的 PPL；
- 零样本下游任务：ARC-Challenge、ARC-Easy、HellaSwag、LAMBADA、PIQA、WinoGrande，使用 lm-evaluation-harness 统一评测；
- 补充实验还包括 MMLU 与 MATH（附录 F）。

**对比方法**：
- FP16 全精度基线；
- QuaRot（Hadamard 旋转）；
- SpinQuant（可学习旋转）；
- FlatQuant（前 SOTA，基于 Kronecker 分解的平坦度方法）。

**训练配置**：校准集使用 WikiText2 中 128 个句子（每句 2048 tokens），batch size 4，训练 150 epochs，AdamW 初始学习率 5e-3 并经 cosine 退火，\(\delta=0.5\)，对角矩阵初始化为单位阵。

## 4. 资源与算力

论文在正文与限制声明中**没有提供训练 BDQ 所需的总算力明细**（如 GPU 卡数、总训练时长、总 Token 数等），仅给出了优化超参数。

- 训练阶段：校准集相当小（128 句 × 2048 tokens，共 150 epochs），推理成本应远低于全模型微调，但论文并未报告实际 GPU 时数。
- 硬件平台：推理效率实验在 NVIDIA A100 80GB 与 AMD MI250 上进行，测出了最高 3.44× 的 prefill 加速与 3.74× 的内存节约，不过这部分结果是量化后模型与 FP16 的对比，而不代表量化参数训练过程中消耗的算力。
- 作者也明确表示：由于资源有限，没有在更大模型（>70B）和更多 GPU 类型上做验证。

## 5. 实验数量与充分性

实验总体上是**比较充分且成体系**的：

- **主实验**：Table 2/6 覆盖 8 个模型-位宽组合，每个组合下都报告 2 个 PPL + 6 个下游任务 + 平均精度，

## 5. 实验数量与充分性（续）

- **设置覆盖**：除 W4A4KV4 主设置外，W3A3KV3 与 W2A4KV16 两组低比特设置能直接检验论文“极低比特下仍有效”的核心声明，且在不同模型家族（LLaMA-2/3、DeepSeek-R1-Distill）中均有对应报告，提升了结论的可迁移性。
- **消融实验**（论文 §4.3 与附录）：分别验证了四个变体的必要性，包括①不使用 Hadamard 旋转、②去掉可学习旋转、③将双向对角替换为单向对角、④将 RCE 换回标准 CE、⑤去掉对角变换的初始化策略。每一项均给出 PPL/下游精度对比，证明了 BDQ 各组件缺一不可。
- **视觉模型验证**：论文额外在 ViT（如 DeiT-Small/Tiny）上做了量化实验，以说明方法不局限于 LLM，而是具有跨模态/跨任务的通用性。
- **效率报告**：同时测算了实际推理吞吐与显存占用，属于量化和部署工作应有的必要补充。

**充分性评价**：从系统性看，实验覆盖了模型规模（7B→70B）、位宽（2-bit 到 4-bit）、任务类型（语言建模、常识推理、多任务理解）以及理论分析（Flatness 与误差界的验证），足以支撑“极低比特 PTQ 优于已有方法”这一结论。但个别细节仍缺：如训练 BDQ 本身的收敛曲线、训练耗时报告、多次随机种子下的方差（论文仅报告单次结果），对 RCE 中 \(\delta\) 的敏感性测试也只给了一档或两档结论，未给出网格搜索过程。

## 6. 理论贡献 vs. 必要性质疑

论文最强卖点在于“给出 Flatness 最优变换的理论证明”。需要理性分析该理论贡献实质：

- **理论界是否足够新颖**：离群点导致量化误差放大的直觉并非首次出现（如 AWQ、OmniQuant 也有相关观察），但本文是把误差放大约束为偏离矩阵能量均匀分布的凸/拟凸函数，再用拉格朗日乘子法求出闭式解，这一**形式化路径**确实少见于已有 PTQ 文献。
- **最优性条件的局限**：理论最优变换的推导建立在“Flatness 指标”被定义正确、以及能量约束最合理的前提之上。但 Flatness 本身只是量化误差的一种代理度量，并非精确的最终精度。论文也承认该代理与最终 PPL/下游精度并非完全单调一致，因此“最优 Flatness 的变换就是最优量化变换”这一论证链条中有一个隐含假设并不严格成立。
- **实用贡献的独立性**：即便理论证明存在瑕疵，BDQ + RCE 的实用性贡献依然成立，因为它在多个模型/位宽上的效果提升明显。因此可理解为：理论分析提供了方向性指导，而方法的最终有效性由实验背书，属于“启发式理论 + 实验驱动”的典型组合。

## 7. 方法细节的可复现性与潜在坑点

论文在方法层面暴露了几个较难复现或需要谨慎对待的问题：

- **4 组对角矩阵 + 旋转矩阵的等价变换重写方式**：需要手工设计每个线性层前后插何处对角矩阵、何处旋转矩阵，论文虽给出伪代码，但针对不同模型（如 LLaMA-2 与 LLaMA-3 的 GQA/MHA 差异）是否要微调结构并未详细展开。
- **初始化策略**：论文使用“单位阵 + 基于校准统计的缩放”初始化对角矩阵，但该缩放的计算方式只在正文给出了一个概要式子，附录中才给出严格表达式；读者按正文复现时容易因细节缺失产生偏差。
- **RCE 中 \(\delta\) 的实现**：第二项中的 \(\delta p_i+(1-\delta)q_i\) 会对预测概率做平滑插值， \(\delta\) 的大小直接影响损失梯度反传行为。若在计算 log 时直接使用原始 \(p_i\) 或 \(q_i\) 可能出现数值不稳定，但论文并未讨论数值处理细节。
- **小校准集与迭代次数**：128 条样本训练 150 epochs 虽比全参数微调轻量，但相对于一般 PTQ（若干分钟即可完成），BDQ 可能需要数小时级别 GPU 时间；论文没有说明超参数选择如何随模型规模缩放，例如 70B 模型是否也需要 150 epochs。
- **与其他量化器耦合**：论文只报告与 GPTQ 的配合。若改用 RTN、AWQ 或位宽切分等其他量化器，BDQ 训练出来的变换是否能直接迁移缺乏验证。

## 8. 社会影响与局限性

该文属于基础方法类工作，不涉及伦理、偏见或错误信息风险直接相关的内容。其潜在积极影响在于降低大模型部署门槛，使低资源设备运行大模型成为可能；潜在负面效应则与所有加速技术类似——降低部署成本可能使恶意模型更易传播。作者在论文中也明确承认主要局限：理论分析仅针对线性层、不覆盖注意力 logits 中离群结构；受 GPU 资源所限未在更大规模（>70B）上验证；无法完全保证所选激活/权重结构对所有未来模型家族都适用。

## 9. 总结与综合评价

**优点**：
1. 首次以显式指标“Flatness”系统刻画 PTQ 离群点问题，并给出闭式最优形式，理论自洽性较高；
2. BDQ 结构简单，不引入大量额外参数，实际部署友好；
3. 在 W2A4KV16 这类极端低比特下仍有明显收益，结果有可验证性；
4. RCE 损失巧妙缓解了小校准集过拟合问题，属于对量化训练流程的重要改进；
5. 实验覆盖面较宽，模型规模和位宽范围均有代表性。

**不足**：
1. 理论“最优性”建立在代理指标 Flatness 上，未形成端到端精度界；
2. 训练成本、收敛细节、方差等工程信息缺失，不利于快速评估实用性；
3. 泛化性实验始终局限于其声称的少数架构，缺乏对更多新模型（如 Mistral、Qwen、Gemma）的检验；
4. 依赖手工设计的随机旋转初始化和多矩阵结构，易用性与自动化程度不及完全端到端学习的方案。

**综合判断**：本文是一篇质量较高的量化工作，其理论建模或可作为后续离群点研究的基准视角；BDQ 在低比特量化场景下的效果具有明确实用价值。但读者不应把“理论最优”误解为“全局精度最优”，该项工作的实际价值仍需在更广泛模型、更长校准数据以及不同量化后端的复制中进一步确认。未来工作可沿着“统一自动学习变换结构 + 更紧的端到端量化误差界”方向继续发展。

（完）
