(setq initial-scratch-message (concat "\
;; Welcome to emacs. Right now it's: " (current-time-string)))
(setq inhibit-startup-screen t)
(setq initial-buffer-choice "~/.config/emacs/mylife.org")
(global-display-line-numbers-mode)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(use-package meow
  :ensure t
  :config
  (defun meow-setup ()
     (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
     (meow-motion-overwrite-define-key
      '("j" . meow-next)
      '("k" . meow-prev)
      '("<escape>" . ignore))
     (meow-leader-define-key
      ;; Use SPC (0-9) for digit arguments.
      '("1" . meow-digit-argument)
      '("2" . meow-digit-argument)
      '("3" . meow-digit-argument)
      '("4" . meow-digit-argument)
      '("5" . meow-digit-argument)
      '("6" . meow-digit-argument)
      '("7" . meow-digit-argument)
      '("8" . meow-digit-argument)
      '("9" . meow-digit-argument)
      '("0" . meow-digit-argument)
      '("/" . meow-keypad-describe-key)
      '("?" . meow-cheatsheet))
     (meow-normal-define-key
      '("0" . meow-expand-0)
      '("9" . meow-expand-9)
      '("8" . meow-expand-8)
      '("7" . meow-expand-7)
      '("6" . meow-expand-6)
      '("5" . meow-expand-5)
      '("4" . meow-expand-4)
      '("3" . meow-expand-3)
      '("2" . meow-expand-2)
      '("1" . meow-expand-1)
      '("-" . negative-argument)
      '(";" . meow-reverse)
      '("," . meow-inner-of-thing)
      '("." . meow-bounds-of-thing)
      '("[" . meow-beginning-of-thing)
      '("]" . meow-end-of-thing)
      '("a" . meow-append)
      '("A" . meow-open-below)
      '("b" . meow-back-word)
      '("B" . meow-back-symbol)
      '("c" . meow-change)
      '("d" . meow-delete)
      '("D" . meow-backward-delete)
      '("e" . meow-next-word)
      '("E" . meow-next-symbol)
      '("f" . meow-find)
      '("g" . meow-cancel-selection)
      '("G" . meow-grab)
      '("h" . meow-left)
      '("H" . meow-left-expand)
      '("i" . meow-insert)
      '("I" . meow-open-above)
      '("j" . meow-next)
      '("J" . meow-next-expand)
      '("k" . meow-prev)
      '("K" . meow-prev-expand)
      '("l" . meow-right)
      '("L" . meow-right-expand)
      '("m" . meow-join)
      '("n" . meow-search)
      '("o" . meow-block)
      '("O" . meow-to-block)
      '("p" . meow-yank)
      '("q" . meow-quit)
      '("Q" . meow-goto-line)
      '("r" . meow-replace)
      '("R" . meow-swap-grab)
      '("s" . meow-kill)
      '("t" . meow-till)
      '("u" . meow-undo)
      '("U" . meow-undo-in-selection)
      '("v" . meow-visit)
      '("w" . meow-mark-word)
      '("W" . meow-mark-symbol)
      '("x" . meow-line)
      '("X" . meow-goto-line)
      '("y" . meow-save)
      '("Y" . meow-sync-grab)
      '("z" . meow-pop-selection)
      '("'" . repeat)
      '("<escape>" . ignore)))
  (meow-setup)
  (meow-global-mode 1)
  ;; Force eat-mode to always start in insert (passthrough) mode
  (add-to-list 'meow-mode-state-list '(eat-mode . insert)))

(use-package meow-tree-sitter
  :ensure t
  :config
  (meow-tree-sitter-register-defaults))

(use-package ligature
  :vc (:url "https://github.com/mickeynp/ligature.el" :rev "6ac1634612dbd42f7eb81ecaf022bd239aabb954")
  :config   ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(add-to-list 'default-frame-alist
       '(font . "Fira Code-13"))
(with-eval-after-load 'org
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.4 :weight bold))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.25 :weight bold))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.15 :weight semi-bold))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.05 :weight semi-bold)))))
  (setq org-hide-leading-stars t)
  (setq org-superstar-headline-bullets-list '("•"))
  ;; Hide emphasis markers like /italic/ or *bold* (renders just the styled text)
  (setq org-hide-emphasis-markers t)
  ;; Use pretty replacements for things like lambda, arrows, etc.
  (setq org-pretty-entities t)
  ;; Require subscripts to be in {}
  (setq org-use-sub-superscripts '{})
  (setq org-display-inline-images t)
  ;; Automatically wrap long lines
  (add-hook 'org-mode-hook 'visual-line-mode))

(use-package gruvbox-theme
             :ensure t
             :config
             (load-theme 'gruvbox-dark-medium t))

(use-package transient-cycles
             :ensure t)
(use-package magit
             :ensure t)
(use-package treesit-auto
  :ensure t
  :config
  (setq treesit-auto-langs (delete 'elisp treesit-auto-langs))  ; Defend elisp
  (global-treesit-auto-mode))

;; Rename Python tree sitter to Python-TS so that it's showing
(add-hook 'python-ts-mode-hook
          (lambda ()
            (setq mode-name "Python-TS")))

(use-package eglot
  :ensure nil ;; Built-in, no download needed
  :hook ((python-ts-mode) . eglot-ensure))

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))

(use-package diff-hl
  :ensure t
  :init
  (global-diff-hl-mode)
  :config
  (global-diff-hl-amend-mode)
  (diff-hl-flydiff-mode 1))

(use-package dape
  :ensure t
  :config
  (setq dape-request-timeout 120)
  (add-to-list 'dape-configs
    '(ansible-module
      modes (python-mode python-ts-mode)
      command "~/Projects/ansible/bin/debug-adapter.sh"
      command-args ()
      :request "attach"
      :type "python"
      :listen (:host "127.0.0.1" :port 5678)
      :justMyCode nil
      :showReturnValue t)
    `(debugpy
      modes (python-mode python-ts-mode)
      command "python3"
      command-args ("-m" "debugpy.adapter")
      :type "executable"
      :request "launch"
      :cwd dape-cwd-fn
      :program dape-find-file-buffer-default))
  (defun my/dape-ansible ()
    "Start ansible module debug listener"
    (interactive)
    (dape (alist-get 'ansible-module dape-configs)))
  (global-set-key (kbd "C-c d a") #'my/dape-ansible))

(use-package eat
  :ensure t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :ensure t
  :bind (("C-s" . consult-line) ; Search current buffer
         ("M-g g" . consult-ripgrep))) ; Live grep across the project (Requires ripgrep installed on your system!)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("836b0bc16dbd2aed387e552edabd4d67d227961efa3af412da387eb3e010d76b"
     "5a0ddbd75929d24f5ef34944d78789c6c3421aa943c15218bac791c199fc897d"
     default))
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(consult dape diff-hl eat envrc gnu-elpa-keyring-update gruvbox-theme
	     ligature magit meow meow-tree-sitter orderless
	     transient-cycles treesit-auto vertico))
 '(package-vc-selected-packages
   '((ligature :url "https://github.com/mickeynp/ligature.el")))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(vc-follow-symlinks nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :height 1.4 :weight bold))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.25 :weight bold))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.15 :weight semi-bold))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.05 :weight semi-bold)))))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 

