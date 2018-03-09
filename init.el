
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(require 'twittering-mode)
(add-to-list 'load-path "C:\opt\twittering-mode-3.0.0")
(setq twittering-use-master-password t)
(setq twittering-auth-method 'oauth)
(setq twittering-allow-insecure-server-cert t)
(add-to-list 'load-path "C:\opt\epg\epg-0.0.16")
;;
(global-set-key "\C-h" 'delete-backward-char)

;; javascriptmode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/opt/auto-complete"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/opt/popup-el"))
;;(add-to-list 'load-path "c:\opt\popup-el")
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(define-key ac-completing-map (kbd "TAB") 'ac-complete)
;; web-mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/opt/web-mode"))
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;;
(add-to-list 'load-path (expand-file-name "~/.emacs.d/opt/yasnippet"))
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
        "~/.emacs.d/opt/yasnippet-snippets"
        ))

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

(yas-global-mode 1)

;; ファイルをWindowsの関連付けで開く
(add-hook 'dired-load-hook (function (lambda ()
    (define-key dired-mode-map "w" 'dired-open-file)
)))
(defun dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename)))
    (message "WindowsOpening %s..." file)
      (call-process "cmd.exe" nil 0 nil "/c" "start" "" (convert-standard-filename file) )
    (message "WindowsOpening %s done" file)
   ))
;; 警告音の代わりに画面フラッシュ
(setq visible-bell t)

;;angy-ftp
(setq ange-ftp-ftp-program-name "C:\\opt\\command\\ftp.exe")
;;grep-find
;;find をcygwin64を優先で呼ぶ
(setenv "PATH" (format "c:\\cygwin64\\bin;%s" (getenv "PATH")))

;;excel
(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(setq auto-mode-alist (append '(("\\.\frm\\|bas\\|cls\$" .
                                 visual-basic-mode)) auto-mode-alist))

