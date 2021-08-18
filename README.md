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

| Module        | Mode   | Key Bindings   | Descriptions                                 |
| ------------- | ------ | -------------- | -------------------------------------------- |
| Window        | Normal | `<Tab>`        | Switch window                                |
| Window        | Normal | `<C-h>`        | Switch focus to left side window             |
| Window        | Normal | `<C-j>`        | Switch focus to up side window               |
| Window        | Normal | `<C-k>`        | Switch focus to down side window             |
| Window        | Normal | `<C-l>`        | Switch focus to right side window            |
| Buffer        | Normal | `<Leader>N`    | Switch to buffer N, N in range [1, 9]        |
| Buffer        | Normal | `<Leader>ml`   | Move current buffer right                    |
| Buffer        | Normal | `<Leader>mh`   | Move current buffer left                     |
| Buffer        | Normal | `<Leader>dp`   | Pick and delete selected buffer              |
| Buffer        | Normal | `<Leader>dh`   | Delete left buffer                           |
| Buffer        | Normal | `<Leader>dl`   | Delete right buffers                         |
| File Explorer | Normal | `<C-n>`        | Toggle file tree (valid in buffer & tree)    |
| File Explorer | Normal | `<C-r>`        | Refresh file tree (valid in buffer)          |
| File Explorer | Normal | `<Cr>`         | Edit file (valid in tree)                    |
| File Explorer | Normal | `r`            | Rename file (valid in tree)                  |
| File Explorer | Normal | `c`            | Copy file name (valid in tree)               |
| File Explorer | Normal | `y`            | Copy file (valid in tree)                    |
| File Explorer | Normal | `x`            | Cut file (valid in tree)                     |
| File Explorer | Normal | `d`            | Remove file (valid in tree)                  |
| File Explorer | Normal | `N`            | New file or directory (valid in tree)        |
| File Explorer | Normal | `h`            | Close node (valid in tree)                   |
| File Explorer | Normal | `l`            | Open node (valid in tree)                    |
| File Explorer | Normal | `-`            | Change dir to parent (valid in tree)         |
| Search        | Normal | `ff`           | Find files by name                           |
| Search        | Normal | `<C-p>`        | Fly grep                                     |
| Search        | Normal | `fg`           | Fly grep                                     |
| Search        | Normal | `fb`           | Find bufers                                  |
| Search        | Normal | `fh`           | Find help tags                               |
| Search        | Normal | `fk`           | Find keymaps                                 |
| Search        | Normal | `fc`           | Find commands                                |
| Search        | Normal | `fa`           | Find auto commands                           |
| Search        | Normal | `fm`           | Find man pages                               |
| Search        | Normal | `<C-n>/<Down>` | Next item                                    |
| Search        | Normal | `<C-p>/<Up>`   | Previous item                                |
| Search        | Normal | `j/k`          | Next/previous (in normal mode)               |
| Search        | Normal | `<Cr>`         | Confirm selection                            |
| Search        | Normal | `<C-x>`        | go to file selection as a split              |
| Search        | Normal | `<C-v>`        | go to file selection as a vsplit             |
| Search        | Normal | `<C-t>`        | go to a file in a new tab                    |
| Search        | Normal | `<C-u>`        | scroll up in preview window                  |
| Search        | Normal | `<C-d>`        | scroll down in preview window                |
| Search        | Normal | `<C-c>`        | close telescope                              |
| Search        | Normal | `<Esc>`        | close telescope (in normal mode)             |
| Complete      | Insert | `<C-Space>`    | Complete                                     |
| Complete      | Insert | `<Tab>`        | Complete Select item                         |
| Complete      | Insert | `<Cr>`         | Complete confirm                             |
| Complete      | Normal | `gd`           | Goto definition                              |
| Complete      | Normal | `gi`           | Goto implemention                            |
| Complete      | Normal | `gr`           | Goto references                              |
| Format        | Normal | `<Leader>f`    | Format buffer code                           |
| Comment       | Normal | `gcc`          | Comment line code                            |
| Comment       | Visual | `gc`           | Comment visual line code operator            |
| Text Object   | Visual | `.`            | Smart select text object                     |
| Text Object   | Visual | `;`            | Smart select outer text object               |
| Text Object   | Visual | `<C-h>`        | Move block left                              |
| Text Object   | Visual | `<C-l>`        | Move block right                             |
| Text Object   | Visual | `<C-k>`        | Move block up                                |
| Text Object   | Visual | `<C-j>`        | Move block down                              |
| Translate     | Normal | `<Leader>t`    | Translate selected word in command line      |
| Translate     | Visual | `<Leader>t`    | Translate selected word in command line      |
| Translate     | Normal | `<Leader>w`    | Translate selected word in window            |
| Translate     | Visual | `<Leader>w`    | Translate selected word in window            |
| Quckfix       | Normal | `<Leader>xx`   | Open document quickfix window                |
| Quckfix       | Normal | `<Leader>xw`   | Open workspace quickfix window               |
| Quckfix       | Normal | `<Esc>`        | Back to window / buffer                      |
| Quckfix       | Normal | `q`            | Close quickfix window                        |
| Quckfix       | Normal | `o`            | Jump to the diagnostic and close             |
| Quckfix       | Normal | `r`            | Refresh quickfix window                      |
| Quckfix       | Normal | `m`            | Mode change between "workspace" & "document" |

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
for cpp. You should put a `compile_commands.json` or `compile_flags.txt` in project root, so that the
language server know where to find and reference.

### Formatter

### Linter

[spacevim]: https://github.com/SpaceVim/SpaceVim
[lsp-servers]: https://github.com/kabouzeid/nvim-lspinstall#bundled-installers
[dockerfile]: Dockerfile
[clang-format]: https://clang.llvm.org/docs/ClangFormat.html
[prettier]: https://prettier.io
[clangd]: https://clangd.llvm.org/installation.html
