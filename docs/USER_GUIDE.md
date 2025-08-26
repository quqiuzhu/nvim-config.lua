# Neovim 配置用户使用指南

## 简介

这是一个现代化的 Neovim 配置，专为提高编程效率而设计。配置继承了 SpaceVim 的使用习惯，提供了完整的 IDE 功能，支持多种编程语言的开发环境。

## 系统要求

- **Neovim**: 0.5.0 或更高版本
- **Git**: 用于克隆仓库和插件管理
- **Node.js**: 某些 LSP 服务器需要
- **Python**: 某些插件需要
- **Ripgrep**: 用于文件搜索（推荐）
- **字体**: 支持图标的字体（如 Nerd Fonts）

## 安装指南

### 方法一：直接安装

1. **备份现有配置**（如果有）：

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **克隆配置**：

   ```bash
   git clone --recurse-submodules https://github.com/your-repo/nvim-config.lua ~/.config/nvim
   ```

3. **启动 Neovim**：

   ```bash
   nvim
   ```

   首次启动会自动安装插件，请耐心等待。

4. **安装格式化工具**（可选）：
   - clang-format（C/C++）
   - prettier（JavaScript/TypeScript）
   - black（Python）
   - rustfmt（Rust）

### 方法二：Docker 环境（推荐用于试用）

1. **克隆仓库**：

   ```bash
   git clone --recurse-submodules https://github.com/your-repo/nvim-config.lua /path/to/nvim-config
   cd /path/to/nvim-config
   ```

2. **构建 Docker 镜像**：

   ```bash
   make build
   ```

3. **启动开发环境**：
   ```bash
   make dev dir=/path/to/your/code
   ```

## 核心功能

### 1. 文件管理

#### 文件浏览器 (nvim-tree)

- **自动打开**：启动时自动显示文件树
- **Git 集成**：显示文件的 Git 状态
- **项目根目录**：自动切换到项目根目录

#### 启动页面 (startify)

- **最近文件**：显示最近编辑的文件
- **会话管理**：自动保存和恢复会话
- **书签功能**：快速访问常用目录

### 2. 代码编辑

#### 智能补全 (nvim-cmp + LSP)

- **语法感知**：基于 LSP 的智能补全
- **代码片段**：支持自定义代码片段
- **多源补全**：文件路径、缓冲区内容、LSP 等

#### 语法高亮 (Treesitter)

- **精确高亮**：基于语法树的精确高亮
- **代码折叠**：智能代码折叠
- **文本对象**：智能文本选择

#### 代码格式化

- **自动格式化**：保存时自动格式化
- **多语言支持**：支持主流编程语言
- **自定义规则**：可配置格式化规则

### 3. 搜索和导航

#### 模糊查找 (Telescope)

- **文件查找**：快速查找项目文件
- **内容搜索**：全项目文本搜索
- **符号搜索**：查找函数、变量等符号

#### 代码导航

- **跳转定义**：快速跳转到定义
- **查找引用**：查找符号的所有引用
- **符号大纲**：显示文件符号结构

### 4. Git 集成

- **Git 状态**：实时显示文件的 Git 状态
- **Git 责任**：显示代码的提交信息
- **差异显示**：高亮显示代码变更

### 5. 调试功能

- **断点管理**：设置和管理断点
- **变量查看**：查看变量值
- **调用栈**：显示函数调用栈

## 快捷键映射

> 注意：默认 Leader 键是 `\`

### 窗口管理

| 快捷键  | 功能           |
| ------- | -------------- |
| `<Tab>` | 切换窗口       |
| `<C-h>` | 切换到左侧窗口 |
| `<C-j>` | 切换到下方窗口 |
| `<C-k>` | 切换到上方窗口 |
| `<C-l>` | 切换到右侧窗口 |

### 缓冲区管理

| 快捷键        | 功能               |
| ------------- | ------------------ |
| `<Leader>1-9` | 切换到指定缓冲区   |
| `<Leader>ml`  | 向右移动当前缓冲区 |
| `<Leader>mh`  | 向左移动当前缓冲区 |
| `<Leader>dp`  | 选择并删除缓冲区   |
| `<Leader>dh`  | 删除左侧缓冲区     |
| `<Leader>dl`  | 删除右侧缓冲区     |

### 文件浏览器

| 快捷键    | 功能              |
| --------- | ----------------- |
| `<C-n>`   | 切换文件树显示    |
| `<C-r>`   | 刷新文件树        |
| `<Enter>` | 打开文件/目录     |
| `l`       | 打开文件/展开目录 |
| `h`       | 关闭目录          |
| `r`       | 重命名文件        |
| `N`       | 新建文件/目录     |
| `d`       | 删除文件          |
| `c`       | 复制文件名        |
| `y`       | 复制文件          |
| `x`       | 剪切文件          |
| `p`       | 粘贴文件          |
| `-`       | 返回上级目录      |

### 搜索和查找

| 快捷键  | 功能         |
| ------- | ------------ |
| `ff`    | 查找文件     |
| `<C-p>` | 全文搜索     |
| `fg`    | 全文搜索     |
| `fb`    | 查找缓冲区   |
| `fh`    | 查找帮助文档 |
| `fk`    | 查找快捷键   |
| `fc`    | 查找命令     |
| `fa`    | 查找自动命令 |
| `fm`    | 查找手册页   |

### 代码编辑

| 快捷键      | 功能                  |
| ----------- | --------------------- |
| `<C-Space>` | 触发补全              |
| `<Tab>`     | 选择补全项            |
| `<Enter>`   | 确认补全              |
| `gd`        | 跳转到定义            |
| `gi`        | 跳转到实现            |
| `gr`        | 查找引用              |
| `<Leader>f` | 格式化代码            |
| `gcc`       | 注释/取消注释行       |
| `gc`        | 注释/取消注释选中内容 |

### 文本对象和移动

| 快捷键  | 功能                       |
| ------- | -------------------------- |
| `.`     | 智能选择文本对象           |
| `;`     | 智能选择外层文本对象       |
| `<C-h>` | 向左移动代码块（可视模式） |
| `<C-j>` | 向下移动代码块（可视模式） |
| `<C-k>` | 向上移动代码块（可视模式） |
| `<C-l>` | 向右移动代码块（可视模式） |

### 翻译功能

| 快捷键      | 功能               |
| ----------- | ------------------ |
| `<Leader>t` | 在命令行翻译选中词 |
| `<Leader>w` | 在窗口中翻译选中词 |

### 快速修复

| 快捷键       | 功能                 |
| ------------ | -------------------- |
| `<Leader>xx` | 打开文档诊断窗口     |
| `<Leader>xw` | 打开工作区诊断窗口   |
| `<Esc>`      | 返回编辑窗口         |
| `q`          | 关闭快速修复窗口     |
| `o`          | 跳转到问题并关闭窗口 |
| `r`          | 刷新快速修复窗口     |
| `m`          | 切换文档/工作区模式  |

## 支持的编程语言

### 内置支持

- **Lua**: 完整的 LSP 支持
- **C/C++**: clangd LSP 服务器
- **Go**: gopls LSP 服务器
- **Rust**: rust-analyzer LSP 服务器
- **Python**: pylyzer LSP 服务器
- **JavaScript/TypeScript**: denols LSP 服务器
- **Java**: jdtls LSP 服务器
- **LaTeX**: texlab LSP 服务器

### 添加新语言支持

1. 使用 Mason 安装 LSP 服务器：

   ```vim
   :LspInstall <language>
   ```

2. 对于某些语言（如 C++），需要在项目根目录添加配置文件：
   - `compile_commands.json` 或
   - `compile_flags.txt`

## 主题配置

### 可用主题

- **onedark** (默认)
- **tokyonight** (tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon)
- **catppuccin** (catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha)
- **kanagawa** (kanagawa-wave, kanagawa-dragon, kanagawa-lotus)
- **gruvbox**

### 切换主题

```vim
:colorscheme tokyonight
:colorscheme catppuccin-mocha
:colorscheme kanagawa
:colorscheme gruvbox
```

## 自定义配置

### LSP 服务器配置

可以通过设置全局变量来自定义 LSP 服务器：

```lua
-- 在 init.lua 中添加
vim.g.lsp_server_configs = {
    clangd = {
        cmd = {"clangd", "--background-index", "--clang-tidy"},
        filetypes = {"c", "cpp", "objc", "objcpp"},
    },
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    },
}
```

### 自定义快捷键

```lua
-- 在 init.lua 中添加
vim.keymap.set('n', '<Leader>custom', ':echo "Custom command"<CR>', {silent = true})
```

## 常见问题

### Q: 插件安装失败

**A**: 检查网络连接，或尝试使用代理。也可以手动删除 `~/.local/share/nvim` 目录后重新启动。

### Q: LSP 不工作

**A**:

1. 检查是否安装了对应的语言服务器：`:LspInfo`
2. 确保项目有正确的配置文件（如 C++ 的 compile_commands.json）
3. 重启 LSP 服务器：`:LspRestart`

### Q: 字体图标显示异常

**A**: 安装支持图标的字体，如 [Nerd Fonts](https://www.nerdfonts.com/)。

### Q: 性能问题

**A**:

1. 检查是否有大文件导致的性能问题
2. 禁用不需要的插件
3. 调整 Treesitter 的解析器设置

### Q: 翻译功能不工作

**A**: 检查网络连接，翻译功能需要访问在线翻译服务。

## 高级功能

### 会话管理

- 自动保存会话状态
- 启动时恢复上次会话
- 支持多项目会话切换

### 项目管理

- 自动检测项目根目录
- 支持多种项目类型（Git、Makefile、package.json 等）
- 项目间快速切换

### 代码片段

- 支持自定义代码片段
- 智能参数填充
- 多语言片段支持

### 调试集成

- 支持多种调试器
- 可视化调试界面
- 断点和变量管理

## 更新和维护

### 更新配置

```bash
cd ~/.config/nvim
git pull --recurse-submodules
```

### 更新插件

```vim
:Lazy update
```

### 清理缓存

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
```

## 获取帮助

- **内置帮助**：`:help` 或 `<F1>`
- **插件文档**：`:help <plugin-name>`
- **键位映射**：`:map` 查看所有映射
- **健康检查**：`:checkhealth` 检查配置状态

## 贡献和反馈

如果您发现问题或有改进建议，欢迎：

1. 提交 Issue
2. 发送 Pull Request
3. 参与讨论

---

_享受高效的 Neovim 编程体验！_
