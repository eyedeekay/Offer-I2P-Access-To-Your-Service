
new: check faq ident
	pandoc --highlight-style=tango -f gfm INTRO.md -o - | tee index.html
	pandoc --highlight-style=tango -f gfm DISCLAIMER.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm PROCESSONE.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm PROCESSTWO.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm CHECK.md -o - | tee -a index.html
	pandoc --highlight-style=tango -f gfm ASIDE.md -o - | tee -a index.html
	cat INTRO.md DISCLAIMER.md PROCESSONE.md PROCESSTWO.md CHECK.md ASIDE.md | tee README.md
	cat README.md FAQ/FAQ-admin.md FAQ/FAQ-users.md IDENTITY/TLS.md | pandoc --highlight-style=tango -f gfm - -t html5 -o README.pdf

rst: meta
	@echo "=====================================================" | tee -a INTRO.rst
	torst INTRO.md | tee -a INTRO.rst
	@echo "" | tee DISCLAIMER.rst
	torst DISCLAIMER.md | tee -a DISCLAIMER.rst
	@echo "" | tee PROCESSONE.rst
	torst PROCESSONE.md | tee -a PROCESSONE.rst
	@echo "" | tee PROCESSTWO.rst
	torst PROCESSTWO.md | tee -a PROCESSTWO.rst
	@echo "" | tee CHECK.rst
	torst CHECK.md | tee -a CHECK.rst
	@echo "" | tee -a ASIDE.rst
	torst ASIDE.md | tee ASIDE.rst
	cat INTRO.rst DISCLAIMER.rst PROCESSONE.rst PROCESSTWO.rst CHECK.rst ASIDE.rst | tee mirroring-guide.rst

meta:
	@echo '.. meta::' | tee INTRO.rst
	@echo '    :author: idk' | tee -a INTRO.rst
	@echo '    :date: 2019-06-01' | tee -a INTRO.rst
	@echo '    :excerpt: Offering an I2P Mirror' | tee -a INTRO.rst
	@echo '' | tee -a INTRO.rst

blog:
	mkdir -p $(HOME)/Workspace/desktop-Workspace/mtn/i2p.www/i2p2www/blog/2019/06/01
	cp mirroring-guide.rst $(HOME)/Workspace/desktop-Workspace/mtn/i2p.www/i2p2www/blog/2019/06/01


faq:
	pandoc --highlight-style=tango -f gfm FAQ/FAQ-admin.md -o - | tee FAQ/index.html
	pandoc --highlight-style=tango -f gfm FAQ/FAQ-user.md -o - | tee -a FAQ/index.html

ident:
	pandoc --highlight-style=tango -f gfm IDENTITY/TLS.md | tee IDENTITY/tls.html

check:
	find . -name '*.md' -exec sed -i 's| i2p | I2P |g' {} \;
	find . -name '*.md' -exec sed -i 's|\.b32\.I2P|\.b32\.i2p|g' {} \;
	find . -name '*.md' -exec sed -i 's|\.I2P|\.i2p|g' {} \;
	find . -name '*.md' -exec sed -i 's| i2p\.| I2P\.|g' {} \;
