# Plugins

## 升级记录

### 2025-01-16 - 核心插件升级

#### 第一批升级 - 翻译、笔记

#### 第二批升级 - 代码检查、格式化、调试、注释、编辑增强

#### 第三批升级 - 主题&UI、Markdown、会话管理

#### 第四批升级 - 符号大纲、启动页面、Telescope优化

| 原插件                        | 新插件                         | 升级原因                                          | 兼容性说明                                |
| ----------------------------- | ------------------------------ | ------------------------------------------------- | ----------------------------------------- |
| `voldikss/vim-translator`     | `uga-rosa/translate.nvim`      | 原插件停止维护，新插件是现代 Lua 实现，支持多引擎 | 保持相同快捷键 `<Leader>t` 和 `<Leader>w` |
| `vhyrro/neorg`                | `nvim-neorg/neorg`             | 插件迁移到新的官方组织，功能更完善                | 配置语法略有变化，但功能保持一致          |
| `mhartington/formatter.nvim`  | `stevearc/conform.nvim`        | 新插件性能更好，配置更简单，支持 fallback         | 保持相同快捷键 `<Leader>f`                |
| `diagnosticls-configs-nvim`   | `mfussenegger/nvim-lint`       | 现代异步 linting，更好的性能和配置                | 自动触发，无需手动配置                    |
| `Pocco81/dap-buddy.nvim`      | `jay-babu/mason-nvim-dap.nvim` | 官方 Mason 生态内的替代方案                       | 自动安装调试器，更好的集成                |
| `terrortylor/nvim-comment`    | `numToStr/Comment.nvim`        | 更现代、维护活跃、性能更好                        | 保持相同快捷键 `gcc` 和 `gc`              |
| `ggandor/lightspeed.nvim`     | `ggandor/leap.nvim`            | Leap 是 lightspeed 的继任版本                     | 快捷键从 `f/F/t/T` 改为 `s/S/gs`          |
| `norcalli/nvim-colorizer.lua` | `NvChad/nvim-colorizer.lua`    | 官方不更新，新 fork 在维护                        | 功能保持一致，配置语法略有变化            |
| `yamatsum/nvim-cursorline`    | `RRethy/vim-illuminate`        | 维护更活跃，智能高亮同名符号                      | 新增 `]]` 和 `[[` 快捷键跳转引用          |
| `npxbr/glow.nvim`             | `OXY2DEV/markview.nvim`        | markview 支持直接渲染                             | 保持 `<leader>p` 快捷键，新增实时渲染     |
| `ethanholz/nvim-lastplace` | `folke/persistence.nvim` | Persistence 还能恢复 buffers 会话 | 新增会话管理快捷键 `<leader>qs/ql/qd` |
| `simrat39/symbols-outline.nvim` | `stevearc/aerial.nvim` | 功能更强，支持 LSP + Treesitter | 新增快捷键 `<leader>a`，更丰富的导航功能 |
| `mhinz/vim-startify` | `goolord/alpha-nvim` | 新一代 dashboard，更现代化 | 保持启动页面功能，界面更美观 |
| Telescope 依赖 `popup.nvim` | 移除 `popup.nvim` 依赖 | Telescope 已内置替代功能 | 功能保持一致，减少依赖 |

#### 功能变化

**翻译功能 (translate.nvim)**:

- ✅ 保持原有快捷键不变
- ✅ 支持多种翻译引擎
- ✅ 更好的 Lua 集成
- ⚠️ 需要安装 `translate-shell` 命令行工具

**笔记功能 (neorg)**:

- ✅ 更完善的工作区管理
- ✅ 更好的 nvim-cmp 集成
- ✅ 支持导出功能
- ✅ 新增 `<Leader>n` 作为 neorg 专用前缀键

**代码格式化 (conform.nvim)**:

- ✅ 保持原有快捷键 `<Leader>f`
- ✅ 更好的性能和启动速度
- ✅ 支持 LSP fallback 格式化
- ✅ 支持多个格式化器链式调用
- ✅ 更简单的配置语法

**代码检查 (nvim-lint)**:

- ✅ 异步 linting，不阻塞编辑
- ✅ 自动触发检查（保存、进入、离开插入模式）
- ✅ 更好的错误显示和集成
- ⚠️ 需要手动安装对应的 linter 工具

**调试功能 (mason-nvim-dap)**:

- ✅ 自动安装和配置调试器
- ✅ 更好的 Mason 生态集成
- ✅ 新增调试快捷键：`<F1-F5>`, `<Leader>b`, `<Leader>du`
- ✅ 支持多种语言调试器

**注释功能 (Comment.nvim)**:

- ✅ 保持原有快捷键 `gcc` 和 `gc`
- ✅ 更好的性能和响应速度
- ✅ 支持块注释 `gbc` 和 `gb`
- ✅ 新增额外快捷键：`gcO`, `gco`, `gcA`

**快速跳转 (leap.nvim)**:

- ⚠️ 快捷键变化：`s`（向前）、`S`（向后）、`gs`（跨窗口）
- ✅ 更精确的跳转算法
- ✅ 更好的视觉反馈
- ✅ 支持跨窗口跳转

**颜色显示 (NvChad/nvim-colorizer.lua)**:

- ✅ 功能保持一致
- ✅ 更活跃的维护和更新
- ✅ 更好的性能和稳定性
- ⚠️ 配置语法略有变化

**光标高亮 (vim-illuminate)**:

- ✅ 智能高亮同名符号
- ✅ 支持 LSP、Treesitter、正则表达式多种提供者
- ✅ 新增快捷键：`]]`（下一个引用）、`[[`（上一个引用）
- ✅ 更好的性能和可配置性

**Markdown 渲染**:

- ✅ **markview.nvim**: 直接在 Neovim 内实时渲染 markdown
- ✅ 双重支持：实时渲染 + 外部预览
- ✅ 更好的 markdown 编辑体验

**会话管理 (persistence.nvim)**:
- ✅ 自动保存和恢复会话
- ✅ 恢复缓冲区、窗口布局、工作目录等
- ✅ 新增快捷键：`<leader>qs`（保存）、`<leader>ql`（加载）、`<leader>qd`（停止）
- ✅ 比简单的 lastplace 功能更强大

**符号大纲 (aerial.nvim)**:
- ✅ 支持 LSP + Treesitter 双重后端
- ✅ 新增快捷键：`<leader>a` 切换符号大纲
- ✅ 更丰富的导航功能和快捷键
- ✅ 支持浮动窗口和导航模式
- ✅ 更好的性能和可配置性

**启动页面 (alpha-nvim)**:
- ✅ 现代化的启动页面设计
- ✅ 显示插件数量和 Neovim 版本信息
- ✅ 快速访问常用功能：新建文件、查找文件、最近文件等
- ✅ 美观的 ASCII 艺术字标题
- ✅ 更好的可定制性

**Telescope 优化**:
- ✅ 移除不必要的 popup.nvim 依赖
- ✅ 减少插件依赖，提高启动速度
- ✅ 功能保持完全一致
- ✅ 更简洁的配置

---

| Module           | Plugin                                    | Stars     | Description                                   |
| ---------------- | ----------------------------------------- | --------- | --------------------------------------------- |
| ide.autocomplete | [neovim/nvim-lspconfig][1]                | ![][1001] | configurations for LSP client                 |
| ide.autocomplete | [williamboman/mason.nvim][2]              | ![][1002] | manager for LSP, DAP, linters, formatters     |
| ide.autocomplete | [williamboman/mason-lspconfig.nvim][41]   | ![][1041] | use lspconfig with mason.nvim                 |
| ide.autocomplete | [hrsh7th/nvim-cmp][37]                    | ![][1037] | official recommended completion plugin        |
| ide.autocomplete | [hrsh7th/cmp-nvim-lsp][38]                | ![][1038] | nvim-cmp source for neovim builtin LSP client |
| ide.autocomplete | [hrsh7th/cmp-buffer][39]                  | ![][1039] | nvim-cmp source for buffer words              |
| ide.autocomplete | [hrsh7th/cmp-path][40]                    | ![][1040] | nvim-cmp source for path                      |
| ide.autocomplete | [nvim-lua/lsp-status.nvim][42]            | ![][1042] | show nvim-lsp progress                        |
| ide.autocomplete | [ray-x/lsp_signature.nvim][43]            | ![][1043] | complete function parameters                  |
| ide.lint         | [mfussenegger/nvim-lint][36]              | ![][1036] | modern async linting with better performance  |
| ide.git          | [f-person/git-blame.nvim][3]              | ![][1003] | show git blame information in line            |
| ide.format       | [stevearc/conform.nvim][4]                | ![][1004] | modern formatter with better performance      |
| ide.debug        | [mfussenegger/nvim-dap][5]                | ![][1005] | Debug Adapter Protocol client                 |
| ide.debug        | [jay-babu/mason-nvim-dap.nvim][6]         | ![][1006] | install & manage debuggers with Mason         |
| ide.debug        | [rcarriga/nvim-dap-ui][7]                 | ![][1007] | A UI for nvim-dap                             |
| ide.debug        | [jbyuki/one-small-step-for-vimkind][8]    | ![][1008] | Debug adapter for Neovim plugins              |
| ide.comment      | [numToStr/Comment.nvim][9]                | ![][1009] | modern and performant comment plugin          |
| editor.enhance   | [kevinhwang91/nvim-hlslens][10]           | ![][1010] | better serarch highlighting                   |
| editor.enhance   | [ggandor/leap.nvim][11]                   | ![][1011] | modern motion plugin, successor to lightspeed |
| editor.enhance   | [karb94/neoscroll.nvim][12]               | ![][1012] | smooth scrolling                              |
| editor.enhance   | [windwp/nvim-autopairs][13]               | ![][1013] | autopairs                                     |
| editor.enhance   | [fedepujol/move.nvim][14]                 | ![][1014] | move lines and selections up and down         |
| editor.enhance   | [folke/persistence.nvim][15]              | ![][1015] | session management with buffer restoration    |
| editor.note      | [nvim-neorg/neorg][17]                    | ![][1017] | modern note-taking with org-mode features     |
| editor.tmux      | [numToStr/Navigator.nvim][18]             | ![][1018] | navigate between neovim splits and tmux panes |
| editor.translate | [uga-rosa/translate.nvim][19]             | ![][1019] | modern Lua-based translation plugin           |
| ui.theme         | [nvim-treesitter/nvim-treesitter][20]     | ![][1020] | config for highlighting of languages          |
| ui.theme         | [RRethy/nvim-treesitter-textsubjects][21] | ![][1021] | smart selection highlighting                  |
| ui.theme         | [navarasu/onedark.nvim][22]               | ![][1022] | A dark neovim colorscheme                     |
| ui.theme         | [folke/tokyonight.nvim][44]               | ![][1044] | A dark neovim colorscheme                     |
| ui.theme         | [catppuccin/nvim][45]                     | ![][1045] | A dark neovim colorscheme                     |
| ui.theme         | [rebelot/kanagawa.nvim][46]               | ![][1046] | A dark neovim colorscheme                     |
| ui.theme         | [ellisonleao/gruvbox.nvim][47]            | ![][1047] | A dark neovim colorscheme                     |
| ui.theme         | [NvChad/nvim-colorizer.lua][23]           | ![][1023] | modern colorizer with active maintenance      |
| ui.theme         | [RRethy/vim-illuminate][24]               | ![][1024] | intelligent highlighting of word under cursor |
| ui.explorer      | [kyazdani42/nvim-tree.lua][25]            | ![][1025] | file explorer                                 |
| ui.explorer      | [kyazdani42/nvim-web-devicons][26]        | ![][1026] | common icons                                  |
| ui.dashboard     | [goolord/alpha-nvim][27]                  | ![][1027] | modern and customizable start screen         |
| ui.outline       | [stevearc/aerial.nvim][28]                | ![][1028] | modern symbol outline with LSP + Treesitter  |
| ui.finder        | [nvim-telescope/telescope.nvim][29]       | ![][1029] | highly extendable fuzzy finder over lists     |
| ui.finder        | [ahmedkhalf/project.nvim][34]             | ![][1034] | change cwd to project's root                  |
| ui.quickfix      | [folke/trouble.nvim][31]                  | ![][1031] | quickfix and location list                    |
| ui.statusbar     | [nvim-lualine/lualine.nvim][32]           | ![][1032] | statusline                                    |
| ui.tab           | [akinsho/nvim-bufferline.lua][33]         | ![][1033] | tabs                                          |
| lang.markdown    | [OXY2DEV/markview.nvim][48]               | ![][1048] | real-time markdown rendering in neovim        |

[1]: https://github.com/neovim/nvim-lspconfig
[2]: https://github.com/williamboman/mason.nvim
[3]: https://github.com/f-person/git-blame.nvim
[4]: https://github.com/stevearc/conform.nvim
[5]: https://github.com/mfussenegger/nvim-dap
[6]: https://github.com/jay-babu/mason-nvim-dap.nvim
[7]: https://github.com/rcarriga/nvim-dap-ui
[8]: https://github.com/jbyuki/one-small-step-for-vimkind
[9]: https://github.com/numToStr/Comment.nvim
[10]: https://github.com/kevinhwang91/nvim-hlslens
[11]: https://github.com/ggandor/leap.nvim
[12]: https://github.com/karb94/neoscroll.nvim
[13]: https://github.com/windwp/nvim-autopairs
[14]: https://github.com/fedepujol/move.nvim
[15]: https://github.com/folke/persistence.nvim
[17]: https://github.com/nvim-neorg/neorg
[18]: https://github.com/numToStr/Navigator.nvim
[19]: https://github.com/uga-rosa/translate.nvim
[20]: https://github.com/nvim-treesitter/nvim-treesitter
[21]: https://github.com/RRethy/nvim-treesitter-textsubjects
[22]: https://github.com/navarasu/onedark.nvim
[23]: https://github.com/NvChad/nvim-colorizer.lua
[24]: https://github.com/RRethy/vim-illuminate
[25]: https://github.com/kyazdani42/nvim-tree.lua
[26]: https://github.com/kyazdani42/nvim-web-devicons
[27]: https://github.com/goolord/alpha-nvim
[28]: https://github.com/stevearc/aerial.nvim
[29]: https://github.com/nvim-telescope/telescope.nvim
[31]: https://github.com/folke/trouble.nvim
[32]: https://github.com/nvim-lualine/lualine.nvim
[33]: https://github.com/akinsho/nvim-bufferline.lua
[34]: https://github.com/ahmedkhalf/project.nvim
[48]: https://github.com/OXY2DEV/markview.nvim
[36]: https://github.com/mfussenegger/nvim-lint
[37]: https://github.com/hrsh7th/nvim-cmp
[38]: https://github.com/hrsh7th/cmp-nvim-lsp
[39]: https://github.com/hrsh7th/cmp-buffer
[40]: https://github.com/hrsh7th/cmp-path
[41]: https://github.com/williamboman/mason-lspconfig.nvim
[42]: https://github.com/nvim-lua/lsp-status.nvim
[43]: https://github.com/ray-x/lsp_signature.nvim
[44]: https://github.com/folke/tokyonight.nvim
[45]: https://github.com/catppuccin/nvim
[46]: https://github.com/rebelot/kanagawa.nvim
[47]: https://github.com/ellisonleao/gruvbox.nvim
[1001]: https://img.shields.io/github/stars/neovim/nvim-lspconfig
[1002]: https://img.shields.io/github/stars/williamboman/mason.nvim
[1003]: https://img.shields.io/github/stars/f-person/git-blame.nvim
[1004]: https://img.shields.io/github/stars/stevearc/conform.nvim
[1005]: https://img.shields.io/github/stars/mfussenegger/nvim-dap
[1006]: https://img.shields.io/github/stars/jay-babu/mason-nvim-dap.nvim
[1007]: https://img.shields.io/github/stars/rcarriga/nvim-dap-ui
[1008]: https://img.shields.io/github/stars/jbyuki/one-small-step-for-vimkind
[1009]: https://img.shields.io/github/stars/numToStr/Comment.nvim
[1010]: https://img.shields.io/github/stars/kevinhwang91/nvim-hlslens
[1011]: https://img.shields.io/github/stars/ggandor/leap.nvim
[1012]: https://img.shields.io/github/stars/karb94/neoscroll.nvim
[1013]: https://img.shields.io/github/stars/windwp/nvim-autopairs
[1014]: https://img.shields.io/github/stars/fedepujol/move.nvim
[1015]: https://img.shields.io/github/stars/folke/persistence.nvim
[1017]: https://img.shields.io/github/stars/nvim-neorg/neorg
[1018]: https://img.shields.io/github/stars/numToStr/Navigator.nvim
[1019]: https://img.shields.io/github/stars/uga-rosa/translate.nvim
[1020]: https://img.shields.io/github/stars/nvim-treesitter/nvim-treesitter
[1021]: https://img.shields.io/github/stars/RRethy/nvim-treesitter-textsubjects
[1022]: https://img.shields.io/github/stars/navarasu/onedark.nvim
[1023]: https://img.shields.io/github/stars/NvChad/nvim-colorizer.lua
[1024]: https://img.shields.io/github/stars/RRethy/vim-illuminate
[1025]: https://img.shields.io/github/stars/kyazdani42/nvim-tree.lua
[1026]: https://img.shields.io/github/stars/kyazdani42/nvim-web-devicons
[1027]: https://img.shields.io/github/stars/goolord/alpha-nvim
[1028]: https://img.shields.io/github/stars/stevearc/aerial.nvim
[1029]: https://img.shields.io/github/stars/nvim-telescope/telescope.nvim
[1031]: https://img.shields.io/github/stars/folke/trouble.nvim
[1032]: https://img.shields.io/github/stars/nvim-lualine/lualine.nvim
[1033]: https://img.shields.io/github/stars/akinsho/nvim-bufferline.lua
[1034]: https://img.shields.io/github/stars/ahmedkhalf/project.nvim
[1048]: https://img.shields.io/github/stars/OXY2DEV/markview.nvim
[1036]: https://img.shields.io/github/stars/mfussenegger/nvim-lint
[1037]: https://img.shields.io/github/stars/hrsh7th/nvim-cmp
[1038]: https://img.shields.io/github/stars/hrsh7th/cmp-nvim-lsp
[1039]: https://img.shields.io/github/stars/hrsh7th/cmp-buffer
[1040]: https://img.shields.io/github/stars/hrsh7th/cmp-path
[1041]: https://img.shields.io/github/stars/williamboman/mason-lspconfig.nvim
[1042]: https://img.shields.io/github/stars/nvim-lua/lsp-status.nvim
[1043]: https://img.shields.io/github/stars/ray-x/lsp_signature.nvim
[1044]: https://img.shields.io/github/stars/folke/tokyonight.nvim
[1045]: https://img.shields.io/github/stars/catppuccin/nvim
[1046]: https://img.shields.io/github/stars/rebelot/kanagawa.nvim
[1047]: https://img.shields.io/github/stars/ellisonleao/gruvbox.nvim
