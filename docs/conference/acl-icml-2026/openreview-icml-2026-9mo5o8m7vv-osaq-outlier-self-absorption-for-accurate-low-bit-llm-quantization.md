---
title: "OSAQ: Outlier Self-Absorption for Accurate Low-bit LLM Quantization"
title_zh: OSAQ：利用离群点自吸收实现精确的低比特大模型量化
authors: "Zhikai Li, Zhen Dong, Xuewen Liu, Jing Zhang, Qingyi Gu"
date: 2026-04-30
pdf: "https://openreview.net/pdf/27206182571b9d469a9198bc1d13079cbca95977.pdf"
tags: ["query:wbv"]
score: 4.0
evidence: 低比特权重量化结合二阶低秩离群点自吸收，虽无VQ但可迁移至极低比特VQ/SQ，属于同一大领域的弱相关
tldr: 低比特权重量化在降低大模型推理成本时，会受到权重中系统性离群点的显著影响；现有缩放、旋转等方法仍未完全解决退化。OSAQ利用二阶低秩分解获得加性的权重抑制项，在量化前将离群点自吸收掉，从而减少对量化区间的挤压。实验显示该做法相比此前离群点处理技术能更好地保持低比特模型精度。作为与量化方案正交的预处理，它可为2比特VQ或3比特SQ等极低比特方法提供精度增益。
source: ICML-2026-Accepted
selection_source: conference_retrieval
motivation: 低比特权重量化前景好，但权重系统离群点让低比特精度远不理想，缩放和旋转等现有思路不能完全解决问题。
method: 基于二阶低秩分解推导加性权重抑制项，在量化前自吸收系统离群点，降低权重分布的离群影响。
result: 在低比特权重量化实验上相较现有离群点处理方法取得更高精度，性能更接近全精度基线。
conclusion: 离群点预处理与量化可以解耦，这种自吸收技术可进一步提升极低比特量化方案的表现。
---

## Abstract
Large Language Models (LLMs) have demonstrated remarkable capabilities in understanding and generation tasks. However, their massive parameter scale leads to significant resource consumption and latency during inference. Post-training weight-only quantization offers a promising solution by reducing model size and accelerating token generation through alleviating the memory-bound issue. Nevertheless, there are inherent systematic outliers in weights, and although some efforts have attempted to address them, such as scaling and rotation, the performance of low-bit quantization remains far from satisfactory. In this paper, we propose Outlier Self-Absorption Quantization (OSAQ), which performs second-order low-rank derived additive weight suppression for low-bit weight-only LLM quantization. Specifically, we observe that Hessian exhibits low-rank consistency across different inputs, with certain directions persistently lacking strength. Leveraging this property, we construct an additive weight transformation based on the Hessian’s null space, thereby suppressing weight outliers without affecting the task loss. This additive transformation can be absorbed into the weights offline, requiring no inter-layer transformations and introducing no inference overhead. Moreover, the construction is efficiently achieved by a closed-form solution, without resource-intensive training or iterative procedures. Extensive experiments across models of varying scales and tasks are conducted, and the results show that OSAQ effectively suppresses outliers and improves low-bit quantization performance.

---

## 论文详细总结（自动生成）

# OSAQ 论文总结

## 1. 核心问题与整体含义

- **背景**：大语言模型（LLM）参数规模巨大，推理时存在严重的内存瓶颈和延迟问题。
- **现有方案**：训练后权重量化（Post-training weight-only quantization）是一种有前景的解决方案，可减小模型体积并加速 token 生成。
- **关键困难**：权重中存在系统性的离群点（systematic outliers），即使已有多种方法（如缩放 scaling、旋转 rotation）尝试处理，低比特量化性能仍远不理想。
- **研究目标**：通过提出 OSAQ（Outlier Self-Absorption Quantization，离群点自吸收量化），在量化前抑制权重离群点，从而提升低比特权重量化的精度，且不引入推理开销。

## 2. 方法论

- **核心思想**：利用 Hessian（二阶信息）的低秩一致性，构造一个加性权重变换，使该变换位于 Hessian 的零空间中，从而在**不改变任务损失**的前提下抑制权重离群点。
- **关键技术细节**：
  - 观察到 Hessian 在不同输入下具有低秩一致性，某些方向始终缺乏强度（即零空间方向）。
  - 基于这一性质，推导出**二阶低秩的加性权重抑制项**。
  - 该加性变换可以在离线阶段直接吸收进权重中，无需层间变换，也无需额外推理计算。
- **算法特点**：
  - 通过**闭式解（closed-form solution）** 高效构造，无需高代价的训练或迭代过程。
  - 与现有量化方法**正交**，可作为预处理步骤应用到各种极低比特量化方案（如 2-bit VQ、3-bit SQ）中。
- 注：摘要中未给出具体公式，仅以文字描述方法流程。

## 3. 实验设计

- **根据摘要**：论文进行了“跨不同规模模型和任务的大量实验”（Experiments across models of varying scales and tasks），用于验证 OSAQ 对离群点的抑制效果及低比特量化精度提升。
- **对比方法**：摘要仅提及与现有离群点处理技术（如 scaling、rotation）及已有量化方案进行对比，并未给出具体方法名称。
- **基准/数据集**：摘要中没有列出具体数据集、模型名称、任务类型或评估指标。
- **结论**：实验结果显示 OSAQ 能有效抑制离群点并改善低比特量化性能。

## 4. 资源与算力

- 论文提供的文本（摘要和元数据）中**未明确说明**使用的 GPU 型号、数量、训练/推理时长、显存等任何算力信息。
- 由于 OSAQ 采用离线闭式解构造，推断其计算代价可能较低，但具体资源用量不可知。

## 5. 实验数量与充分性

- **数量**：摘要声称“extensive experiments”，但未列出具体实验个数、数据集数量或消融实验详情。因此无法判断实际实验规模。
- **充分性**：
  - 从元数据看，论文被 ICML-2026 接收，且 source 为“conference_retrieval”，说明可能经过同行评审。
  - 但从现有信息看，缺失实验设置细节、消融研究、基线和完整结果表格，难以客观评估其公平性和充分性。
  - 有对比（与 scaling/rotation 等），但没有给出具体数值，无法判断改进幅度。

## 6. 主要结论与发现

- Hessian 在不同输入间具有低秩一致性，其零空间方向可用于构造不影响损失的权重变换。
- 基于 Hessian 零空间构造的加性抑制项，可有效“自吸收”权重中的系统性离群点。
- 该预处理能在低比特权重量化中有效抑制离群点，提升量化精度，且不引入推理开销。
- 离群点预处理与量化过程可解耦，该技术可迁移至极低比特量化领域（如 VQ/SQ），提供额外精度增益。

## 7. 优点

- **无需训练或迭代**：采用闭式解，计算高效。
- **零推理开销**：变换在离线阶段被吸收进权重，不改变推理结构。
- **方法普适**：与量化方案正交，可作为通用预处理应用到不同量化方法（尤其低比特）。
- **理论角度新颖**：利用 Hessian 低秩结构和零空间特性，从二阶优化角度处理离群点，比启发式缩放或旋转更有依据。
- **问题动机明确**：直指低比特权重量化中离群点对量化区间的挤压这一核心痛点。

## 8. 不足与局限

- **信息缺失**：提交的文本仅为摘要，缺少具体算法推导、公式、实现细节、评估协议、模型规模、数据集列表、对比基线名称和结果表格，无法对方法有效性进行完整评判。
- **实验细节不明**：未提供消融研究、对不同量化位宽的影响、与主流量化方法（如 GPTQ、AWQ、QuIP 等）的对比数据，也未说明重复实验次数和方差。
- **泛化性验证不足**：未说明模型规模覆盖范围（如是否包含 7B~70B 及以上）、任务类型（语言建模、下游任务）以及不同量化方案（RTN、GPTQ、VQ、SQ）的检验情况。
- **偏差风险**：摘要中只给出正面结论，未讨论失败场景或潜在限制，例如：闭式解近似精度、Hessian 低秩假设在极小位宽（如 2-bit 以下）是否依然成立、处理后的权重分布是否会给后续量化带来新的偏差等。
- **可重复性**：由于缺少代码/超参/算法伪代码，外部研究者难以复现。
- **应用局限**：主要面向 weight-only 量化，对于权重和激活同时量化的场景是否有效未说明；且对超低比特（<2-bit）的泛化尚未验证。

（完）
