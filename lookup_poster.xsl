<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output method="text" />
	<xsl:param name="movie-id" />
    
	<xsl:template match="/">
		<xsl:value-of select="//movie[id=$movie-id]/poster-url" />
	</xsl:template>
    
</xsl:stylesheet>
