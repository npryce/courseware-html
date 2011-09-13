<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:import href="report-unknown-elements.xslt"/>
  <xsl:import href="slide.xslt"/>
  <xsl:import href="license.xslt"/>
  
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="cw:programlisting cw:code"/>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cw:presentation">
    <html>
      <head>
	<link rel="stylesheet" type="text/css" href="google-code-prettify/prettify.css"/>
	<link rel="stylesheet" type="text/css" href="slideshow.css"/>
	<script type="text/javascript" src="jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="jquery.hotkeys.js"></script>
	<script type="text/javascript" src="google-code-prettify/prettify.js"></script>
	<script type="text/javascript" src="slideshow.js"></script>
      </head>
      <body>
        <section id="1" class="courseware-slide courseware-title-slide">
	  <h1><xsl:apply-templates select="cw:title/node()"/></h1>
	</section>
	
	<xsl:apply-templates select="cw:slide">
	  <xsl:with-param name="intro-slide-count" select="1" tunnel="yes"/>
	</xsl:apply-templates>
      </body>
    </html>
  </xsl:template>  
</xsl:stylesheet>
