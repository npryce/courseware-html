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
      
      <xsl:variable name="html-slides" 
		    select="$transformed//html:section[contains(@class, 'courseware-slide ')]"/>
      
      <test:assert-equal actual="count($html-slides)" expected="3"/>
      
      <p>Creates a Title Slide</p>
      
      <xsl:variable name="title-slide" select="$html-slides[1]"/>
      <test:assert-equal actual="string($title-slide/@class)"
			 expected="'courseware-slide courseware-title-slide'"/>
      <test:assert-equal actual="string($title-slide/html:h1)"
			 expected="'Example Presentation'"/>


      <p>Slides are given an id: 1, 2, 3...</p>
      
      <xsl:variable name="html-slides" select="$transformed//html:section[contains(@class, 'courseware-slide ')]"/>
      
      <test:assert-equal actual="number($html-slides[1]/@id)" expected="1"/>
      <test:assert-equal actual="number($html-slides[2]/@id)" expected="2"/>
      <test:assert-equal actual="number($html-slides[3]/@id)" expected="3"/>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
