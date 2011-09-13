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
      
      <xsl:if test="cw:visual/cw:copyright or cw:visual/cw:license">
        <xsl:apply-templates select="cw:visual" mode="image-credits"/>
      </xsl:if>
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
  
  <xsl:template match="cw:visual" mode="image-credits">
    <xsl:variable name="slide-index"><xsl:number/></xsl:variable>
    
    <div class="courseware-image-credits">
      <p>
        <xsl:apply-templates select="cw:copyright"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="cw:license"/>
      </p>
    </div>
  </xsl:template>
  
  <xsl:template match="cw:visual/cw:copyright">
    <xsl:text>Image copyright &#xA9; </xsl:text>
    <xsl:value-of select="cw:year"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="cw:holder"/>
    <xsl:text>.</xsl:text>
  </xsl:template>
  
  <xsl:template match="cw:visual/cw:license">
    <xsl:choose>
      <xsl:when test="@href">
        <xsl:variable name="license-name" select="cw:license-name(@href)"/>
        <xsl:choose>
          <xsl:when test="exists($license-name)">
            <xsl:text>Used under the terms of </xsl:text><a href="{@href}"><xsl:copy-of select="$license-name"/></a>
          </xsl:when>
          <xsl:otherwise>
            <a href="{@href}"><xsl:apply-templates/></a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>.</xsl:text>
  </xsl:template>
</xsl:stylesheet>
