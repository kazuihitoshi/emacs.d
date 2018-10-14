
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(keyboard-translate ?\C-h ?\C-?)

;; javascriptmode
;;(require 'js2-mode)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/opt/auto-complete"))
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/opt/popup-el"))
;;(add-to-list 'load-path "c:\opt\popup-el")
;;(require 'auto-complete)
;;(require 'auto-complete-config)
;;(global-auto-complete-mode t)
;;(define-key ac-completing-map (kbd "C-n") 'ac-next)
;;(define-key ac-completing-map (kbd "C-p") 'ac-previous)
;;(define-key ac-completing-map (kbd "TAB") 'ac-complete)
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

;;      (call-process-shell-command (convert-standard-filename file)  )
;;   (call-process "cmd.exe" nil 0 nil "/c" "start" "" \"(convert-standard-filename file)\" )
   
;;等倍フォント設定
;;http://ongaeshi.hatenablog.com/entry/20110118/1295373477
(set-default-font "ＭＳ ゴシック-9")
;; 行間を開ける量、これを調整することでかなり見え方が変わる
(setq-default line-spacing 2)
;;ange-ftp
;;http://u.hoso.net/2009/12/ntemacs-ftp.html
(setq ange-ftp-ftp-program-name "C:\\emacs-ime\\bin\\ftp.exe")

(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/../Local/Temp"))
        backup-directory-alist))

(set-language-environment 'Japanese)
(prefer-coding-system 'shift_jis)
;; 警告音の代わりに画面フラッシュ
(setq visible-bell t)
;;find をcygwin64を優先で呼ぶ
(setenv "PATH" (format "c:\\cygwin64\\bin;%s" (getenv "PATH")))

;;Emacs で全角スペース/タブ文字を可視化
;;http://weboo-returns.com/blog/emacs-shows-double-space-and-tab/
(setq whitespace-style
      '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")

(require 'package) ; パッケージ機能を有効にする
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t) ; MELPAリポジトリを追加する
(package-initialize) ; インストールされているパッケージを初期化する
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (migemo magit magit-annex magit-filenotify ssh vbasense))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; git 
(setq magit-git-executable "C:/Program Files/Git/bin/git.exe")
;; ssh putty
;; https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html
(setenv "PATH" (concat "C:/Program Files/PuTTY" ";" (getenv "PATH")))
(setq tramp-default-method "psftp")
;; magit チュートリアル
;; https://qiita.com/maueki/items/70dbf62d8bd2ee348274
;;
;;リポジトリ作成
;; M-x magit-init 
(global-set-key (kbd "C-x g") 'magit-status)



;; sqlmode
;;; SQL文の整形をする設定
;; 実行する外部コマンド
(setq sql-format-external-command
  (concat "java -jar " (expand-file-name "~/.emacs.d/opt/sql-formatter/binary/sql-formatter-1.0.0-jar-with-dependencies.jar")))

;; SQL文をフォーマットする関数
(defun my-format-sql ()
  "バッファまたはリージョン内のSQL文を整形する。"
  (interactive)
  (let (begin end)
    (cond (mark-active
           (setq begin (region-beginning))
           (setq end (region-end)))
          (t
           (setq begin (point-min))
           (setq end (point-max))))
    (save-excursion
      (shell-command-on-region
       begin
       end
       sql-format-external-command
       nil 
       t ; replace buffer
       ))))

;; キーバインド設定
;; C-S-f はコントロールキーとShiftキーを押しながら fキーを押すの意味
;;control alt  meta hyper shift
;;C       A    M    H     S
;;http://d.hatena.ne.jp/tomoya/20090415/1239809615
(with-eval-after-load "sql"
  (define-key sql-mode-map (kbd "C-S-f") 'my-format-sql))

(define-key esc-map (kbd "d") 'ediff-buffes)


;; migemo
;;(require 'migemo)
;;(setq migemo-dictionary "C:/Users/ys62.YSKAD/AppData/Roaming/.emacs.d/migemo/dict/cp932/migemo-dict")
;;(setq migemo-command "cmigemo")
;;(setq migemo-options '("-q" "--emacs" "-i" "\a"))
;;(setq migemo-user-dictionary nil)
;;(setq migemo-regex-dictionary nil)
;;(setq migemo-coding-system 'utf-8-unix)
;;(load-library "migemo")
;;(migemo-init)

(autoload 'visual-basic-mode "~/.emacs.d/opt/visual-basic-mode" "Visual Basic mode." t)
 (setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\)$" .
                                  visual-basic-mode)) auto-mode-alist))
;;自動インデントを無効化
(add-hook 'text-mode-hook '(lambda ()
			      (electric-indent-local-mode -1)))
(fset 'hogehoge
   "this is a pen\C-a")
(global-set-key (kbd "M-k") 'hogehoge)


;; init.el reload
(global-set-key
  [f12] 'eval-buffer)


;; ウィンドウを透明にする
;; アクティブウィンドウ／非アクティブウィンドウ（alphaの値で透明度を指定）
(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; メニューバーを消す
;;(menu-bar-mode -1)

;; ツールバーを消す
(tool-bar-mode -1)


;; カーソル行をハイライトする
(global-hl-line-mode t)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

(require 'tramp )
(setq tramp-default-method "ssh")
