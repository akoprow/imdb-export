<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" indent="yes"  />
    
	<xsl:template match="id">
		<xsl:copy-of select="." />
		<poster-url>
			<xsl:variable name="poster-url" select="document(concat('imdb/movie-', ., '.xhtml'))//xhtml:a[@id='poster']/xhtml:img/@src" />
			<xsl:if test="string-length($poster-url) = 0">
				<xsl:message>
					<xsl:text>Could not locate a poster for movie: </xsl:text>
					<xsl:value-of select="../title" />
				</xsl:message>
			</xsl:if>
			<xsl:value-of select="$poster-url" />		
		</poster-url>
	</xsl:template>

	<xsl:template match="*">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
    
</xsl:stylesheet>
