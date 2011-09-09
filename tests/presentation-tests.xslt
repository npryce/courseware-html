<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/xsltest/1.0">

  <xsl:import href="../xslt/presentation.xslt"/>
  

  <xsl:template name="presentation-tests">
    <test:suite>
      <h2>Presentation Transformations</h2>
      
      <p>A simple presentation</p>
      
      <xsl:variable name="presentation">
	<cw:presentation>
	  <cw:title>Example Presentation</cw:title>
	  <cw:slide>
	    <cw:title>Slide 1</cw:title>
	    <cw:visual href="slide-1-visual"/>
	  </cw:slide>
	  <cw:slide>
	    <cw:title>Slide 2</cw:title>
	    <cw:visual href="slide-2-visual"/>
	  </cw:slide>
	</cw:presentation>
      </xsl:variable>
      
      <xsl:variable name="transformed">
	<xsl:apply-templates select="$presentation"/>
      </xsl:variable>
      
      <xsl:variable name="html-slides" 
		    select="$transformed//html:section[contains(@class, 'courseware-slide ')]"/>
      
      <test:assert-equal actual="count($html-slides)" expected="3"/>
      
      <p>Creates a Title Slide</p>
      
      <xsl:variable name="title-slide" select="$html-slides[1]"/>
      <test:assert-equal actual="string($title-slide/@class)"
			 expected="'courseware-slide courseware-title-slide'"/>
      <test:assert-equal actual="string($title-slide/html:h1)"
			 expected="'Example Presentation'"/>


      <p>Slides are given a numeric id starting from 1</p>
      
      <test:assert-equal actual="number($html-slides[1]/@id)" expected="1"/>
      <test:assert-equal actual="number($html-slides[2]/@id)" expected="2"/>
      <test:assert-equal actual="number($html-slides[3]/@id)" expected="3"/>
    </test:suite>


    <test:suite>
      <h2>License Information</h2>
      
      <xsl:variable name="presentation-with-licensed-images">
	<cw:presentation>
	  <cw:title>Another Presentation</cw:title>
	  <cw:slide>
	    <cw:title>First Title</cw:title>
	    <cw:visual href="slide-a1-visual">
	      <cw:copyright><cw:year>1999</cw:year><cw:holder>Alice Band</cw:holder></cw:copyright>
	      <cw:license href="http://creativecommons.org/licenses/by/2.0/"/>
	    </cw:visual>
	  </cw:slide>
	  <cw:slide>
	    <cw:title>A Slide Without a Licensed Image</cw:title>
	    <cw:visual href="slide-2-visual"/>
	  </cw:slide>
	  <cw:slide>
	    <cw:title>Third Title</cw:title>
	    <cw:visual href="slide-3-visual">
	      <cw:copyright><cw:year>2011</cw:year><cw:holder>Bob Downe</cw:holder></cw:copyright>
	      <cw:license href="http://example.com/bobs-own-license-terms">Bob's Own License</cw:license>
	    </cw:visual>
	  </cw:slide>
	  <cw:slide>
	    <cw:title>A Slide Without a License URL</cw:title>
	    <cw:visual href="slide-3-visual">
	      <cw:copyright><cw:year>2011</cw:year><cw:holder>Cliff Edge</cw:holder></cw:copyright>
	      <cw:license>Edge Image License</cw:license>
	    </cw:visual>
	  </cw:slide>
	</cw:presentation>
      </xsl:variable>
      
      <xsl:variable name="transformed">
	<xsl:apply-templates select="$presentation-with-licensed-images"/>
      </xsl:variable>
      
      <xsl:variable name="html-slides" 
		    select="$transformed//html:section[contains(@class, 'courseware-slide ')]"/>
      
      <p>Collates any image copyright and license information into credits slide</p>
      
      <test:assert-equal actual="count($html-slides)" expected="6"/>
      
      <xsl:variable name="license-slide" select="$html-slides[6]"/>
      
      <p>The license slide is a text slide with an additional 'courseware-credits-slide' class</p>
      
      <test:assert-equal actual="string($license-slide/@class)" 
                         expected="'courseware-slide courseware-text-slide courseware-credits-slide'"/>
      
      <p>The credits slide has a descriptive title</p>
      <test:assert-equal actual="string($license-slide/html:h2)"
                         expected="'Image Credits'"/>
      
      <p>The credits slide is given an id</p>
      
      <test:assert-equal actual="number($license-slide/@id)" expected="6"/>
      
      <p>Only slides with licensed images are included in the list</p>
      
      <test:assert-equal actual="count($license-slide//html:li)"
                         expected="3"/>
      
      <p>The credits are listed with slide number and title</p>
      
      <test:assert-equal actual="normalize-space($license-slide//html:li[1]/html:p[@class='courseware-credits-slide-details'])"
                         expected="'Slide 1, First Title.'"/>
      
      <test:assert-equal actual="normalize-space($license-slide//html:li[2]/html:p[@class='courseware-credits-slide-details'])"
                         expected="'Slide 3, Third Title.'"/>
      
      <p>Copyright Information is included</p>
      
      <test:assert-equal actual="string($license-slide//html:li[1]/html:p[@class='courseware-credits-copyright'])"
                         expected="'Copyright &#xA9; 1999 Alice Band.'"/>
      
      <test:assert-equal actual="string($license-slide//html:li[2]/html:p[@class='courseware-credits-copyright'])"
                         expected="'Copyright &#xA9; 2011 Bob Downe.'"/>
      
      <p>Known licenses are described</p>
      
      <test:assert-equal actual="normalize-space($license-slide//html:li[1]/html:p[@class='courseware-credits-license'])"
                         expected="'Used under the terms of the Creative Commons Attribution 2.0 Generic license.'"/>
      
      <p>Unknown licenses are described using text in the <code>license</code> element</p>
      
      <xsl:variable name="expected-license">Used under the terms of Bob's Own License.</xsl:variable>
      <test:assert-equal actual="normalize-space($license-slide//html:li[2]/html:p[@class='courseware-credits-license'])"
                         expected="string($expected-license)"/>
      
      <p>Unknown licenses do not need to have a URL</p>
      
      <test:assert that="not(exists($license-slide//html:li[3]/html:p[@class='courseware-credits-license']/html:a))"/>
      
      <p>Credits are in a courseware-slide-contents div</p>
      
      <test:assert-equal actual="string($license-slide//html:div/@class)"
                         expected="'courseware-slide-contents'"/>
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
