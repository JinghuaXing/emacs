(autoload 'dictionary-search "dictionary"
  "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary"
  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
  "Create a new dictionary buffer" t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary"
  "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary"
  "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary"
  "Display tooltips for the current word" t)
(setq dictionary-server "localhost")
(setq dictionary-tooltip-dictionary "xdict")
(require 'dictionary)
(global-dictionary-tooltip-mode t)
(global-set-key (kbd "<mouse-3>") 'dictionary-mouse-popup-matching-words)
(add-hook 'text-mode-hook 'dictionary-tooltip-mode)
(global-set-key (kbd "C-c C-s") 'dictionary-search)
