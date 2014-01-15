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
;; (global-set-key (kbd "M-n") 'forward-paragraph)
;; (global-set-key (kbd "M-p") 'backward-paragraph)

;; (global-set-key (kbd "M-n") '(lambda () (interactive) (scroll-down 1)))
;; (global-set-key (kbd "M-p") '(lambda () (interactive) (scroll-up 1)))

(define-key global-map (kbd "RET") 'newline-and-indent)

(add-to-list 'load-path "~/.emacs.d/elpa/inf-mongo-20130305.127/")
(require 'inf-mongo)

(defun insert-pdb-debug ()
  (interactive)
  (progn
    (beginning-of-line)
    (open-line 1)
    (indent-for-tab-command)
    (insert "import pdb; pdb.set_trace()")))

(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "<S-left>") nil)
     (define-key org-mode-map (kbd "<S-right>") nil)
     (define-key org-mode-map (kbd "<S-down>") nil)
     (define-key org-mode-map (kbd "<S-up>") nil)
     (org-display-inline-images)))


(require 'zencoding-mode)
(add-hook 'html-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes
(require 'smartparens-config)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional

(scroll-bar-mode -1)

(setq scroll-preserve-screen-position 1)

(global-set-key (kbd "C-M-m") 'projectile-compile-project)

(add-hook 'find-file-hook (lambda () (setq buffer-save-without-query t)))

(global-set-key (kbd "C-c p p") 'projectile-debug-project)


(setq android-mode-sdk-dir "~/program/adt-bundle-mac-x86_64-20130219/sdk/")
(require 'android-mode)
(load-file "~/.emacs.d/personal/android.el")

(add-hook 'term-mode-hook (lambda()
                            (yas-minor-mode -1)))

(setq projectile-switch-project-action 'projectile-dired)
(global-set-key (kbd "M-.") 'projectile-find-tag)

(define-key yas-minor-mode-map (kbd "TAB") nil)

(eval-after-load "html-mode"
  '(progn
     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))

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

(require 'shell-here)
(global-set-key (kbd "C-c !") 'shell-here)
(global-set-key (kbd "C-c i") 'imenu)

(setq compilation-scroll-output 'first-error)
;; (add-to-list 'auto-mode-alist '("\\.xml$" . sgml-mode))
(add-hook 'projectile-switch-project
          '(lambda () (interactive) (progn
                                     (tags-reset-tags-tables)
                                     (visit-tags-table (projectile-project-root)))))

(global-set-key (kbd "M-.") 'projectile-find-tag)

(require 'prelude-key-chord)

(defun insert-file-name ()
  "Insert the full p
ath file name into the current buffer."
  (interactive)
  (insert (get-file-name)))

(defun get-file-name ()
  (let ((file-name (file-name-sans-extension (buffer-name (window-buffer (minibuffer-selected-window))))))
    file-name))
(global-set-key [f2] 'insert-file-name)

;;vim like gd implement in emacs.
(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

(add-to-list 'projectile-project-root-files "AndroidManifest.xml")
(setq projectile-remember-window-configs t)

(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "^")
              (lambda () (interactive) (find-alternate-file "..")))
                                        ; was dired-up-directory
            ))

(global-set-key (kbd "C-c C-h e") 'helm-etags-select)
(global-set-key (kbd "C-h j") 'javadoc-lookup)
(global-set-key (kbd "C-c RET i") 'add-java-import)

(require 'javadoc-lookup)
(javadoc-add-roots "/Users/ccheng/program/adt-bundle-mac-x86_64-20130219/sdk/docs/reference")
(javadoc-add-artifacts [com.squareup.dagger dagger "1.0.1"])

(defun launch-android-logcat ()
  (interactive)
  (let ((log-buffer (get-buffer "*android-logcat*")))
    (if log-buffer
        (switch-to-buffer-other-window "*android-logcat*")
      (android-logcat))))
(global-set-key (kbd "C-c RET l") 'launch-android-logcat)

;;; Make ansi-term won't hide bottom line when the content fill all the screen.
(setq term-scroll-show-maximum-output 100)

(global-set-key (kbd "C-x C-c") nil)
(global-set-key (kbd "C-x r q") 'save-buffers-kill-terminal)

;;; Set the highlight color of theme
(set-face-attribute 'region nil :background "#666")

(require 'dired-single)

(setq sql-user "root")
(setq sql-password "aa")
(setq sql-server "127.0.0.1")

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Enable html mode for go template files. If found better mode for the template, replace it.
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . html-mode))

;; kill preivous compilation without prompt.
(add-hook 'compilation-start-hook 'kill-compilation)

;; disable auto save feature when in tramp mode.
(setq backup-enable-predicate
      (lambda (name)
        (and (normal-backup-enable-predicate name)
             (not
              (let ((method (file-remote-p name 'method)))
                (when (stringp method)
                  (member method '("su" "sudo"))))))))

(global-set-key (kbd "C-c a L") 'org-timeline)

(require 'goto-chg)
(global-set-key (kbd "C-.") 'goto-last-change)
(global-set-key (kbd "C-,") 'goto-last-change-reverse)
