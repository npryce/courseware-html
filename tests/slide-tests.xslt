<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/xsltest/1.0">

  <xsl:import href="../xslt/presentation.xslt"/>
  
  <xsl:template name="slide-tests">
    <test:suite>
      <h2>Slide Transforms</h2>
      
      <p>A slide is translated to a div with an H2</p>
      
      <p>Slides can contain text</p>
      
      <test:assert-transform>
	<test:original>
	  <cw:slide>
	    <cw:title>A Slide</cw:title>
	    <cw:vml>
	      <cw:para>An example of a slide with some text on it.</cw:para>
	    </cw:vml>
	  </cw:slide>
	</test:original>
	
	<test:expected>
	  <section class="courseware-slide courseware-text-slide" id="1">
	    <h2 class="courseware-slide-title">A Slide</h2>
	    <div class="courseware-slide-contents">
	      <p>An example of a slide with some text on it.</p>
	    </div>
	  </section>
	</test:expected>
      </test:assert-transform>
      
      <p>Slides can contain just images.  Images are translated into
	<code>div</code> elements with a background-image style, not
        into <code>img</code> elements, so that they can easily be made
        to fill the slide with CSS.
      </p>
	
      <test:assert-transform>
	<test:original>
	  <cw:slide>
	    <cw:title>Another Slide</cw:title>
	    <cw:visual fileref="a-picture.jpg"/>
	  </cw:slide>
	</test:original>
	<test:expected>
	  <section class="courseware-slide courseware-image-slide" id="1">
	    <h2 class="courseware-slide-title">Another Slide</h2>
	    <div class="courseware-slide-contents" 
		 style="background-image: url('{resolve-uri('a-picture.jpg')}')"/>
	  </section>
	</test:expected>
      </test:assert-transform>
      
      <p>Notes are skipped</p>
      
      <test:assert-transform>
	<test:original>
	  <cw:slide>
	    <cw:title>Another Slide</cw:title>
	    <cw:visual fileref="something.svg"/>
	    <cw:notes>
              <cw:student><cw:para>Should not be shown</cw:para></cw:student>
              <cw:presenter><cw:para>Should not be shown either</cw:para></cw:presenter>
	    </cw:notes>
	  </cw:slide>
	</test:original>
	
	<test:expected>
	  <section class="courseware-slide courseware-image-slide" id="1">
	    <h2 class="courseware-slide-title">Another Slide</h2>
	    <div class="courseware-slide-contents" style="background-image: url('{resolve-uri('something.svg')}')"/>
	  </section>
	</test:expected>
      </test:assert-transform>
      
      <p>Licensing Information Is Not Displayed Next To the Slide</p>
      
      <test:assert-transform>
	<test:original>
	  <cw:slide>
	    <cw:title>Slide with License</cw:title>
	    <cw:visual fileref="foo">
	      <cw:copyright>
		<cw:year>2007</cw:year>
		<cw:holder>Copyright Owner</cw:holder>
	      </cw:copyright>
	      <cw:license href="license-url">License Description</cw:license>
	    </cw:visual>
	  </cw:slide>
	</test:original>
	
	<test:expected>
	  <section class="courseware-slide courseware-image-slide" id="1">
	    <h2 class="courseware-slide-title">Slide with License</h2>
	    <div class="courseware-slide-contents" style="background-image: url('{resolve-uri('foo')}')"/>
	  </section>
	</test:expected>
      </test:assert-transform>
      
      <p>The visuals's background attribute is translated to CSS in the section's style attribute</p>
      
      <xsl:variable name="slide-with-background">
	<cw:slide>
	  <cw:title>Slide with License</cw:title>
	    <cw:visual fileref="foo" bg="red"/>
	</cw:slide>
      </xsl:variable>
      
      <xsl:variable name="html-with-background">
        <xsl:apply-templates select="$slide-with-background"/>
      </xsl:variable>
      
      <test:assert-equal actual="string($html-with-background/html:section/@style)"
                         expected="'background-color: red'"/>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
