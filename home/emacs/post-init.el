;; post-init.el --- DESCRIPTION -*- no-byte-compile: t; lexical-binding: t; -*-

;; Misc. emacs configuration
(use-package emacs
  :init
  (pixel-scroll-precision-mode t)
  (set-face-attribute 'default nil
                      :font (font-spec 
			                 :family "FiraCode Nerd Font" 
			                 :size 10.0))
  (set-face-attribute 'fixed-pitch nil
                      :font (font-spec
                             :family "FiraCode Nerd Font"
                             :size 10.0))
  (set-face-attribute 'variable-pitch nil
                      :font (font-spec
                             :family "FiraCode Nerd Font"
                             :size 10.0))

  :hook (prog-mode . display-line-numbers-mode)

  :custom
  (undo-limit 67108864)
  (undo-strong-limit 100663296)
  (undo-outer-limit 1006632960))

;; Native compilation enhances Emacs performance by converting Elisp code into
;; native machine code, resulting in faster execution and improved
;; responsiveness.
;;
;; Ensure adding the following compile-angel code at the very beginning
;; of your `~/.emacs.d/post-init.el` file, before all other packages.
(use-package compile-angel
  :demand t
  :config
  ;; The following disables compilation of packages during installation;
  ;; compile-angel will handle it.
  (setq package-native-compile nil)

  ;; Set `compile-angel-verbose' to nil to disable compile-angel messages.
  ;; (When set to nil, compile-angel won't show which file is being compiled.)
  (setq compile-angel-verbose t)

  ;; The following directive prevents compile-angel from compiling your init
  ;; files. If you choose to remove this push to `compile-angel-excluded-files'
  ;; and compile your pre/post-init files, ensure you understand the
  ;; implications and thoroughly test your code. For example, if you're using
  ;; the `use-package' macro, you'll need to explicitly add:
  ;; (eval-when-compile (require 'use-package))
  ;; at the top of your init file.
  (push "/init.el" compile-angel-excluded-files)
  (push "/early-init.el" compile-angel-excluded-files)
  (push "/pre-init.el" compile-angel-excluded-files)
  (push "/post-init.el" compile-angel-excluded-files)
  (push "/pre-early-init.el" compile-angel-excluded-files)
  (push "/post-early-init.el" compile-angel-excluded-files)

  ;; A local mode that compiles .el files whenever the user saves them.
  ;; (add-hook 'emacs-lisp-mode-hook #'compile-angel-on-save-local-mode)

  ;; A global mode that compiles .el files prior to loading them via `load' or
  ;; `require'. Additionally, it compiles all packages that were loaded before
  ;; the mode `compile-angel-on-load-mode' was activated.
  (compile-angel-on-load-mode 1))

(use-package exec-path-from-shell
  :if (and (or (display-graphic-p) (daemonp))
           (eq system-type 'darwin)) ; macOS only
  :demand t
  :functions exec-path-from-shell-initialize
  :config
  (dolist (var '("TMPDIR"
                 "SSH_AUTH_SOCK" "SSH_AGENT_PID"
                 "GPG_AGENT_INFO"
                 ;; "FZF_DEFAULT_COMMAND" "FZF_DEFAULT_OPTS" ; fzf
                 ;; "VIRTUAL_ENV" ; Python
                 ;; "GOPATH" "GOROOT" "GOBIN" ; Go
                 ;; "CARGO_HOME" "RUSTUP_HOME" ; Rust
                 ;; "NVM_DIR" "NODE_PATH" ; Node/JS
                 "LANG" "LC_CTYPE"))
    (add-to-list 'exec-path-from-shell-variables var))
  ;; Initialize
  (exec-path-from-shell-initialize))

;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(use-package autorevert
  :ensure nil
  :commands (auto-revert-mode global-auto-revert-mode)
  :hook
  (after-init . global-auto-revert-mode)
  :init
  ;; (setq auto-revert-verbose t)
  (setq auto-revert-interval 3)
  (setq auto-revert-remote-files nil)
  (setq auto-revert-use-notify t)
  (setq auto-revert-avoid-polling nil))

;; Recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(use-package recentf
  :ensure nil
  :commands (recentf-mode recentf-cleanup)
  :hook
  (after-init . recentf-mode)

  :init
  (setq recentf-auto-cleanup (if (daemonp) 300 'never))
  (setq recentf-exclude
        (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
              "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
              "\\.7z$" "\\.rar$"
              "COMMIT_EDITMSG\\'"
              "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
              "-autoloads\\.el$" "autoload\\.el$"))

  :config
  ;; A cleanup depth of -90 ensures that `recentf-cleanup' runs before
  ;; `recentf-save-list', allowing stale entries to be removed before the list
  ;; is saved by `recentf-save-list', which is automatically added to
  ;; `kill-emacs-hook' by `recentf-mode'.
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(use-package savehist
  :ensure nil
  :commands (savehist-mode savehist-save)
  :hook
  (after-init . savehist-mode)
  :init
  (setq history-length 300)
  (setq savehist-autosave-interval 600))

;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(use-package saveplace
  :ensure nil
  :commands (save-place-mode save-place-local-mode)
  :hook
  (after-init . save-place-mode)
  :init
  (setq save-place-limit 400))

;; minibuffer (completion, commands, etc)
(use-package vertico
  :config
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :commands (marginalia-mode marginalia-cycle)
  :hook (after-init . marginalia-mode))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))

  :init
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package consult
  :bind (([remap Info-search] . consult-info) ;; search Emacs info manuals.
         ;; C-c commands
         ("C-c h" . consult-history) ;; browse input history in any context.
         ;; C-x commands
         ("C-x b" . consult-buffer) ;; buffer switcher
         ("C-x 4 b" . consult-buffer-other-window) ;; buffer switcher, open in another window.
         ("C-x 5 b" . consult-buffer-other-frame) ;; buffer switcher, open in another frame.
         ("C-x t b" . consult-buffer-other-tab) ;; buffer switcher, open in another tab.
         ("C-x p b" . consult-project-buffer) ;; buffer switcher, limited to current project.
         ;; M-g commands
         ("M-g e" . consult-compile-error) ;; jump to compilation error.
         ("M-g f" . consult-flycheck) ;; jump to flymake diagnostic.
         ("M-g i" . consult-imenu) ;; jump to function/class/heading.
         ;; M-s commands
         ("M-s l" . consult-line) ;; search lines in current buffer.
         ("M-s g" . consult-ripgrep) ;; search with ripgrep.
         ("M-s e" . consult-isearch-history) ;; browse previous isearch search terms.
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))

  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-window))

;; in-buffer completion

(use-package corfu
  :commands (corfu-mode global-corfu-mode)

  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))

  :bind (:map corfu-map
              ("RET" . nil))

  :custom
  (read-extended-command-predicate #'command-completion-default-include-p)
  (text-mode-ispell-word-completion nil)
  (tab-always-indent 'complete)

  :config
  (setq corfu-auto t
        corfu-auto-delay 0
        corfu-auto-prefix 0
        corfu-auto-trigger "."
        corfu-quit-no-match 'separator)
  (corfu-popupinfo-mode 1))

(use-package nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package cape
  :commands (cape-dabbrev cape-file cape-elisp-block)
  :bind ("C-c p" . cape-prefix-map)

  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

;; undo-fu
(use-package undo-fu
  :commands (undo-fu-only-undo
             undo-fu-only-redo
             undo-fu-only-redo-all
             undo-fu-disable-checkpoint)

  :config
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z") 'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

(use-package undo-fu-session
  :commands undo-fu-session-global-mode
  :hook (after-init . undo-fu-session-global-mode))

;; evil-mode
(use-package evil
  :commands (evil-mode evil-define-key)
  :hook (after-init . evil-mode)

  :init
  (setq evil-want-integration t
        evil-want-fine-undo t
        evil-want-C-u-scroll t
        evil-want-keybinding nil)

  :custom
  (evil-undo-system 'undo-fu)
  (evil-split-window-below t)
  (evil-vsplit-window-right t))

(use-package evil-collection
  :after evil

  :init
  (setq evil-collection-setup-minibuffer t)

  :config
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

(use-package evil-surround
  :after evil
  :hook (after-init . global-evil-surround-mode))

;; matching pairs/delimiter handling
(use-package elec-pair
  :ensure nil
  :commands (electric-pair-mode
             electric-pair-local-mode
             electric-pair-delete-mode)

  :hook (after-init . electric-pair-mode))


;; nerd-icons
(use-package nerd-icons)

;; ligature
(use-package ligature
  :config
  (ligature-set-ligatures 't '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
                                "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
                                "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
                                "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
                                ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
                                "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
                                "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
                                "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
                                ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
                                "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
                                "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
                                "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

  (global-ligature-mode t))

;; doom-modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)

  :custom
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-buffer-file-name-style 'auto)
  (doom-modeline-minor-modes nil)
  (doom-modeline-enable-buffer-position t)
  (doom-modeline-modal t)
  (doom-modeline-battery t)
  (doom-modeline-buffer-encoding nil))

;; themes
(use-package doom-themes
  :demand t
  :config
  (add-to-list 'custom-theme-load-path "~/custom-emacs-config/themes/")
  (load-theme 'doom-gruvbox-material t))

;; tree-sitter
(use-package treesit-auto
  :demand t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; centaur-tabs (prettier tabs)
(use-package centaur-tabs
  :demand 
  :config
  (centaur-tabs-mode t)
  (centaur-tabs-headline-match)
  (setq centaur-tabs-style "alternate")
  (setq centaur-tabs-height 28)
  (setq centaur-tabs-icon-type 'nerd-icons)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-modified-marker t)

  :bind
  ("C-<prior>" . 'centaur-tabs-backward)
  ("C-<next>" . 'centaur-tabs-forward))

;; treemacs (file tree)
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))

  :config
  (progn
    (setq treemacs-collapse-dirs 3)))

(use-package treemacs-nerd-icons
  :ensure t
  :config
  (treemacs-nerd-icons-config))

;; code folding
(use-package kirigami
  :commands (kirigami-open-fold
             kirigami-open-fold-rec
             kirigami-close-fold
             kirigami-toggle-fold
             kirigami-open-folds
             kirigami-close-folds-except-current
             kirigami-close-folds)
  :bind
  (("C-c z o" . kirigami-open-fold)          ; Open fold at point
   ("C-c z O" . kirigami-open-fold-rec)      ; Open fold recursively
   ("C-c z r" . kirigami-open-folds)         ; Open all folds
   ("C-c z c" . kirigami-close-fold)         ; Close fold at point
   ("C-c z m" . kirigami-close-folds)        ; Close all folds
   ("C-c z a" . kirigami-toggle-fold)))      ; Toggle fold at point      
