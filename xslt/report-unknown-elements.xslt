<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  
  <xsl:template match="*">
    <xsl:value-of select="error(cw:unknown, concat('unknown element {', namespace-uri(), '}', name()), .)"/>
  </xsl:template>
  
</xsl:stylesheet>
