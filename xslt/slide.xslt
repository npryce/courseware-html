<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">

  <xsl:import href="text.xslt"/>
  
  
  <xsl:template match="cw:slide">
    <div class="slide">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="cw:slide/cw:title">
    <h1><xsl:apply-templates/></h1>
  </xsl:template>
  
  <xsl:template match="cw:vml">
    <div class="courseware-slide-vml">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
</xsl:stylesheet>
