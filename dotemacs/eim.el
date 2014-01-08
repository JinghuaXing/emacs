(add-to-list 'load-path "~/.elisp/eim")

(require 'eim-extra)
(autoload 'eim-use-package "eim" "Another emacs input method")
(setq eim-use-tooltip nil)
(setq eim-punc-translate-p nil)         ; use English punctuation
(defun my-eim-py-activate-function ()
  (add-hook 'eim-active-hook
	    (lambda ()
	      (let ((map (eim-mode-map)))
		(define-key eim-mode-map "-" 'eim-previous-page)
		(define-key eim-mode-map "=" 'eim-next-page)))))
(register-input-method
 "eim-wb" "euc-cn" 'eim-use-package
 "五笔" "EIM Chinese Wubi Input Method" "wb.txt"
 'my-eim-py-activate-function)
(set-input-method "eim-wb")             ; use Pinyin input method
(setq activate-input-method t)          ; active input method
(toggle-input-method nil)          ; default is turn off

