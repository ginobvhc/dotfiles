;; This Determines The Style Of Line Numbers In Effect. If Set To `Nil', Line
;; Numbers Are Disabled. For Relative Line Numbers, Set This To `Relative'.
(setq display-line-numbers-type 'relative)

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

(map! :leader
      :desc "Copy to register"
      "r c" #'copy-to-register
      :leader
      :desc "Frameset to register"
      "r f" #'frameset-to-register
      :leader
      :desc "Insert contents of register"
      "r i" #'insert-register
      :leader
      :desc "Jump to register"
      "r j" #'jump-to-register
      :leader
      :desc "List registers"
      "r l" #'list-registers
      :leader
      :desc "Number to register"
      "r n" #'number-to-register
      :leader
      :desc "Interactively choose a register"
      "r r" #'counsel-register
      :leader
      :desc "View a register"
      "r v" #'view-register
      :leader
      :desc "Window configuration to register"
      "r w" #'window-configuration-to-register
      :leader
      :desc "Increment register"
      "r +" #'increment-register
      :leader
      :desc "Point to register"
      "r SPC" #'point-to-register)

(setq-default evil-escape-key-sequence "df")

(map! :leader
      :desc "List bookmarks"
      "b L" #'list-bookmarks
      :leader
      :desc "Save current bookmarks to bookmark file"
      "b w" #'bookmark-save)

(setq centaur-tabs-set-bar 'over
      centaur-tabs-set-icons t
      centaur-tabs-gray-out-icons 'buffer
      centaur-tabs-height 24
      centaur-tabs-set-modified-marker t
      centaur-tabs-style "bar"
      centaur-tabs-modified-marker "•")
(map! :leader
      :desc "Toggle tabs on/off"
      "t c" #'centaur-tabs-local-mode)
(evil-define-key 'normal centaur-tabs-mode-map (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
                                               (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
                                               (kbd "g <down>")  'centaur-tabs-forward-group
                                               (kbd "g <up>")    'centaur-tabs-backward-group)

(map! :leader
      :desc "Dired"
      "d d" #'dired
      :leader
      :desc "Dired jump to current"
      "d j" #'dired-jump
      (:after dired
        (:map dired-mode-map
         :leader
         :desc "Peep-dired image previews"
         "d p" #'peep-dired
         :leader
         :desc "Dired view file"
         "d v" #'dired-view-file)))
;; Make 'h' and 'l' go back and forward in dired. Much faster to navigate the directory structure!
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
;; If peep-dired is enabled, you will get image previews as you go up/down with 'j' and 'k'
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "FT")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/home/ginobvhc/Sync/Org/")
;;(setq initial-buffer-choice "~/Org/todo.org")

(setq projectile-project-search-path '("/home/ginobvhc/programacion/01-projects/" "/home/ginobvhc/Sync/Org/"))

(setq shell-file-name "/bin/zsh"
      eshell-aliases-file "~/.doom.d/aliases"
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh")
      vterm-max-scrollback 5000)
(map! :leader
      :desc "Counsel eshell history"
      "e h" #'counsel-esh-history)

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "qutebrowser")

(require 'mu4e)
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

;; Download dir


(setq mu4e-attachment-dir  "~/Downloads")


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

(custom-set-variables
 '(elfeed-feeds
   (quote
    (("https://www.reddit.com/r/linux.rss" reddit linux)
     ("https://www.gamingonlinux.com/article_rss.php" gaming linux)
     ("https://hackaday.com/blog/feed/" hackaday linux)
     ("https://opensource.com/feed" opensource linux)
     ("https://linux.softpedia.com/backend.xml" softpedia linux)
     ("https://itsfoss.com/feed/" itsfoss linux)
     ("https://www.zdnet.com/topic/linux/rss.xml" zdnet linux)
     ("https://www.phoronix.com/rss.php" phoronix linux)
     ("http://feeds.feedburner.com/d0od" omgubuntu linux)
     ("https://www.computerworld.com/index.rss" computerworld linux)
     ("https://www.networkworld.com/category/linux/index.rss" networkworld linux)
     ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
     ("https://betanews.com/feed" betanews linux)
     ("http://lxer.com/module/newswire/headlines.rss" lxer linux)
     ("https://distrowatch.com/news/dwd.xml" distrowatch linux)))))

(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)

(after! company
  (setq company-minimum-prefix-length 2
        company-idle-delay 0.1))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-include-signature t
        lsp-ui-doc-max-height 15
        lsp-ui-doc-max-width 100
        lsp-ui-doc-position 'at-point))

(setq projectile-project-search-path '("~/Sync/proyectos/programacion/01-projects/" "~/Sync/Org/"))

;; Patch up the evil-org key map, so that org is usable with daemon
;; https://github.com/hlissner/doom-emacs/issues/1897
(after! evil-org
  (evil-define-key '(normal visual) evil-org-mode-map
    (kbd "TAB") 'org-cycle))
