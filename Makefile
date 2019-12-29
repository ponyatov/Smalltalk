
CWD    = $(CURDIR)
MODULE = $(notdir $(CWD))

NOW = $(shell date +%d%m%y)
REL = $(shell git rev-parse --short=4 HEAD)

TEX  = $(MODULE).tex header.tex
TEX += bib.tex
TEX += intro.tex install.tex
TEX += interface.tex base/lang.tex base/kay.tex
TEX += base/prim.tex base/vars.tex base/oop.tex base/browser.tex base/loops.tex base/cont.tex
TEX += meta/meta.tex meta/install.tex meta/frame.tex meta/eds.tex
TEX += akka/akka.tex akka/problems.tex
TEX += meta/cpp.tex meta/os.tex meta/linux.tex meta/RTOS.tex meta/hw.tex
TEX += impl/ement.tex impl/preface.tex
TEX += impl/part1.tex impl/basics.tex impl/objects.tex
TEX += impl/part2.tex

IMG  = img/firstrun.png img/settings.png img/font.png
IMG += img/lesnevsky.png img/kir.jpeg img/inside1.png img/inside2.png 
IMG += img/blue.jpg img/red.png img/green.png img/little.jpeg
IMG += img/winmenu.png img/sysexit.png img/wmenu.png img/halo.png
IMG += img/playground.png img/2p3.png img/plmenu.png img/inspect.png
IMG += img/browser.png img/br1.png img/MFrame.png img/install.png
IMG += img/plinstall.png img/metacello.png img/opengit.png img/metopen.png
IMG += img/minsky.png img/Author.png img/AlanKay.png img/balloon.png
IMG += img/c89.png img/print.png img/printin.png img/agha.jpg
IMG += impl/fig_1_1.png impl/fig_1_2.png impl/fig_1_3.png

IMG += dot/ctypes.png dot/ctypes.dot dot/HW.png dot/HW.dot

SRC  = rc.rc meta/MetaL.st meta/MFrame.st meta/initialize.st meta/install.st
SRC += metaL/metaL.package/MFrame.class/instance/printString.st
SRC += metaL/metaL.package/MFrame.class/instance/dump.pfx..st
SRC += metaL/metaL.package/MFrame.class/instance/head..st
SRC += metaL/metaL.package/MFrame.class/instance/_val.st
SRC += metaL/metaL.package/MFrame.class/instance/_pad..st
SRC += meta/OS.st meta/Linux.st meta/HW.st meta/main.st


LATEX = pdflatex -halt-on-error

$(MODULE).pdf: $(TEX) $(SRC) $(IMG)
	$(LATEX) $< | tail -n7
	$(LATEX) $< | tail -n7
	# $(LATEX) $<

pdf: $(MODULE)_$(NOW)-$(REL).pdf
$(MODULE)_$(NOW)-$(REL).pdf: $(MODULE).pdf Makefile
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
		-dNOPAUSE -dQUIET -dBATCH -sOutputFile=$@ $<
# /screen /ebook /prepress

dot/%.png: dot/%.dot
	dot -Tpng -o $@ $<

clean:
	rm *.log *.aux *.toc

################################################################### INSTALL

ifeq ($(OS),Windows_NT)
VM = pharo-win-stable
IM = pharo
SOFT = mingw-get update ; mingw-get install msys-base msys-unzip msys-make mingw32-gcc mingw32-gcc-g++ ; mingw-get upgrade
else
VM = pharo64-linux-stable
IM = pharo64
SOFT = sudo apt install -u `cat apt.txt`
endif

WGET = wget -c --no-check-certificate

install: pharo pharo.version doc vscode
	$(SOFT)

pharo: distr/$(VM).zip
	unzip -x $< && touch $@
pharo.version: distr/$(IM).zip
	unzip -x $< && touch $@
distr/$(VM).zip:
	$(WGET) -O $@ https://files.pharo.org/get-files/70/$(VM).zip
distr/$(IM).zip:
	$(WGET) -O $@ https://files.pharo.org/get-files/70/$(IM).zip

ifeq ($(OS),Windows_NT)
VSCsettings = .vscode/windows.json
else
VSCsettings = .vscode/linux.json
endif

vscode: .vscode/settings.json
.vscode/settings.json: $(VSCsettings)
	cp $< $@

###################################################################### DOC	

doc: doc/LittleSmalltalk.pdf doc/KirutenkoSaveliev.pdf doc/DSL.pdf doc/PharoByExample.pdf \
		doc/StdANSI_19.pdf doc/Bluebook.pdf doc/InsideSmalltalkI.pdf doc/InsideSmalltalkII.pdf doc/PERQ.pdf doc/Self.pdf \
		doc/Lesnevski.djvu doc/AITR-844.pdf
doc/AITR-844.pdf:
	$(WGET) -O $@ https://github.com/ponyatov/Smalltalk/releases/download/101219-3600/AITR-844.pdf
doc/Lesnevski.djvu:
	$(WGET)	-O $@ https://github.com/ponyatov/Smalltalk/releases/download/101219-3600/Lesnevski.djvu
doc/LittleSmalltalk.pdf:
	$(WGET)	-O $@ http://sdmeta.gforge.inria.fr/FreeBooks/LittleSmalltalk/ALittleSmalltalk.pdf
doc/Bluebook.pdf:
	$(WGET)	-O $@ http://stephane.ducasse.free.fr/FreeBooks/BlueBook/Bluebook.pdf
doc/KirutenkoSaveliev.pdf:
	$(WGET)	-O $@ http://www.mmcs.sfedu.ru/jdownload/finish/52-spetskursy-kafedry-matematicheskogo-analiza/213-kiryutenko-yu-a-savelev-v-a-ob-ektno-orientirovannoe-programmirovanie-yazyk-smalltalk-uchebnoe-posobie
doc/StdANSI_19.pdf:
	$(WGET)	-O $@ http://wiki.squeak.org/squeak/uploads/172/standard_v1_9-indexed.pdf
doc/DSL.pdf:
	$(WGET)	-O $@ http://rmod-pharo-mooc.lille.inria.fr/MOOC/Exercises/Exercises-DSL/DSLExercises.pdf
doc/PharoByExample.pdf:
	$(WGET)	-O $@ http://books.pharo.org/updated-pharo-by-example/pdf/2018-09-29-UpdatedPharoByExample.pdf
doc/InsideSmalltalkI.pdf:
	$(WGET)	-O $@ http://stephane.ducasse.free.fr/FreeBooks/InsideST/InsideSmalltalkNoOCRed.pdf
doc/InsideSmalltalkII.pdf:
	$(WGET)	-O $@ http://stephane.ducasse.free.fr/FreeBooks/InsideST/InsideSmalltalkII.pdf
doc/PERQ.pdf:
	$(WGET)	-O $@ http://www.wolczko.com/msc.pdf
doc/Self.pdf:
	$(WGET)	-O $@ http://bibliography.selflanguage.org/_static/implementation.pdf

################################################################# SHADOW git	

.PHONY: merge release zip

MERGE  = Makefile README.md .gitignore distr doc apt.txt
MERGE += $(TEX) $(SRC) $(IMG) metaL

merge:
	git checkout master
	git checkout shadow -- $(MERGE)

release: pdf
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	git checkout shadow

zip: $(MODULE)_$(NOW)-$(REL).zip
$(MODULE)_$(NOW)-$(REL).zip:
	git archive --format zip --output $@ HEAD
