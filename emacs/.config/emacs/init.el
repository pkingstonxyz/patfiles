(use-package tokyo-night
  :vc (:url "https://github.com/bbatsov/tokyo-night-emacs" :rev "92037072b6e9a485d736bf8a7673193694410")
  :config (load-theme 'tokyo-night t))

(custom-set-variables
  '(package-selected-packages '(magit tokyo-night transient-cycles))
  '(package-vc-selected-packages '((tokyo-night :url "https://github.com/bbatsov/tokyo-night-emacs")))
  '(scroll-bar-mode nil))

(custom-set-faces)
