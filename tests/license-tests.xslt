<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/xsltest/1.0">

  <xsl:import href="../xslt/license.xslt"/>
  
  <xsl:template name="license-tests">
    <test:suite>
      <h2>Known Licenses</h2>
      <ul>
	<li><p>Can name CC Attribution license</p>
	  <test:assert that="cw:license-name('http://creativecommons.org/licenses/by/2.0/anything-else')
			     = 'the Creative Commons Attribution 2.0 Generic license'"/>
	</li>
	<li><p>Returns nothing for unknown license</p>
	  <test:assert that="not(exists(cw:license-name('http://example.com/unknown-license')))"/>
	</li>
      </ul>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
