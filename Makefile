
#   https://pypi.python.org/pypi/xml2rfc
xml2rfc ?= xml2rfc
#  mmark (https://github.com/miekg/mmark)
mmark ?= mmark -xml2 -page
ifneq (,$(XML_LIBRARY))
	mmark += -bib-id $(XML_LIBRARY)/ -bib-rfc $(XML_LIBRARY)/
endif


DRAFT = draft-jennings-dispatch-spad-v0
VERSION = 00

.PHONY: all clean diff pages draft tidy check 
.PRECIOUS: %.xml

all: pages draft 

draft: $(DRAFT)-$(VERSION).txt $(DRAFT)-$(VERSION).html 

pages: pages/api.html 

diff: $(DRAFT).diff.html

clean:
	-rm -f $(DRAFT)-$(VERSION).{txt,html,xml,pdf} $(DRAFT).diff.html pages/*

check:
	jayschema example1.spad spad-schema.json

tidy:
	json -I --output json -f spad-schema.json
	json -I --output json -f example1.spad
    ramllint spad.raml

%.txt: %.xml 
	$(xml2rfc) -N $< -o $@ --text

%.html: %.xml 
	$(xml2rfc) -N $< -o $@ --html

$(DRAFT)-$(VERSION).xml: $(DRAFT).md 
	$(mmark) -xml2 -page $< $@

$(DRAFT).diff.html: $(DRAFT)-$(VERSION).txt $(DRAFT)-old.txt
	touch $(DRAFT)-old.txt
	htmlwdiff   $(DRAFT)-old.txt   $(DRAFT)-$(VERSION).txt >   $(DRAFT).diff.html


pages/api.html: spad.raml example1.spad 
	raml2html spad.raml -o pages/api.html

