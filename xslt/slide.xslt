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
    <xsl:param tunnel="yes" name="intro-slide-count" select="0"/>
    
    <section id="{index-of(..//cw:slide, .) + $intro-slide-count}" class="{cw:slide-class(.)}">
      <xsl:if test="cw:visual/@bg">
        <xsl:attribute name="style">background-color: <xsl:value-of select="cw:visual/@bg"/></xsl:attribute>
      </xsl:if>
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
    <div class="courseware-slide-contents" style="background-image: url('{resolve-uri(@fileref,base-uri())}')"/>
  </xsl:template>
  
  <xsl:template match="cw:notes"/>
</xsl:stylesheet>
