local gknapsettings = {
    texoutputext = "pdf",
    -- textopdf = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
    textopdf = "lualatex --shell-escape %docroot%",
    textopdfviewerlaunch = "zathura --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
    textopdfviewerrefresh = "none",
    markdownoutputext = "pdf",
    textopdfforwardjump = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",
    markdowntopdfviewerlaunch = "zathura %outputfile%",
    markdowntopdf = "pandoc %docroot% --pdf-engine=wkhtmltopdf -V margin-top=5mm -V margin-bottom=5mm -V margin-left=0mm -V margin-right=0mm -V disable-smart-shrinking -V papersize=a5 --highlight-style=breezedark -o %outputfile%",
    mdoutputext = "pdf",
    mdtopdfviewerlaunch = "zathura %outputfile%",
    -- mdtopdf = "pandoc -t html5 -V margin-top=3 -V margin-left=3 -V margin-right=3 -V margin-bottom=3 -V papersize=letter -s %docroot% -o %outputfile%"
    mdtopdf = "mdpdf %docroot%"

}
vim.g.knap_settings = gknapsettings
