<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:param name="ns" select="'http://www.natpryce.com/courseware/1.0'"/>
  
  <xsl:template match="*">
    <xsl:choose>
      <xsl:when test="namespace-uri() = ''">
	<xsl:element name="{local-name()}" namespace="{$ns}">
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates select="node()"/>
	</xsl:element>
      </xsl:when>
      <xsl:otherwise>
	<xsl:copy>
	  <xsl:copy-of select="@*"/>
	  <xsl:apply-templates select="node()"/>
	</xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
