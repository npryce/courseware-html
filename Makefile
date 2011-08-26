

XSLT:=$(shell find xslt -name '*.xslt')
XSLT_TESTS=$(shell find tests -name '*.xslt')

JQUERY=lib/jquery-1.6.2
DECK=lib/imakewebthings-deck.js-46d52ce

JQUERY_FILES=$(wildcard $(JQUERY)/*.js)
DECK_FILES=$(DECK)/modernizr.custom.js $(DECK)/core $(DECK)/themes $(DECK)/extensions

SKELETON_FILES=$(JQUERY_FILES:$(JQUERY)/%=build/skeleton/%) \
               $(DECK_FILES:$(DECK)/%=build/skeleton/deck/%)

all: check $(SKELETON_FILES)

build/testing/%.xslt: tests/%.xslt xsltunit/xsltunit.xslt
	@mkdir -p $(dir $@)
	saxon -xsl:xsltunit/xsltunit.xslt -s:$< -o:$@

build/testing/results.xml: $(XSLT_TESTS:tests/%.xslt=build/testing/%.xslt) $(XSLT)
	saxon -xsl:build/testing/all-tests.xslt -it:all-tests -o:$@

build/testing/report.html: build/testing/results.xml xsltunit/report.xslt
	saxon -xsl:xsltunit/report.xslt -s:$< -o:$@

# Avoid saxon's slow startup if we can say for sure that no tests failed
check: build/testing/report.html xsltunit/test-abort-build.xslt
	@if grep -q -m 1 'result="failed"' build/testing/results.xml; then \
	    saxon -xsl:xsltunit/test-abort-build.xslt -s:build/testing/results.xml; \
	fi

build/skeleton/%: $(JQUERY)/%
	mkdir -p $(dir $@)
	cp -r $< $@

build/skeleton/deck/%: $(DECK)/%
	mkdir -p $(dir $@)
	cp -r  $< $@

clean:
	rm -rf build

again: clean all

.PHONY: all check clean again install