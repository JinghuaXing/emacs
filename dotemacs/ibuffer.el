(setq ibuffer-saved-filter-groups
      '(("firm"
	 ("java" (mode . java-mode))
	 ("c/cpp" (or (mode . c++-mode)
			(mode . c-mode)))
	 ("dired" (mode . dired-mode))
	 ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*"))))))

(add-hook 'ibuffer-mode-hook 
	  '(lambda ()
	     (ibuffer-switch-to-saved-filter-groups "firm")))
(setq ibuffer-expert t)