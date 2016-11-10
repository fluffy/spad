
#   https://pypi.python.org/pypi/xml2rfc
xml2rfc ?= xml2rfc
#  mmark (https://github.com/miekg/mmark)
mmark ?= mmark -xml2 -page
ifneq (,$(XML_LIBRARY))
	mmark += -bib-id $(XML_LIBRARY)/ -bib-rfc $(XML_LIBRARY)/
endif

DRAFT = draft-jennings-dispatch-spad-v0
ifeq (,$(VERSION))
	VERSION = latest
endif

.PHONY: all clean diff pages draft tidy check site
.PRECIOUS: %.xml

all: pages draft 

draft: pages/$(DRAFT)-$(VERSION).txt pages/$(DRAFT)-$(VERSION).html 

pages: pages/api.html

site: site/content/about.mmark site/content/getting_started.mmark site/content/overview.mmark \
	site/content/contributing.mmark site/content/raml.mmark site/content/schemas.mmark\
	site/content/api.html site/content/$(DRAFT)-$(VERSION).html
	( cd site  ; hugo  ) 

site/content/contributing.mmark: CONTRIBUTING.md
	( echo "---" ; echo "title: Contributing " ; echo "---" ) >  $@
	cat $< >>  $@

site/content/about.mmark: about.md
	( echo "---" ; echo "title: About SPAD" ; echo "---" ) >  $@
	cat $< >>  $@

site/content/getting_started.mmark: gettingStarted.md
	( echo "---" ; echo "title: Getting Started" ; echo "---" ) >  $@
	cat $< >>  $@

site/content/overview.mmark: overview.md
	( echo "---" ; echo "title: Simple Port and Address Discovery (SPAD)" ; echo "---" ) >  $@
	cat $< >>  $@

site/content/raml.mmark: raml.md
	( echo "---" ; echo "title: RAML Spec for API" ; echo "---" ) >  $@
	cat $< >>  $@

site/content/schemas.mmark: schemas.md
	( echo "---" ; echo "title: JSON Schema for Results" ; echo "---" ) >  $@
	cat $< >>  $@

site/content/api.html: pages/api.html
	cp $< $@

site/content/$(DRAFT)-$(VERSION).html: pages/$(DRAFT)-$(VERSION).html
	cp $< $@

diff: $(DRAFT).diff.html

clean:
	-rm -f pages/$(DRAFT)-$(VERSION).{txt,html,xml,pdf} $(DRAFT).diff.html pages/* gen/*

check:
	jayschema example1.json spad-schema.json
	jayschema example2.json spad-schema.json

tidy:
	json -I --output json -f spad-schema.json
	json -I --output json -f example1.json
	json -I --output json -f example2.json
	ramllint spad.raml

%.txt: %.xml 
	$(xml2rfc) -N $< -o $@ --text

%.html: %.xml 
	$(xml2rfc) -N $< -o $@ --html

pages/$(DRAFT)-$(VERSION).xml: $(DRAFT).md  *.md gen/example1.json.md gen/example2.json.md gen/spad.raml.md gen/spad-schema.json.md
	$(mmark) -xml2 -page $< $@

$(DRAFT).diff.html: $(DRAFT)-$(VERSION).txt $(DRAFT)-old.txt
	touch $(DRAFT)-old.txt
	htmlwdiff   $(DRAFT)-old.txt   $(DRAFT)-$(VERSION).txt >   $(DRAFT).diff.html


pages/api.html: spad.raml example1.json example2.json spad-schema.json
	mkdir -p pages
	raml2html spad.raml -o pages/api.html

gen/%.raml.md: %.raml
	mkdir -p gen 
	( echo "~~~ yaml" ; cat $< ; echo "~~~" ) > $@

gen/%.json.md: %.json
	mkdir -p gen 
	( echo "~~~ " ; cat $< ; echo "~~~" ) > $@


