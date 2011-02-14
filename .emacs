;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;功能扩展
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;加入扩展的路径
(add-to-list 'load-path "~/.config/emacs/" t)
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.config/emacs/")
;=;=;=;;;;;;;;;;;;;;;;
;=;=;=;;;
;=;=;=;;;
;=;=;=;;;
;=;=;=;ibuffer,更强大的buffer浏览
(require 'ibuffer)
    (global-set-key (kbd "C-x C-b") 'ibuffer)
;=;=;=;;;;;;;;;;;;;;;;;
;=;=;=;;;
;=;=;=;;;
;=;=;=;;;
;=;=;=;记录变量，寄存器，打开的文件，修改过的文件和最后修改的位置等等
(require 'session)
    (add-hook 'after-init-hook 'session-initialize)
;;;org-mode的时候不保存  ---有冲突
    (add-to-list 'session-globals-exclude
                 'org-mark-ring)
;=;=;=;;;;;;;;;;;;;;;
;=;=;=;;;
;=;=;=;;;
;=;=;=;;;
;保存上次打开的文件记录
(load "desktop")
    (desktop-save-mode 1)
    (desktop-load-default)
    ;(desktop-read)
;=;=;=;;;;;;;;;;;
;=;=;=;;;Desktop Aid,和desktop功能类似的一个模块
;=;=;=;;;;;;;;;;;
;(autoload 'dta-hook-up "desktopaid.elc" "Desktop Aid" t)
;=;=;=;;;;;;;;;;;;;;;;
;=;=;=;;;
;=;=;=;;;
;=;=;=;;;
;;;显示行号模块  ---别人修改setnu后写的一个模块
;(require 'display-line-number)
    ;;;如果想所有打开的文件都显示行的话就打开下面的注释
    ;(global-display-line-number-mode 1)
    ;;;设置显示格式
;(setq display-line-number-format "%3d| ")
    ;; 在 tool bar 上增加一个图标，
    ;; 注意: 一定要在 load-path 中 可以找到
    ;display-line-nuber.xpm 文件才行。
    ;;
    ;(tool-bar-add-item "display-line-number"
    ;	'display-line-number-mode
    ;	'display-line-number-mode
    ;	:help "display line number!"
    ;	:button (cons :toggle '(and (boundp
    ;					display-line-number-mode)
    ;					display-line-number-mode)))
    ;;
    ;; 使用方法
    ;; M-x display-line-number-mode
    ;; 用来 toggle 显示行号的模式
    ;; M-x display-line-number-mode-on
    ;; 启动显示行号的模式
    ;; M-x display-line-number-mode-off
    ;; 关闭显示行号的模式
    ;; 仅对某种 mode 启动显示行号的模式
    ;; (add-hook 'c-mode-hook 'display-line-number-mode)

;;配置w3m为Emacs默认浏览器
(setq browser-url-browser-function 'w3m-browse-url)
;(setq w3m-session-automatic-save t)
;(setq w3m-session-load-last-session t)


;=;=;=;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=;=;=;;;界面设置
;=;=;=;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-font-lock-mode t);语法高亮
;设置sentence-end可以识别中文标点。不用在fill时在句号后插入两个空格
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq inhibit-startup-message t) ;关闭启动时的“开机画面”
(setq frame-title-format "%n%F@%b");在标题栏提示你目前在什么位置
(setq default-fill-column 78);默认显示80列，按空格就换行
(setq line-number-mode t) ;显示行号
(setq column-number-mode t);显示列号
(setq size-indication-mode t) ;显示文件大小
(transient-mark-mode t);高亮显示要copy的区域
(show-paren-mode t);显示括号匹配
(display-time-mode nil);显示时间，格式如下
    (setq display-time-24hr-format nil)
    (setq display-time-day-and-date nil)
;(tool-bar-mode nil);去掉那个大大的工具栏
(menu-bar-mode nil);;禁用菜单栏，F10开启/关闭菜单
(require 'hl-line)
;(setq hl-line-mode t)  ;;高亮当前行
;;or
;(global-hl-line-mode 1)
;;;;;;;;;;;;;;
;防止页面滚动时跳动， scroll-margin 5 可以在靠近屏幕边沿5行时就开始滚动，
;可以很好的看到上下文。
(setq scroll-margin 5
      scroll-conservatively 10000)
;=;=;=;;;;;;;;;;;;
;;shell-mode下自动更改buffer name，显示路径名
;;;;;;;;;;;;
(make-variable-buffer-local 'wcy-shell-mode-directory-changed)
(setq wcy-shell-mode-directory-changed t)

    (defun wcy-shell-mode-auto-rename-buffer-output-filter (text)
      (if (and (eq major-mode (or 'shell-mode 'term))
                   wcy-shell-mode-directory-changed)
              (progn
                   (let ((bn  (concat "sh:"
                       default-directory)))
                          (if (not (string= (buffer-name)
                        bn))
                                     (rename-buffer
                              bn t)))
                       (setq
                    wcy-shell-mode-directory-changed
                    nil))))


    (defun wcy-shell-mode-auto-rename-buffer-input-filter (text)
       (if (eq major-mode 'shell-mode)
              (if ( string-match "^[ \t]*cd *" text)
                     (setq wcy-shell-mode-directory-changed
                  t))))
    (add-hook 'comint-output-filter-functions
     'wcy-shell-mode-auto-rename-buffer-output-filter)
    (add-hook 'comint-input-filter-functions
     'wcy-shell-mode-auto-rename-buffer-input-filter )

;========================================
;;;;分割窗口自动换行显示
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(ecb-options-version "2.32")
 ;; 去掉断词
 ;;(global-visual-line-mode 1) ;;目前发现这样将使得find-file使用行快捷键不是很符合原来的风格
 '(global-visual-line-mode nil)
 '(org-agenda-files (quote ("~/repository/center/doc/faq.txt" "~/org/work.org" "~/org/life.org" "~/org/knowledge.org")))
 '(php-mode-force-pear t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(truncate-partial-width-windows nil)
 '(woman-manpath (quote ("/usr/local/man" "/usr/local/apache/man" "/usr/local/svn/man" "/usr/local/php/man" "/usr/local/emacs23/man" "/usr/man" "/usr/share/man" "/usr/local/share/man" ("/bin" . "/usr/share/man") ("/usr/bin" . "/usr/share/man") ("/sbin" . "/usr/share/man") ("/usr/sbin" . "/usr/share/man") ("/usr/local/bin" . "/usr/local/man") ("/usr/local/bin" . "/usr/local/share/man") ("/usr/local/sbin" . "/usr/local/man") ("/usr/local/sbin" . "/usr/local/share/man") ("/usr/X11R6/bin" . "/usr/X11R6/man") ("/usr/bin/X11" . "/usr/X11R6/man") ("/usr/games" . "/usr/share/man") ("/opt/bin" . "/opt/man") ("/opt/sbin" . "/opt/man")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New")))))
;;;'(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 176 :width normal :foundry "monotype" :family "Courier New")))))
;=;=;=
;=;=;=
;=;=;=;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;备份设置
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq kill-ring-max 200) ;kill的保存
;;;;;emacs还有一个自动保存功能，默认在~/.emacs.d/auto-save-list里，这个非常有用，我这里没有改动，
;;;;;具体可以参见Sams teach yourself emacs in 24hours(我简称为sams24)
;;;;;启用版本控制，即可以备份多次
(setq version-control t)
;;;;;备份最原始的版本两次，记第一次编辑前的文档，和第二次编辑前的文档
(setq kept-old-versions 2)
;;;;;备份最新的版本五次，理解同上
(setq kept-new-versions 5)
;;;;;删掉不属于以上7中版本的版本
(setq delete-old-versions t)
;;;;;设置备份文件的路径
(setq backup-directory-alist '(("." . "~/.emacs.tmp")))
;;;;;备份设置方法，直接拷贝
(setq backup-by-copying t)
;; 自动存盘
(setq auto-save-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;操作更好
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq visible-bell t);关闭敲击table没有匹配时的喇叭声
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
;不要在鼠标点击的那个地方插入剪贴板内容。我不喜欢那样，
;经常把我的文档搞的一团糟。我觉得先用光标定位，然后鼠标
;中键点击要好的多。不管你的光标在文档的那个位置，或是在
;minibuffer，鼠标中键一点击，X selection 的内容就被插入到那个位置。
(setq mouse-yank-at-point t)
(setq-default indent-tabs-mode nil) ;取消Tab
    (setq default-tab-width 4)
    (setq tab-stop-list())
(setq enable-recursive-minibuffers t) ;递归使用minibuffer
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
;;搜索替换，用M-x qrr就可以
(defalias 'qrr 'query-replace-regexp)
;;替换字符串，用M-x rs
(defalias 'rs 'replace-string)
;;替换正则表达式，用M-x rr
(defalias 'rr 'replace-regexp)
;;删除光标后所有空格,用M-x sd
(defalias 'sd 'c-hungry-delete-forward)
;;回车换行缩进，不一定好，直接用C-j就行
;(global-set-key [return] 'newline-and-indent)
;;;;;;;;;;;;;;;;;;
;;关闭shell时自动关闭buffer
(add-hook 'shell-mode-hook 'wcy-shell-mode-hook-func)
(defun wcy-shell-mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                        'wcy-shell-mode-kill-buffer-on-exit)
  )
(defun wcy-shell-mode-kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))
    )
  )
;;关闭term时自动关闭buffer
;(add-hook 'term-mode-hook 'wcy-shell-mode-hook-func)
;(add-hook 'sql-mode-hook 'wcy-shell-mode-hook-func)

;;;;;;;;;;;;;;;;
;;;C-w剪切所在行，M－w复制所在行
;;;;;;;;;;;;;;;;
    (defadvice kill-ring-save (before slickcopy activate compile)
    "When called interactively with no active region, copy a single line instead."
    (interactive
        (if mark-active (list (region-beginning) (region-end))
        (list (line-beginning-position)
        (line-beginning-position 2)))))

    (defadvice kill-region (before slickcut activate compile)
    "When called interactively with no active region, kill a single line instead."
    (interactive
        (if mark-active (list (region-beginning) (region-end))
        (list (line-beginning-position)
        (line-beginning-position 2)))))
;========================================
;;;当%在括号上按下时，匹配括号，否则输入一个%
;(global-set-key "%" 'match-paren)
;(defun match-paren (arg)
;  "Go to the matching paren if on a paren; otherwise insert %."
;  (interactive "p")
;  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;        ((looking-at "\\s\[") (forward-list 1) (backward-char 1))
;        ((looking-at "\\s\]") (forward-char 1) (backward-list 1))
;        ((looking-at "\\s\{") (forward-list 1) (backward-char 1))
;        ((looking-at "\\s\}") (forward-char 1) (backward-list 1))
;        (t (self-insert-command (or arg 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "andy")
(setq user-mail-address "andy@hqtarget.com")
;=;=;=
;=;=;=
;=;=;=
;=;=;=;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=;=;=;;;编程
;=;=;=;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;=;=;=;========================================
;;;自动补全
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))
;=;=;=;========================================
;;;html模式
(setq auto-mode-alist
      (append '(("\\.html$" . html-mode)
                ("\\.htm$" . html-mode)
                ("\\.phtml$" . html-mode)
                ("\\.tpl$" . html-mode))
              auto-mode-alist))

(add-hook 'html-mode-hook (lambda()
                            (setq c-basic-offset 2)
                            (setq sgml-basic-offset 2)
                            (setq tab-width 2)
                            (setq comment-start "<{")
                            (setq comment-end "}>")
                            ))

;;
;; xml模式
;; 23版本提供
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))

;; smarty模式
;; (require 'smarty-mode)
;; (add-hook 'smarty-mode-user-hook 'turn-on-font-lock)

;;;php模式
(require 'php-mode)
(setq auto-mode-alist
      (append '(("\\.php$" . php-mode)
                ("\\.php3$" . php-mode)
                ("\\.module$" . php-mode)
                ("\\.inc$" . php-mode)
                ("\\.install$" . php-mode)
                ("\\.engine$" . php-mode))
              auto-mode-alist))
;;;;;自动补全php函数
;;第二种方法，生成文件
;$ cd /usr/share/doc/php-manual/en/html
;$ ls -1 function*.html \
;$ | sed -e 's/^function\.\([a-zA-Z_0-9]*\)\.html/\1/' \
;$ | tr - _ \
;$ > ~/.config/emacs/php/php-completion-file
(setq php-completion-file "~/.config/emacs/php/php-completion-file")
;;第一种方法，每次都搜索目录，可能慢
;(setq php-manual-path "/usr/share/doc/php-manual/en/html")
;;设置快捷键,console下为F9,gui可以用meta(Alt)-Tab
(global-set-key [(f9)] 'php-complete-function)
;;;;;;;
;;输入左边的括号，就会自动补全右边的部分.包括(), "", [] , {} , 等等。
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
    (?` _ "'")
    (?\( _ ")")
    (?\[ _ "]")
    (?\< _ ">")
    (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "<") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair)
(add-hook 'php-mode-hook 'my-c-mode-auto-pair)
;(add-hook 'html-mode-hook 'my-c-mode-auto-pair)
(add-hook 'java-mode-hook 'my-c-mode-auto-pair)
(add-hook 'javascript-mode-hook 'my-c-mode-auto-pair)
(add-hook 'lisp-mode-hook 'my-c-mode-auto-pair)
(add-hook 'emacs-lisp-mode-hook 'my-c-mode-auto-pair)
(add-hook 'python-mode-hook 'my-c-mode-auto-pair)

(defun my-html-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
    (?` _ "'")
    (?\( _ ")")
    (?\[ _ "]")
    (?\< _ ">")
    (?\{ _ "}")))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "<") 'skeleton-pair-insert-maybe))
(add-hook 'html-mode-hook 'my-html-mode-auto-pair)
;(add-hook 'javascript-mode-hook 'my-html-mode-auto-pair)

;;;;;;;;;;;;
;;遵循pear风格
(defun php-mode-hook ()
  (setq tab-width 2
        c-basic-offset 2
        c-hanging-comment-ender-p nil
        indent-tabs-mode
        (not
         (and
          (string-match "\.php$" (buffer-list))))))
(add-hook 'php-mode-user-hook
          'php-mode-hook)

;=;=;=;========================================
;=;=;=;;;设置前缀
;=;=;=(setq adaptive-fill-regexp "[ \t]+\\|[ \t]*\\([0-9]+\\.\\|\\*+\\|\\#+\\)[ \t]*")
;=;=;=;;;单行文字的前缀选择
;=;=;=(setq adaptive-fill-first-line-regexp "^\\* *$")
;=;=;=
;=;=;=;=======================================
;=;=;=;;;快捷键设置
;=;=;=;;;putty远程登录的时候，backspace没起效用，可以这样设置全局快捷键，但C-h就没有原来的作用了(帮助相关的快捷键)
;=;=;=;;;解决方法是，激活远程终端backspace发送delete的功能
;=;=;=;;;(global-set-key "\C-h" 'delete-backward-char)


;;;;;;;
;;扩充info和man路径
(add-to-list 'Info-default-directory-list "~/emacs/info")
;(add-to-list 'Info-directory-list "~/emacs/info")

;;;;;;;
;;垂直显示buffer
;(setq split-width-threshold 1)



;;;;;;;;
;;在Emacs中使用鼠标(终端的情况下)
;(xterm-mouse-mode t)
;;使用鼠标的时候启动滚轮
;(mouse-wheel-mode t)



;;;;;;;;
;;org模式
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/life.org"
                             "~/org/knowledge.org"))

;;;;;;;;
;;gtalk
;(add-to-list 'load-path "~/.config/emacs/emacs-jabber")
;(require 'jabber)


;;;;;;;;
;;ecb
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/eieio" t)
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/semantic" t)
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/ecb" t)
;(require 'ecb)

;;;;;;;;
;;xcscope C语言索引查找？
;(require 'xcscope)

;;;;;;;;
;;dict查询字典 TODO 23中不好使
(autoload 'dictionary-search "dictionary"
  "Ask for a word and saerch it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary"
  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
  "Create a new dictionary buffer" t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary"
  "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary"
  "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary"
  "Display tooltips for the current word" t)
(autoload 'global-dictionary-tooltip-mode "dictionary"
  "Enable/disable dictionary-tooltip-mode for all buffers" t)
;;绑定快捷键
(global-set-key [mouse-3] 'dictionary-mouse-popup-matching-words)
(global-set-key "\C-cd" 'dictionary-lookup-definition)
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)
;;选择字典服务器（可以是网络上的）
(setq dictionary-server "localhost")


;;;;;;;;
;;设置地理位置
(setq calendar-latitude +39.92);纬度
(setq calendar-longitude +116.46);经度
(setq calendar-location-name "北京")

(setq calendar-time-zone -360)
(setq calendar-standard-time-zone-name "CST")
(setq calendar-daylight-time-zone-name "CDT")

;;;;;;;;
;;javascript
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

;;;;;;;;
;;注释？好像没大用，也许在现在的版本中已经有了
;(defadvice comment-or-uncomment-region (before slickcomment activate compile)
;  "When called interactively with no active region, toggle comment on curren line instead."
;  (interactive
;    (if mark-active (list (region-beginning) (region-end))
;      (list (line-beginning-position)
;            (line-beginning-position 2)))))
;(define-key php-mode-map (kbd "C-c C-d") 'comment-or-uncomment-region)
(put 'dired-find-alternate-file 'disabled nil)

;;;;;;;;
;;缩写
(setq-default abbrev-mode t)
(read-abbrev-file "~/.abbrev_defs")
(setq save-abbrevs t)

;;;;;;;;
;;Emacs中执行设定的bash，而不是登录的Shell
(setenv "ESHELL" (expand-file-name "/bin/bash"))

;;;;;;;;
;;Ipython
(setq ipython-command "/usr/bin/ipython")
(require 'ipython)

;;;;;;;;
;;Python-mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;;;;;;;;
;;tramp 编辑远程文件
(add-to-list 'load-path "~/.config/emacs/tramp/lisp" t)

;(setq tramp-default-method "ssh")
;(setq tramp-debug-buffer t)
;;;;;;;
;;在Emacs内使用sudo   默认好像就已经安装了 TODO 23版本中好像不行
;;C-x C-f /sudo::/filepath
(require 'tramp)

;;;;;;;;
;;psvn SVN版本控制
(require 'psvn)

;;;;;;;;
;;插入当前时间 TODO current-time有错误，没这个变量，查看time.el.gz寻找答案
;(define-key insert-current-time ()
;  (interactive)
;  (insert (format-time-string "%Y-%m-%d %H:%M:%S" (current-time))))
;(define-key global-map [(meta f10)] 'insert-current-time)

;;;;;;;;
;;tramp 保存tramp时间
;(setq password-cache-expory nil)
;(add-to-list 'tramp-default-method-alist
;             '("\\`localhost\\'" "\\`andy\\'" "sudo")
;             )

;;;;;;;;
;;multi-term
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setq multi-term-dedicated-select-after-open-p t)
(defalias 'mt 'multi-term)
(defalias 'mtt 'multi-term-dedicated-open)

;; 文件编码
(setq terminal-coding-system 'utf-8-unix)
(setq default-coding-systems 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8-unix)
(setq ansi-color-for-comint-mode t)
(prefer-coding-system 'utf-8-unix)


;;;;;;;;
;;eshell
;;使用"emacs"命令在当前的emacs中打开文件
(defun eshell/emacs (&reset args)
  "Open a file in emacs. Some habits die hard."
  (if (null args)
      ;; If I just rand "emacs", I probably expect to be launching
      ;; Emacs, whihc is rather silly since I'm already in Emacs.
      ;; So just pretend to do what I ask.
      (bury-buffer)
    ;; We have to expand the file names or else naming a directory in an
    ;; argument causes later arguments to be looked for in that dircetory,
    ;; not the starging directory
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

;;;;;;;;
;; 多标签
;;(require 'tabbar)
;;(xterm-mouse-mode t)                    ;必须得启动鼠标才可以有tab，挺麻烦的，而在终端还没什么效果！
;;(tabbar-mode)
;;(global-set-key (kbd "<s-up>") 'tabbar-backward-group)
;;(global-set-key (kbd "<s-down>") 'tabbar-forward-group)
;;(global-set-key (kbd "<s-left>") 'tabbar-backward)
;;(global-set-key (kbd "<s-right>") 'tabbar-forward)
;;;;tabbar hack 王垠
;;;;;;;;;;;
;;(setq tabbar-buffer-groups-function 'tabbar-buffer-ignore-groups)
;;
;;(defun tabbar-buffer-ignore-groups (buffer)
;;  "Return the list of group names BUFFER belongs to.
;;     Return only one group for each buffer."
;;  (with-current-buffer (get-buffer buffer)
;;    (cond
;;     ((or (get-buffer-process (current-buffer))
;;          (memq major-mode
;;                '(comint-mode compilation-mode)))
;;      '("Process")
;;      )
;;     ((member (buffer-name)
;;              '("*scratch*" "*Messages*"))
;;      '("Common")
;;      )
;;     ((eq major-mode 'dired-mode)
;;      '("Dired")
;;      )
;;     ((memq major-mode
;;            '(help-mode apropos-mode Info-mode Man-mode))
;;      '("Help")
;;      )
;;     ((memq major-mode
;;            '(rmail-mode
;;              rmail-edit-mode vm-summary-mode vm-mode mail-mode
;;              mh-letter-mode mh-show-mode mh-folder-mode
;;              gnus-summary-mode message-mode gnus-group-mode
;;              gnus-article-mode score-mode gnus-browse-killed-mode))
;;      '("Mail")
;;      )
;;     (t
;;      (list
;;       "default"  ;; no-grouping
;;       (if (and (stringp mode-name) (string-match "[^ ]" mode-name))
;;           mode-name
;;         (symbol-name major-mode)))
;;      )
;;
;;     )))


;;(global-set-key (kbd "<s-up>") 'windmove-up)
;;(global-set-key (kbd "<s-down>") 'windmove-down)
;;(global-set-key (kbd "<s-left>") 'windmove-left)
;;(global-set-key (kbd "<s-right>") 'windmove-right)

;;;;;;;;
;; 移动光标到当前buffer上下左右窗口
(defalias 'wl 'windmove-left)
(defalias 'wr 'windmove-right)
(defalias 'wu 'windmove-up)
(defalias 'wd 'windmove-down)


;;;;;;;;
;; outline模式
(setq outline-minor-mode t)
(defalias 'hl 'hide-subtree)
(defalias 'sl 'show-subtree)

;;;;;;;;
;; 保存时删除行尾空格
(add-hook 'before-save-hook '(lambda()
                               (delete-trailing-whitespace) ; 删除行尾空格
                               ))
                                        ;(whitespace-cleanup) ; 删除whitespace-style设定的空白
;;;;;;;;
;; smarty template mode for editting php code in emacs
;; 暂时没什么用
;;(require 'smarty-mode)

;;;;;;;;
;; M-x grep-find/find-grep时的参数
(setq grep-find-command "find . -path \"*.svn\" -prune -o -type f -print0 | xargs -0 -e grep -snH -e ")
(defalias 'fg 'find-grep)

;;;;;;;;
;; ibuffer分组
(require 'ibuf-ext)
(setq ibuffer-mode-hook
      (lambda ()
        (setq ibuffer-filter-groups
              '(
                ("*buffer*" (or (name . "\\*\\(Messages\\|scratch\\|Completions\\|Process List\\|Shell Command Output\\)\\*")
                                (name . "\\*tramp.*")))
                ("secret" (or (name . ".*Encrypt.*")
                              (name . "would be set")
                              (name . ".*NetConfig.*")))
                ("shell" (or (mode . term-mode)
                             (mode . eshell-mode)
                             (mode . shell-mode)
                             (mode . shell-script-mode)
                             (name . ".*\\.sh$")))
                ("dired" (mode . dired-mode))
                ("php" (or (mode . php-mode)
                           (name . ".*\\.ini$")))
                ("javascript" (mode . javascript-mode))
                ("html" (mode . html-mode))
                ("xml" (mode . nxml-mode))
                ("org" (mode . org-mode))
                ("elisp" (or (mode . emacs-lisp-mode)
                             (mode . lisp-interaction-mode)))
                ("prog" (or (mode . python-mode)
                            (mode . c++-mode)
                            (mode . c-mode)
                            (mode . java-mode)
                            (mode . perl-mode)))
                ("help" (or (mode . info-mode)
                            (name . "\\*info\\*")
                            (mode . help-mode)
                            (mode . woman-mode)
                            (mode . man-mode)))
                ))))

;;;;;;;;
;; 左侧显示行数
;;(dolist (hook (list
;;               'c-mode-hook
;;               'emacs-list-mode-hook
;;               'lisp-interaction-mode-hook
;;               'lisp-mode-hook
;;               ))
;;  (add-hook hook (lambda () (linum-mode 1))))
;; (linum-mode 1)

;; 断词
;; 23版本提供
;;(global-visual-line-mode 1) ;;目前发现这样将使得find-file使用行快捷键不是很符合原来的风格

;; 断行
;;(set-fill-column 78) ;;前面设置过了
(auto-fill-mode t)


;; open file
(defalias 'open 'find-file)
(defalias 'openo 'find-file-other-window)

;; eshell & bookmarks
;; eshell/bmk - version 0.1.2
(defun pcomplete/eshell-mode/bmk ()
  "Completion for `bmk'"
  (pcomplete-here (bookmark-all-names)))

(defun eshell/bmk (&rest args)
  "Integration between EShell and bookmarks.
For usage, execute without arguments."
  (setq args (eshell-flatten-list args))
  (let ((bookmark (car args))
        filename name)
    (cond
     ((eq nil args)
      (format "Usage: bmk BOOKMARK to change directory pointed to by BOOKMARK
    or bmk . BOOKMARK to bookmark current directory in BOOKMARK.
Completion is available."))
     ((string= "." bookmark)
      ;; Store current path in EShell as a bookmark
      (if (setq name (car (cdr args)))
          (progn
            (bookmark-set name)
            (bookmark-set-filename name (eshell/pwd))
            (format "Saved current directory in bookmark %s" name))
        (error "You must enter a bookmark name")))
     (t
       ;; Assume the user wants to go to the path pointed out by a bookmark.
       (if (setq filename (cdr (car (bookmark-get-bookmark-record bookmark))))
           (if (file-directory-p filename)
               (eshell/cd filename)
             ;; TODO: Handle this better and offer to go to directory
             ;; where the file is located.
             (error "Bookmark %s points to %s which is not a directory"
                    bookmark filename))
         (error "%s is not a bookmark" bookmark))))))

;; eshell color ouput
(require 'ansi-color)
(require 'eshell)
(defun eshell-handle-ansi-color ()
  (ansi-color-apply-on-region eshell-last-output-start
                              eshell-last-output-end))
(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

;; completion (cd /ssh:webadmin@211.157.109.209:/home/web...)
(defadvice pcomplete (around avoid-remote-connections activate)
  (let ((file-name-handler-alist (copy-alist file-name-handler-alist)))
    (setq file-name-handler-alist
          (delete (rassoc 'tramp-completion-file-name-handler
                          file-name-handler-alist) file-name-handler-alist))
    ad-do-it))

;; pcomplete-list than completion cycling
(setq eshell-cmpl-cycle-completions nil)

;; send commands to eshell from other buffer
(defun my-eshell-execute-current-line ()
  "Insert text of current line in eshell and execute."
  (interactive)
  (require 'eshell)
  (let ((command (buffer-substring
                  (save-excursion
                    (beginning-of-line)
                    (point))
                  (save-excursion
                    (end-of-line)
                    (point)))))
    (let ((buf (current-buffer)))
      (unless (get-buffer eshell-buffer-name)
        (eshell))
      (display-buffer eshell-buffer-name t)
      (switch-to-buffer-other-window eshell-buffer-name)
      (end-of-buffer)
      (eshell-kill-input)
      (insert command)
      (eshell-send-input)
      (end-of-buffer)
      (switch-to-buffer-other-window buf))))

(global-set-key [f8] 'my-eshell-execute-current-line)

;; execute emacs in eshell
(defun eshell/emacs (&rest args)
  "Open a file in emacs. Some habits die hard."
  (if (null args)
      ;; If I just ran "emacs", I probably expect to be launching
      ;; Emacs, Which is rather silly since I'm already in Emacs.
      ;; So just pretend to do what i ask.
      (bury-buffer)
    ;; We have to expand the file names or else naming a directory in an
    ;; argument causes later arguments to be looked for in that directory,
    ;; not the starting directory
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

;; eshell/perldoc
(defun eshell/perldoc (&rest args)
      "Like `eshell/man', but invoke `perldoc'."
      (funcall 'perldoc (apply 'eshell-flatten-and-stringify args)))
(defun perldoc (man-args)
      (interactive "sPerldoc: ")
      (require 'man)
      (let ((manual-program "perldoc"))
        (man man-args)))

;; debian
(defun eshell/deb (&rest args)
  (eshell-eval-using-options
   "deb" args
   '((?f "find" t find "list available packages matching a pattern")
     (?i "installed" t installed "list installed debs matching a pattern")
     (?l "list-files" t list-files "list files of a package")
     (?s "show" t show "show an available package")
     (?v "version" t version "show the version of an installed package")
     (?w "where" t where "find the package containing the given file")
     (nil "help" nil nil "show this usage information")
     :show-usage)
   (eshell-do-eval
    (eshell-parse-command
     (cond
      (find
       (format "apt-cache search %s" find))
      (installed
       (format "dlocate -l %s | grep '^.i'" installed))
      (list-files
       (format "dlocate -L %s | sort" list-files))
      (show
       (format "apt-cache show %s" show))
      (version
       (format "dlocate -s %s | egrep '^(Package|Status|Version):'" version))
      (where
       (format "dlocate %s" where))))
    t)))

;; mysql
;(require 'mysql)




;; auto save mode disabled
(setq auto-save-default nil)

;; php error reporting flymake
;; (require 'flymake)
;; (defun flymake-php-init ()
;;   "Use php to check the syntax of the current file."
;;   (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
;;          (local (file-relative-name temp (file-name-directory buffer-file-name))))
;;     (list "php" (list "-f" local "-l"))))
;;
;; (add-to-list 'flymake-err-line-patterns
;;              '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))
;;
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))
;;
;; (add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
;; (define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
;; (define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)

;; (locate-library "auto-complete.el")
;; (add-hook 'php-mode-hook
;;       (lambda()
;;         (require 'php-completion)
;;         (php-completion-mode t)
;;         (define-key php-mode-map (kbd "C-c p") 'phpcmp-complete)
;;         (when (require 'auto-complete t)
;;           (make-variable-buffer-local 'ac-sources)
;;           (add-to-list 'ac-sources 'ac-source-php-completion)
;;           (auto-complete-mode t))))

;; php Tab indentation to 4
(defun clean-php-mode()
  (interactive)
  (php-mode)
  (setq c-basic-offset 4) ;4 tabs indenting
  (setq indent-tabs-mode nil)
  (setq fill-column 78)
  (c-set-offset 'case-label '+)
  (c-set-offset 'arglist-close 'c-lineup-arglist-operators)
  (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-math); for DBTNG fields and values
  )

;; ;; run php lint when press f8 key
;; ;; php lint
;; (defun phplint-thisfile()
;;   (interactive)
;;   (compile (format "php -l %s" (buffer-file-name)))
;;   (add-hook 'php-mode-hook
;;             '(lambda ()
;;                (local-set-key [f8] 'phplint-thisfile)))
;;   )

;; nxhtml mode for web developing
;; (load "~/.config/emacs/nxhtml/autostart.el")