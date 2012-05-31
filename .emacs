(global-font-lock-mode 1)
(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Stop using arrow keys!
;;(defun warn-brian ()
;;  (interactive)
;;  (message "brian, instead use C-f, C-b, C-n, C-p, C-v, M-v, M->, M-<"))

;;(global-set-key (kbd "<left>") 'warn-brian)
;;(global-set-key (kbd "<right>") 'warn-brian)
;;(global-set-key (kbd "<up>") 'warn-brian)
;;(global-set-key (kbd "<down>") 'warn-brian)
;;(global-set-key (kbd "<prior>") 'warn-brian)
;;(global-set-key (kbd "<next>") 'warn-brian)

;; js2 mode
(add-to-list 'load-path "~/.emacs.d/extensions/")
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(defun my-js2-mode-hook ()
  (require 'whitespace)
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (global-whitespace-mode t)
  (local-set-key (kbd "RET") 'newline-and-indent))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)

;; html/jqtpl
(add-to-list 'auto-mode-alist '("\\.jqtpl$" . html-mode))

;; css/less
(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))
(defun my-css-mode-hook ()
  (require 'whitespace)
  (setq whitespace-style '(face empty tabs trailing))
  (global-whitespace-mode t)
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'css-mode-hook 'my-css-mode-hook)
