# 插件升级

我的插件列表里面有不少插件已经有更现代、功能更强或者维护更活跃的替代方案，特别是 Neovim 0.9+ 生态里的一些新趋势。
我会根据插件的功能和我自己的需求，分模块升级插件。

---

## **1. 自动补全 & LSP**

| 现用插件                                               | 状态                | 推荐替代 / 补充                               | 原因                               |
| -------------------------------------------------- | ----------------- | --------------------------------------- | -------------------------------- |
| `neovim/nvim-lspconfig`                            | ✅ 保留              | `neovim/nvim-lspconfig`                 | 核心必备，继续用                         |
| `williamboman/mason.nvim` + `mason-lspconfig.nvim` | ✅ 保留              | —                                       | 目前最主流的 LSP/DAP 安装管理组合            |
| `hrsh7th/nvim-cmp` 系列                              | ✅ 保留              | 考虑 `onsails/lspkind.nvim`               | `lspkind.nvim` 能给补全菜单加上漂亮的图标     |
| `j-hui/fidget.nvim`                                | ⚠️ 已经长期停更（2023 后） | `nvim-lsp-status` 或 `nvim-lsp-progress` | 替代显示 LSP 进度的插件                   |
| `ray-x/lsp_signature.nvim`                         | ✅ 保留              | 也可用 `folke/noice.nvim` 统一消息 UI          | Noice 可以替代 LSP 弹窗 & signature 功能 |

---

## **2. 代码检查 & 格式化**

| 现用插件                        | 状态        | 推荐替代                         | 原因                                                |
| --------------------------- | --------- | ---------------------------- | ------------------------------------------------- |
| `diagnosticls-configs-nvim` | ⚠️ 不再活跃   | `nvim-lint` + `null-ls.nvim` | `nvim-lint` 负责异步 lint，`null-ls` 可整合格式化和非 LSP 代码检查 |
| `formatter.nvim`            | ⚠️ 较旧，功能弱 | `conform.nvim`               | `conform.nvim` 启动快，配置简单，支持 fallback 格式化           |

---

## **3. 调试**

| 现用插件                     | 状态    | 推荐替代                    | 原因                |
| ------------------------ | ----- | ----------------------- | ----------------- |
| `mfussenegger/nvim-dap`  | ✅ 保留  | —                       | DAP 核心            |
| `Pocco81/dap-buddy.nvim` | ⚠️ 停更 | 用 `mason-nvim-dap.nvim` | 官方 mason 生态内替代    |
| 其他 DAP UI/插件             | ✅ 保留  | —                       | `nvim-dap-ui` 很好用 |

---

## **4. 注释**

| 现用插件           | 状态    | 推荐替代                    | 原因           |
| -------------- | ----- | ----------------------- | ------------ |
| `nvim-comment` | ⚠️ 停更 | `numToStr/Comment.nvim` | 更现代、维护活跃、性能好 |

---

## **5. 编辑增强**

| 现用插件                      | 状态        | 推荐替代                                                       | 原因                          |
| ------------------------- | --------- | ---------------------------------------------------------- | --------------------------- |
| `ggandor/lightspeed.nvim` | ⚠️ 已被作者弃用 | `ggandor/leap.nvim`                                        | Leap 是 lightspeed 的继任版本     |
| `karb94/neoscroll.nvim`   | ✅ 保留      | —                                                          | 依然好用                        |
| `nvim-autopairs`          | ✅ 保留      | —                                                          | 社区标准                        |
| `nvim-lastplace`          | ⚠️ 停更     | `ethanholz/nvim-lastplace` fork 或 `folke/persistence.nvim` | Persistence 还能恢复 buffers 会话 |

---

## **6. 笔记 & 文档**

| 现用插件             | 状态    | 推荐替代                                                 | 原因                |
| ---------------- | ----- | ---------------------------------------------------- | ----------------- |
| `neorg`          | ✅ 保留  | —                                                    | 依然活跃              |
| `vim-translator` | ⚠️ 停更 | `potamides/pantran.nvim` 或 `uga-rosa/translate.nvim` | 新的 Lua 翻译插件，支持多引擎 |

---

## **7. 主题 & UI**

| 现用插件                   | 状态          | 推荐替代                                                | 原因                        |
| ---------------------- | ----------- | --------------------------------------------------- | ------------------------- |
| `nvim-colorizer.lua`   | ⚠️ 不活跃      | `NvChad/nvim-colorizer.lua`（fork）                   | 官方不更新，新 fork 在维护          |
| `nvim-cursorline`      | ⚠️ 不活跃      | `RRethy/vim-illuminate`                             | 维护更活跃，智能高亮同名符号            |
| `nvim-tree.lua`        | ⚠️ 维护中但性能一般 | `nvim-neo-tree/neo-tree.nvim` 或 `stevearc/oil.nvim` | Neo-tree 功能丰富，Oil 类似文件管理器 |
| `vim-startify`         | ⚠️ 已停止维护    | `goolord/alpha-nvim`                                | 新一代 dashboard             |
| `symbols-outline.nvim` | ⚠️ 更新少      | `stevearc/aerial.nvim`                              | 功能更强，支持 LSP + Treesitter  |
| `popup.nvim`           | ⚠️ 已弃用      | 可删（Telescope 已内置替代）                                 | Telescope 已不依赖            |
| `nvim-bufferline.lua`  | ✅ 保留        | —                                                   | 依然流行                      |

---

## **8. 项目管理**

| 现用插件           | 状态   | 推荐替代 | 原因   |
| -------------- | ---- | ---- | ---- |
| `project.nvim` | ✅ 保留 | —    | 依然好用 |

---

## **9. Markdown**

| 现用插件        | 状态      | 推荐替代                                                   | 原因                                        |
| ----------- | ------- | ------------------------------------------------------ | ----------------------------------------- |
| `glow.nvim` | ⚠️ 功能有限 | `ellisonleao/glow.nvim`（更新版） 或 `OXY2DEV/markview.nvim` | `markview.nvim` 支持直接在 Neovim 内渲染 markdown |

---

### **核心建议**

* **LSP**: 保留现有组合，`fidget.nvim` 换成维护活跃的进度插件。
* **格式化/Lint**: `formatter.nvim` → `conform.nvim`，`diagnosticls` → `nvim-lint + null-ls`。
* **注释**: 换成 `Comment.nvim`。
* **文件树**: `nvim-tree` → `neo-tree` 或 `oil.nvim`。
* **跳转**: `lightspeed` → `leap.nvim`。
* **UI**: `startify` → `alpha-nvim`，`cursorline` → `vim-illuminate`，`colorizer` → fork 版本。

---

直接把**这份插件表改成一个 2025 年最佳实践版本**，用 lazy.nvim 的配置格式一次性替换，保证都是社区活跃插件。这样你可以直接迁移过去用。
