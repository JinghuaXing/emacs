(require 'openwith)
(openwith-mode t)
(when (eq system-type 'gnu/linux)
  (setq openwith-associations
        '(("\\.pdf$" "evince" (file)) ("\\.mp3$" "mplayer" (file) )
          ("\\.mov\\|\\.RM$\\|\\.RMVB$\\|\\.avi$\\|\\.AVI$\\|\\.flv$\\|\\.mp4\\|\\.mkv$\\|\\.rmvb$" "mplayer" (file) )
          ("\\.jpe?g$\\|\\.png$\\|\\.bmp\\|\\.gif$" "display" (file))
          ("\\.CHM$\\|\\.chm$" "chmsee"  (file) )
	  ("\\.xlsx?$\\|\\.XLSX?$" "soffice"  (file) )
          )
        )
  )
(when (eq system-type 'windows-nt)
  (setq openwith-associations
        '(("\\.pdf$" "open" (file)) ("\\.mp3$" "open" (file) )
          ("\\.mov\\|\\.RM$\\|\\.RMVB$\\|\\.avi$\\|\\.AVI$\\|\\.flv$\\|\\.mp4\\|\\.mkv$\\|\\.rmvb$" "open" (file) )
          ("\\.jpe?g$\\|\\.png$\\|\\.bmp\\|\\.gif$" "open" (file))
          ("\\.CHM$\\|\\.chm$" "open"  (file) )
          )
        )
  )
