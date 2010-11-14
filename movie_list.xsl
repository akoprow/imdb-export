<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output method="text" />

	<xsl:template match="/">
		<xsl:for-each select="//movie | //tvserie">
 			<xsl:value-of select="id" />
 			<xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:template>
    
</xsl:stylesheet>
