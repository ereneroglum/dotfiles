{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraConfig = ''
      ;; Package Management
      (require 'package)
      (package-initialize)
      (add-to-list 'package-archives
                   '("melpa" . "http://melpa.org/packages/") t)
      (setq package-selected-packages
            '(atom-one-dark-theme company eglot helm magit which-key go-mode nix-mode rust-mode))
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
            backup-directory-alist '(("" . "~/.emacs.d/backup")))

      ;; UI
      (global-display-line-numbers-mode 1)
      (global-hl-line-mode 1)
      (menu-bar-mode -1)
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (xterm-mouse-mode 1)
      (set-frame-font "JetBrainsMono Nerd Font Mono 10")
      (load-theme 'atom-one-dark t)

      ;; Show number of matching phrases
      (setq isearch-lazy-count t)

      ;; Trailing Whitespace Clear Before Save
      (add-hook 'before-save-hook 'delete-trailing-whitespace)

      ;; Window Navigation
      (windmove-default-keybindings)

      ;; Auto Close Brackets
      (electric-pair-mode 1)

      ;; Helm
      (global-set-key (kbd "C-x C-f") #'helm-find-files)
      (global-set-key (kbd "M-x") #'helm-M-x)
      (helm-mode 1)
      (helm-autoresize-mode 1)

      ;; Which Key Mode
      (which-key-mode 1)

      ;; Company Mode Config
      (setq company-idle-delay 0.1
            company-minimum-prefix-length 1)
      (global-company-mode 1)

      ;; Eglot Config
      (add-hook 'c++-mode-hook 'eglot-ensure)
      (add-hook 'c-mode-hook 'eglot-ensure)
      (add-hook 'go-mode-hook 'eglot-ensure)
      (add-hook 'python-mode-hook 'eglot-ensure)
      (add-hook 'rust-mode-hook 'eglot-ensure)
    '';
  };

  services.emacs.enable = true;
}
