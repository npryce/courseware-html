<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0"
                xmlns:test="http://www.natpryce.com/xsltest/1.0">

  <xsl:import href="../xslt/presentation.xslt"/>
  
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
	    <p>Some text</p>
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
	    <ol><li>Some text</li></ol>
	  </test:expected>
	</test:assert-transform>
	
	<p>Itemizedlists/listitem elements are translated to HTML ul/li elements</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:itemizedlist><cw:listitem>Some text</cw:listitem></cw:itemizedlist>
	  </test:original>
	  
	  <test:expected>
	    <ul><li>Some text</li></ul>
	  </test:expected>
	</test:assert-transform>
	
	<p>Copes with empty lists</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:orderedlist></cw:orderedlist>
	  </test:original>
	  
	  <test:expected>
	    <ol></ol>
	  </test:expected>
	</test:assert-transform>
	
	<test:assert-transform>
	  <test:original>
	    <cw:itemizedlist></cw:itemizedlist>
	  </test:original>
	  
	  <test:expected>
	    <ul></ul>
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
	    <ul>
	      <li>
		<ol>
		  <li>A</li>
		  <li>B</li>
		</ol>
	      </li>
	      <li>X</li>
	    </ul>
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
	    <table class="courseware-termlist">
	      <tr class="courseware-termlist-item">
		<td class="courseware-termlist-term">A</td>
		<td class="courseware-termlist-definition"><p>1</p></td>
	      </tr>
	      <tr class="courseware-termlist-item">
		<td class="courseware-termlist-term">B</td>
		<td class="courseware-termlist-definition"><p>2</p></td>
	      </tr>
	    </table>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
      
      <test:suite>
	<h3>Program Listings</h3>
	<p>Programlistings are translated into prettified, nested HTML <code>pre</code> and <code>code</code> elements.</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:programlisting>int main(int argc, char **argv);</cw:programlisting>
	  </test:original>
	  
	  <test:expected>
	    <pre class="courseware-program-listing prettyprint">
	      <code>int main(int argc, char **argv);</code>
	    </pre>
	  </test:expected>
	</test:assert-transform>
	
	<p>The language is translated into a class on the <code>code</code> element.</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:programlisting lang="java">throw null;</cw:programlisting>
	  </test:original>
	  
	  <test:expected>
	    <pre class="courseware-program-listing prettyprint">
	      <code class="language-java">throw null;</code>
	    </pre>
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
	    <em>Hello</em>
	  </test:expected>
	</test:assert-transform>
	
	<p>When given the 'strong' role, emphasis is translated to an HTML strong element</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:emphasis role="strong">Hello</cw:emphasis>
	  </test:original>
	  
	  <test:expected>
	    <strong>Hello</strong>
	  </test:expected>
	</test:assert-transform>
	
	<p>Any other role is used to set a class on the HTML em element</p>
	
	<test:assert-transform>
	  <test:original>
	    <cw:emphasis role="danger">Hello</cw:emphasis>
	  </test:original>
	  
	  <test:expected>
	    <em class="courseware-emphasis-danger">Hello</em>
	  </test:expected>
	</test:assert-transform>
	
      </test:suite>
      
      <test:suite>
	<h3>Links</h3>
	
	<test:assert-transform>
	  <test:original>
	    <cw:link href="http://www.example.com">Link Text</cw:link>
	  </test:original>
	  
	  <test:expected>
	    <a href="http://www.example.com">Link Text</a>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
      
      <test:suite>
	<h3>Inline Code</h3>
	
	<test:assert-transform>
	  <test:original>
	    <cw:code>% rm -rf *</cw:code>
	  </test:original>
	  
	  <test:expected>
	    <code>% rm -rf *</code>
	  </test:expected>
	</test:assert-transform>
      </test:suite>
    </test:suite> <!-- Inline text transforms -->
  </xsl:template>
</xsl:stylesheet>
