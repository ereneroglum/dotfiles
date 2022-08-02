{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home = {
    username = "eren";
    homeDirectory = "/home/eren";
    stateVersion = "22.11";
    packages = with pkgs; [
      firefox
      htop
      kate
      keepassxc
      man-pages
      man-pages-posix
      nerdfonts
      noto-fonts
      qbittorrent
      tor
      ranger
      weechat
    ];
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        shell = {
          program = "bash";
          args = [ "--login" ];
        };
        window = {
          opacity = 0.95;
          dynamic_padding = true;
        };
        font = {
          normal.family = "JetBrains Mono Nerd Font Mono";
          size = 9.5;
        };
        colors = {
          primary = {
            background = "#282c34";
            foreground = "#abb2bf";
          };
          normal = {
            black = "#282c34";
            red = "#e06c75";
            green = "#98c379";
            yellow = "#d19a66";
            blue = "#61afef";
            magenta = "#c678dd";
            cyan = "#56b6c2";
            white = "#abb2bf";
          };
          bright = {
            black = "#5c6370";
            red = "#e06c75";
            green = "#98c379";
            yellow = "#d19a66";
            blue = "#61afef";
            magenta = "#c678dd";
            cyan = "#56b6c2";
            white = "#ffffff";
          };
        };
        bell = {
          animation = "EaseOutQuad";
          duration = 500;
        };
      };
    };
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        MANPAGER = "nvim +Man!";
      };
    };
    emacs = {
      enable = true;
      extraConfig = ''
        ;; Package Management
        (require 'package)
        (package-initialize)
        (add-to-list 'package-archives
                     '("melpa" . "http://melpa.org/packages/") t)
        (setq package-selected-packages '(atom-one-dark-theme company eglot go-mode nix-mode rust-mode))
        (when (cl-find-if-not #'package-installed-p package-selected-packages)
          (package-refresh-contents)
          (mapc #'package-install package-selected-packages))

        ;; Backups
        (unless (file-directory-p "~/.emacs.d/auto-save")
          (make-directory "~/.emacs.d/auto-save"))
        (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save/" t))
              backup-by-copying t
              delete-old-versions t
              kept-new-versions 6
              kept-old-versions 2
              version-control t
              backup-directory-alist '(("" . "~/.emacs.d/backup")))

        ;; Memory Optimizations
        (setq find-file-visit-truename t
              inhibit-startup-message t
              isearch-lazy-count t
              read-process-output-max (* 1024 1024)
              gc-cons-threshold (* 100 1024 1024))

        ;; UI
        (global-display-line-numbers-mode)
        (menu-bar-mode -1)
        (scroll-bar-mode -1)
        (tool-bar-mode -1)
        (xterm-mouse-mode 1)
        (set-frame-font "JetBrainsMono Nerd Font Mono 10")

        (load-theme 'atom-one-dark t)

        ;; Trailing Whitespace Clear Before Save
        (add-hook 'before-save-hook 'delete-trailing-whitespace)

        ;; Window Navigation
        (windmove-default-keybindings)

        ;; Auto Close Brackets
        (electric-pair-mode 1)

        ;; File Search
        (ido-mode 1)

        ;; Company Mode Config
        (setq company-idle-delay 0.1
              company-minimum-prefix-length 1)
        (global-company-mode 1)

        ;; Eglot Config
        (add-hook 'c++-mode-hook 'eglot-ensure)
        (add-hook 'c-mode-hook 'eglot-ensure)
        (add-hook 'go-mode-hook 'eglot-ensure)
        (add-hook 'nix-mode-hook 'eglot-ensure)
        (add-hook 'python-mode-hook 'eglot-ensure)
        (add-hook 'rust-mode-hook 'eglot-ensure)
      '';
    };
    git = {
      enable = true;
      userName = "Eren Eroğlu";
      userEmail = "108634315+eroglueren@users.noreply.github.com";
      extraConfig = {
        init.defaultBranch = "master";
        pull.ff = "only";
      };
    };
    helix = {
      enable = true;
      settings = {
        theme = "onedark";
        editor.cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
    home-manager.enable = true;
    mpv = {
      enable = true;
      bindings = {
        "ALT+k" = "add sub-scale +0.1";
        "ALT+j" = "add sub-scale -0.1";
        "[" = "add speed -0.1";
        "]" = "add speed 0.1";
      };
    };
    neovim = {
      enable = true;
      extraConfig = ''
        lua << EOF
        local fn = vim.fn
        local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
        if fn.empty(fn.glob(install_path)) > 0 then
          packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        end

        vim.cmd [[ packadd packer.nvim ]]

        require('packer').startup(function(use)
          -- Autopairs
          use({
            'windwp/nvim-autopairs',
            after = { 'nvim-treesitter' },
            config = function()
              local npairs = require('nvim-autopairs')
              npairs.setup({
                check_ts = true
              })
            end
          })

          -- Boostrap package manager
          use({
            'wbthomason/packer.nvim'
          })

          -- Bufferline
          use({
            'akinsho/bufferline.nvim',
            after = { 'nvim-web-devicons' },
            config = function()
              require('bufferline').setup()
            end
          })

          -- Completion
          use({
            'hrsh7th/nvim-cmp',
            requires = {
              { 'hrsh7th/cmp-buffer', after = { 'nvim-cmp' } } ,
              { 'hrsh7th/cmp-nvim-lsp', after = { 'nvim-cmp' } },
              { 'hrsh7th/cmp-path', after = { 'nvim-cmp' } },
              { 'ray-x/cmp-treesitter', after = { 'nvim-cmp' } },
              { 'saadparwaiz1/cmp_luasnip', after = { 'LuaSnip', 'nvim-cmp' } }
            },
            after = { 'nvim-autopairs' },
            config = function()
              vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
              local cmp = require('cmp')
              cmp.setup({
                mapping = cmp.mapping.preset.insert({
                  ['<CR>'] = cmp.mapping.confirm({ select = true })
                }),
                snippet = {
                  expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                  end
                },
                sources = {
                  { name = 'buffer' },
                  { name = 'luasnip' },
                  { name = 'nvim_lsp' },
                  { name = 'path' },
                  { name = 'treesitter' }
                }
              })

              --- Autopairs integration
              local cmp_autopairs = require('nvim-autopairs.completion.cmp')
              cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
            end
          })

          -- File Tree
          use({
            'kyazdani42/nvim-tree.lua',
            after = { 'nvim-web-devicons', 'project.nvim' },
            config = function()
              require('nvim-tree').setup({
                respect_buf_cwd = true,
                update_cwd = true,
                update_focused_file = {
                  enable = true,
                  update_cwd = true
                }
              })
            end
          })

          -- LSP
          use({
            'neovim/nvim-lspconfig',
            after = { 'cmp-nvim-lsp' },
            config = function()
              local lspconfig = require('lspconfig')
              --- Provide capabilities
              local capabilities = vim.lsp.protocol.make_client_capabilities()
              capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

              --- Setup Language Servers
              lspconfig.clangd.setup({ capabilities = capabilities })
              lspconfig.gopls.setup({ capabilities = capabilities })
              lspconfig.pylsp.setup({ capabilities = capabilities })
              lspconfig.rnix.setup({ capabilities = capabilities })
              lspconfig.rust_analyzer.setup({ capabilities = capabilities })
            end
          })

          -- Lualine
          use({
            'nvim-lualine/lualine.nvim',
            after = { 'nvim-web-devicons', 'onedark.nvim' },
            config = function()
              require('lualine').setup()
            end
          })

          -- Luasnip
          use({
            'L3MON4D3/LuaSnip'
          })

          -- Null-ls
          use({
            'jose-elias-alvarez/null-ls.nvim',
            config = function()
              local null_ls = require('null-ls')
              local sources = {
                null_ls.builtins.diagnostics.cppcheck,
                null_ls.builtins.diagnostics.deadnix,
                null_ls.builtins.diagnostics.flake8,
                null_ls.builtins.formatting.autopep8,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.nixfmt,
                null_ls.builtins.formatting.rustfmt
              }
              null_ls.setup({ sources = sources })
            end
          })

          -- Onedark Theme
          use({
            'navarasu/onedark.nvim',
            config = function()
              require('onedark').load()
            end
          })

          -- Plenary
          use({
            'nvim-lua/plenary.nvim'
          })

          -- Project
          use({
            'ahmedkhalf/project.nvim',
            config = function()
              require('project_nvim').setup()
            end
          })

          -- Telescope (Fuzzy Finder)
          use({
            'nvim-telescope/telescope.nvim',
            after = { 'nvim-treesitter', 'nvim-web-devicons', 'plenary.nvim', 'project.nvim' },
            config = function()
              local telescope = require('telescope')
              telescope.setup()
              telescope.load_extension('projects')
            end
          })

          -- Treesitter
          use({
            'nvim-treesitter/nvim-treesitter',
            config = function()
              require('nvim-treesitter.configs').setup({
                ensure_installed = { 'c', 'cpp', 'go', 'nix', 'python', 'rust' },
                sync_install = false,
                highlight = {
                  enable = true
                }
              })

              --- Tree sitter folding
              vim.opt.foldmethod = 'expr'
              vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
            end
          })

          -- Webdev Icons
          use({
            'kyazdani42/nvim-web-devicons',
            config = function()
              require('nvim-web-devicons').setup({
                default = true
              })
            end
          })

          -- WhichKey
          use({
            'folke/which-key.nvim',
            config = function()
              require('which-key').setup()
            end
          })

          -- Automatically set up your configuration after cloning packer.nvim
          if packer_bootstrap then
            require('packer').sync()
          end
        end)

        -- Show line numbers
        vim.opt.number = true

        -- Show some empty characters
        vim.opt.list = true

        -- Enable mouse support
        vim.opt.mouse = 'a'

        -- Set folding
        vim.opt.foldlevel = 7
        EOF
      '';
    };
    tmux.enable = true;
  };

  services.emacs.enable = true;

  nixpkgs.overlays = [
    (self: super: {
      qbittorrent = super.qbittorrent.overrideAttrs (old: {
        version = "4.4.2";
        src = super.fetchFromGitHub {
          owner = "qbittorrent";
          repo = "qBittorrent";
          rev = "release-4.4.2";
          sha256 = "sha256-xBNN9YYKMDcoL1wvERjlAjV8vb2GVgwwlHtb5y0+f+8=";
        };
      });
    })
  ];

  xdg.configFile."ranger/rc.conf".text = ''
    set show_hidden true
    set draw_borders true
  '';
}
