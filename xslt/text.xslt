<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:template match="cw:para">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="cw:itemizedlist">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  
  <xsl:template match="cw:orderedlist">
    <ol>
      <xsl:apply-templates/>
    </ol>
  </xsl:template>
  
  <xsl:template match="cw:listitem">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>
  
  <xsl:template match="cw:termlist">
    <html:table class="courseware-termlist">
      <xsl:apply-templates/>
    </html:table>
  </xsl:template>

  <xsl:template match="cw:termlistitem">
    <html:tr class="courseware-termlist-item">
      <xsl:apply-templates/>
    </html:tr>
  </xsl:template>

  <xsl:template match="cw:term">
    <html:td class="courseware-termlist-term">
      <xsl:apply-templates/>
    </html:td>
  </xsl:template>
  
  <xsl:template match="cw:definition">
    <html:td class="courseware-termlist-definition">
      <xsl:apply-templates/>
    </html:td>
  </xsl:template>
  
  <xsl:template match="cw:programlisting">
    <html:pre>
      <xsl:if test="@lang">
	<xsl:attribute name="class" select="concat('courseware-programlisting-', @lang)"/>
      </xsl:if>
      <xsl:apply-templates/>
    </html:pre>
  </xsl:template>

  <xsl:template match="cw:emphasis[@role='strong']">
    <html:strong>
      <xsl:apply-templates/>
    </html:strong>
  </xsl:template>
  
  <xsl:template match="cw:emphasis">
    <html:em>
      <xsl:if test="@role">
	<xsl:attribute name="class" select="concat('courseware-emphasis-', @role)"/>
      </xsl:if>
      <xsl:apply-templates/>
    </html:em>
  </xsl:template>
  
  <xsl:template match="cw:link">
    <html:a href="{@href}">
      <xsl:apply-templates/>
    </html:a>
  </xsl:template>

  <xsl:template match="cw:code">
    <html:code>
      <xsl:apply-templates/>
    </html:code>
  </xsl:template>
</xsl:stylesheet>
