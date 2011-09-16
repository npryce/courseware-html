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
	<link rel="stylesheet" type="text/css" href="notes.css"/>
	<script type="text/javascript" src="google-code-prettify/prettify.js"></script>
      </head>
      <body onload="prettyPrint()">
	<h1><xsl:apply-templates select="cw:title/node()"/></h1>
	
	<xsl:apply-templates select="cw:slide"/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="cw:notes">
    <xsl:apply-templates select="cw:student"/>
  </xsl:template>
  
  <xsl:template match="cw:visual/@bg" mode="slide-background"/>
  
  <xsl:template match="cw:notes/cw:student">
    <div class="courseware-student-notes">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
</xsl:stylesheet>
