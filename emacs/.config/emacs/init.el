(require 'package)
(setq package-enable-at-startup nil)

;;; repositories to fetch packages from
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(org-babel-load-file
  (expand-file-name
    (concat user-emacs-directory "/conf.org")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 '("515ebca406da3e759f073bf2e4c8a88f8e8979ad0fdaba65ebde2edafc3f928c" "9ed206ff6874db89cb4a588c6cdc75a7b056fecbc9880e9758881bdef6d9d79a" "4871b9580169db848da98ba561259089fd83cbbe7b12481db6ca2d906a844154" "2777f300b438d2d061560c6a1afac9723e7f840413b12a471055428269ee17dd" "3b5bac2bef0c51a169be7e9b5f80414e662e5eb2e3e3cf126873325e9344d26e" "6631f884f5f43e9d8eee42f5bcf8522a7f791688d2d2667ec135c129066be243" "2ca3da7d36b0d326f984530a07be54b272b5c313b1361989acf747d8b5616162" "c2c63381042e2e4686166d5d59a09118017b39003e58732b31737deeed454f1c" "84b04a13facae7bf10f6f1e7b8526a83ca7ada36913d1a2d14902e35de4d146f" "79a8c85692a05a0ce0502168bb0e00d25f021a75d8b0136b46978bddf25e3b72" "2949f71b19f52bcee693534b6b6ad8796e495eb0c676e9c94f3e33f10511eb47" "4d4475c85408bbc9d71e692dd05d55c6b753d64847f5e364d1ebec78d43e2aef" "5014b68d3880d21a5539af6ef40c1e257e9045d224efb3b65bf0ae7ff2a5e17a" "86a9bfbda652a2dd887077a4ad91afbec2fde569e26147ceb8a605976c99d8d2" "13bf32d92677469e577baa02d654d462f074c115597652c1a3fce6872502bbea" "a8a5fd1c8afea56c5943ead67442a652f1f64c8191c257d76988edb0b1ad5dfa" "9a456f2aac10f18204e8ece27c84950c359f91bb06bda8c711bf4f5095ca8250" "917d7e7f0483dc90a5e2791db980ce9bc39e109a29198c6e9bdcd3d88a200c33" "3ca84532551daa1b492545bbfa47fd1b726ca951d8be29c60a3214ced30b86f5" "438f0e2b9fd637c53b20c27c140d2fc14fa154acf9ef92630666cab497c69742" "64c4ff0a617e6bf33443821525f7feb3ef925a939c4575e77f3811c5b32e72c0" "b940c68944436ab216d83c13a05808bcacf40ac224c4aba2c209c3cbf2c76427" "b0dc32efddfd36f0a12d022ac3c79a3d6d9614558bc8a991e5a5a29be70dafe9" "779aa194815bd4f88b672856961077bc3c735cb82d05b440e981bd218749cf18" "ddb9bc949afc4ead71a8861e68ad364cd3c512890be51e23a34e4ba5a18b0ade" "76c646974f43b321a8fd460a0f5759f916654575da5927d3fd4195029c158018" "a876039e0832c9a0e11af80ffbdbb4539aede1fbdc19460290fc4d1bf3a21741" "6c655326d9bb38d4be02d364d344bfa61b3c8fdabd1cf4b97dddc8c0b3047b47" "0dfc663c336d18541ac6925f44e48cb7851f7463d7a3b201b8ae829a4b622501" "df2cdf4ffb933c929b6a95d60ac375013335b61565b9ebf02177b86e5e4d643f" "6128465c3d56c2630732d98a3d1c2438c76a2f296f3c795ebda534d62bb8a0e3" "3c7a784b90f7abebb213869a21e84da462c26a1fda7e5bd0ffebf6ba12dbd041" default))
 '(go-ts-mode-indent-offset 2)
 '(lsp-ui-doc-position 'at-point)
 '(lsp-ui-doc-show-with-mouse nil)
 '(nf-theme-dark-name 'ef-dark)
 '(package-selected-packages
	 '(dap-gdb-lldb yasnippet ocamlformat tuareg elfeed terraform-mode treemacs-projectile treemacs-evil treemacs consult projectile go-mode lsp-ui lsp-haskell awesome-tray org-pomodoro treesit-auto org-roam-ui all-the-icons doom-modeline general org-roam lsp-mode rustic flycheck company kaolin-themes evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fic-author-face ((t (:foreground "yellow" :underline t))))
 '(fic-face ((t (:foreground "red" :weight bold)))))
