
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

.PHONY: all clean diff  draft tidy check site
.PRECIOUS: %.xml


all:  dirs draft site 

dirs:
	mkdir -p gen/content
	mkdir -p docs
	mkdir -p themes/



draft: docs/id/$(DRAFT)-$(VERSION).txt docs/id/$(DRAFT)-$(VERSION).html 

server:
	hugo  --config hugo-config.yaml --contentDir gen/content --destination docs server


site: themes/blackburn/README.md gen/content/about.mmark gen/content/getting_started.mmark gen/content/overview.mmark \
	gen/content/contributing.mmark gen/content/raml.mmark gen/content/schemas.mmark\
	gen/content/api.html  gen/content/blueprint.mmark \
	gen/content/$(DRAFT)-$(VERSION).mmark gen/Contributors.md \
	hugo-config.yaml gen/spad.apib.md
	hugo  --config hugo-config.yaml --contentDir gen/content --destination docs 

gen/content/contributing.mmark: spec/CONTRIBUTING.md
	( echo "---" ; echo "title: Contributing " ; echo "---" ) >  $@
	cat $< >>  $@

gen/Contributors.md: Contributors.md
	cat $< > $@


gen/content/$(DRAFT)-$(VERSION).mmark:  spec/$(DRAFT).md
	( echo "---" ; echo "title: Internet Draft" ; echo "---" ) >  $@
	cat $< >>  $@

gen/content/about.mmark:  spec/about.md
	( echo "---" ; echo "title: About SPAD" ; echo "---" ) >  $@
	cat $< >>  $@

gen/content/getting_started.mmark:  spec/gettingStarted.md
	( echo "---" ; echo "title: Getting Started" ; echo "---" ) >  $@
	cat $< >>  $@

gen/content/overview.mmark:  spec/overview.md
	( echo "---" ; echo "title: Simple Port and Address Discovery (SPAD)" ; echo "---" ) >  $@
	cat $< >>  $@

gen/content/blueprint.mmark:  spec/blueprint.md
	( echo "---" ; echo "title: Blueprint Spec for API" ; echo "---" ) >  $@
	cat $< >>  $@

gen/content/raml.mmark:  spec/raml.md
	( echo "---" ; echo "title: RAML Spec for API" ; echo "---" ) >  $@
	cat $< >>  $@

gen/content/schemas.mmark:  spec/schemas.md
	( echo "---" ; echo "title: JSON Schema for Results" ; echo "---" ) >  $@
	cat $< >>  $@

gen/content/draft.mmark:  
	( echo "---" ; echo "title: Internet Draft" ; echo "---" ) >  $@
	cat $< >>  $@

gen/content/$(DRAFT)-$(VERSION).html: docs/$(DRAFT)-$(VERSION).html
	cp $< $@

diff: $(DRAFT).diff.html

clean:
	-rm -f docs/* docs/*/* gen/content/* gen/*
	-rmdir docs/* gen/content

check:
	jayschema spec/example1.json spec/spad-schema.json
	jayschema spec/example2.json spec/spad-schema.json

tidy:
	json -I --output json -f spec/spad-schema.json
	json -I --output json -f spec/example1.json
	json -I --output json -f spec/example2.json
	ramllint spec/spad.raml

%.txt: %.xml 
	$(xml2rfc) -N $< -o $@ --text

%.html: %.xml 
	$(xml2rfc) -N $< -o $@ --html

docs/id/$(DRAFT)-$(VERSION).xml: spec/$(DRAFT).md  spec/*.md gen/example1.json.md gen/example2.json.md gen/spad.raml.md gen/spad-schema.json.md gen/Contributors.md
	mkdir -p docs/id
	$(mmark) -xml2 -page spec/$(DRAFT).md $@

$(DRAFT).diff.html: $(DRAFT)-$(VERSION).txt $(DRAFT)-old.txt
	touch $(DRAFT)-old.txt
	htmlwdiff   $(DRAFT)-old.txt   $(DRAFT)-$(VERSION).txt >   $(DRAFT).diff.html


#docs/api.html: spad.raml example1.json example2.json spad-schema.json
#	mkdir -p page
#	raml2html spad.raml -o docs/api.html

gen/content/api.html: spec/spad.apib
	mkdir -p docs
	aglio --no-theme-condense --theme-full-width -i $<  -o $@


gen/%.raml.md: spec/%.raml
	mkdir -p gen 
	( echo "~~~ yaml" ; cat $< ; echo "~~~" ) > $@

gen/%.apib.md: spec/%.apib
	mkdir -p gen 
	( echo "~~~ md" ; cat $< ; echo "~~~" ) > $@

gen/%.json.md: spec/%.json
	mkdir -p gen 
	( echo "~~~ " ; cat $< ; echo "~~~" ) > $@


themes/blackburn/README.md:
	mkdir -p themes/
	(cd themes/ ; git clone https://github.com/yoshiharuyamashita/blackburn.git )

