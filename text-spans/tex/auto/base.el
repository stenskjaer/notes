(TeX-add-style-hook
 "base"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("book" "a4paper" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("reledmac" "final")))
   (TeX-run-style-hooks
    "latex2e"
    "book"
    "bk12"
    "imakeidx"
    "libertine"
    "csquotes"
    "geometry"
    "fancyhdr"
    "polyglossia"
    "amssymb"
    "gitinfo2"
    "titlesec"
    "reledmac"
    "draftwatermark")
   (TeX-add-symbols
    '("corruption" 1)
    '("no" 1)
    '("del" 1)
    '("hand" 1)
    '("metatext" 1)
    '("secluded" 1)
    '("suppliedInVacuo" 1)
    '("supplied" 1)
    '("worktitle" 1)
    '("lemmaQuote" 1)
    '("name" 1)
    "Afootnoterule"
    "Bfootnoterule"
    "syll")
   (LaTeX-add-counters
    "extrasection"
    "extrasubsection")
   (LaTeX-add-polyglossia-langs
    '("english" "mainlanguage" "")
    '("latin" "otherlanguage" "")))
 :latex)

