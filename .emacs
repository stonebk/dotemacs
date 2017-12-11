;; global tab width
(setq my-tab-width 4)

(global-font-lock-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width my-tab-width)
(setq inhibit-startup-message t)
(setq column-number-mode t)

;; https://emacs.stackexchange.com/questions/598/how-do-i-prevent-extremely-long-lines-making-emacs-slow
(setq-default bidi-display-reordering nil)

;; http://emacsredux.com/blog/2013/05/09/keep-backup-and-auto-save-files-out-of-the-way/
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; html spaces for tab
(setq-default sgml-basic-offset my-tab-width)

;; Load extensions/themes
(add-to-list 'load-path "~/.emacs.d/extensions/")

;; Show whitespace
(require 'whitespace)
(setq whitespace-style '(face empty tabs trailing))
(global-whitespace-mode t)

;; js, json, jsx
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jinja2$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(setq web-mode-content-types-alist
      '(("jsx"  . "\\.js$")))

(custom-set-variables
 '(web-mode-markup-indent-offset my-tab-width)
 '(web-mode-css-indent-offset my-tab-width)
 '(web-mode-code-indent-offset my-tab-width))

;; html/jqtpl/mustache
(add-to-list 'auto-mode-alist '("\\.jqtpl$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.mustache$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.hbs$" . html-mode))

;; scss
(setq css-indent-offset my-tab-width)
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;; css/less
(autoload 'less-css-mode "less-css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))
(defun my-css-mode-hook ()
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'css-mode-hook 'my-css-mode-hook)
(add-hook 'less-css-mode-hook 'my-css-mode-hook)

;; cleanup whitespace macro
(fset 'clean-whitespace
   "\C-xh\C-[xunta\C-i\C-m\C-[xdelet\C-itra\C-i\C-m\C-@")

(fset 'clean-quotes
   "\C-[<\C-[xreplace-string\C-m”\C-m\"\C-m\C-[<\C-[xreplace-string\C-m“\C-m\"\C-m\C-[<\C-[xreplace-string\C-m‘\C-m\'\C-m\C-[<\C-[xreplace-string\C-m’\C-m\'\C-m")

;; HTML template
(fset 'html-template
   "<!doctype html>\C-m<html>\C-m\C-i<head>\C-m\C-i<title></title>\C-m\C-i</head>\C-i\C-m\C-i<body>\C-m\C-i</body>\C-i\C-m</html>\C-p\C-p\C-p\C-p\C-e\C-b\C-b\C-b\C-b\C-b\C-b\C-b\C-b")

(fset 'lorem-ipsum
   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ornare lorem sit amet quam mattis, ac fringilla est commodo. Vestibulum rhoncus congue tempus. Vivamus cursus scelerisque nulla sit amet placerat. Morbi rhoncus dictum elementum. Nulla facilisi. Mauris porta sit amet erat a euismod. Duis lacus mauris, molestie et purus a, mollis ullamcorper velit. Aliquam accumsan, augue id sollicitudin posuere, magna nulla fermentum purus, eu pharetra odio tortor porttitor nisi. Vestibulum faucibus tellus sed magna sodales ultricies. Suspendisse potenti. Curabitur at eros porttitor, luctus quam quis, feugiat metus. Ut semper, tortor eget mattis euismod, enim mi rutrum risus, sit amet commodo diam metus at est. Nam vel urna nec felis mollis adipiscing non eget mauris. Cras auctor, nulla a iaculis interdum, arcu lorem mattis augue, eu porta diam ligula a dui. Morbi eu porttitor sapien. Donec fermentum justo eu ligula placerat lobortis.")
(fset 'lorem-ipsum-2
    "Integer scelerisque lorem ut nulla facilisis, nec cursus ante varius. Ut sem urna, viverra pellentesque tincidunt nec, mattis eu lorem. Suspendisse interdum purus sit amet porttitor feugiat. Praesent molestie eu purus vel elementum. Aliquam vitae mauris vel orci vehicula commodo. Vivamus ac fringilla elit, et pulvinar lorem. Curabitur ut nibh id elit pretium rutrum quis sed mi. Vestibulum lobortis, augue at elementum iaculis, justo sem rhoncus eros, a cursus risus nunc cursus magna. Phasellus eleifend rhoncus sapien, non consectetur erat dictum rhoncus. Proin tempor ac odio ac dapibus. Fusce a lorem mauris. Quisque posuere eleifend diam, non faucibus ipsum porttitor ac. Integer in arcu nec augue bibendum rhoncus ac quis nisl. Vivamus purus metus, sagittis vel purus ut, facilisis varius nulla. Ut in sapien eget lorem vestibulum ultrices semper eu tellus.")
(fset 'lorem-ipsum-3
    "Praesent sed elementum dolor. Nulla commodo scelerisque sapien, ut tempor lorem dictum ut. Quisque luctus sed dui eu ornare. Maecenas in posuere orci. Maecenas quis nulla nec quam faucibus malesuada. Phasellus a fermentum odio. Ut ac quam et justo porta fringilla. Integer dictum vehicula odio quis porta. Sed vitae convallis sem. Curabitur vel suscipit purus. Praesent sagittis laoreet leo non sollicitudin. Praesent cursus et diam a aliquet. Cras tempus sem ut placerat aliquam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nam congue odio eget justo tempus, suscipit ullamcorper neque fringilla.")
(fset 'lorem-ipsum-4
    "Nulla fringilla id quam sed ullamcorper. Vivamus fringilla erat id nisi molestie, auctor elementum orci sollicitudin. In nec iaculis eros. In scelerisque enim adipiscing felis ultricies pretium. Integer egestas, mauris in semper imperdiet, nibh massa ultrices libero, id molestie mi est quis massa. Nullam ut massa ut dolor condimentum pharetra. Donec interdum, lectus eget bibendum aliquet, augue dui luctus orci, quis pretium metus ligula in enim. Mauris lacus turpis, varius sed congue ut, feugiat a tellus. Nunc ac pretium enim. Proin pulvinar at velit non auctor. Fusce dignissim nec diam quis blandit. Morbi ac justo sit amet purus posuere ornare ut ac tellus. Fusce hendrerit varius tortor, nec tempor metus. Phasellus in lectus feugiat tellus venenatis mattis vel et nulla. Etiam tristique semper enim sagittis pellentesque.")
(fset 'lorem-ipsum-5
    "Integer at velit ornare, ultrices tortor accumsan, interdum dolor. Aliquam accumsan ultrices pulvinar. Suspendisse varius faucibus faucibus. Proin pharetra est tincidunt, venenatis ante sit amet, molestie neque. Maecenas velit sapien, accumsan nec libero quis, imperdiet vestibulum neque. Nam tincidunt sapien nec congue sagittis. Donec pretium mi odio, ut commodo arcu elementum nec. In hac habitasse platea dictumst. Curabitur lacus erat, blandit et sollicitudin egestas, pretium et est. Ut nec lectus tellus. Sed malesuada auctor augue a lobortis. Morbi pharetra, quam egestas fringilla ullamcorper, ligula augue fermentum enim, quis vulputate sem magna ut tortor. Duis vehicula volutpat rhoncus. Vestibulum feugiat dolor arcu, et vehicula massa pulvinar id. Sed in est vitae elit cursus fermentum.")

(fset 'html-template
   "<html>\C-m    <head>\C-m        <title>Zillow Style Guide v2 :: Hackweek</title>\C-m        <link rel=\"stylesheet\" type=\"text/css\" href=\"/css/zsg/zsg.css\">\C-m        <link rel=\"stylesheet\" type=\"text/css\" href=\"/css/styleguide/styleguide.css\">\C-m        <script src=\"/thirdparty/webcomponentsjs/webcomponents.js\"></script>\C-m\C-m        <!-- Import web components -->\C-m        <link rel=\"import\" href=\"/styleguide/webcomponents/styleguide-example.html\">\C-m        <link rel=\"import\" href=\"/styleguide/webcomponents/styleguide-nav.html\">\C-m        <link rel=\"import\" href=\"/styleguide/webcomponents/styleguide-permalink.html\">\C-m    </head>\C-m    <body unresolved>\C-m        <div class=\"zsg-layout-width zsg-layout-top zsg-layout-bottom\">\C-m            <main class=\"zsg-layout-content\">\C-m\C-m            </main>\C-m        </div>\C-m    </body>\C-m</html>\C-p\C-p\C-p\C-p\C-m\C-m\C-p\C-i")

;; js2 mode
;;(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

;;(defun my-js-mode-hook ()
;;  (setq whitespace-style '(face empty tabs lines-tail trailing))
;;  (global-whitespace-mode t)
;;  (local-set-key (kbd "RET") 'newline-and-indent))

;;(add-hook 'js-mode-hook 'my-js-mode-hook)

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
