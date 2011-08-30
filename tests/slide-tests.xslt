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
	    <html:div class="courseware-slide">
	      <html:h2>A Slide</html:h2>
	      <html:div class="courseware-slide-vml">
		<html:p>An example of a slide with some text on it.</html:p>
	      </html:div>
	    </html:div>
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
	    <div class="courseware-slide">
	      <html:h2>Another Slide</html:h2>
	      <img class="courseware-slide-visual" 
		   src="{resolve-uri('a-picture.jpg')}"/>
	    </div>
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
	    <html:div class="courseware-slide">
	      <html:h2>Another Slide</html:h2>
	      <html:img class="courseware-slide-visual" src="{resolve-uri('something.svg')}"/>
	    </html:div>
	  </test:expected>
	</test:assert-transform>
	
	<h3>Licensing Information Is Not Displayed Next To the Slide</h3>
	
	<xsl:variable name="original">
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
	</xsl:variable>
	
	<test:assert-transform>
	  <test:original>
	    <xsl:copy-of select="$original"/>
	  </test:original>
	  
	  <test:expected>
	    <div class="courseware-slide">
	      <html:h2>Slide with License</html:h2>
	      <img class="courseware-slide-visual" src="{resolve-uri('foo')}"/>
	    </div>
	  </test:expected>
	  
	</test:assert-transform>
      </test:suite>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
