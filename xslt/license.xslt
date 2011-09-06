<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:variable name="known-licenses">
    <cw:license url="http://creativecommons.org/licenses/by/2.0/">the Creative Commons Attribution 2.0 Generic license</cw:license>
  </xsl:variable>
  
  <xsl:function name="cw:license-name">
    <xsl:param name="url"/>
    
    <xsl:variable name="match" select="$known-licenses/cw:license[starts-with($url,@url)]"/>
    <xsl:choose>
      <xsl:when test="$match"><xsl:value-of select="$match"/></xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>
