(setq inhibit-startup-message t)

;; Some basic config to clean up the UI of unnecessary clutter
(tooltip-mode -1)    ; Disable tooltips
(menu-bar-mode -1)   ; Disable the menu bar

;; These don't seem to be necessary when using -nw
;;(scroll-bar-mode -1) ; Disable visible scrollbar
;;(tool-bar-mode -1)   ; Disable the toolbar
;;(set-fringe-mode 10) ; Give some breathing room

(global-font-lock-mode 1)

;; Handle tabs
(setq my-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width my-tab-width)
(setq-default sgml-basic-offset my-tab-width)

;; Show column numbers in the mode line
(column-number-mode)

;; Add line numbers
(global-display-line-numbers-mode t)

;; Disable the bell
(setq visible-bell 1)

;; https://emacs.stackexchange.com/questions/598/how-do-i-prevent-extremely-long-lines-making-emacs-slow
(setq-default bidi-display-reordering nil)

;; Move backup directory
;; https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Move custom file
;; https://stackoverflow.com/questions/5052088/what-is-custom-set-variables-and-faces-in-my-emacs
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Completion library
(use-package ivy
  :diminish
  :config
  (ivy-mode 1)
  (setq ivy-wrap t))
(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))
(use-package counsel
  :config
  (counsel-mode 1))

;; Keep the current selection when quitting search with C-g
(setq swiper-stay-on-quit t)

;; Customize the theme
(use-package doom-themes
  :config
  (load-theme 'doom-gruvbox t))
  ;;(load-theme 'doom-monokai-classic t))
  ;;(load-theme 'doom-monokai-pro t))
  ;;(load-theme 'doom-old-hope t))
  ;;(load-theme 'doom-tomorrow-night t))
  ;;(load-theme 'doom-one t))
  ;;(load-theme 'wombat t))
  ;;(load-theme 'doom-Iosvkem t))

;; Update gruvbox's mode-line colors so that vertically stacked windows have a delimeter that matches the horizontal delimeter
(set-face-background 'mode-line "#4e4e4e")
(set-face-background 'mode-line-inactive "#4e4e4e")
(set-face-foreground 'mode-line-inactive "#ffffff")

;; Icons for doom-modeline
;; Note: Must run M-x all-the-icons-install-fonts manually once
;; Note: Does not work with emacs -nw
(use-package all-the-icons
  :if (display-graphic-p))

;; Prettier mode line (bottom status bar)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Show whitespace
(use-package whitespace
  :custom
  (whitespace-style '(face empty tabs trailing))
  (whitespace-global-modes '(not magit-status-mode magit-diff-mode))
  :config
  (global-whitespace-mode))

;; More useful help info when asked for a choice
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

;; Easy key bindings
(use-package general)

(general-define-key
  "C-x b" 'counsel-switch-buffer
  "C-s" 'counsel-grep-or-swiper
  "C-r" 'swiper)
(general-define-key
  :keymaps 'ivy-minibuffer-map
  "C-r" 'ivy-previous-line)

;; Project managment project
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/git")
    (setq projectile-project-search-path '("~/git")))
    (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

;; git management
(use-package magit)

;; lsp-mode
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  (setq lsp-headerline-breadcrumb-enable nil)
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

;; Typescript language server
(use-package typescript-mode
  :mode "\\.tsx?\\'"
  :hook (typescript-mode . lsp-deferred))

;; Better completion at point
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; web-mode
(use-package web-mode
  :mode ("\\.html?$" "\\.jsx?$" "\\.tsx?$" "\\.json$")
  :hook (web-mode . lsp-deferred))

;; Always use jsx content type with .js (this preserves jsx markup indentation)
(setq web-mode-content-types-alist
      '(("jsx"  . "\\.js$")))

(custom-set-variables
 '(web-mode-markup-indent-offset my-tab-width)
 '(web-mode-css-indent-offset my-tab-width)
 '(web-mode-code-indent-offset my-tab-width))
