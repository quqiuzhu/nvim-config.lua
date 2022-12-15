# Plugins

| Module           | Plugin                                    | Description                                   |
| ---------------- | ----------------------------------------- | --------------------------------------------- |
| ide.autocomplete | [neovim/nvim-lspconfig][1]                | configurations for LSP client                 |
| ide.autocomplete | [williamboman/nvim-lsp-installer][2]      | install & manage LSP servers                  |
| ide.autocomplete | [hrsh7th/nvim-cmp][37]                    | official recommended completion plugin        |
| ide.autocomplete | [hrsh7th/cmp-nvim-lsp][38]                | nvim-cmp source for neovim builtin LSP client |
| ide.autocomplete | [hrsh7th/cmp-buffer][39]                  | nvim-cmp source for buffer words              |
| ide.autocomplete | [hrsh7th/cmp-path][40]                    | nvim-cmp source for path                      |
| ide.lint         | [diagnosticls-configs-nvim][36]           | linter base on diagnosticls LSP server        |
| ide.git          | [f-person/git-blame.nvim][3]              | show git blame information in line            |
| ide.format       | [mhartington/formatter.nvim][4]           | format runner                                 |
| ide.debug        | [mfussenegger/nvim-dap][5]                | Debug Adapter Protocol client                 |
| ide.debug        | [Pocco81/dap-buddy.nvim][6]               | install & manage debugers                     |
| ide.debug        | [rcarriga/nvim-dap-ui][7]                 | A UI for nvim-dap                             |
| ide.debug        | [jbyuki/one-small-step-for-vimkind][8]    | Debug adapter for Neovim plugins              |
| ide.comment      | [terrortylor/nvim-comment][9]             | A comment toggler                             |
| editor.enhance   | [kevinhwang91/nvim-hlslens][10]           | better serarch highlighting                   |
| editor.enhance   | [ggandor/lightspeed.nvim][11]             | motion                                        |
| editor.enhance   | [karb94/neoscroll.nvim][12]               | smooth scrolling                              |
| editor.enhance   | [windwp/nvim-autopairs][13]               | autopairs                                     |
| editor.enhance   | [quqiuzhu/vim-move][14]                   | move lines and selections up and down         |
| editor.enhance   | [ethanholz/nvim-lastplace][15]            | reopen files at last edit position            |
| editor.note      | [nvim-lua/plenary.nvim][16]               | module with common lua functions              |
| editor.note      | [vhyrro/neorg][17]                        | redesigned to clone org-mode from emacs       |
| editor.tmux      | [numToStr/Navigator.nvim][18]             | navigate between neovim splits and tmux panes |
| editor.translate | [voldikss/vim-translator][19]             | translating                                   |
| ui.theme         | [nvim-treesitter/nvim-treesitter][20]     | config for highlighting of languages          |
| ui.theme         | [RRethy/nvim-treesitter-textsubjects][21] | smart selection highlighting                  |
| ui.theme         | [navarasu/onedark.nvim][22]               | A dark neovim colorscheme                     |
| ui.theme         | [norcalli/nvim-colorizer.lua][23]         | colorizer show color in vim                   |
| ui.theme         | [yamatsum/nvim-cursorline][24]            | highlight words and lines on the cursor       |
| ui.explorer      | [kyazdani42/nvim-tree.lua][25]            | file explorer                                 |
| ui.explorer      | [kyazdani42/nvim-web-devicons][26]        | common icons                                  |
| ui.explorer      | [mhinz/vim-startify][27]                  | A fancy start screen                          |
| ui.outline       | [simrat39/symbols-outline.nvim][28]       | A tree like view for symbols                  |
| ui.finder        | [nvim-telescope/telescope.nvim][29]       | highly extendable fuzzy finder over lists     |
| ui.finder        | [nvim-lua/popup.nvim][30]                 | Popup API                                     |
| ui.finder        | [ygm2/rooter.nvim][34]                    | change cwd to project's root directory        |
| ui.quickfix      | [folke/trouble.nvim][31]                  | quickfix and location list                    |
| ui.statusbar     | [nvim-lualine/lualine.nvim][32]           | statusline                                    |
| ui.tab           | [akinsho/nvim-bufferline.lua][33]         | tabs                                          |
| lang.markdown    | [npxbr/glow.nvim][35]                     | preview directly in neovim buffer             |

[1]: https://github.com/neovim/nvim-lspconfig
[2]: https://github.com/williamboman/nvim-lsp-installer
[3]: https://github.com/f-person/git-blame.nvim
[4]: https://github.com/mhartington/formatter.nvim
[5]: https://github.com/mfussenegger/nvim-dap
[6]: https://github.com/Pocco81/dap-buddy.nvim
[7]: https://github.com/rcarriga/nvim-dap-ui
[8]: https://github.com/jbyuki/one-small-step-for-vimkind
[9]: https://github.com/terrortylor/nvim-comment
[10]: https://github.com/kevinhwang91/nvim-hlslens
[11]: https://github.com/ggandor/lightspeed.nvim
[12]: https://github.com/karb94/neoscroll.nvim
[13]: https://github.com/windwp/nvim-autopairs
[14]: https://github.com/quqiuzhu/vim-move
[15]: https://github.com/ethanholz/nvim-lastplace
[16]: https://github.com/nvim-lua/plenary.nvim
[17]: https://github.com/vhyrro/neorg
[18]: https://github.com/numToStr/Navigator.nvim
[19]: https://github.com/voldikss/vim-translator
[20]: https://github.com/nvim-treesitter/nvim-treesitter
[21]: https://github.com/RRethy/nvim-treesitter-textsubjects
[22]: https://github.com/navarasu/onedark.nvim
[23]: https://github.com/norcalli/nvim-colorizer.lua
[24]: https://github.com/yamatsum/nvim-cursorline
[25]: https://github.com/kyazdani42/nvim-tree.lua
[26]: https://github.com/kyazdani42/nvim-web-devicons
[27]: https://github.com/mhinz/vim-startify
[28]: https://github.com/simrat39/symbols-outline.nvim
[29]: https://github.com/nvim-telescope/telescope.nvim
[30]: https://github.com/nvim-lua/popup.nvim
[31]: https://github.com/folke/trouble.nvim
[32]: https://github.com/nvim-lualine/lualine.nvim
[33]: https://github.com/akinsho/nvim-bufferline.lua
[34]: https://github.com/ygm2/rooter.nvim
[35]: https://github.com/npxbr/glow.nvim
[36]: https://github.com/creativenull/diagnosticls-configs-nvim
[37]: https://github.com/hrsh7th/nvim-cmp
[38]: https://github.com/hrsh7th/cmp-nvim-lsp
[39]: https://github.com/hrsh7th/cmp-buffer
[40]: https://github.com/hrsh7th/cmp-path
