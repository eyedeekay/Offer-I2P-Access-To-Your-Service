
new:
	pandoc --highlight-style=tango -f gfm INTRO.md -o - | tee index.html
	pandoc --highlight-style=tango -f gfm DISCLAIMER.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm PROCESSONE.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm PROCESSTWO.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm CHECK.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm ASIDE.md -o - | tee -a index.html
	cat INTRO.md DISCLAIMER.md PROCESSONE.md PROCESSTWO.md CHECK.md ASIDE.md | tee README.md
	pandoc --highlight-style=tango -f gfm README.md -t html5 -o README.pdf
