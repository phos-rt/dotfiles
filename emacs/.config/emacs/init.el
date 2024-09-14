(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
			  :ref nil :depth 1
			  :files (:defaults "elpaca-test.el" (:exclude "extensions"))
			  :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
   (build (expand-file-name "elpaca/" elpaca-builds-directory))
   (order (cdr elpaca-order))
   (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
	(if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
		 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
						 ,@(when-let ((depth (plist-get order :depth)))
						     (list (format "--depth=%d" depth) "--no-single-branch"))
						 ,(plist-get order :repo) ,repo))))
		 ((zerop (call-process "git" nil buffer t "checkout"
				   (or (plist-get order :ref) "--"))))
		 (emacs (concat invocation-directory invocation-name))
		 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
				   "--eval" "(byte-recompile-directory \".\" 0 'force)")))
		 ((require 'elpaca))
		 ((elpaca-generate-autoloads "elpaca" repo)))
	    (progn (message "%s" (buffer-string)) (kill-buffer buffer))
	  (error "%s" (with-current-buffer buffer (buffer-string))))
  ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(setq custom-file (expand-file-name "customs.el" user-emacs-directory))
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

(elpaca elpaca-use-package
  (elpaca-use-package-mode))

(use-package ef-themes
  :ensure t
  :demand t)

(use-package solaire-mode
  :ensure t
  :config
  (solaire-global-mode 0))

(use-package corfu
  :ensure t
  :config
  (setq corfu-auto  t
	corfu-cycle t
	corfu-auto-prefix 2)
  (global-corfu-mode t))

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-log-io nil
	gc-cons-threshold 100000000
	read-process-output-max (* 1024 1024)) ;; 1 mb
  :config
  (add-hook 'c-ts-mode-hook          #'lsp-deferred)
  (add-hook 'c++-ts-mode-hook        #'lsp-deferred)
  (add-hook 'typescript-ts-mode-hook #'lsp-deferred))

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))

(use-package lsp-ui
  :ensure t
  :config
  (add-hook 'lsp-ui-doc-frame-mode-hook
		#'(lambda () (display-line-numbers-mode -1))))

(defun lsp-pre-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(add-hook 'c-ts-mode-hook #'lsp-pre-save-hooks)

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode)
  (setq treesit-auto-install 'prompt))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs (list (expand-file-name (concat user-emacs-directory "snippets"))))
  (yas-global-mode))

(setq typescript-ts-mode-indent-offset 2)

(use-package nasm-mode
  :ensure t)

(setq-default tab-width 4
			  indent-tabs-mode nil)

(use-package evil
  :ensure t
  :demand t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package general
  :ensure t
  :after org
  :config
  (general-create-definer gr-main-leader-def :prefix ";")

  (gr-main-leader-def
   :keymaps 'normal
   "ce"         #'lsp-execute-code-action
   "cd"         #'lsp-ui-doc-glance
   "cD"         #'lsp-describe-thing-at-point
   "csd"        #'lsp-find-definition
   "csr"        #'lsp-find-references
   "csR"        #'lsp-rename
   "of"         #'org-roam-node-find
   "oi"         #'org-roam-node-insert
   "oc"         #'org-roam-capture
   "nb"         #'consult-buffer
   "nf"         #'ido-find-file
   "er"          '(lambda ()
		    (interactive)
		    (org-babel-tangle-file (concat user-emacs-directory "init.org"))
		    (load-file (concat user-emacs-directory "init.el")))))

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-add-key-based-replacements
   "; e"   "emacs"
   "; er"  "reload configuration"
   "; c"   "code"
   "; ce"  "execute action"
   "; cd"  "describe"
   "; cD"  "describe better"
   "; cs"  "symbols"
   "; csd" "find definition"
   "; csr" "find references"
   "; csR" "rename"
   "; n"   "navigation"
   "; nb"  "switch buffer"
   "; nf"  "find file"
   "; o"   "org-roam"
   "; of"  "find"
   "; oi"  "insert"
   "; oc"  "capture"))

(use-package vertico
  :ensure t
  :init (vertico-mode))

(use-package marginalia
  :ensure t
  :init (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :ensure t)

(use-package embark
  :ensure t)

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-'") #'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(defun gora/org-roam-insert-created-property ()
  (when (org-roam-file-p)
    (save-excursion
  (goto-char (point-min))
  (org-set-property "CREATED" (format-time-string "[%Y-%m-%d %a %H:%M]")))))

(defun gora/org-roam-insert-modified-property ()
  (when (org-roam-file-p)
    (save-excursion
  (goto-char (point-min))
  (org-set-property "MODIFIED" (format-time-string "[%Y-%m-%d %a %H:%M]")))))

(use-package org-roam
  :ensure t
  :config
  (make-directory (concat (getenv "HOME") "/cloud/secrets/records") t)
  (setq
   org-roam-directory   (concat (getenv "HOME") "/cloud/secrets/records")
   org-roam-db-location (concat (getenv "HOME") "/cloud/secrets/org-roam.db")
   org-roam-dailies-directory (concat (getenv "HOME") "/cloud/secrets/journal")
   org-roam-dailies-capture-templates
   '(("d" "default" entry
  "* %?"
  :target (file+head "%<%Y-%m-%d>.org"
			 "#+title: %<%Y-%m-%d>\n"))))

  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode)
  (add-hook 'org-roam-capture-new-node-hook #'gora/org-roam-insert-created-property)
  (add-hook 'before-save-hook               #'gora/org-roam-insert-modified-property))

(use-package org-roam-ui
  :after org-roam
  :ensure t
  :config
  (setq org-roam-ui-sync-theme t
	org-roam-ui-follow t
	org-roam-ui-update-on-save t
	org-roam-ui-open-on-start t))

(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(setq
 ; save every 20 characters
 auto-save-interval 20
 ; save after 15 seconds if stop typing
 auto-save-timeout 15
 ; copy files instead of renaming them
 backup-by-copying t
 ; newest backups to keep
 kept-new-versions 10
 ; oldest backups to keep, anything between the newest and oldest will
 ; be deletec
 kept-old-versions 10
 ; don't ask before deleting backup files
 delete-old-versions t
 ; use version numbers for backups
 version-control t
 ; backup files even in a project with version-control
 vc-make-backup-files t
 ; where to store backups
 backup-directory-alist `((".*" . "~/tmp/ebackup/")))

; save the file directly instead of saving it in an #auto-save# file
(add-hook 'after-init-hook #'auto-save-visited-mode)

(defun save-all ()
  "Save all the buffers silently."
  (interactive)
  (save-some-buffers t))

; save them each time you change between buffers
(add-hook 'focus-out-hook #'save-all)

(setq org-agenda-files `(,(concat (getenv "HOME") "/cloud/secrets/journal")))

(setq org-agenda-custom-commands
  '(
	("D" "block agenda"
	 ((tags-todo "*"
		     ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
		  (org-agenda-skip-function
		   `(org-agenda-skip-entry-if
			 'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
		  (org-agenda-block-separator nil)
		  (org-agenda-overriding-header "Important tasks without a date\n")))
	  (todo "WAIT"
		((org-agenda-block-separator nil)
		 (org-agenda-overriding-header "\nTasks on hold\n")))
	  (agenda ""
		  ((org-agenda-block-separator nil)
		   (org-agenda-span 1)
		   (org-deadline-warning-days 0)
		   (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
		   (org-agenda-overriding-header "\nDaily agenda\n")))
	  (agenda ""
		  ((org-agenda-block-separator nil)
		   (org-agenda-start-day "+1d")
		   (org-agenda-span 3)
		   (org-deadline-warning-days 0)
		   (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
		   (org-agenda-skip-function `(org-agenda-skip-entry-if 'todo 'done))
		   (org-agenda-overriding-header "\nNext three days\n")))))))
