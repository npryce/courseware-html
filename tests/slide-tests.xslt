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
      
      <test:suite>
	<h3>Slide is Translated to a Div with an H2</h3>
	
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
	
	<p>Slides can contain just images</p>
	
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
	      <img class="courseware-slide-contents" 
		   src="{resolve-uri('a-picture.jpg')}"/>
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
	      <img class="courseware-slide-contents" src="{resolve-uri('something.svg')}"/>
	    </section>
	  </test:expected>
	</test:assert-transform>
	
	<p>Licensing Information Is Not Displayed Next To the Slide</p>
	
	<xsl:variable name="original">
	</xsl:variable>
	
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
	      <img class="courseware-slide-contents" src="{resolve-uri('foo')}"/>
	    </section>
	  </test:expected>
	</test:assert-transform>
	
	<p>Slides are given an id: 1, 2, 3...</p>
	
	<xsl:variable name="original">
	  <cw:presentation>
	    <cw:slide>
	      <cw:title>First</cw:title>
	    </cw:slide>
	    <cw:slide>
	      <cw:title>Second</cw:title>
	    </cw:slide>
	  </cw:presentation>
	</xsl:variable>
		
	<xsl:variable name="transformed">
	  <xsl:apply-templates select="$original"/>
	</xsl:variable>
	
	<xsl:variable name="html-slides" select="$transformed//html:section[@class='courseware-slide']"/>
	
	<test:assert-equal actual="number($html-slides[1]/@id)" expected="1"/>
	<test:assert-equal actual="number($html-slides[2]/@id)" expected="2"/>
	
      </test:suite>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
