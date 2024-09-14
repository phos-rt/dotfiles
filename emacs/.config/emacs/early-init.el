;;; early-init.el --- Early Init File -*- lexical-binding: t; no-byte-compile: t; no-update-autoloads: t -*-

(setq package-enable-at-startup nil)

(tool-bar-mode   -1)
(menu-bar-mode   -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)
(setq visible-bell       nil
      ring-bell-function #'ignore)

;; Recommended by lsp-mode for performance. Will compile lsp-mode with
;; the plist implementation instead of the hash-table implementation,
;; which supposedly is faster.
(setenv "LSP_USE_PLISTS" "true")
