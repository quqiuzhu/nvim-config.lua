# 插件升级指南

## 概述

本文档记录了 Neovim 配置中插件的升级过程和变化说明，帮助用户了解升级后的功能变化和使用方法。

## 2025-01-16 升级记录

### 升级的插件

#### 1. 翻译插件升级

**从**: `voldikss/vim-translator` → **到**: `uga-rosa/translate.nvim`

**升级原因**:
- 原插件 `vim-translator` 已停止维护
- 新插件是现代 Lua 实现，性能更好
- 支持更多翻译引擎和配置选项
- 更好的 Neovim 集成

**兼容性保证**:
- ✅ 保持相同的快捷键映射
- ✅ 功能行为基本一致
- ⚠️ 需要额外安装依赖工具

#### 2. 笔记插件升级

**从**: `vhyrro/neorg` → **到**: `nvim-neorg/neorg`

**升级原因**:
- 插件迁移到官方组织维护
- 更活跃的社区支持
- 功能更加完善和稳定
- 更好的文档和生态

**兼容性保证**:
- ✅ 核心功能保持一致
- ✅ 文件格式完全兼容
- ⚠️ 配置语法有轻微变化

## 详细变化说明

### 翻译功能 (translate.nvim)

#### 新功能特性

1. **多引擎支持**:
   - 支持 Google Translate
   - 支持 DeepL
   - 支持本地翻译工具
   - 可配置默认引擎

2. **输出方式**:
   - 命令行输出（原 `<Leader>t` 功能）
   - 分割窗口输出（原 `<Leader>w` 功能）
   - 浮动窗口输出
   - 替换原文本

3. **配置选项**:
   ```lua
   require('translate').setup({
       default = {
           command = 'translate_shell',  -- 默认翻译命令
       },
       preset = {
           output = {
               split = {
                   append = true,
                   min_size = 5,
               },
           },
       },
   })
   ```

#### 快捷键映射（保持不变）

| 快捷键 | 模式 | 功能 | 变化说明 |
|--------|------|------|----------|
| `<Leader>t` | Normal/Visual | 翻译到命令行 | 功能保持一致 |
| `<Leader>w` | Normal/Visual | 翻译到窗口 | 现在使用分割窗口 |

#### 安装要求

**必需依赖**:
```bash
# 安装 translate-shell
# macOS
brew install translate-shell

# Ubuntu/Debian
sudo apt install translate-shell

# Arch Linux
sudo pacman -S translate-shell
```

#### 使用方法

1. **翻译单词**:
   - 将光标放在单词上
   - 按 `<Leader>t` 在命令行显示翻译
   - 按 `<Leader>w` 在分割窗口显示翻译

2. **翻译选中文本**:
   - 选中要翻译的文本
   - 按 `<Leader>t` 或 `<Leader>w`

### 笔记功能 (neorg)

#### 新功能特性

1. **工作区管理**:
   ```lua
   workspaces = {
       notes = '~/notes',      -- 个人笔记
       work = '~/work-notes',  -- 工作笔记
   },
   default_workspace = 'notes',
   ```

2. **自动补全集成**:
   - 与 nvim-cmp 深度集成
   - 支持标签、链接、任务等补全
   - 智能语法补全

3. **导出功能**:
   - 支持导出为 Markdown
   - 支持导出为 HTML
   - 支持导出为 PDF

4. **新的快捷键前缀**:
   - `<Leader>n` 作为 neorg 专用前缀
   - 更好的功能组织

#### 配置变化

**旧配置**:
```lua
{
    'vhyrro/neorg',
    lazy = false,
    version = '*',
    config = true
}
```

**新配置**:
```lua
{
    'nvim-neorg/neorg',
    dependencies = { 'nvim-lua/plenary.nvim' },
    build = ':Neorg sync-parsers',
    ft = 'norg',
    cmd = 'Neorg',
    keys = {
        {'<Leader>n', desc = 'Neorg commands'}
    },
    config = setup
}
```

#### 主要命令

| 命令 | 功能 |
|------|------|
| `:Neorg workspace notes` | 切换到笔记工作区 |
| `:Neorg workspace work` | 切换到工作工作区 |
| `:Neorg index` | 打开当前工作区索引 |
| `:Neorg export` | 导出当前文件 |
| `:Neorg sync-parsers` | 同步语法解析器 |

#### 文件结构建议

```
~/notes/
├── index.norg          # 主索引文件
├── daily/              # 日记目录
│   ├── 2025-01-16.norg
│   └── ...
├── projects/           # 项目笔记
│   ├── project-a.norg
│   └── project-b.norg
└── reference/          # 参考资料
    ├── books.norg
    └── articles.norg
```

## 迁移指南

### 翻译功能迁移

1. **安装依赖**:
   ```bash
   brew install translate-shell  # macOS
   ```

2. **测试功能**:
   - 打开任意文件
   - 将光标放在英文单词上
   - 按 `<Leader>t` 测试翻译

3. **自定义配置**（可选）:
   ```lua
   -- 在 init.lua 中添加
   vim.g.translate_config = {
       default_engine = 'google',
       target_lang = 'zh-CN'
   }
   ```

### 笔记功能迁移

1. **创建工作区目录**:
   ```bash
   mkdir -p ~/notes ~/work-notes
   ```

2. **创建索引文件**:
   ```bash
   touch ~/notes/index.norg
   ```

3. **测试功能**:
   - 运行 `:Neorg workspace notes`
   - 创建新的 `.norg` 文件
   - 测试语法高亮和补全

## 故障排除

### 翻译功能问题

**问题**: 翻译不工作
**解决方案**:
1. 检查是否安装了 `translate-shell`
2. 测试命令行: `trans hello`
3. 检查网络连接

**问题**: 翻译结果乱码
**解决方案**:
1. 检查终端编码设置
2. 确保 Neovim 使用 UTF-8 编码

### 笔记功能问题

**问题**: 语法高亮不工作
**解决方案**:
1. 运行 `:Neorg sync-parsers`
2. 重启 Neovim
3. 检查文件扩展名是否为 `.norg`

**问题**: 补全不工作
**解决方案**:
1. 确保 nvim-cmp 正常工作
2. 检查 neorg 是否正确加载
3. 重新加载配置

## 回滚指南

如果升级后遇到问题，可以临时回滚到旧版本：

### 回滚翻译插件

```lua
-- 在对应模块中临时替换
{
    'voldikss/vim-translator',
    init = function()
        -- 旧的配置代码
    end
}
```

### 回滚笔记插件

```lua
-- 在对应模块中临时替换
{
    'vhyrro/neorg',
    lazy = false,
    version = '*',
    config = true
}
```

## 未来升级计划

根据插件升级建议，后续还将升级以下插件：

1. **编辑增强**: `lightspeed.nvim` → `leap.nvim`
2. **注释功能**: `nvim-comment` → `Comment.nvim`
3. **文件浏览**: `nvim-tree` → `neo-tree` 或 `oil.nvim`
4. **代码格式化**: `formatter.nvim` → `conform.nvim`
5. **启动页面**: `vim-startify` → `alpha-nvim`

每次升级都会遵循相同的原则：
- 保持用户习惯
- 详细记录变化
- 提供迁移指南
- 支持回滚方案

---

*最后更新: 2025-01-16*