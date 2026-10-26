#!/usr/bin/env bash
set -euo pipefail
# T3 Code 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/pingdotgg/t3code/blob/main/docs/user/install.md
# 更新日期：2026-10-26
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }

mkdir -p .download
cd .download

curl -fsSL https://t3.codes/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
command -v t3 >/dev/null 2>&1 || { echo "安装后没找到 t3，请把 ~/.local/bin 加入 PATH"; exit 1; }
t3 --version

echo ""

echo "安装完成：运行 t3 启动服务并打开 Web 应用，再到 Settings → Providers 启用已登录的 Agent"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/pingdotgg/t3code/blob/main/docs/user/install.md"
