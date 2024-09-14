(define-configuration buffer
    ((default-modes
         (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))

(define-configuration base-mode
    ((keyscheme-map
      (define-keyscheme-map "custom" (list :import %slot-value%)
        nyxt/keyscheme:emacs
        (list
         "M-j" 'nyxt/mode/document:scroll-down
         "M-k" 'nyxt/mode/document:scroll-up
         "M-J" 'nyxt/mode/document:scroll-page-down
         "M-K" 'nyxt/mode/document:scroll-page-up)))))
