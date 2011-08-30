<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:cw="http://www.natpryce.com/courseware/1.0">
  
  <xsl:import href="report-unknown-elements.xslt"/>
  <xsl:import href="slide.xslt"/>
  
  <xsl:param name="deck-theme" select="'web-2.0'"/>
  <xsl:param name="deck-transition" select="'horizontal-slide'"/>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="cw:presentation">
    <html>
      <head>
	<link rel="stylesheet" href="deck/core/deck.core.css"/>
	<link rel="stylesheet" href="deck/extensions/goto/deck.goto.css"/>
	<link rel="stylesheet" href="deck/extensions/menu/deck.menu.css"/>
	<link rel="stylesheet" href="deck/extensions/navigation/deck.navigation.css"/>
	<link rel="stylesheet" href="deck/extensions/status/deck.status.css"/>
	<link rel="stylesheet" href="deck/extensions/hash/deck.hash.css"/>
	<link rel="stylesheet" href="deck/themes/style/{$deck-theme}.css"/>
	<link rel="stylesheet" href="deck/themes/transition/${deck-transition}.css"/>
	<script src="jquery-1.6.2.min.js"></script>
	<script src="deck/modernizr.custom.js"></script>
	<script>
	  $(function() {
	      $.deck('.courseware-slide');
	  });
	</script>
      </head>
      <body class="deck-container">
	<xsl:apply-templates select="cw:slide"/>
	<xsl:call-template name="deck-navigation"/>
	
	<script src="deck/core/deck.core.js"></script>
	<script src="deck/extensions/menu/deck.menu.js"></script>
	<script src="deck/extensions/goto/deck.goto.js"></script>
	<script src="deck/extensions/status/deck.status.js"></script>
	<script src="deck/extensions/navigation/deck.navigation.js"></script>
	<script src="deck/extensions/hash/deck.hash.js"></script>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template name="deck-navigation">
    <a href="#" class="deck-prev-link" title="Previous">&#8592;</a>
    <a href="#" class="deck-next-link" title="Next">&#8594;</a>
    
    <p class="deck-status">
      <span class="deck-status-current"></span> / <span class="deck-status-total"></span>
    </p>
    
    <form action="." method="get" class="goto-form">
      <label for="goto-slide">Go to slide:</label>
      <input type="number" name="slidenum" id="goto-slide"/>
      <input type="submit" value="Go"/>
    </form>
  </xsl:template>
</xsl:stylesheet>
