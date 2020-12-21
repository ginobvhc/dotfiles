;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Fabricio Todeschini"
      user-mail-address "ginobvhc@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/home/ginobvhc/Sync/Org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)
(setq projectile-project-search-path '("/home/ginobvhc/programacion/01-projects/" "/home/ginobvhc/Sync/Org/"))


(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "qutebrowser")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; De Ginobvhc
;; starts Org File
;;(setq initial-buffer-choice "~/Org/todo.org")
(setq-default evil-escape-key-sequence "df")

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;;(require 'smtpmail)
(setq user-mail-address "ftodeschini@gmail.com"
      user-full-name  "Fabricio Todeschini"
      ;; I have my mbsyncrc in a different folder on my system, to keep it separate from the
      ;; mbsyncrc available publicly in my dotfiles. You MUST edit the following line.
      ;; Be sure that the following command is: "mbsync -c ~/.config/mu4e/mbsyncrc -a"
      ;;mu4e-get-mail-command "mbsync -c ~/.config/mu4e-dt/mbsyncrc -a"
      mu4e-get-mail-command "mbsync -a"
      mu4e-update-interval  300
      mu4e-main-buffer-hide-personal-addresses t


      message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/bin/msmtp"

      mu4e-sent-folder "/ginobvhc/Sent"
      mu4e-drafts-folder "/ginobvhc/Drafts"
      mu4e-trash-folder "/ginobvhc/Trash"
      mu4e-maildir-shortcuts
      '(("/ginobvhc/Inbox"      . ?i)
        ("/ginobvhc/Sent Items" . ?s)
        ("/ginobvhc/Drafts"     . ?d)
        ("/ginobvhc/Trash"      . ?t)))
;; ~/.doom.d/config.el

;; (require 'mu4e)

;; ;; use mu4e for e-mail in emacs
;; (setq mail-user-agent 'mu4e-user-agent)
;; (setq mu4e-maildir "/home/ginobvhc/.mail")
;; ;; allow for updating mail using 'U' in the main view:
;; (setq mu4e-get-mail-command "mbsync -Va")

;; (require 'org-mu4e)
;; (setq org-mu4e-convert-to-html t)


;; (setq message-send-mail-function 'message-send-mail-with-sendmail)
;; (setq sendmail-program "/usr/bin/msmtp")
;; ;; tell msmtp to choose the SMTP server by the 'from' field in the outgoing email
;; (setq message-sendmail-extra-arguments '("--read-envelope-from"))
;; (setq message-sendmail-f-is-evil 't)

;; ;; this seems to fix the babel file saving thing
;; (defun org~mu4e-mime-replace-images (str current-file)
;;   "Replace images in html files with cid links."
;;   (let (html-images)
;;     (cons
;;      (replace-regexp-in-string ;; replace images in html
;;       "src=\"\\([^\"]+\\)\""
;;       (lambda (text)
;;         (format
;;          "src=\"./:%s\""
;;          (let* ((url (and (string-match "src=\"\\([^\"]+\\)\"" text)
;;                           (match-string 1 text)))
;;                 (path (expand-file-name
;;                        url (file-name-directory current-file)))
;;                 (ext (file-name-extension path))
;;                 (id (replace-regexp-in-string "[\/\\\\]" "_" path)))
;;            (add-to-list 'html-images
;;                         (org~mu4e-mime-file (concat "image/" ext) path id))
;;            id)))
;;       str)
;;      html-images)))




;; Filtros
;;
;; (add-to-list 'mu4e-bookmarks
;;              '( :name  "Big messages"
;;                 :query "size:5M..500M"
;;                 :key   ?b))

;; (add-to-list 'mu4e-bookmarks
;;   '( :name "Last Year"
;;      :query "date:1y..now"
;;      :key ?y))


;; (add-to-list 'mu4e-bookmarks
;;   '( :name "Unread"
;;      :query "flag:unread"
;;      :key ?u)
;;   )

;;  ACA van los shortcuts
(setq mu4e-maildir-shortcuts
      '(("/ginobvhc/Inbox" . ?g)
        ("/ftodeschini/Inbox" . ?f)))


;; exwm
(require 'exwm)
(require 'exwm-config)
(setq exwm-input-global-keys
      `(([?\s-r] . exwm-reset)
        ([?\s-w] . exwm-workspace-switch)
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))))
(setq exwm-workspace-number 4)
(require 'exwm-systemtray)
