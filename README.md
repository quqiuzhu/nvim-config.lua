# nvim-config.lua

Before this project, I am using [SpaceVim][spacevim], So I inherit habits and borrow ideas from it.

## Installl

First, clone this project and submodules to you computer, and link to your nvim config path(~/.config/nvim)

```
> git clone --recurse-submodules project/path/nvim-config.lua /your/path
> ln -s /your/path ~/.config/nvim
```

Then install packages by type `nvim` command, when install is done, restart nvim to use.

Formatters are not installed, please reference the [Dockerfile][dockerfile] to install [clang-format][clang-format],
[prettier][prettier] and other formaters.

## Mapping

Keymaps should be short, and you don't need too many of them, the core keymaps may be shared across editors.

### Window & Buffer

| Mode   | Key Bindings | Descriptions                          |
| ------ | ------------ | ------------------------------------- |
| Normal | `<Tab>`      | Switch window                         |
| Normal | `<Leader>N`  | Switch to buffer N, N in range [1, 9] |
| Normal | `<Leader>d`  | Select and delete buffer              |

### File Explorer

| Mode   | Key Bindings | Descriptions                              |
| ------ | ------------ | ----------------------------------------- |
| Normal | `<C-n>`      | Toggle file tree (valid in buffer & tree) |
| Normal | `<C-r>`      | Refresh file tree (valid in buffer)       |
| Normal | `<Cr>`       | Edit file (valid in tree)                 |
| Normal | `r`          | Rename file (valid in tree)               |
| Normal | `c`          | Copy file name (valid in tree)            |
| Normal | `y`          | Copy file (valid in tree)                 |
| Normal | `x`          | Cut file (valid in tree)                  |
| Normal | `d`          | Remove file (valid in tree)               |
| Normal | `N`          | New file or directory (valid in tree)     |
| Normal | `h`          | Close node (valid in tree)                |
| Normal | `l`          | Open node (valid in tree)                 |
| Normal | `-`          | Change dir to parent (valid in tree)      |

### Search

| Mode   | Key Bindings | Descriptions       |
| ------ | ------------ | ------------------ |
| Normal | `<C-f>`      | Find files by name |
| Normal | `<C-p>`      | Fly grep           |
| Normal | `<C-h>`      | Find help tags     |

### Complete

| Mode   | Key Bindings | Descriptions         |
| ------ | ------------ | -------------------- |
| Insert | `<C-Space>`  | Complete             |
| Insert | `<Tab>`      | Complete Select item |
| Insert | `<Cr>`       | Complete confirm     |
| Normal | `gd`         | Goto definition      |
| Normal | `gi`         | Goto implemention    |
| Normal | `gr`         | Goto references      |

## Language

Run `:LspInstall cpp` to install cpp language server, and other supported [language servers][lsp-servers].

The docker image support languages.

- lua
- cpp
- golang
- rust

Note: LspInstall don't means all, some language server should be configured further, such as [clangd][clangd]
for cpp. clangd need you put a `compile_commands.json` or `compile_flags.txt` in project root, so that the
language server know where to find and reference.

### Formatter

### Linter

[spacevim]: https://github.com/SpaceVim/SpaceVim
[lsp-servers]: https://github.com/kabouzeid/nvim-lspinstall#bundled-installers
[dockerfile]: Dockerfile
[clang-format]: https://clang.llvm.org/docs/ClangFormat.html
[prettier]: https://prettier.io
[clangd]: https://clangd.llvm.org/installation.html
