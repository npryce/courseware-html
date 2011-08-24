<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:test="http://www.natpryce.com/testxslt/1.0"
		exclude-result-prefixes="test">
  
  <xsl:import href="xmlverbatim.xslt"/>
  
  <xsl:output method="xhtml"
	      indent="yes"
	      encoding="utf-8"
	      />
  
  <xsl:param name="title">Test Results</xsl:param>
  <xsl:param name="css" select="resolve-uri('report.css')"/>
  
  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:copy-of select="$title"/></title>
	<link rel="stylesheet" type="text/css" href="{$css}"/>
      </head>
      <body>
	<h1><xsl:copy-of select="$title"/></h1>
	
	<p class="summary">
	  <xsl:value-of select="count(//test:assert)"/> assertions:
	  <xsl:value-of select="count(//test:assert[@result='passed'])"/> passed,
	  <xsl:value-of select="count(//test:assert[@result='failed'])"/> failed.
	</p>
	
	<xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="test:suite">
    <div>
      <xsl:attribute name="class">
	<xsl:choose>
	  <xsl:when test=".//*[@result = 'failed']">suite failed</xsl:when>
	  <xsl:otherwise>suite passed</xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
      
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="test:assert[@that]">
    <xsl:if test="@result = 'failed'">
      <p class="failed"><xsl:value-of select="@that"/></p>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="test:assert[test:transformed]">
    <xsl:if test="@result = 'failed'">
      <div class="diagnostics">
	<p>Transform failed:</p>
	<table>
	  <tr><th>Original</th><td><xsl:apply-templates select="test:original/*" mode="xmlverb"/></td></tr>
	  <tr><th>Expected</th><td><xsl:apply-templates select="test:expected/*" mode="xmlverb"/></td></tr>
	  <tr><th>Actual</th><td><xsl:apply-templates select="test:transformed/*" mode="xmlverb"/></td></tr>
	</table>
      </div>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="test:*"/>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
