<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output method="text" />
	<xsl:param name="movie-id" />
    
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="//movie[id=$movie-id]">
				<xsl:value-of select="//movie[id=$movie-id]/poster-url" />			
			</xsl:when>
			<xsl:when test="//tvserie[id=$movie-id]">
				<xsl:value-of select="//tvserie[id=$movie-id]/poster-url" />			
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">
					<xsl:text>Cannot find poster URL for movie with id: </xsl:text>
					<xsl:value-of select="$movie-id" />
				</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
    
</xsl:stylesheet>
