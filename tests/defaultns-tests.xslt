<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/xsltest/1.0">

  <xsl:import href="../xslt/presentation.xslt"/>
  
  <xsl:template name="defaultns-tests">
    <test:suite>
      <html:h2>Namespace Defaulting</html:h2>
      
      <test:suite>
	<html:p>If the namespace is not set, it is transformed as if in the Courseware namespace</html:p>
	
	<test:assert-transform>
	  <test:original>
	    <para>Some text</para>
	  </test:original>
	  <test:expected>
	    <html:p>Some text</html:p>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
