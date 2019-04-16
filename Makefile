
new: check faq ident
	pandoc --highlight-style=tango -f gfm INTRO.md -o - | tee index.html
	pandoc --highlight-style=tango -f gfm DISCLAIMER.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm PROCESSONE.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm PROCESSTWO.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm CHECK.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm ASIDE.md -o - | tee -a index.html
	cat INTRO.md DISCLAIMER.md PROCESSONE.md PROCESSTWO.md CHECK.md ASIDE.md | tee README.md
	cat README.md FAQ/FAQ-admin.md FAQ/FAQ-users.md IDENTITY/TLS.md | pandoc --highlight-style=tango -f gfm - -t html5 -o README.pdf

faq:
	pandoc --highlight-style=tango -f gfm FAQ/FAQ-admin.md -o - | tee FAQ/index.html
	pandoc --highlight-style=tango -f gfm FAQ/FAQ-user.md -o - | tee -a FAQ/index.html

ident:
	pandoc --highlight-style=tango -f gfm IDENTITY/TLS.md | tee IDENTITY/tls.html

check:
	find . -name '*.md' -exec sed -i 's|i2p|I2P|g' {} \;
