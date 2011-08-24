<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/testxslt/1.0">

  <xsl:import href="../xslt/text.xslt"/>
  
  <xsl:template name="text-tests">
    <test:suite>
      <h2>Block Transforms</h2>
      
      <test:suite>
	<h3>Paragraphs</h3>
	<p>Para elements are translated to HTML p elements</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:para>Some text</cw:para>
	  </test:original>
	  <test:expected>
	    <html:p>Some text</html:p>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
      
      <test:suite>
	<h3>Lists</h3>
	
	<p>Orderedlist/listitem elements are translated to HTML ol/li elements</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:orderedlist><cw:listitem>Some text</cw:listitem></cw:orderedlist>
	  </test:original>
	  
	  <test:expected>
	    <html:ol><html:li>Some text</html:li></html:ol>
	  </test:expected>
	</test:assert-transform>
	
	<p>Itemizedlists/listitem elements are translated to HTML ul/li elements</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:itemizedlist><cw:listitem>Some text</cw:listitem></cw:itemizedlist>
	  </test:original>
	  
	  <test:expected>
	    <html:ul><html:li>Some text</html:li></html:ul>
	  </test:expected>
	</test:assert-transform>
	
	<p>Copes with empty lists</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:orderedlist></cw:orderedlist>
	  </test:original>
	  
	  <test:expected>
	    <html:ol></html:ol>
	  </test:expected>
	</test:assert-transform>
	
	<test:assert-transform>
	  <test:original>
	    <cw:itemizedlist></cw:itemizedlist>
	  </test:original>
	  
	  <test:expected>
	    <html:ul></html:ul>
	  </test:expected>
	</test:assert-transform>
	
	<p>Copes with nested lists</p>
	<test:assert-transform>
	  <test:original>
	    <cw:itemizedlist>
	      <cw:listitem>
		<cw:orderedlist>
		  <cw:listitem>A</cw:listitem>
		  <cw:listitem>B</cw:listitem>
		</cw:orderedlist>
	      </cw:listitem>
	      <cw:listitem>X</cw:listitem>
	    </cw:itemizedlist>
	  </test:original>
	  
	  <test:expected>
	    <html:ul>
	      <html:li>
		<html:ol>
		  <html:li>A</html:li>
		  <html:li>B</html:li>
		</html:ol>
	      </html:li>
	      <html:li>X</html:li>
	    </html:ul>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
      
      <test:suite>
	<h3>Term Lists</h3>
	<p>Termlists are translated into tables</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:termlist>
	      <cw:termlistitem>
		<cw:term>A</cw:term>
		<cw:definition><cw:para>1</cw:para></cw:definition>
	      </cw:termlistitem>
	      <cw:termlistitem>
		<cw:term>B</cw:term>
		<cw:definition><cw:para>2</cw:para></cw:definition>
	      </cw:termlistitem>
	    </cw:termlist>
	  </test:original>
	  
	  <test:expected>
	    <html:table class="courseware-termlist">
	      <html:tr class="courseware-termlist-item">
		<html:td class="courseware-termlist-term">A</html:td>
		<html:td class="courseware-termlist-definition"><html:p>1</html:p></html:td>
	      </html:tr>
	      <html:tr class="courseware-termlist-item">
		<html:td class="courseware-termlist-term">B</html:td>
		<html:td class="courseware-termlist-definition"><html:p>2</html:p></html:td>
	      </html:tr>
	    </html:table>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
      
      <test:suite>
	<h3>Program Listings</h3>
	<p>Programlistings are translated into HTML pre elements.</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:programlisting>
	      int main(int argc, char **argv);
	    </cw:programlisting>
	  </test:original>
	  
	  <test:expected>
	    <html:pre>
	      int main(int argc, char **argv);
	    </html:pre>
	  </test:expected>
	</test:assert-transform>
	
	<p>The language is translated into a class on the pre element.</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:programlisting lang="java">
	      throw null;
	    </cw:programlisting>
	  </test:original>
	  
	  <test:expected>
	    <html:pre class="courseware-programlisting-java">
	      throw null;
	    </html:pre>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
    </test:suite> <!-- Block transforms -->
    
    <test:suite>
      <h2>Inline Text Transforms</h2>
      
      <test:suite>
	<h3>Emphasis</h3>
	
	<p>Without any role, emphasis is translated to an HTML em element</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:emphasis>Hello</cw:emphasis>
	  </test:original>
	  
	  <test:expected>
	    <html:em>Hello</html:em>
	  </test:expected>
	</test:assert-transform>
	
	<p>When given the 'strong' role, emphasis is translated to an HTML strong element</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:emphasis role="strong">Hello</cw:emphasis>
	  </test:original>
	  
	  <test:expected>
	    <html:strong>Hello</html:strong>
	  </test:expected>
	</test:assert-transform>
	
	<p>Any other role is used to set a class on the HTML em element</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:emphasis role="danger">Hello</cw:emphasis>
	  </test:original>
	  
	  <test:expected>
	    <html:em class="courseware-emphasis-danger">Hello</html:em>
	  </test:expected>
	</test:assert-transform>
	
      </test:suite>
      
      <test:suite>
	<h2>Links</h2>
	
	<test:assert-transform>
	  <test:original>
	    <cw:link href="http://www.example.com">Link Text</cw:link>
	  </test:original>
	  
	  <test:expected>
	    <html:a href="http://www.example.com">Link Text</html:a>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
      
      <test:suite>
	<h2>Inline Code</h2>
	
	<test:assert-transform>
	  <test:original>
	    <cw:code>% rm -rf *</cw:code>
	  </test:original>
	  
	  <test:expected>
	    <html:code>% rm -rf *</html:code>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
    </test:suite> <!-- Inline text transforms -->
  </xsl:template>
</xsl:stylesheet>
