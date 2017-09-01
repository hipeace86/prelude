(prelude-require-packages '(auto-complete fill-column-indicator molokai-theme neotree graphviz-dot-mode elpy multiple-cursors emmet-mode impatient-mode markdown-mode ox-reveal))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (molokai)))
 '(custom-safe-themes
   (quote
    ("b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" default)))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (slim-mode slime tangotango-theme dockerfile-mode php-mode yaml-mode go-mode json-mode lua-mode ox-reveal markdown-mode impatient-mode emmet-mode multiple-cursors elpy graphviz-dot-mode neotree molokai-theme fill-column-indicator auto-complete vkill exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line operate-on-number move-text magit projectile ov imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl easy-kill diminish diff-hl discover-my-major dash crux browse-kill-ring beacon anzu ace-window)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun load-molokai-theme()(load-theme 'molokai t))
;; set lisp system and optionally
(setq inferior-lisp-program "sbcl")
(setq slime-contribs '(slime-fancy))
;; setup auto compute
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
;; setup fill-column
(require 'fill-column-indicator)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;; setup context menu
(global-set-key (kbd "<mouse-3>")nil)
(global-set-key (kbd "<mouse-3>")'mouse-popup-menubar-stuff)

;; setup markdown-mode
(autoload 'markdown-mode "markdown-mode"
             "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; line number format
(global-linum-mode t)
(set-face-attribute 'default nil :height 150 :family "Yahei Mono")

;; elpy config
;; system must execute:pip install elpy rope jedi
(require 'elpy nil t)
(elpy-enable)
;;(elpy-use-ipython)
(setq elpy-rpc-backend "jedi")
(add-hook 'python-mode-hook (lambda() (py-autopep8-enable-on-save)))

(require 'multiple-cursors)
;; global keybinding for multiple-cursor
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; html-mode auto setting
(add-hook 'html-mode-hook (lambda () (emmet-mode 1)))
(add-hook 'html-mode-hook (lambda () (impatient-mode 1)))
;; (add-hook 'org-mode-hook (lambda () (load-theme 'tangotango t)))

(require 'yasnippet)
(yas-global-mode 1)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)
   (python . t)
   (js . t)))
(require 'ox-reveal)
;;(setq org-reveal-root "file:///data/www/reveal.js")

(defun fci-mode-override-advice (&rest args))
(advice-add 'org-html-fontify-code :around
            (lambda (fun &rest args)
              (advice-add 'fci-mode :override #'fci-mode-override-advice)
              (let ((result  (apply fun args)))
                (advice-remove 'fci-mode #'fci-mode-override-advice)
                result)))
