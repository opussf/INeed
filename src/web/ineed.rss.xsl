<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes"/>

	<xsl:variable name='maxLevel' select='/restedToons/maxLevel'/>

	<xsl:template match="/">
		<rss version="2.0">
		<channel>
			<title>iNeeded Items</title>
			<link>http://www.zz9-za.com/~opus/ineed</link>
			<description>iNeeded Items</description>
			<generator>xslt</generator>
			<ttl>30</ttl>
			
			<xsl:call-template name="itemCount"/>

			<xsl:apply-templates select="/ineed/item">
				<xsl:with-param name="title">Oldest added item</xsl:with-param>
				<xsl:sort data-type='number' order='ascending' select='./player/@addedTS'/>
			</xsl:apply-templates>
			
			<xsl:apply-templates select="/ineed/item">
				<xsl:with-param name="title">Oldest updated item</xsl:with-param>
				<xsl:sort data-type='number' order='ascending' select='./player/@updatedTS'/>
			</xsl:apply-templates>
			
			<xsl:apply-templates select="/ineed/item">
				<xsl:with-param name="title">Newest added item</xsl:with-param>
				<xsl:sort data-type='number' order='descending' select='./player/@addedTS'/>
			</xsl:apply-templates>
			
			<xsl:apply-templates select="/ineed/item">
				<xsl:with-param name="title">Newest updated item</xsl:with-param>
				<xsl:sort data-type='number' order='descending' select='./player/@updatedTS'/>
			</xsl:apply-templates>

		</channel>
		</rss>
	</xsl:template>

	<xsl:template name='itemCount'>
		<xsl:variable name="outText">
		<xsl:value-of select='count(/ineed/item)'/>
		<xsl:text> items needed. </xsl:text>
		<xsl:text>(</xsl:text>
		<xsl:value-of select='sum(/ineed/item/player/@has)'/>
		<xsl:text> / </xsl:text>
		<xsl:value-of select='sum(/ineed/item/player/@needs)'/>
		<xsl:text>)</xsl:text>
		</xsl:variable>
		<item>
		<title><xsl:value-of select="$outText"/></title>
		<link>http://www.zz9-za.com/~opus/ineed</link>
		<guid isPermaLink="false"><xsl:value-of select="$outText"/></guid>
		<description><xsl:value-of select="$outText"/></description>
		</item>
	</xsl:template>

	<xsl:template match='item'>
		<xsl:param name="title"/>
		<xsl:if test='position() = 1'>
		<xsl:variable name="playerInfo"><xsl:apply-templates select="./player">
			<xsl:sort data-type='number' order='descending' select='./player/@added'/>
		</xsl:apply-templates></xsl:variable>
		<item>
		<title><xsl:value-of select="$title"/>: <xsl:value-of select="@id"/>
		<xsl:text> added at </xsl:text>
		<xsl:apply-templates select="./player">
			<xsl:sort data-type='number' order='descending' select='./player/@added'/>
		</xsl:apply-templates>
		</title>
		<link>http://www.zz9-za.com/~opus/ineed/&#x23;<xsl:value-of select='@id'/></link>
		<guid isPermaLink="false"><xsl:value-of select="@id"/>-<xsl:value-of select='$title'/>-<xsl:value-of select='$playerInfo'/></guid>
		<description><xsl:value-of select="@id"/> (<xsl:value-of select="itemLink"/>)</description>
		</item>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match='player'>
		<xsl:if test='position() = 1'>
		<xsl:value-of select='@added'/> for <xsl:value-of select='@name'/>-<xsl:value-of select='@realm'/>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
