<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:import href="report-unknown-elements.xslt"/>
  <xsl:import href="slide.xslt"/>
  <xsl:import href="license.xslt"/>
  
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="cw:programlisting cw:code"/>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cw:presentation">
    <html>
      <head>
	<link rel="stylesheet" type="text/css" href="google-code-prettify/prettify.css"/>
	<link rel="stylesheet" type="text/css" href="slideshow.css"/>
	<script type="text/javascript" src="jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="jquery.hotkeys.js"></script>
	<script type="text/javascript" src="google-code-prettify/prettify.js"></script>
	<script type="text/javascript" src="slideshow.js"></script>
      </head>
      <body>
        <section id="1" class="courseware-slide courseware-title-slide">
	  <h1><xsl:apply-templates select="cw:title/node()"/></h1>
	</section>
	
	<xsl:apply-templates select="cw:slide">
	  <xsl:with-param name="intro-slide-count" select="1" tunnel="yes"/>
	</xsl:apply-templates>
        
        <xsl:if test="cw:slide/cw:visual/cw:license">
          <section id="{count(cw:slide)+2}" class="courseware-slide courseware-text-slide courseware-credits-slide">
            <h2 class="courseware-slide-title">Image Credits</h2>
            <div class="courseware-slide-contents">
              <ul>
                <xsl:apply-templates select="cw:slide[cw:visual/cw:license]" mode="image-credits"/>
              </ul>
            </div>
          </section>
        </xsl:if>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="cw:slide[cw:visual/cw:license]" mode="image-credits">
    <xsl:variable name="slide-index"><xsl:number/></xsl:variable>
    
    <li>
      <p class="courseware-credits-slide-details">
        <a href="#{$slide-index}">Slide <xsl:value-of select="$slide-index"/>, 
          <em><xsl:value-of select="cw:title"/></em>
        </a>
        <xsl:text>.</xsl:text>
      </p>
      <xsl:apply-templates select="cw:visual/cw:copyright"/>
      <xsl:apply-templates select="cw:visual/cw:license"/>
    </li>
  </xsl:template>
  
  <xsl:template match="cw:visual/cw:copyright">
    <p class="courseware-credits-copyright">
      <xsl:text>Copyright &#xA9; </xsl:text>
      <xsl:value-of select="cw:year"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="cw:holder"/>
      <xsl:text>.</xsl:text>
    </p>
  </xsl:template>
  
  <xsl:template match="cw:visual/cw:license">
    <xsl:variable name="license-name" select="cw:license-name(@href)"/>
    
    <p class="courseware-credits-license">
      <xsl:text>Used under the terms of </xsl:text>
      <a href="{@href}">
        <xsl:choose>
          <xsl:when test="exists($license-name)"><xsl:copy-of select="$license-name"/></xsl:when>
          <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
      </a>
      <xsl:text>.</xsl:text>
    </p>
  </xsl:template>
</xsl:stylesheet>
