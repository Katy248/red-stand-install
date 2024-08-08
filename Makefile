manuals: ./dist/docs/red-stand-install.1 
	 
./dist/docs/red-stand-install.1: ./docs/red-stand-install.adoc
	asciidoctor -b manpage $< -o $@

./dist:
	mkdir -p $@
