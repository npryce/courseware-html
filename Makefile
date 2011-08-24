

XSLT:=$(shell find xslt -name '*.xslt')
XSLT_TESTS=$(shell find tests -name '*.xslt')

all: check

build/testing/%.xslt: tests/%.xslt xsltunit/xsltunit.xslt
	@mkdir -p $(dir $@)
	saxon -xsl:xsltunit/xsltunit.xslt -s:$< -o:$@

build/testing/results.xml: $(XSLT_TESTS:tests/%.xslt=build/testing/%.xslt) $(XSLT)
	saxon -xsl:build/testing/all-tests.xslt -it:all-tests -o:$@

build/testing/report.html: build/testing/results.xml xsltunit/report.xslt
	saxon -xsl:xsltunit/report.xslt -s:$< -o:$@

check: build/testing/report.html xsltunit/test-abort-build.xslt
	saxon -xsl:xsltunit/test-abort-build.xslt -s:build/testing/results.xml

clean:
	rm -rf build

again: clean all

.PHONY: all check clean again install
