# T3 Code 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/pingdotgg/t3code/blob/main/docs/user/install.md
# 更新日期：2026-10-26
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

irm https://t3.codes/install.ps1 | iex
$env:Path = "$env:USERPROFILE\.local\bin;$env:Path" ; t3 --version
Write-Host '安装完成：运行 t3 启动服务并打开本地 Web 应用'

Write-Host ''

Write-Host '安装完成：运行 t3 启动服务并打开 Web 应用，再到 Settings → Providers 启用已登录的 Agent'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/pingdotgg/t3code/blob/main/docs/user/install.md'
