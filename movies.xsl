<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" indent="yes"  />
    
    <xsl:template match="/">
    	<movies>
    		<xsl:apply-templates />
    	</movies>
    </xsl:template>
    
	<xsl:template match="node()">
		<xsl:apply-templates />
	</xsl:template>
    
    <xsl:template match="//xhtml:table//xhtml:table//xhtml:table//xhtml:table//xhtml:tr[position() ge 4 and position() le last()-3]">
    	<movie>
    		<link>
    			<xsl:text>http://www.imdb.com</xsl:text>
		    	<xsl:value-of select="xhtml:td[2]/xhtml:a/@href" />    	
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
    
</xsl:stylesheet>
