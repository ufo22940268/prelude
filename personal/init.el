(prelude-require-package 'auto-complete)

(prelude-require-package 'yasnippet)


(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/personal/snippets"                 ;; personal snippets
        "~/.emacs.d/elpa/yasnippet-20131129.2134/yasmate/snippets"
        "~/.emacs.d/elpa/yasnippet-20131129.2134/snippets"
        ))
(yas-global-mode 1)


(setq prelude-whitespace nil)

(defun view-personal-config()
  (interactive)
  (find-file "~/.emacs.d/personal/init.el"))

(defun my-expand-file-name-at-point ()
  "Use hippie-expand to expand the filename"
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-complete-file-name-partially try-complete-file-name)))
    (call-interactively 'hippie-expand)))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(global-set-key (kbd "C-x C-e") 'eval-buffer)
(global-set-key (kbd "C-c v p") 'view-personal-config)
(global-set-key (kbd "C-M-/") 'my-expand-file-name-at-point)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; (eval-when-compile (require 'cl))

;; (defun set-font (english chinese english-size chinese-size)
;;   (set-face-attribute 'default nil :font
;;                       (format "%s:pixelsize=%d" english english-size))
;;   (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;     (set-fontset-font (frame-parameter nil 'font) charset
;;                       (font-spec :family chinese :size chinese-size))))
;; (set-font "Monaco" "LiHei Pro" 16 18)

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "~/.virtualenvs"/)

(setq visible-bell 1)

(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
(define-key global-map (kbd "RET") 'newline-and-indent)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

(add-to-list 'load-path "~/.emacs.d/elpa/inf-mongo-20130305.127/")
(require 'inf-mongo)

(defun insert-pdb-debug ()
  (interactive)
  (insert "import pdb; pdb.set_trace()")
  )
;; (define-key python-mode-map (kbd "") insert-pdb-)

(setq buffer-save-without-query t)
(setq prelude-flyspell nil)
(add-hook 'web-mode-hook 'html-mode)
