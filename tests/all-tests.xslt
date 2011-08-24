<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/testxslt/1.0">

  <test:import href="slide-tests.xslt"/>
  <test:import href="text-tests.xslt"/>
  
  <xsl:output method="xml"/>
  
  <xsl:template name="all-tests">
    <test:suite>
      <h1>Courseware to HTML Transformation</h1>
      <xsl:call-template name="slide-tests"/>
      <xsl:call-template name="text-tests"/>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
