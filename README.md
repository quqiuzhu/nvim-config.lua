# nvim-config.lua

Before this project, I was using [SpaceVim][spacevim], So I inherit habits and borrow ideas from it.

## Try

The project is working in progress, you can try it by the docker image

```
> git clone --recurse-submodules project/path/nvim-config.lua /your/path
> cd /your/path
> make dev dir=/your/code/explore/dir
```

Then you'll in a docker instance, run `nvim` to install packages, when install is done, quit nvim by
type `:q` and run `nvim` again to experience.

## Installl

Requires neovim 0.5.0+.

First, clone this project and submodules to you computer, and link to your nvim config path(~/.config/nvim)

```
> git clone --recurse-submodules project/path/nvim-config.lua /your/path
> ln -s /your/path ~/.config/nvim
```

Then install packages by type `nvim` command, when install is done, restart nvim to use.

Formatters are not installed, please reference the [Dockerfile][dockerfile] to install [clang-format][clang-format],
[prettier][prettier] and other formaters.

## Design

TODO

## Mapping

Keymaps should be short, and you don't need too many of them, the core keymaps may be shared across editors.

| Module        | Mode   | Key Bindings | Descriptions                              |
| ------------- | ------ | ------------ | ----------------------------------------- |
| Window        | Normal | `<Tab>`      | Switch window                             |
| Buffer        | Normal | `<Leader>N`  | Switch to buffer N, N in range [1, 9]     |
| Buffer        | Normal | `<Leader>d`  | Select and delete buffer                  |
| File Explorer | Normal | `<C-n>`      | Toggle file tree (valid in buffer & tree) |
| File Explorer | Normal | `<C-r>`      | Refresh file tree (valid in buffer)       |
| File Explorer | Normal | `<Cr>`       | Edit file (valid in tree)                 |
| File Explorer | Normal | `r`          | Rename file (valid in tree)               |
| File Explorer | Normal | `c`          | Copy file name (valid in tree)            |
| File Explorer | Normal | `y`          | Copy file (valid in tree)                 |
| File Explorer | Normal | `x`          | Cut file (valid in tree)                  |
| File Explorer | Normal | `d`          | Remove file (valid in tree)               |
| File Explorer | Normal | `N`          | New file or directory (valid in tree)     |
| File Explorer | Normal | `h`          | Close node (valid in tree)                |
| File Explorer | Normal | `l`          | Open node (valid in tree)                 |
| File Explorer | Normal | `-`          | Change dir to parent (valid in tree)      |
| Search        | Normal | `ff`         | Find files by name                        |
| Search        | Normal | `<C-p>`      | Fly grep                                  |
| Search        | Normal | `fp`         | Fly grep                                  |
| Search        | Normal | `fh`         | Find help tags                            |
| Complete      | Insert | `<C-Space>`  | Complete                                  |
| Complete      | Insert | `<Tab>`      | Complete Select item                      |
| Complete      | Insert | `<Cr>`       | Complete confirm                          |
| Complete      | Normal | `gd`         | Goto definition                           |
| Complete      | Normal | `gi`         | Goto implemention                         |
| Complete      | Normal | `gr`         | Goto references                           |
| Format        | Normal | `<Leader>f`  | Format buffer code                        |
| Comment       | Normal | `gcc`        | Comment line code                         |
| Comment       | Visual | `gc`         | Comment visual line code operator         |
| Text Object   | Visual | `.`          | Smart select text object                  |
| Text Object   | Visual | `;`          | Smart select outer text object            |
| Text Object   | Visual | `<C-h>`      | Move block left                           |
| Text Object   | Visual | `<C-l>`      | Move block right                          |
| Text Object   | Visual | `<C-k>`      | Move block up                             |
| Text Object   | Visual | `<C-j>`      | Move block down                           |

Note: default leader is `\`.

## Command & AutoCommand

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
