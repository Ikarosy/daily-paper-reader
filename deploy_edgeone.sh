#!/bin/bash

# EdgeOne Pages 部署脚本
# 参考 EdgeOne 文档：edgeone pages deploy <directoryOrZip> -n <projectName> -t <token> [-e <env>]

set -e
export EDGEONE_PAGES_PROJECT_NAME=daily-paper-reader-upload   # 或你在控制台看到的项目名
export EDGEONE_API_TOKEN=UNhwyPtS+neECc+i+ta4b2o96dPh4wRbfh5Je5LXnkI=


PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="${PROJECT_DIR}/docs"

if ! command -v edgeone &>/dev/null; then
  echo "❌ 未检测到 edgeone CLI，请先安装（参考 EdgeOne 文档）。"
  exit 1
fi

if [ -z "${EDGEONE_PAGES_PROJECT_NAME}" ]; then
  echo "❌ 请先设置环境变量 EDGEONE_PAGES_PROJECT_NAME，用于指定 Pages 项目名称。"
  exit 1
fi

if [ -z "${EDGEONE_API_TOKEN}" ]; then
  echo "❌ 请先设置环境变量 EDGEONE_API_TOKEN，用于授权 CLI 部署。"
  exit 1
fi

echo "🚀 开始将 docs/ 目录部署到 EdgeOne Pages..."
cd "${PROJECT_DIR}"

edgeone pages deploy "${DIST_DIR}" -n "${EDGEONE_PAGES_PROJECT_NAME}" -t "${EDGEONE_API_TOKEN}"

echo "✅ EdgeOne Pages 部署完成。"

