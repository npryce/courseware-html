
ifndef OUTDIR
OUTDIR=output
endif

PRESENTATIONS:=$(wildcard *.presentation)
PRESENTATIONS_HTML=$(PRESENTATIONS:%.presentation=$(OUTDIR)/html/%.html)

VISUALS:=$(shell find * -not -name '$(OUTDIR)' -prune -type f -name '*.svg' -or -name '*.png' -or -name '*.jpg')

COURSEWARE_HTML_SKELETON=$(shell find $(COURSEWARE_HTML_HOME)/skeleton/* -type f)

HTML_RESOURCES=\
	$(COURSEWARE_HTML_SKELETON:$(COURSEWARE_HTML_HOME)/skeleton/%=$(OUTDIR)/html/%) \
	$(subst svg,png,$(VISUALS:%=$(OUTDIR)/html/%))

all: html pdf

html: $(PRESENTATIONS:%.presentation=$(OUTDIR)/html/%.html)
html: $(PRESENTATIONS:%.presentation=$(OUTDIR)/html/%-notes.html)
html: $(HTML_RESOURCES)

pdf: $(PRESENTATIONS:%.presentation=$(OUTDIR)/pdf/%-notes-2up.pdf)
pdf: $(PRESENTATIONS:%.presentation=$(OUTDIR)/pdf/%-notes-4up.pdf)

$(OUTDIR)/html/%.html: %.presentation $(OUTDIR)/xslt/presentation.xslt
	@mkdir -p $(dir $@)
	saxon -xsl:$(COURSEWARE_HTML_HOME)/xslt/fixns.xslt -s:$< | saxon -xsl:$(OUTDIR)/xslt/presentation.xslt -s:- -o:$@

$(OUTDIR)/html/%-notes.html: %.presentation $(OUTDIR)/xslt/notes.xslt
	@mkdir -p $(dir $@)
	saxon -xsl:$(COURSEWARE_HTML_HOME)/xslt/fixns.xslt -s:$< | saxon -xsl:$(OUTDIR)/xslt/notes.xslt -s:- -o:$@

$(OUTDIR)/xslt/%.xslt: $(COURSEWARE_HTML_HOME)/xslt/bodge-svg.xslt.template
	@mkdir -p $(dir $@)
	sed -e 's|REAL_XSLT|$(COURSEWARE_HTML_HOME)/xslt/$*.xslt|g' $< > $@

$(OUTDIR)/html/%.png: %.svg
	@mkdir -p $(dir $@)
	$(COURSEWARE_HTML_HOME)/bin/svg-rasterizer -d $@ -maxw 2048 -maxh 1536 -m image/png $<

$(OUTDIR)/html/%: %
	@mkdir -p $(dir $@)
	cp $< $@

$(OUTDIR)/html/%: $(COURSEWARE_HTML_HOME)/skeleton/%
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
