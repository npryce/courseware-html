

ifndef COURSEWARE_HOME
$(error COURSEWARE_HOME variable not set)
endif

ifndef OUTDIR
OUTDIR=output
endif

ifndef PRESENTATIONS
PRESENTATIONS:=$(wildcard *.presentation)
endif

PRESENTATIONS_HTML=$(PRESENTATIONS:%.presentation=$(OUTDIR)/html/%.html)

ifndef VISUALS
VISUALS:=$(shell find * -not -name '$(OUTDIR)' -prune -type f -name '*.svg' -or -name '*.png' -or -name '*.jpg')
endif

COURSEWARE_HTML_SKELETON=$(shell find $(COURSEWARE_HTML_HOME)/skeleton/* -type f)

HTML_RESOURCES=$(subst svg,png,$(VISUALS:%=$(OUTDIR)/html/%))

all: html pdf

html: $(PRESENTATIONS:%.presentation=$(OUTDIR)/html/%.html)
html: $(PRESENTATIONS:%.presentation=$(OUTDIR)/html/%-notes.html)
html: $(HTML_RESOURCES)

pdf: $(PRESENTATIONS:%.presentation=$(OUTDIR)/pdf/%-notes-2up.pdf)
pdf: $(PRESENTATIONS:%.presentation=$(OUTDIR)/pdf/%-notes-4up.pdf)

$(OUTDIR)/html/%.html: %.presentation $(OUTDIR)/xslt/presentation.xslt $(COURSEWARE_HTML_SKELETON)
	@mkdir -p $(dir $@)
	saxon -xsl:$(COURSEWARE_HTML_HOME)/xslt/fixns.xslt -s:$< | saxon -xsl:$(OUTDIR)/xslt/presentation.xslt -s:- -o:$@
	cp -Ru $(COURSEWARE_HTML_HOME)/skeleton/* $(dir $@)

$(OUTDIR)/html/%-notes.html: %.presentation $(OUTDIR)/xslt/notes.xslt
	@mkdir -p $(dir $@)
	saxon -xsl:$(COURSEWARE_HTML_HOME)/xslt/fixns.xslt -s:$< | saxon -xsl:$(OUTDIR)/xslt/notes.xslt -s:- -o:$@
	cp -Ru $(COURSEWARE_HTML_HOME)/skeleton/* $(dir $@)

$(OUTDIR)/xslt/%.xslt: $(COURSEWARE_HTML_HOME)/xslt/bodge-svg.xslt.template
	@mkdir -p $(dir $@)
	sed -e 's|REAL_XSLT|$(COURSEWARE_HTML_HOME)/xslt/$*.xslt|g' $< > $@

$(OUTDIR)/html/%.png: %.svg
	@mkdir -p $(dir $@)
	$(COURSEWARE_HTML_HOME)/bin/svg-rasterizer -d $@ -maxw 2048 -maxh 1536 -m image/png $<

$(OUTDIR)/html/%: %
	@mkdir -p $(dir $@)
	cp $< $@

$(OUTDIR)/pdf/%.pdf: $(OUTDIR)/html/%.html $(HTML_RESOURCES)
	@mkdir -p $(dir $@)
	prince $< -o $@

%-4up.pdf: %.pdf
	$(COURSEWARE_HOME)/bin/pdfnup 4 $< $@

%-2up.pdf: %.pdf
	$(COURSEWARE_HOME)/bin/pdfnup 2 $< $@

clean:
	rm -rf $(OUTDIR)

again: clean all

.PHONY: all html pdf clean again
