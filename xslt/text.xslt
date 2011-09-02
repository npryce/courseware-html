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
    <table class="courseware-termlist">
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="cw:termlistitem">
    <tr class="courseware-termlist-item">
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="cw:term">
    <td class="courseware-termlist-term">
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  
  <xsl:template match="cw:definition">
    <td class="courseware-termlist-definition">
      <xsl:apply-templates/>
    </td>
  </xsl:template>
  
  <xsl:template match="cw:programlisting">
    <pre class="courseware-program-listing prettyprint">
      <code>
	<xsl:if test="@lang">
	  <xsl:attribute name="class" select="concat('language-', @lang)"/>
	</xsl:if>
	<xsl:apply-templates/>
      </code>
    </pre>
  </xsl:template>

  <xsl:template match="cw:emphasis[@role='strong']">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>
  
  <xsl:template match="cw:emphasis">
    <em>
      <xsl:if test="@role">
	<xsl:attribute name="class" select="concat('courseware-emphasis-', @role)"/>
      </xsl:if>
      <xsl:apply-templates/>
    </em>
  </xsl:template>
  
  <xsl:template match="cw:link">
    <a href="{@href}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="cw:code">
    <code>
      <xsl:apply-templates/>
    </code>
  </xsl:template>
</xsl:stylesheet>
