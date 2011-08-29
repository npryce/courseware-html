<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  
  <xsl:template match="*">
    <xsl:choose>
      <xsl:when test="not(namespace-uri())">
	<xsl:variable name="adapted">
	  <xsl:element name="{local-name()}"
		       namespace="http://www.natpryce.com/courseware/1.0">
	    <xsl:copy-of select="node()|@*"/>
	  </xsl:element>
	</xsl:variable>
	<xsl:apply-templates select="$adapted"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="error(cw:unknown, concat('unknown element {', namespace-uri(), '}', name()), .)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
