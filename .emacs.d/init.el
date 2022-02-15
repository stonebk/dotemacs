(setq inhibit-startup-message t)

;; Some basic config to clean up the UI of unnecessary clutter
(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1)   ; Disable the toolbar
(tooltip-mode -1)    ; Disable tooltips
(set-fringe-mode 10) ; Give some breathing room
(menu-bar-mode -1)   ; Disable the menu bar

;; Show column numbers in the mode line
(column-number-mode)

;; Add line numbers
(global-display-line-numbers-mode t)

;; Disable the bell
(setq visible-bell 1)

;; Move backup directory
;; https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

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
(set-face-background 'mode-line-inactive "#4e4e4e")
(set-face-foreground 'mode-line-inactive "#ffffff")

;; Icons for doom-modeline
;; Note: Must run M-x all-the-icons-install-fonts manually once
(use-package all-the-icons)

;; Prettier mode line (bottom status bar)
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Show whitespace
(require 'whitespace)
(setq whitespace-style '(face empty tabs trailing))
(global-whitespace-mode t)

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
