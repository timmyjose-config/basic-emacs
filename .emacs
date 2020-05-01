(require 'package)

(package-initialize)

(setq package-archives
      '(("elpa" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/"))
      package-archive-priorities
      '(("elpa" . 100)
	("melpa" . 50)
	("melpa-stable" . 25)))

;;; helper functions

(defun require-package (pkg)
  (when (not (package-installed-p pkg))
    (package-refresh-contents)
    (package-install pkg)))

(defun configure-look-and-feel ()
  (setq inhibit-startup-message t)
  (setq split-height-threshold nil)
  (setq column-number-mode t)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;;; packages

(require-package 'slime)
(require-package 'paredit)
(require-package 'exec-path-from-shell)
(require-package 'zig-mode)
(require-package 'deadgrep)
(require-package 'fzf)

;;; basic config

(add-to-list 'default-frame-alist
	     '(fullscreen . maximized) t)

(configure-look-and-feel)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;; lisp

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

;;; fzf and ripgrep

(global-set-key (kbd "M-g") #'deadgrep)
(global-set-key (kbd "M-t") #'fzf)

;;; hooks

(autoload 'enable-paredit-mode "paredit" "enable paredit" t)
(add-hook 'prog-mode-hook #'enable-paredit-mode)
(add-hook 'prog-mode-hook (lambda () (electric-pair-mode 1))) 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (fzf projectile exec-path-from-shell zig-mode monokai paredit slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
