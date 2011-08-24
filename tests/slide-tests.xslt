<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/testxslt/1.0">

  <xsl:import href="../xslt/slide.xslt"/>
  
  <xsl:template name="slide-tests">
    <test:suite>
      <h2>Slide Transforms</h2>
      
      <test:suite>
	<h3>Slide is Translated to a Section with a Title</h3>
	
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
	    <html:div class="slide">
	      <html:h1>A Slide</html:h1>
	      <html:div class="courseware-slide-vml">
		<html:p>An example of a slide with some text on it.</html:p>
	      </html:div>
	    </html:div>
	  </test:expected>
	</test:assert-transform>
	
      </test:suite>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
