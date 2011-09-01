<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:import href="report-unknown-elements.xslt"/>
  <xsl:import href="slide.xslt"/>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cw:presentation">
    <html>
      <head>
	<link rel="stylesheet" type="text/css" href="slideshow.css"/>
	<link rel="stylesheet" type="text/css" href="prettify.css"/>
	<script type="text/javascript" src="jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="slideshow.js"></script>
      </head>
      <body>
	<xsl:apply-templates select="cw:slide"/>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
