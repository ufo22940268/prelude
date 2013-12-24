(prelude-require-package 'auto-complete)

(prelude-require-package 'yasnippet)

(require 'auto-complete-config)
(ac-config-default)

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

;; (global-set-key (kbd "C-x C-e") 'eval-buffer)
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
(setq venv-location "~/.virtualenvs")

(setq visible-bell 1)

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))

(defun scroll-up-half ()
  (interactive)
  (scroll-up (window-half-height)))

(defun scroll-down-half ()
  (interactive)
  (scroll-down (window-half-height)))

(global-set-key (kbd "C-v") 'scroll-up-half)
(global-set-key (kbd "M-v") 'scroll-down-half)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)

;; (global-set-key (kbd "M-n") '(lambda () (interactive) (scroll-down 1)))
;; (global-set-key (kbd "M-p") '(lambda () (interactive) (scroll-up 1)))

(define-key global-map (kbd "RET") 'newline-and-indent)

(add-to-list 'load-path "~/.emacs.d/elpa/inf-mongo-20130305.127/")
(require 'inf-mongo)

(defun insert-pdb-debug ()
  (interactive)
  (insert "import pdb; pdb.set_trace()"))

(add-hook 'web-mode-hook 'html-mode)

;; ;; flx-ido looks better with ido-vertical-mode
;; (require 'ido-vertical-mode)
;; (ido-vertical-mode)

(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "<S-left>") nil)
     (define-key org-mode-map (kbd "<S-right>") nil)
     (define-key org-mode-map (kbd "<S-down>") nil)
     (define-key org-mode-map (kbd "<S-up>") nil)
     (org-display-inline-images)))


(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes
(smartparens-global-mode t)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional

(scroll-bar-mode -1)

(require 'goto-last-change) ;; download this package and install in load-path
(global-set-key (kbd "C-.") 'goto-last-change)

;; (global-set-key (kbd "C-c C-j") 'imenu)

(setq scroll-preserve-screen-position 1)

(global-set-key (kbd "C-M-m") 'projectile-compile-project)

;; (defun move-to-end-and-new-line-with-indent (args)
;;   (interactive)
;;   (prog (move-end-of-line 1)
;;         (newline-and-indent)))
;; (global-set-key (kbd "C-M-return") 'move-to-end-and-new-line-with-indent)

;; (add-hook 'before-save-hook
;;           'delete-trailing-whitespace)

(add-hook 'find-file-hook (lambda () (setq buffer-save-without-query t)))

(global-set-key (kbd "C-c p p") 'projectile-debug-project)


(setq android-mode-sdk-dir "~/program/adt-bundle-mac-x86_64-20130219/sdk/")
(require 'android-mode)
(load-file "~/.emacs.d/personal/android.el")

(add-hook 'term-mode-hook (lambda()
                            (yas-minor-mode -1)))
;; (setq system-uses-terminfo nil)

;; (add-hook 'compilation-mode-hook (lambda () (interactive) (end-of-buffer)))
(setq projectile-switch-project-action 'projectile-dired)
(global-set-key (kbd "M-.") 'projectile-find-tag)
;; (global-set-key (kbd "M-.") 'helm-etags-select) 

(define-key yas-minor-mode-map (kbd "C-,") 'er/expand-region)
(define-key yas-minor-mode-map (kbd "TAB") nil)
;; (global-set-key (kbd "C-c f") 'projectile-find-file)
;; (global-set-key (kbd "C-c r") 'projectile-recentf)
;; (define-key projectile-mode-map (kbd "C-x C-f") 'projectile-find-file)

(eval-after-load "sgml-mode"
  '(progn
     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (add-hook 'sgml-mode-hook (lambda () (tagedit-mode 1)))))

(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(defun next-emacs-buffer ()
  "Switch to the next emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-emacs-buffer ()
  "Switch to the previous emacs buffer.
Emacs buffers are those whose name starts with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-match "^*" (buffer-name))) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))
(global-set-key (kbd "C-x n") 'next-user-buffer)
(global-set-key (kbd "C-x p") 'previous-user-buffer)
(global-set-key (kbd "C-x C-n") 'next-user-buffer)
(global-set-key (kbd "C-x C-p") 'previous-user-buffer)

(custom-set-variables
 '(eclim-eclipse-dirs '("~/program/eclipse/")))
(custom-set-variables
 '(eclim-executable "~/program/eclipse/eclim"))
(require 'eclim)
(global-eclim-mode)
(require 'eclimd)
(setq eclimd-default-workspace "~/Documents/eclipse_workspace/")
(setq eclimd-wait-for-process nil)


;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)


(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)
(setq eclim-autoupdate-problems nil)
(setq eclim-problems-hl-errors nil)
(define-key eclim-mode-map (kbd "C-c C-e d") 'eclim-java-show-documentation-for-current-element)

(require 'shell-here)
(global-set-key (kbd "C-c !") 'shell-here)
(global-set-key (kbd "C-j") 'imenu)

(require 'ac-emacs-eclim-source)

(setq compilation-scroll-output 'first-error)
(add-to-list 'auto-mode-alist '("\\.xml$" . sgml-mode))
(add-hook 'projectile-switch-project
          '(lambda () (interactive) (progn
                                     (tags-reset-tags-tables)
                                     (visit-tags-table (projectile-project-root)))))
(global-set-key (kbd "M-.") 'find-tag)

(require 'prelude-key-chord)

(defun insert-file-name ()
  "Insert the full p
ath file name into the current buffer."
  (interactive)
  (insert (get-file-name)))

(defun get-file-name ()
  (let ((file-name (file-name-sans-extension (buffer-name (window-buffer (minibuffer-selected-window))))))
    file-name))

