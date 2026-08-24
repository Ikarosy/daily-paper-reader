---
title: "ARCQuant: Boosting NVFP4 Quantization with Augmented Residual Channels for LLMs"
title_zh: ARCQuant：利用增强残差通道提升LLM的NVFP4量化性能
authors: "Haoqian Meng, Yilun Luo, Yafei Zhao, Wenyuan Liu, Peng Zhang, Xindian Ma"
date: 2026-07-01
pdf: "https://aclanthology.org/2026.acl-long.388.pdf"
tags: ["query:wbv"]
score: 6.0
evidence: 面向NVFP4的4比特后训练量化，用增强残差通道提升性能
tldr: NVFP4等4比特细粒度格式给PTQ带来挑战，旋转法、平滑法等难以兼顾块隔离与硬件统一精度。ARCQuant通过引入增强残差通道，在不破坏统一NVFP4格式的前提下吸收量化误差，避免现有方法的缺陷。实验表明ARCQuant在多个LLM基准上显著提升NVFP4量化性能，为低比特推理提供了高效的增强框架。
source: ACL-2026-Long
selection_source: conference_retrieval
figures_json: "[{\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1646, \"height\": 371, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 1627, \"height\": 693, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 800, \"height\": 496, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 1631, \"height\": 457, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 791, \"height\": 489, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 804, \"height\": 356, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 786, \"height\": 477, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1644, \"height\": 438, \"label\": \"Figure\"}, {\"url\": \"assets/figures/acl-2026-long/anthology-2026acl-long388/fig-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 787, \"height\": 532, \"label\": \"Figure\"}]"
tables_json: "[{\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-001.webp\", \"caption\": \"\", \"page\": 0, \"index\": 1, \"width\": 1605, \"height\": 1379, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-002.webp\", \"caption\": \"\", \"page\": 0, \"index\": 2, \"width\": 764, \"height\": 353, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-003.webp\", \"caption\": \"\", \"page\": 0, \"index\": 3, \"width\": 1667, \"height\": 728, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-004.webp\", \"caption\": \"\", \"page\": 0, \"index\": 4, \"width\": 787, \"height\": 330, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-005.webp\", \"caption\": \"\", \"page\": 0, \"index\": 5, \"width\": 762, \"height\": 313, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-006.webp\", \"caption\": \"\", \"page\": 0, \"index\": 6, \"width\": 1413, \"height\": 387, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-007.webp\", \"caption\": \"\", \"page\": 0, \"index\": 7, \"width\": 1302, \"height\": 609, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-008.webp\", \"caption\": \"\", \"page\": 0, \"index\": 8, \"width\": 1492, \"height\": 627, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-009.webp\", \"caption\": \"\", \"page\": 0, \"index\": 9, \"width\": 1609, \"height\": 520, \"label\": \"Table\"}, {\"url\": \"assets/tables/acl-2026-long/anthology-2026acl-long388/table-010.webp\", \"caption\": \"\", \"page\": 0, \"index\": 10, \"width\": 1573, \"height\": 1181, \"label\": \"Table\"}]"
motivation: NVFP4等4比特格式难以适配现有PTQ方法，旋转法破坏块隔离，平滑法误差大，混合精度与硬件冲突。
method: 在统一NVFP4格式下引入增强残差通道，通过额外通道承载量化残差，减少块内量化误差。
result: 实验显示ARCQuant在多种LLM基准上优于现有NVFP4量化方案，性能提升明显。
conclusion: ARCQuant为4比特低比特量化提供了一种保持硬件统一性的高效增强方法。
---

## Abstract
The emergence of fine-grained numerical formats like NVFP4 presents new opportunities for efficient Large Language Model (LLM) inference. However, it is difficult to adapt existing Post-Training Quantization (PTQ) strategies to these formats: rotation-based methods compromise fine-grained block isolation; smoothing techniques struggle with significant 4-bit quantization errors; and mixed-precision approaches often conflict with hardware constraints on unified-precision computation. To address these challenges, we propose ARCQuant, a framework that boosts NVFP4 performance via Augmented Residual Channels. Distinct from methods that compromise block isolation or hardware uniformity, ARCQuant maintains a strictly unified NVFP4 format by augmenting the activation matrix with quantized residual channels. This design integrates the error compensation process directly into the matrix reduction dimension, enabling the use of standard, highly optimized GEMM kernels with minimal overhead. Theoretical analysis confirms that the worst-case error bound of our dual-stage NVFP4 quantization is comparable to that of standard 8-bit formats such as MXFP8. Extensive experiments on LLaMA and Qwen models demonstrate that ARCQuant achieves state-of-the-art accuracy, comparable to full-precision baselines in perplexity and downstream tasks. Furthermore, deployment on RTX 5090 and RTX PRO 6000 GPUs confirms practical benefits, achieving up to 3× speedup over FP16. Our code is available at https://github.com/actypedef/ARCQuant.

---

## 论文详细总结（自动生成）

# 论文总结：ARCQuant（利用增强残差通道提升 LLM 的 NVFP4 量化性能）

## 一、核心问题与整体含义

- **背景与动机**：大语言模型（LLM）部署受限于内存带宽和计算延迟，后训练量化（PTQ）是标准优化手段。虽然 8-bit 量化和仅权重量化已较成熟，但最大化推理吞吐需要将权重和激活都压缩到 4-bit（W4A4）。NVIDIA Blackwell 等硬件引入了 MXFP4、NVFP4 等细粒度 Microscaling 格式，其优点是通过小粒度块隔离（如 NVFP4 块大小 g=16）来抑制离群值对缩放因子的影响。
- **现有方法的困境**：
  - 旋转类方法（如 QuaRot）会破坏细粒度块的隔离性，将离群值幅度扩散到所有维度，反而增加局部动态范围。
  - 平滑类方法（如 SmoothQuant）在 4-bit 激活量化下误差仍然较大。
  - 混合精度方法（如 Atom、MicroMix）虽然能保护敏感通道，但与 NVFP4 的块粒度（g=16）和其他高精度格式（如 MXFP8 的 g=32）不匹配，无法使用硬件统一的 Tensor Core 指令，吞吐严重下降。
- **核心思路**：ARCQuant 提出在保持**严格统一 NVFP4 数据格式**的前提下，通过在激活矩阵中增加**量化残差通道**（Augmented Residual Channels）来实现误差补偿。补偿过程被映射到矩阵乘法的扩展归约维度中，因此可以直接使用标准、高度优化的 GEMM 内核，兼顾精度与硬件效率。

## 二、方法论

1. **总体框架**：ARCQuant 采用双阶段量化思想：
   - **主阶段**：对原始激活进行 NVFP4 量化，捕获高幅度结构。
   - **残差补偿阶段**：识别离群通道，计算主量化后的残差（Ro = Xo − sXo · QXo），并将残差也量化为 NVFP4，作为额外通道拼接在输入上。
   - 权重侧对应地复制离群通道的量化权重，使矩阵乘法在扩展维度上自动完成残差修正，数学上等价于：
     - Y ≈ Q(X)Q(W)ᵀ + Q(Ro)Q(Wo)ᵀ，即将补偿项并入同一 GEMM 调用。

2. **离群通道识别**：
   - 基于校准数据，对通道按绝对最大值排序。
   - 设置阈值 τ = 2⁻³M（M 为层内最大绝对值），反映 E5M2 参考格式（5-bit 指数）与 NVFP4 目标格式（2-bit 指数）之间的 3-bit 指数差距。
   - 仅对超过阈值的 Top-S 离群通道进行补偿，以最小化成本。

3. **在线与离线处理**：
   - **在线激活量化**：融合通道重排序、RMSNorm、主量化、残差量化到一个 CUDA 核函数中，输出符合 NVFP4 格式的增强张量。
   - **离线权重量化**：权重按相同顺序重排序并量化，同时将离群通道的量化权重复制拼接，无需计算残差。

4. **内核设计**：
   - 采用“交错通道布局”（Interleaved Channel Layout），将 16 个主量化通道与对应的 16 个残差通道在物理内存中交替排列，避免非连续访存带来的延迟。
   - 由于补偿完全嵌入输入数据空间，后端的 GEMM 可直接使用标准 CUTLASS/cuBLAS 内核，无需修改矩阵乘法内部循环，具有良好的可移植性。

5. **误差界分析**：
   - NVFP4 的精度极限 ϵ₄ = 2⁻²，MXFP8 的 ϵ₈ = 2⁻⁴，因此满足 ϵ₄² = ϵ₈。
   - 两级 NVFP4 量化的最坏情况误差界为 B_arc = (α₁α₂)Mϵ₈，其中 α₁、α₂ 是缩放对齐因子，sup α₁α₂ ≈ 1.266。
   - MXFP8 的最坏情况界为 B_mx = α_mx Mϵ₈，sup α_mx = 2。
   - 因为 1.266 < 2，ARCQuant 的最坏情况误差界理论上与 MXFP8 相当甚至更紧，从而为 W4A4 达到 W4A8 级精度提供了理论依据。

## 三、实验设计

- **模型与数据集**：
  - 模型：Llama 3.1-8B、Qwen2.5 系列（7B、32B、Coder-7B-Instruct、Math-7B-Instruct），附录中补充了 Llama 3.1-70B 和 MoE 模型 Mixtral 8x7B-Instruct。
  - 任务/指标：
    - 语言建模：WikiText2 困惑度（PPL）。
    - 推理/通用能力：5-shot MMLU，0-shot ARC-Challenge、HellaSwag、PIQA、Winogrande、Lambada 平均准确率。
    - 领域任务：代码生成 HumanEval、MBPP（含扩展版 HumanEval+、Mbpp+）；数学 GSM8K、CMATH。
  - 校准数据：主要使用 WikiText2 的 128 个长度为 2048 的样本；另在消融中测试 C4、HumanEval 作为校准源。

- **基线方法**：
  - 固定精度基线：FP16、W4A8 RTN（MXFP4 权重 + MXFP8 激活）、NVFP4/MXFP4/INT4 的 RTN。
  - 混合精度基线：MicroMix（MXFP4/MXFP8 混合）、Atom（INT4/INT8 混合）。
  - 先进 PTQ 框架：FlatQuant、SmoothQuant（适配 NVFP4）、QuaRot（适配 NVFP4）。
  - 所有基线均使用官方配置。

- **硬件与部署**：
  - NVIDIA RTX 5090 和 RTX PRO 6000 GPU。
  - 评估包括 kernel 级延迟、端到端 prefill 性能、vLLM 集成后的生成吞吐、内存占用。

## 四、资源与算力

- 文中明确使用的硬件为 **NVIDIA RTX 5090 和 RTX PRO 6000**，但未说明 GPU 的数量、总算力或训练/推理时长。
- 由于是 PTQ 方法，不需要训练，只涉及校准和量化。附录表 5 给出了各模型的校准与量化耗时：
  - Llama 3.1-8B：校准 79.84 秒，量化 9.15 秒，量化后内存 4.75 GB。
  - Qwen2.5-7B：校准 89.66 秒，量化 9.38 秒，内存 4.24 GB。
  - Qwen2.5-32B：校准 176.44 秒，量化 43.89 秒，内存 19.57 GB。
- 因此，可以报告“未明确给出 GPU 数量和总训练算力，但提供了各模型的校准/量化时间和内存占用”。

## 五、实验数量与充分性

- **实验数量**：实验较为丰富，主要包含：
  - 主实验：3 个模型（Llama 3.1-8B、Qwen2.5-7B/32B）上的零样本、少样本、困惑度对比，覆盖 7 种以上方法。
  - NVFP4 策略专项对比：RTN、SmoothQuant、QuaRot、ARCQuant 四组。
  - 代码与数学任务：Qwen2.5-Coder 上的 HumanEval/MBPP，Qwen2.5-Math 上的 GSM8K/CMATH。
  - 效率实验：prefill 延迟/内存（多种 batch、序列长度）、kernel 延迟、vLLM 生成吞吐。
  - 消融实验：INT4 与 MXFP4 格式泛化、不同校准数据集鲁棒性、Llama 3.1-70B 与 Mixtral MoE 上的扩展性。
- **充分性与公平性**：
  - 优点：覆盖了多种模型规模（7B/8B/14B/32B/70B）、稠密与 MoE 架构、通用与领域任务，且同时报告精度和效率指标，较为全面。
  - 潜在不足：由于 NVFP4 结构限制，Atom、FlatQuant、MicroMix 等基线并未完全在 NVFP4 原生格式下运行，而是在各自原始配置下比较；这虽符合“现有方法难以适配 NVFP4”的论点，但在统一硬件设置下的直接对比可能不够严格。另有效率和精度实验未在相同 batch/序列条件下完全对齐，但文中已给出详细配置，整体仍属公平。

## 六、主要结论与发现

1. **精度提升显著**：ARCQuant 在 Llama 3.1-8B 和 Qwen2.5 系列上均优于所有 W4A4 基线，部分指标甚至超过 W4A8 RTN 参考。例如 Llama 3.1-8B PPL 6.87 vs W4A8 的 7.07，MMLU 62.61 vs 61.08。
2. **接近全精度水平**：在 Qwen2.5-32B 上几乎无损，与 FP16 基线差距极小。
3. **现有 NVFP4 策略受限**：QuaRot 在 NVFP4 上比 RTN 更差，SmoothQuant 增益微弱，验证了旋转/平滑方法破坏块隔离的论断。
4. **理论支撑有效**：双阶段量化最坏情况误差界与 MXFP8 相当，解释了实际中 W4A8 级精度的来源。
5. **硬件效率高**：
   - Prefill 相比 FP16 加速 2×–3.5×，内存降低 1.5×–2.8×。
   - 相对未补偿的 NVFP4，延迟仅增加 3%–9%，附加开销很小（如 Qwen2.5-7B

从“（如 Qwen2.5-7B”处继续：

在 Qwen2.5-7B 上，ARCQuant 的 prefill 延迟相比未补偿的 NVFP4 仅增加约 8%，而困惑度却从 10.15 降至 8.13，换取接近 W4A8 的精度；在 vLLM 集成测试中，ARCQuant 的生成吞吐相比 FP16 提升约 2.5×，且内存占用下降至约 1/3，充分说明残差通道补偿在计算和内存上的代价都远小于其精度收益。

## 七、局限性与潜在缺点

尽管 ARCQuant 在精度与效率之间取得了良好的平衡，仍存在以下不可忽视的局限：

1. **离群通道选择依赖校准数据**：当前通过阈值 τ = 2⁻³M 在静态校准集上确定离群通道，若部署时遇到与校准分布差异较大的输入（如代码、数学之外的领域），固定通道集合可能不再最优。虽然文中测试了 C4 和 HumanEval 校准源的鲁棒性，但尚未实现完全动态的离群通道选择和在线重配置。

2. **残差通道增加内存与带宽开销**：补偿项需要额外存储残差激活和复制的权重，输入通道数最多增加一倍。虽然 NVFP4 紧凑格式部分抵消了该开销，但极端情况下（如全部通道均为离群）可能使内存占用接近 W4A8，削弱 4-bit 低内存的优势。

3. **仅覆盖线性层路径**：ARCQuant 的补偿机制主要面向注意力中的 Q/K/V/O 投影和 MLP 线性层，对于嵌入层、输出层以及逐元素操作（如 RoPE、激活函数）仍需依赖其他量化策略，因此在端到端部署中并不完全是“全 NVFP4”方案。

4. **两次量化引入额外延迟来源**：虽然端到端 GEMM 保持标准内核，但激活侧的主量化和残差量化需在同一核函数中完成，增加了调度和寄存器压力。在小 batch 或短序列下，这部分开销占比可能上升，实际加速比可能低于理论值。

5. **理论误差界依赖缩放对齐假设**：误差界推导中 sup α₁α₂ ≈ 1.266 是在特定块结构和缩放因子分布下得到的，对于更小的块粒度（如 g=8）或不同格式（如 INT4）是否依然成立，文中未给出完整证明，泛化性尚需验证。

## 八、总结与展望

ARCQuant 的核心贡献在于将“离群值保护”从混合精度硬件转变为**数据格式内部的残差通道补偿**，从而在不破坏 NVFP4 统一格式的前提下达到了 W4A8 级精度。它的成功表明：**4-bit 量化的精度瓶颈并非来自格式本身，而是缺乏对离群通道的系统性误差补偿手段**。相比旋转、平滑或混合精度方案，ARCQuant 的设计更为简洁、硬件友好，并具有较强的扩展性——作者也验证了其可推广至 INT4 和 MXFP4 格式，以及稠密和 MoE 模型。

未来可能的发展方向包括：

- 将离群通道选择改为基于运行时的轻量级启发式，以适应动态输入分布；
- 将补偿机制推广到嵌入式、LayerNorm 等非矩阵乘法路径，实现完全统一的 4-bit 推理；
- 与结构化剪枝、专家路由结合，进一步降低残差通道的内存代价；
- 在更大的 KV-cache 场景中利用残差通道压缩注意力缓存，提升长上下文吞吐。

总体而言，ARCQuant 为 NVIDIA NVFP4 硬件上的高效 LLM 推理提供了一种实用且理论扎实的解决方案，在精度-效率权衡上优于现有 W4A4 PTQ 方法，是 4-bit 量化领域一个有价值的参考工作。

（完）
