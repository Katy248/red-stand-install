MAN_PAGE := ./dist/docs/red-stand-install.1

manuals: $(MAN_PAGE)
	 
$(MAN_PAGE): ./docs/red-stand-install.adoc
	asciidoctor -b manpage $< -o $@

./dist:
	mkdir -p $@

INSTALL_DESTINATION := /usr/share/red-stand-install/
MAN_DEST_DIR := /usr/local/share/man/man1/

$(INSTALL_DESTINATION):
	mkdir -p $@

install: $(INSTALL_DESTINATION) manuals
	cp -r ./src/ $(INSTALL_DESTINATION)
	cp -r ./repositories/ $(INSTALL_DESTINATION)
	cp -r ./drawings/ $(INSTALL_DESTINATION)
	cp ./install.sh $(INSTALL_DESTINATION)/install.sh
	cp ./rsirc $(INSTALL_DESTINATION)/rsirc
	cp $(MAN_PAGE) $(MAN_DEST_DIR)
	chmod +x ./other/red-stand-install
	cp ./other/red-stand-install /usr/bin/red-stand-install
	cp ./other/red-stand-install.desktop /usr/share/applications/
