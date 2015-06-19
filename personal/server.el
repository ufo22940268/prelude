;; connect to remove server
(defun my-ssh (user host port)
  "Connect to a remote host by SSH."
  (let* ((port (if (equal port "") "22" port))
         (switches (list host "-l" user "-p" port)))
    (set-buffer (apply 'make-term "ssh" "ssh" nil switches))
    (term-mode)
    (term-char-mode)
    (switch-to-buffer-other-window "*ssh*")))

(setq yd-server-address "115.29.187.10")
(defun connect-to-yd()
  (interactive)
  (my-ssh "root" yd-server-address "22"))

(setq asia-server-address "116.251.217.213")
(defun connect-to-asia()
  (interactive)
  (my-ssh "root" asia-server-address "22"))

(define-key prelude-mode-map (kbd "C-c s") nil)
(global-set-key (kbd "C-c s y") 'connect-to-yd)
(global-set-key (kbd "C-c s a") 'connect-to-asia)
(global-set-key (kbd "C-c m") 'prelude-swap-windows)


;; Edit remote server
(defun server-edit (address)
  (interactive)
  (prelude-start-or-switch-to
 (lambda () (interactive) (dired (concat "/root@" address ":/root"))) "*dired yd*"))

(defun server-edit-yd ()
  (interactive)
  (server-edit yd-server-address))

(defun server-edit-asia ()
  (interactive)
  (server-edit asia-server-address))

(global-set-key (kbd "C-c v y") 'server-edit-yd)
(global-set-key (kbd "C-c v a") 'server-edit-asia)

