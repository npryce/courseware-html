<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/xsltest/1.0">

  <xsl:import href="../xslt/presentation.xslt"/>
  
  <xsl:template name="slide-tests">
    <test:suite>
      <h2>Slide Transforms</h2>
      
      <p>A slide is translated to a div with an H2</p>
      
      <p>Slides can contain text</p>
      
      <test:assert-transform>
	<test:original>
	  <cw:slide>
	    <cw:title>A Slide</cw:title>
	    <cw:vml>
	      <cw:para>An example of a slide with some text on it.</cw:para>
	    </cw:vml>
	  </cw:slide>
	</test:original>
	
	<test:expected>
	  <section class="courseware-slide courseware-text-slide" id="1">
	    <h2 class="courseware-slide-title">A Slide</h2>
	    <div class="courseware-slide-contents">
	      <p>An example of a slide with some text on it.</p>
	    </div>
	  </section>
	</test:expected>
      </test:assert-transform>
      
      <p>Slides can contain just images.  Images are translated into
	<code>div</code> elements with a background-image style, not
        into <code>img</code> elements, so that they can easily be made
        to fill the slide with CSS.
      </p>
	
      <test:assert-transform>
	<test:original>
	  <cw:slide>
	    <cw:title>Another Slide</cw:title>
	    <cw:visual fileref="a-picture.jpg"/>
	  </cw:slide>
	</test:original>
	<test:expected>
	  <section class="courseware-slide courseware-image-slide" id="1">
	    <h2 class="courseware-slide-title">Another Slide</h2>
	    <div class="courseware-slide-contents" 
		 style="background-image: url('{resolve-uri('a-picture.jpg')}')"/>
	  </section>
	</test:expected>
      </test:assert-transform>
      
      <p>Notes are skipped</p>
      
      <test:assert-transform>
	<test:original>
	  <cw:slide>
	    <cw:title>Another Slide</cw:title>
	    <cw:visual fileref="something.svg"/>
	    <cw:notes>
              <cw:student><cw:para>Should not be shown</cw:para></cw:student>
              <cw:presenter><cw:para>Should not be shown either</cw:para></cw:presenter>
	    </cw:notes>
	  </cw:slide>
	</test:original>
	
	<test:expected>
	  <section class="courseware-slide courseware-image-slide" id="1">
	    <h2 class="courseware-slide-title">Another Slide</h2>
	    <div class="courseware-slide-contents" style="background-image: url('{resolve-uri('something.svg')}')"/>
	  </section>
	</test:expected>
      </test:assert-transform>
      
      <p>The visuals's background attribute is translated to CSS in the section's style attribute</p>
      
      <xsl:variable name="slide-with-background">
	<cw:slide>
	  <cw:title>Slide with License</cw:title>
	    <cw:visual fileref="foo" bg="red"/>
	</cw:slide>
      </xsl:variable>
      
      <xsl:variable name="html-with-background">
        <xsl:apply-templates select="$slide-with-background"/>
      </xsl:variable>
      
      <test:assert-equal actual="string($html-with-background/html:section/@style)"
                         expected="'background-color: red'"/>
    </test:suite>
    
    <test:suite>
      <h3>Image Copyright and Licensing</h3>
      
      <p>Licensing Information Is Displayed Over the Slide</p>
      
      <test:assert-transform>
	<test:original>
	  <cw:slide>
	    <cw:title>Slide with License</cw:title>
	    <cw:visual fileref="foo">
	      <cw:copyright>
		<cw:year>2007</cw:year>
		<cw:holder>Copyright Owner</cw:holder>
	      </cw:copyright>
	      <cw:license href="license-url">License Description</cw:license>
	    </cw:visual>
	  </cw:slide>
	</test:original>
	
	<test:expected>
	  <section class="courseware-slide courseware-image-slide" id="1">
	    <h2 class="courseware-slide-title">Slide with License</h2>
	    <div class="courseware-slide-contents" style="background-image: url('{resolve-uri('foo')}')"/>
            <div class="courseware-image-credits">
              <p>Image copyright &#xA9; 2007 Copyright Owner. Used under the terms of <a href="license-url">License Description</a>.</p>
            </div>
	  </section>
	</test:expected>
      </test:assert-transform>
      
      
      <p>Standard licenses can be identified by URL alone</p>
      
      <xsl:variable name="slide-with-standard-license">
	<cw:slide>
	  <cw:title>Slide with Known License</cw:title>
	  <cw:visual fileref="foo">
	    <cw:copyright>
	      <cw:year>2010</cw:year>
	      <cw:holder>Bob</cw:holder>
	    </cw:copyright>
	    <cw:license href="http://creativecommons.org/licenses/by/2.0/"/>
	  </cw:visual>
	</cw:slide>
      </xsl:variable>
      
      <xsl:variable name="transformed-slide-with-standard-license">
        <xsl:apply-templates select="$slide-with-standard-license"/>
      </xsl:variable>
      
      <test:assert-equal
         actual="normalize-space($transformed-slide-with-standard-license//html:div[@class='courseware-image-credits'])"
         expected="'Image copyright &#xA9; 2010 Bob. Used under the terms of the Creative Commons Attribution 2.0 Generic License.'"/>
      
      <test:assert-equal actual="string($transformed-slide-with-standard-license
                                            //html:div[@class='courseware-image-credits']//html:a/@href)"
                         expected="'http://creativecommons.org/licenses/by/2.0/'"/>
      
      <p>Non-Standard licenses are described using text in the <code>license</code> element</p>
      
      <xsl:variable name="slide-with-nonstandard-license">
	<cw:slide>
	  <cw:title>Slide with Non-Standard License</cw:title>
	  <cw:visual fileref="foo">
	    <cw:copyright>
	      <cw:year>2001</cw:year>
	      <cw:holder>Carol</cw:holder>
	    </cw:copyright>
	    <cw:license href="license-url">Carol License</cw:license>
	  </cw:visual>
	</cw:slide>
      </xsl:variable>
      
      <xsl:variable name="transformed-slide-with-nonstandard-license">
        <xsl:apply-templates select="$slide-with-nonstandard-license"/>
      </xsl:variable>
      
      <test:assert-equal 
         actual="normalize-space($transformed-slide-with-nonstandard-license//html:div[@class='courseware-image-credits'])"
         expected="'Image copyright &#xA9; 2001 Carol. Used under the terms of Carol License.'"/>
      
      <test:assert-equal 
         actual="string($transformed-slide-with-nonstandard-license//html:div[@class='courseware-image-credits']
                          //html:a/@href)"
         expected="'license-url'"/>
      
      <xsl:variable name="slide">
	<cw:slide>
	  <cw:title>Slide with No License URL</cw:title>
	  <cw:visual fileref="foo">
	    <cw:copyright>
	      <cw:year>2012</cw:year>
	      <cw:holder>Dave</cw:holder>
	    </cw:copyright>
	    <cw:license>The Big Dave License</cw:license>
	  </cw:visual>
	</cw:slide>
      </xsl:variable>

      <xsl:variable name="transformed">
        <xsl:apply-templates select="$slide"/>
      </xsl:variable>
      
      <test:assert that="exists($transformed//html:div[@class='courseware-image-credits'])"/>
      <test:assert that="not(exists($transformed//html:div[@class='courseware-image-credits']//html:a))"/>
      
    </test:suite>
  </xsl:template>
</xsl:stylesheet>
