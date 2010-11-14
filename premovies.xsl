<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" indent="yes"  />

	<xsl:variable name="tvseries" select="document('tvseries.xml')" />
    
    <xsl:template match="/">
    	<movies>
    		<xsl:apply-templates />
			<xsl:call-template name="tvseries" />
    	</movies>
    </xsl:template>
    
	<xsl:template match="node()">
		<xsl:apply-templates />
	</xsl:template>
    
    <xsl:template match="//xhtml:table//xhtml:table//xhtml:table//xhtml:table//xhtml:tr[position() ge 4 and position() le last()-3]">
    	<movie>
    		<xsl:variable name="link" select="xhtml:td[2]/xhtml:a/@href" />
    		<id>
				<xsl:value-of select="substring(tokenize($link, '/')[3], 3)" />
			</id>
    		<link>
    			<xsl:text>http://www.imdb.com</xsl:text>
		    	<xsl:value-of select="$link" />    	
    		</link>
    		<title>
		    	<xsl:value-of select="normalize-space(xhtml:td[2]/xhtml:a)" />    	
    		</title>
    		<my-rating>
		    	<xsl:value-of select="number(xhtml:td[3])" />
    		</my-rating>
    		<imdb-rating>
		    	<xsl:value-of select="number(xhtml:td[4])" />
    		</imdb-rating>
    	</movie>
    </xsl:template>

	<xsl:template name="tvseries">
		<xsl:for-each select="$tvseries//tvserie">
			<tvserie>
				<id>
					<xsl:value-of select="imdb-id" />
				</id>
				<link>
    				<xsl:text>http://www.imdb.com/title/tt</xsl:text>
					<xsl:value-of select="imdb-id" />    								
				</link>
			</tvserie>
		</xsl:for-each>
	</xsl:template>
    
</xsl:stylesheet>
