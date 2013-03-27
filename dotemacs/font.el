(if (string= window-system "x")
    (progn
      (create-fontset-from-fontset-spec
       "-*-terminus-medium-r-normal--16-*-*-*-*-*-fontset-gbk,
         chinese-gb2312:-misc-simsun-medium-r-normal--14-*-*-*-*-*-gbk-0,
         chinese-gbk:-misc-simsun-medium-r-normal--14-*-*-*-*-*-gbk-0,
         chinese-cns11643-5:-misc-simsun-medium-r-normal--16-*-*-*-*-*-gbk-0,
         chinese-cns11643-6:-misc-simsun-medium-r-normal--16-*-*-*-*-*-gbk-0,
         chinese-cns11643-7:-misc-simsun-medium-r-normal--16-*-*-*-*-*-gbk-0" t)
      (setq default-frame-alist
       	    '(
       	      (font . "fontset-gbk")
       	      )
       	    )
      ))