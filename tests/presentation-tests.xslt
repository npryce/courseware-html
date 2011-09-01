<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/xsltest/1.0">

  <xsl:import href="../xslt/presentation.xslt"/>
  
  <xsl:template name="presentation-tests">
    <test:suite>
      <h2>Presentation Transformations</h2>
      
      <p>A simple presentation</p>
      
      <xsl:variable name="presentation">
	<cw:presentation>
	  <cw:title>Example Presentation</cw:title>
	  <cw:slide>
	    <cw:title>Slide 1</cw:title>
	    <cw:visual href="slide-1-visual"/>
	  </cw:slide>
	  <cw:slide>
	    <cw:title>Slide 2</cw:title>
	    <cw:visual href="slide-2-visual"/>
	  </cw:slide>
	</cw:presentation>
      </xsl:variable>
      
      <xsl:variable name="transformed">
	<xsl:apply-templates select="$presentation"/>
      </xsl:variable>
      
      <test:assert-equal actual="count($transformed//html:section[contains(@class, 'courseware-slide')])"
			 expected="2"/>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
