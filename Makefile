
CWD = $(CURDIR)
MODULE = Smalltalk

NOW = $(shell date +%d%m%y)
REL = $(shell git rev-parse --short=4 HEAD)

TEX  = $(MODULE).tex header.tex
LATEX = pdflatex -halt-on-error

$(MODULE).pdf: $(TEX) $(SRC)
	$(LATEX) $< | tail -n7
	$(LATEX) $< | tail -n7

# $(MODULE)_$(NOW)-$(REL).zip:
# 	git archive --format zip --output $@ HEAD

install: pharo pharo.version doc
	sudo apt install `cat apt.txt`
pharo: distr/pharo64-linux-stable.zip
	unzip -x $< && touch $@
pharo.version: distr/pharo64.zip
	unzip -x $< && touch $@
distr/pharo64-linux-stable.zip:
	wget -c -O $@ https://files.pharo.org/get-files/70/pharo64-linux-stable.zip
distr/pharo64.zip:
	wget -c -O $@ https://files.pharo.org/get-files/70/pharo64.zip

doc: doc/LittleSmalltalk.pdf doc/KirutenkoSaveliev.pdf doc/DSL.pdf doc/PharoByExample.pdf \
		doc/StdANSI_19.pdf doc/Bluebook.pdf doc/InsideSmalltalkI.pdf doc/InsideSmalltalkII.pdf doc/PERQ.pdf doc/Self.pdf
doc/LittleSmalltalk.pdf:
	wget -c -O $@ http://sdmeta.gforge.inria.fr/FreeBooks/LittleSmalltalk/ALittleSmalltalk.pdf
doc/Bluebook.pdf:
	wget -c -O $@ http://stephane.ducasse.free.fr/FreeBooks/BlueBook/Bluebook.pdf
doc/KirutenkoSaveliev.pdf:
	wget -c -O $@ http://www.mmcs.sfedu.ru/jdownload/finish/52-spetskursy-kafedry-matematicheskogo-analiza/213-kiryutenko-yu-a-savelev-v-a-ob-ektno-orientirovannoe-programmirovanie-yazyk-smalltalk-uchebnoe-posobie
doc/StdANSI_19.pdf:
	wget -c -O $@ http://wiki.squeak.org/squeak/uploads/172/standard_v1_9-indexed.pdf
doc/DSL.pdf:
	wget -c -O $@ http://rmod-pharo-mooc.lille.inria.fr/MOOC/Exercises/Exercises-DSL/DSLExercises.pdf
doc/PharoByExample.pdf:
	wget -c -O $@ http://books.pharo.org/updated-pharo-by-example/pdf/2018-09-29-UpdatedPharoByExample.pdf
doc/InsideSmalltalkI.pdf:
	wget -c -O $@ http://stephane.ducasse.free.fr/FreeBooks/InsideST/InsideSmalltalkNoOCRed.pdf
doc/InsideSmalltalkII.pdf:
	wget -c -O $@ http://stephane.ducasse.free.fr/FreeBooks/InsideST/InsideSmalltalkII.pdf
doc/PERQ.pdf:
	wget -c -O $@ http://www.wolczko.com/msc.pdf
doc/Self.pdf:
	wget -c -O $@ http://bibliography.selflanguage.org/_static/implementation.pdf

# MERGE  = Makefile README.md .gitignore distr doc slides

# merge:
# 	git checkout master
# 	git checkout shadow -- $(MERGE)

# release:
# 	git tag $(NOW)-$(REL)
# 	git push -v && git push -v --tags
# 	git checkout shadow

