
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

.PHONY: all clean diff draft tidy check test
.PRECIOUS: %.xml


all:  dirs draft

dirs:
	mkdir -p gen/content
	mkdir -p docs
	mkdir -p themes/



draft: docs/id/$(DRAFT)-$(VERSION).txt docs/id/$(DRAFT)-$(VERSION).html 


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

docs/id/$(DRAFT)-$(VERSION).xml: spec/$(DRAFT).md  \
	gen/example1.json.md gen/example2.json.md \
	gen/spad.raml.md gen/spad-schema.json.md gen/ietf-spad.yang.md gen/spad.apib.md
	mkdir -p docs/id
	$(mmark) -xml2 -page spec/$(DRAFT).md $@

$(DRAFT).diff.html: $(DRAFT)-$(VERSION).txt $(DRAFT)-old.txt
	touch $(DRAFT)-old.txt
	htmlwdiff   $(DRAFT)-old.txt   $(DRAFT)-$(VERSION).txt >   $(DRAFT).diff.html

gen/%.raml.md: spec/%.raml
	mkdir -p gen 
	( echo "~~~ yaml" ; cat $< ; echo "~~~" ) > $@

gen/%.yang.md: spec/%.yang
	mkdir -p gen 
	( echo "~~~ yang" ; cat $< ; echo "~~~" ) > $@

gen/%.apib.md: spec/%.apib
	mkdir -p gen 
	( echo "~~~ md" ; cat $< ; echo "~~~" ) > $@

gen/%.json.md: spec/%.json
	mkdir -p gen 
	( echo "~~~ " ; cat $< ; echo "~~~" ) > $@

test: gen/ietf-spad.ok gen/example-tmpl.xml gen/ietf-spad.xsl gen/example.json gen/rev-example.xml gen/ietf-spad.dsdl gen/ietf-spad.yang gen/example1.xml gen/example2.xml

gen/ietf-spad.ok: spec/ietf-spad.yang
	pyang -V -p contrib  spec/ietf-spad.yang
	touch gen/ietf-spad.ok

gen/example-tmpl.xml: spec/ietf-spad.yang 
	pyang -f sample-xml-skeleton spec/ietf-spad.yang  -p contrib  -o gen/example-tmpl.xml

gen/ietf-spad.yang: spec/ietf-spad.yang 
	pyang -f yang -p contrib  spec/ietf-spad.yang -o gen/ietf-spad.yang

gen/ietf-spad.xsl: spec/ietf-spad.yang 
	pyang -f jsonxsl -p contrib  spec/ietf-spad.yang -o gen/ietf-spad.xsl

gen/ietf-spad.dsdl: spec/ietf-spad.yang 
	pyang -f dsdl -p contrib  spec/ietf-spad.yang -o gen/ietf-spad.dsdl

gen/example.json: spec/example.xml gen/ietf-spad.xsl 
	xsltproc -o gen/example.json gen/ietf-spad.xsl spec/example.xml 

gen/ietf-spad.jtox: spec/ietf-spad.yang 
	pyang -f jtox  -p contrib  spec/ietf-spad.yang -o gen/ietf-spad.jtox

gen/rev-example.xml: gen/ietf-spad.jtox gen/example.json
	json2xml -t config gen/ietf-spad.jtox gen/example.json  -o  gen/rev-example.xml 


gen/example1.xml: gen/ietf-spad.jtox spec/example1.json
	json2xml -t config gen/ietf-spad.jtox spec/example1.json  -o  gen/example1.xml
	xmllint --format gen/example1.xml -o gen/example1.xml

gen/example2.xml: gen/ietf-spad.jtox spec/example2.json
	json2xml -t config gen/ietf-spad.jtox spec/example2.json  -o  gen/example2.xml
	xmllint --format gen/example2.xml -o gen/example2.xml

