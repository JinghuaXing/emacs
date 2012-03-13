(if (string= window-system "w32")
    (progn 
      (add-to-list 'exec-path "c:/Program Files/Git/bin")
      (setenv "PATH" (concat "c:/Program Files/Git/bin;" (getenv "PATH")))
    )
  )
