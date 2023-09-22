;
;
; =============================================================================
;
; EMACS Configuration - Intro
;
; =============================================================================
;
; On MacOS, with iterm2, remember to map the left option key to meta
; Go to iterm2 preferences, profiles, keys, and select left option key to
; act as +Esc

; =============================================================================
;
; Start of the configuration
;
; =============================================================================

; -----------------------------------------------------------------------------
;
; SLIME, for Lisp development
;
; -----------------------------------------------------------------------------

; SLIME, for Lisp development
; This require sbcl and quicklisp to be installed
; See https://lisp-lang.org/learn/getting-started/
;
; Install sbcl
;
; ```bash
; brew install sbcl
; ```
; 
; Install quicklisp
;
; ```bash
; curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp
; sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
;      --eval '(quicklisp-quickstart:install :path "~/.quicklisp")' \
;      --eval '(ql:add-to-init-file)' \
;      --quit
; ```
;
; Install SLIME
; ```bash
; sbcl --eval '(ql:quickload :quicklisp-slime-helper)' --quit
; ```
;
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")
; END SLIME configuration

