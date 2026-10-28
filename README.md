# T3 Code 一键部署指南

> 第三方部署指南 · 非 T3 Code 官方仓库。官方项目：[pingdotgg/t3code](https://github.com/pingdotgg/t3code)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://github.com/pingdotgg/t3code/blob/main/docs/user/install.md)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用换编辑器，让百度搭子装好 T3 Code，手机和浏览器都能接管本机 Agent。

⚠️ 需要本机已安装并登录至少一个 provider（Codex / Claude Code / Cursor / Grok Build / OpenCode）。安装脚本支持 macOS / Linux 与 Windows；后台服务只支持 macOS / Linux。项目自己标注「very early」，可能有 bug。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/t3code-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会运行官方安装脚本，把 t3 装到 ~/.local/bin，并确认版本，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## T3 Code 是什么？

T3 Code 是开源的多端接管本机编码 Agent 的控制台（协议：MIT，<img src="https://img.shields.io/github/stars/pingdotgg/t3code?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

T3 Code 是 Agent 的控制面：把本机已登录的 Codex、Claude Code、Cursor、Grok Build、OpenCode 接管起来，在桌面端、浏览器或手机 App 里发起任务、看 Diff、管多账号。

- 多客户端：桌面端 + 本地 Web + iOS / Android
- 多 Provider：Codex / Claude / Cursor / Grok / OpenCode / Antigravity
- 多账号：每个 provider 可挂多个账号
- 远程：手机或另一台机器连回本机
- 形态：CLI + 桌面端 + 后台服务

（来源：[官方仓库](https://github.com/pingdotgg/t3code)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 31.0k stars | 2026-02 建，8 个月涨到 30.4k |
| 多端接管 | 桌面、浏览器、手机都能用 |
| Provider 覆盖广 | Codex / Claude / Cursor / Grok / OpenCode |
| 安装路径全 | CLI 脚本、npm、winget、scoop、brew、桌面端 |
| 发版快 | 100+ Release，最新 v0.1.3 |

| 需要注意 | 说明 |
|---|---|
| 项目很早期 | 作者自己说 expect bugs |
| Windows 没后台服务 | service 只支持 macOS / Linux |
| 依赖已登录的 provider | 空机器装了也用不了 |
| 暂不接受大功能贡献 | 生态扩展慢 |
| 远程访问要自己配 | 暴露控制端口有安全风险 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 快速部署（官方方式）

```bash
curl -fsSL https://t3.codes/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
command -v t3 >/dev/null 2>&1 || { echo "安装后没找到 t3，请把 ~/.local/bin 加入 PATH"; exit 1; }
t3 --version
```

部署步骤来源：[https://github.com/pingdotgg/t3code/blob/main/docs/user/install.md](https://github.com/pingdotgg/t3code/blob/main/docs/user/install.md)

## 验证状态

| 场景 | 状态 |
|---|---|
| npm 包 t3 版本 0.1.3、engines.node >=20.11 已核对 | 已核对 2026-10-28 |
| Release v0.1.3 的 Windows / macOS / Linux 产物与 SHA256SUMS 已核对 | 已核对 2026-10-28 |
| 安装脚本（sh / ps1）已通读，未执行安装（会写入用户目录） | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

T3 Code 通过 MCP 连接外部 Agent 与工具。本仓库的 MCP 只提供安装、provider 配置与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\t3code-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 启动之后

1. 运行 `t3`：启动服务并打开本地 Web 应用
2. 进 **Settings → Providers**，启用一个已安装并登录的 provider
3. 新建 thread，选项目目录，开始派任务
4. 后台常驻：`t3 service install`（仅 macOS / Linux）；Windows 直接开桌面端或用计划任务

### Provider 先登录

| Provider | 登录命令 |
|---|---|
| Codex | `codex login` |
| Claude Code | `claude auth login` |
| OpenCode | `opencode auth login` |
| Cursor | `agent login` |
| Grok Build | `grok login` |

### 桌面端与手机

- Windows：`winget install T3Tools.T3Code` 或 `scoop install extras/t3code`
- macOS：`brew install --cask t3-code`
- Linux：Release 里的 deb / AppImage / AUR
- 手机：iOS / Android 官方 App，连接本机服务

> ⚠️ 项目处于 v0.1.x 的早期阶段，接口与行为还会变；不要把控制端口直接暴露到公网，远程访问按官方文档配置。

## 常见坑

- 启动后没 provider：先在终端把 Codex / Claude / OpenCode 登录好，再回 Settings 启用
- 找不到 t3：把 `~/.local/bin`（Windows 是 `%USERPROFILE%\.local\bin`）加入 PATH
- Windows 想后台常驻：`t3 service install` 不支持，改用桌面端或任务计划
- 手机连不上：确认手机与本机在同一网络，按官方远程访问文档配置
- 端口冲突：用 `--base-dir` 起独立实例，或先停掉旧的 `t3`
- 版本太旧：`t3 update` 更新到最新稳定版

## 免责声明

本仓库为第三方指南，与 T3 Code 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://github.com/pingdotgg/t3code/blob/main/docs/user/install.md)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
