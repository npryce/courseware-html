
# Override on the command-line to generate release builds
VERSION=SNAPSHOT
PROJECT=courseware-html

DIST=$(PROJECT)-$(VERSION)

XSLT:=$(shell find xslt -name '*.xslt' -not -name '.*' -not -name '*~')
XSLT_TESTS=$(shell find tests -name '*.xslt')

ifndef XSLTEST_HOME
XSLTEST_HOME=../xsltest/src
endif

HTML_FILES:=$(wildcard skeleton/*)

DIST_DIR=build/$(DIST)

SKELETON_FILES:=$(HTML_FILES:skeleton/%=$(DIST_DIR)/skeleton/%)


all: check dist

dist: build/$(DIST).tar.gz

build/$(DIST).tar.gz: $(SKELETON_FILES) $(XSLT:%=$(DIST_DIR)/%)
	tar c$(taropts)z -f $@ -C build $(DIST)

build/testing/%.xslt: tests/%.xslt $(XSLTEST_HOME)/xsltest.xslt
	@mkdir -p $(dir $@)
	saxon -xsl:$(XSLTEST_HOME)/xsltest.xslt -s:$< -o:$@

build/testing/results.xml: $(XSLT_TESTS:tests/%.xslt=build/testing/%.xslt) $(XSLT)
	saxon -xsl:build/testing/all-tests.xslt -it:all-tests -o:$@

build/testing/report.html: build/testing/results.xml $(XSLTEST_HOME)/report.xslt
	saxon -xsl:$(XSLTEST_HOME)/report.xslt -s:$< -o:$@

# Avoid saxon's slow startup if we can say for sure that no tests failed
check: build/testing/report.html $(XSLTEST_HOME)/test-abort-build.xslt
	@if grep -q -m 1 'result="failed"' build/testing/results.xml; then \
	    saxon -xsl:$(XSLTEST_HOME)/test-abort-build.xslt -s:build/testing/results.xml; \
	fi

example: build/example/tutorial.html build/example/tutorial-notes.html $(HTML_FILES)
	cp -R $(HTML_FILES) build/example/

build/example/tutorial.html: example/tutorial.presentation $(XSLT)
	@mkdir -p $(dir $@)
	saxon -xsl:xslt/presentation.xslt -s:$< -o:$@

build/example/tutorial-notes.html: example/tutorial.presentation $(XSLT)
	@mkdir -p $(dir $@)
	saxon -xsl:xslt/notes.xslt -s:$< -o:$@

$(DIST_DIR)/skeleton/%: skeleton/%
	mkdir -p $(dir $@)
	cp -r  $< $@

$(DIST_DIR)/xslt/%: xslt/%
	mkdir -p $(dir $@)
	cp  $< $@

clean:
	rm -rf build

again: clean all

.PHONY: all check clean again install dist example
