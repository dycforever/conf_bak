;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another 
;; package (Gnus, auth-source, ...).
(load-file "~/lisp/cedet-1.1/common/cedet.el")

;; locale coding 
(setq locale-coding-system'utf-8) 
(prefer-coding-system'utf-8) 
(set-keyboard-coding-system'utf-8) 
(set-terminal-coding-system'utf-8) 
(set-selection-coding-system'utf-8) 
(set-clipboard-coding-system 'ctext) 
(set-buffer-file-coding-system 'utf-8) 

(global-set-key  [C-left] 'windmove-left)
(global-set-key  [C-right] 'windmove-right)
(global-set-key  [C-up] 'windmove-up)
(global-set-key  [C-down] 'windmove-down)

;;ha2 related
(load-file "~/lisp/index-engine-tools.el")
(require 'index-engine-tools)
(add-hook 'c-mode-hook
  (lambda ()
    (set (make-local-variable 'compile-command) "scons -D . -j6")))
(add-hook 'c++-mode-hook
  (lambda ()
    (set (make-local-variable 'compile-command) "scons -D . -j6")))

(load-file "~/lisp/vespa-style.el")
(require 'vespa-style)
(add-hook 'c-mode-common-hook 'vespa-c-mode-hook)

;;c++ related
(add-hook 'c++-mode-hook
      '(lambda ( )
         (c-toggle-hungry-state)))
(add-hook 'c++-mode-hook
      '(lambda ( )
         (flyspell-prog-mode)))

(add-hook 'c++-mode-hook
      '(lambda ( )
         (c-set-style "vespa")))

(setq auto-mode-alist
     (cons '("\\.h\\'" . c++-mode) auto-mode-alist))
(setq compile-command "scons -j6 -D .")
(add-to-list 'auto-mode-alist
'("\\..pp\\'" . c++-mode))

(add-to-list 'auto-mode-alist
'("\\.ll\\'" . c++-mode))

(add-to-list 'auto-mode-alist
'("\\.yy\\'" . c++-mode))

;;c-mode related
(add-hook 'c-mode-hook
      '(lambda ( )
         (c-toggle-hungry-state)))
(add-hook 'c-mode-hook
      '(lambda ( )
         (flyspell-prog-mode)))

(load-file "~/lisp/xcscope.el")
(add-hook 'c-mode-common-hook
	    '(lambda ()
	           (require 'xcscope)))


;;customized key bindings following

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)


(autoload 'wikipedia-mode "wikipedia-mode.el"
"Major mode for editing documents in Wikipedia markup." t)

(add-to-list 'auto-mode-alist
'("\\.wiki\\'" . wikipedia-mode))

(add-to-list 'auto-mode-alist
'("asc\\.alibaba\\-inc\\.com_index\\.php" . wikipedia-mode))


;;set colors
(set-foreground-color "grey")
(set-background-color "black")
(set-cursor-color "grey")
(set-mouse-color "gold1")

;;(set-scroll-bar-mode nil)

;;set line number
(setq column-number-mode t)
(setq line-number-mode t)

;;parentheses settings
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;transient-mark-mode
(setq transient-mark-mode t);

;;compilation settings
(defun my-compile()
  "Save buffers and start compile"
  (interactive)
  (save-some-buffers t)
  (switch-to-buffer-other-window "*compilation*")
  (compile compile-commmand))
(global-set-key [C-f5] 'compile)
(global-set-key [f5] 'my-compile)
(global-set-key [f7] 'revert-buffer)

;;eshell settings
(defun open-eshell-other-buffer()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))
(global-set-key [f8] 'open-eshell-other-buffer)
(global-set-key [C-f8] 'eshell)



;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode,
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode,
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberant ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languages only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)


;;add system include path
;;(semantic-add-system-include "/usr/local/include" 'c++-mode)
;;(semantic-add-system-include "/usr/include" 'c++-mode)
;;(semantic-add-system-include "/usr/include/c++/4.3.0" 'c++-mode)
;;(semantic-add-system-include "/usr/include/c++/4.3.0" 'c-mode)
;;(semantic-add-system-include "~/svn/isearch_4_5/src" 'c++-mode)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;;enables the database and idle reparse enginesr*
(semantic-load-enable-minimum-features)

;;enables some tools useful for coding, such as summary mode
;;imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;;ido
(require 'ido)
(ido-mode t)

(add-hook 'ido-define-mode-map-hook 'my-ido-keys)
(defun my-ido-keys ()
  "Set up the keymap for `ido'."
  ;; basic config
  (define-key ido-mode-map "C-e" 'ido-edit-input);;ido mode
  ;(define-key ido-mode-map "t" 'ido-complete) ;;complete partial
  (define-key ido-mode-map "C-c" 'ido-complete)
  (define-key ido-mode-map "C-j" 'ido-select-text)
  (define-key ido-mode-map "C-m" 'ido-exit-minibuffer);;exit minibuffer
  (define-key ido-mode-map "?" 'ido-completion-help) ;; list matched
  ;;filter files step by step
  (define-key ido-mode-map [(control ? )] 'ido-restrict-to-matches)
  (define-key ido-mode-map [(control ?@)] 'ido-restrict-to-matches)
  ;; select files
  (define-key ido-mode-map "C-r" 'ido-prev-match)
  (define-key ido-mode-map "C-s" 'ido-next-match)
  (define-key ido-mode-map [right] 'ido-next-match)
  (define-key ido-mode-map [left] 'ido-prev-match)
  ;; switch
  (define-key ido-mode-map "C-t" 'ido-toggle-regexp) ;;reg match
  (define-key ido-mode-map "C-p" 'ido-toggle-prefix) ;;prefix match
  (define-key ido-mode-map "C-c" 'ido-toggle-case)   ;;case match
  (define-key ido-mode-map "C-a" 'ido-toggle-ignore) ;;ignore some files
  ;; key define in file/folder mod
  (when (memq ido-cur-item '(file dir))
    (define-key ido-mode-map "C-b" 'ido-enter-switch-buffer);;éæbufferæå
    (define-key ido-mode-map "C-d" 'ido-enter-dired) ;;Diredæå
    (define-key ido-mode-map "C-f" 'ido-fallback-command)
    ;; cycle switch in folder
    ;; use [left] and [right] to match
    (define-key ido-mode-map [down] 'ido-next-match-dir)
    (define-key ido-mode-map [up]   'ido-prev-match-dir)
    ;; backspace define
    (define-key ido-mode-map [backspace] 'ido-delete-backward-updir)
    ;(define-key ido-mode-map "d"        'ido-delete-backward-updir)
    (define-key ido-mode-map [(meta backspace)] 'ido-delete-backward-word-updir)
    (define-key ido-mode-map [(control backspace)] 'ido-up-directory)
    ;; 
    (define-key ido-mode-map [(meta ?d)] 'ido-wide-find-dir)
    (define-key ido-mode-map [(meta ?f)] 'ido-wide-find-file)
    (define-key ido-mode-map [(meta ?k)] 'ido-forget-work-directory)
    (define-key ido-mode-map [(meta ?m)] 'ido-make-directory)
    (define-key ido-mode-map [(meta down)] 'ido-next-work-directory)
    (define-key ido-mode-map [(meta up)] 'ido-prev-work-directory)
    (define-key ido-mode-map [(meta left)] 'ido-prev-work-file)
    (define-key ido-mode-map [(meta right)] 'ido-next-work-file)
    ;; search in directories
    ;; C-_ to undo
    (define-key ido-mode-map [(meta ?s)] 'ido-merge-work-directories)
    (define-key ido-mode-map [(control ?\_)] 'ido-undo-merge-work-directory)
    )
  (when (eq ido-cur-item 'file)
    (define-key ido-mode-map "C-k" 'ido-delete-file-at-head)
    (define-key ido-mode-map "C-l" 'ido-toggle-literal)
    (define-key ido-mode-map "C-o" 'ido-copy-current-word)
    (define-key ido-mode-map "C-v" 'ido-toggle-vc)
    (define-key ido-mode-map "C-w" 'ido-copy-current-file-name)
    )

  (when (eq ido-cur-item 'buffer)
    (define-key ido-mode-map "C-b" 'ido-fallback-command)
    (define-key ido-mode-map "C-f" 'ido-enter-find-file)
    (define-key ido-mode-map "C-k" 'ido-kill-buffer-at-head)
    ))

;; smart complitions
(require 'semantic-ia)

;;cache path for semanticdb
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semantic.cache/semanticdb"))

;;eassist
(require 'eassist)

;; customisation of modes
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
;;  (local-set-key "\M-/" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  )
;;(add-hook 'semantic-init-hooks 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'lisp-mode-hook 'my-cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'my-cedet-hook)
;; (add-hook 'erlang-mode-hook 'my-cedet-hook)

(defun my-c-mode-cedet-hook ()
;; (local-set-key "." 'semantic-complete-self-insert)
;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(fset 'move_next_file_end
   "\C-xo\C-[>")

(menu-bar-mode)

(require 'ansi-color)
(add-hook 'compilation-filter-hook
          '(lambda ()
             (let ((min (point-min-marker))
                   (max (point-max-marker)))
               (ansi-color-apply-on-region min max))))

(setq backup-by-copying-when-linked t)
(setq compilation-scroll-output t)
(setq truncate-partial-width-windows nil)


;; highlight space characters at tail
;; set colors

(custom-set-faces
 '(my-tab-face            ((((class color)) (:background "grey10"))) t)
 '(my-trailing-space-face ((((class color)) (:background "gray10"))) t)
 '(my-long-line-face ((((class color)) (:background "tomato"))) t))

 

;; define assist function
(defun cc-mode-add-keywords (mode)
  (font-lock-add-keywords
   mode
   '(("\t+" (0 'my-tab-face append))
     ("^.\\{81\\}\\(.+\\)$" (1 'my-long-line-face append)))))

 

;; Only valid in specified mode
(cc-mode-add-keywords 'c-mode)
(cc-mode-add-keywords 'cc-mode)
(cc-mode-add-keywords 'c++-mode)
(cc-mode-add-keywords 'perl-mode)
(cc-mode-add-keywords 'python-mode)

;;pdb setup, note the python version
;;(setq pdb-path '/usr/ali/lib/python2.5/pdb.py
(setq pdb-path '/usr/lib64/python2.4/pdb.py
       gud-pdb-command-name (symbol-name pdb-path))
(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline pdb-path
			    (file-name-nondirectory buffer-file-name)))))
