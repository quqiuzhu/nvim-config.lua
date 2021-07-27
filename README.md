# nvim-config.lua

Before this project, I am using [SpaceVim][spacevim], So I inherit habits and borrow ideas from it.
When install is done, restart nvim to use.

## Mapping

Keymaps should be short, and you dont need too many keymaps, the core keymaps may be shared across editors.

Window & Buffer

| Mode   | Key Bindings | Descriptions                          |
| ------ | ------------ | ------------------------------------- |
| Normal | `<Tab>`      | Switch window                         |
| Normal | `<Leader> N` | Switch to buffer N, N in range [1, 9] |
| Normal | `bd`         | Delete current buffer                 |

File Tree

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
| Normal | `h`          | Close node (valid in tree)                |
| Normal | `l`          | Open node (valid in tree)                 |
| Normal | `-`          | Change dir to parent (valid in tree)      |

Search

| Mode   | Key Bindings | Descriptions       |
| ------ | ------------ | ------------------ |
| Normal | `<C-f>`      | Find files by name |
| Normal | `<C-p>`      | Fly grep           |
| Normal | `<C-h>`      | Find help tags     |

LSP

| Mode   | Key Bindings | Descriptions         |
| ------ | ------------ | -------------------- |
| Insert | `<C-Space>`  | Complete             |
| Insert | `<Tab>`      | Complete Select item |
| Insert | `<Cr>`       | Complete confirm     |
| Normal | `gd`         | Goto definition      |
| Normal | `gi`         | Goto implemention    |
| Normal | `gr`         | Goto references      |

## Languages

Run `:LspInstall cpp` to install cpp language server, and other supported [language servers][lsp-servers].

The docker image support languages.

- lua
- cpp
- golang
- rust

[spacevim]: https://github.com/SpaceVim/SpaceVim
[lsp-servers]: https://github.com/kabouzeid/nvim-lspinstall#bundled-installers
