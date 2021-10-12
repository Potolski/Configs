(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e6ccd0cc810aa6458391e95e4874942875252cd0342efd5a193de92bfbb6416b" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" default)))
 '(fill-column 80)
 '(org-confirm-babel-evaluate nil)
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (ox-gfm csharp-mode dart-mode indium plantuml-mode gandalf-theme sqlformat sqlup-mode sql-indent fsharp-mode solarized-theme)))
 '(safe-local-variable-values
   (quote
    ((org-html-postamble-format
      ("en" "<p class=\"author\">Author: %a (%e)</p>"))
     (org-html-postamble . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(load-theme 'solarized-light t)


(org-babel-do-load-languages
   'org-babel-load-languages
   '((dot     . t)
     (latex   . t)
     (shell   . t)
     (python  . t)
     (js      . t)
     (java    . t)
     (scheme  . t)
     (plantuml . t)
     (org    . t)))

(setq org-plantuml-jar-path "/home/david/java/plantuml.jar")
(setq ring-bell-function 'ignore)
(setq org-babel-python-command "python3")

(global-set-key [(meta  up)]  'move-line-up)
(global-set-key [(meta down)]  'move-line-down)

(require 'ox-taskjuggler)
(setq org-taskjuggler-target-version 3.6)

(tool-bar-mode -1)
(menu-bar-mode -1)
(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(server-start) (add-to-list 'default-frame-alist '(fullscreen . maximized))


(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))
