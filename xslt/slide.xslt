<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">

  <xsl:import href="text.xslt"/>
  
  <xsl:function name="cw:slide-class">
    <xsl:param name="slide"/>
    
    <xsl:variable name="slide-type">
      <xsl:choose>
	<xsl:when test="$slide/cw:visual">courseware-image-slide</xsl:when>
	<xsl:when test="$slide/cw:vml">courseware-text-slide</xsl:when>
	<xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:value-of select="normalize-space(concat('courseware-slide', ' ', $slide-type))"/>
  </xsl:function>

  <xsl:template match="cw:slide">
    <xsl:param name="extra-slide-class" tunnel="yes">courseware-slide</xsl:param>
    
    <section>
      <xsl:attribute name="id"><xsl:number/></xsl:attribute>
      <xsl:attribute name="class" select="cw:slide-class(.)"/>
      <xsl:apply-templates/>
    </section>
  </xsl:template>
  
  <xsl:template match="cw:slide/cw:title">
    <h2 class="courseware-slide-title"><xsl:apply-templates/></h2>
  </xsl:template>
  
  <xsl:template match="cw:vml">
    <div class="courseware-slide-contents">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="cw:visual">
    <img class="courseware-slide-contents" src="{resolve-uri(@fileref,base-uri())}"/>
  </xsl:template>
  
  <xsl:template match="cw:notes"/>
</xsl:stylesheet>
