# Neovim 配置开发文档

## 项目概述

这是一个基于 Lua 的现代化 Neovim 配置项目，采用模块化设计，支持多种编程语言的开发环境。项目继承了 SpaceVim 的使用习惯，并使用 lazy.nvim 作为插件管理器。

## 项目架构

### 目录结构

```
nvim-config.lua/
├── .devcontainer/          # Docker 开发环境配置
├── init.lua               # Neovim 入口文件
├── lua/                   # Lua 配置文件目录
│   ├── common/            # 通用模块
│   │   ├── config.lua     # 配置管理
│   │   ├── event.lua      # 事件处理
│   │   ├── manager.lua    # 插件管理器
│   │   ├── mapping.lua    # 键位映射
│   │   └── option.lua     # Vim 选项设置
│   ├── editor/            # 编辑器增强功能
│   │   ├── enhance.lua    # 编辑增强
│   │   ├── note.lua       # 笔记功能
│   │   ├── tmux.lua       # Tmux 集成
│   │   └── translate.lua  # 翻译功能
│   ├── ide/               # IDE 功能
│   │   ├── autocomplete.lua # 自动补全
│   │   ├── comment.lua    # 注释功能
│   │   ├── debug.lua      # 调试功能
│   │   ├── format.lua     # 代码格式化
│   │   ├── git.lua        # Git 集成
│   │   └── lint.lua       # 代码检查
│   ├── lang/              # 语言特定配置
│   │   └── markdown.lua   # Markdown 支持
│   ├── main.lua           # 主配置文件
│   └── ui/                # 用户界面
│       ├── explorer.lua   # 文件浏览器
│       ├── finder.lua     # 文件查找
│       ├── outline.lua    # 代码大纲
│       ├── quickfix.lua   # 快速修复
│       ├── statusbar.lua  # 状态栏
│       ├── tab.lua        # 标签页
│       ├── terminal.lua   # 终端
│       └── theme.lua      # 主题配置
└── prompts/               # 文档目录
```

### 核心设计模式

#### 1. 模块化架构

每个功能模块都遵循统一的接口设计：

```lua
local module = {}
module.__index = module

function module:new()
    local o = {}
    setmetatable(o, {__index = self})
    return o
end

function module:plugins()
    -- 返回插件配置数组
end

function module:config()
    -- 模块特定配置
end

function module:mapping()
    -- 键位映射配置
end

return module
```

#### 2. 插件管理机制

使用 `common/manager.lua` 统一管理所有插件：

- **插件收集**：遍历所有模块，收集插件配置
- **依赖管理**：使用 lazy.nvim 处理插件依赖关系
- **配置应用**：统一调用各模块的配置方法

#### 3. 配置分层

1. **全局配置**：`common/option.lua` - Vim 基础选项
2. **模块配置**：各模块的 `config()` 方法
3. **插件配置**：插件的 `setup()` 函数

## 核心模块详解

### Common 模块

#### Manager (插件管理器)

负责整个配置的生命周期管理：

```lua
local m = manager:new(module_names)
m:init()          -- 初始化插件管理器和模块
m:set_configs()   -- 应用模块配置
m:load_plugins()  -- 加载插件
```

#### Config (配置管理)

提供跨平台配置支持：

- 系统检测（macOS/Linux/Windows）
- 路径管理
- 变量和选项设置

#### Mapping (键位映射)

统一的键位映射管理：

- 链式调用 API
- 支持全局和缓冲区级别映射
- 标准化的选项设置

### IDE 模块

#### Autocomplete (自动补全)

基于 LSP 的智能补全系统：

- **Mason**: LSP 服务器管理
- **nvim-cmp**: 补全引擎
- **LuaSnip**: 代码片段
- 支持多种补全源：LSP、缓冲区、路径、代码片段

#### Format & Lint

代码质量保证：

- 格式化工具集成
- 实时代码检查
- 支持多语言

### UI 模块

#### Explorer (文件浏览器)

基于 nvim-tree 的文件管理：

- 自定义键位映射
- Git 状态显示
- 自动打开和关闭逻辑

#### Finder (模糊查找)

基于 Telescope 的查找系统：

- 文件查找
- 内容搜索
- 项目管理集成

#### Theme (主题系统)

- 多主题支持：onedark、tokyonight、catppuccin 等
- Treesitter 语法高亮
- 颜色显示和光标行高亮

## 开发指南

### 添加新模块

1. 在相应目录创建模块文件
2. 实现标准接口（new、plugins、config、mapping）
3. 在 `main.lua` 中注册模块

### 添加新插件

1. 在对应模块的 `plugins()` 方法中添加插件配置
2. 在 `config()` 方法中添加插件设置
3. 在 `mapping()` 方法中添加相关键位映射

### 自定义配置

可以通过设置全局变量来自定义 LSP 服务器配置：

```lua
vim.g.lsp_server_configs = {
    clangd = {
        cmd = {"clangd", "--background-index"},
        -- 其他配置
    }
}
```

### 调试和测试

1. 使用 Docker 环境进行隔离测试
2. 检查插件加载状态：`:Lazy`
3. 查看 LSP 状态：`:LspInfo`
4. 检查键位映射：`:map`

## 构建和部署

### Docker 开发环境

```bash
# 构建镜像
make build

# 启动开发环境
make dev dir=/path/to/your/code
```

### 代码格式化

```bash
# 格式化 Lua 代码
make fmt
```

## 技术栈

- **Neovim**: 0.5.0+
- **Lua**: 配置语言
- **lazy.nvim**: 插件管理器
- **Mason**: LSP/DAP/Linter/Formatter 管理
- **Telescope**: 模糊查找
- **Treesitter**: 语法高亮
- **nvim-cmp**: 自动补全

## 性能优化

1. **延迟加载**：使用 lazy.nvim 的延迟加载机制
2. **禁用内置插件**：禁用不需要的 Vim 内置插件
3. **模块化设计**：按需加载功能模块
4. **缓存优化**：合理使用缓存机制

## 贡献指南

1. Fork 项目
2. 创建功能分支
3. 遵循现有代码风格
4. 添加必要的文档
5. 提交 Pull Request

## 故障排除

### 常见问题

1. **插件加载失败**：检查网络连接和插件仓库地址
2. **LSP 不工作**：确保安装了对应的语言服务器
3. **键位冲突**：检查键位映射配置
4. **性能问题**：检查插件配置和延迟加载设置

### 日志和调试

- Neovim 日志：`:messages`
- LSP 日志：`:LspLog`
- 插件状态：`:Lazy`
- 健康检查：`:checkhealth`
