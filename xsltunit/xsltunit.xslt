<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:test="http://www.natpryce.com/testxslt/1.0"
		xmlns:xslo="http://www.natpryce.com/testxslt/1.0/xsltoutput">
  
  <xsl:output method="xml" indent="yes"/>
  <xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>
  
  <xsl:template match="xsl:import">
    <xslo:import href="{resolve-uri(@href, base-uri())}"/>
  </xsl:template>
  
  <xsl:template match="test:import">
    <xslo:import href="{@href}"/>
  </xsl:template>
  
  <xsl:template match="test:assert">
    <test:assert>
      <xsl:apply-templates select="@*"/>
      
      <xslo:attribute name="result">
	<xslo:choose>
	  <xslo:when test="{@that}">passed</xslo:when>
	  <xslo:otherwise>failed</xslo:otherwise>
	</xslo:choose>
      </xslo:attribute>
      
      <xsl:apply-templates/>
    </test:assert>
  </xsl:template>
  
  <xsl:template match="test:assert-transform">
    <test:assert-transform>
      <xslo:variable name="original">
	<xsl:copy-of select="test:original/*"/>
      </xslo:variable>
      <xslo:variable name="transformed">
	<xslo:apply-templates select="$original"/>
      </xslo:variable>
      <xslo:variable name="expected">
	<xsl:copy-of select="test:expected/*"/>
      </xslo:variable>
      
      <xslo:attribute name="result">
	<xslo:choose>
	  <xslo:when test="deep-equal($transformed, $expected)">passed</xslo:when>
	  <xslo:otherwise>failed</xslo:otherwise>
	</xslo:choose>
      </xslo:attribute>
      
      <xsl:apply-templates/>
      
      <test:transformed>
	<xslo:copy-of select="$transformed"/>
      </test:transformed>
    </test:assert-transform>
  </xsl:template>


  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
