<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">
		<feed xmlns='http://www.w3.org/2005/Atom'>
			<title>iNeeded Items</title>
			<link href="http://www.zz9-za.com/~opus/ineed/atom" rel="self" />
			<link href='http://www.zz9-za.com/~opus/ineed' />
			<id>http://www.zz9-za.com/~opus/ineed/atom/</id>
			<updated>2016-03-04T05:18:00Z</updated>
			<!--
			<updated><xsl:value-of select='$now'/></updated>
			-->
			
			<xsl:call-template name="itemCount">
				<xsl:with-param name='numItems'><xsl:value-of select="count(/ineed/item)"/></xsl:with-param>
			</xsl:call-template>

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

		</feed>
	</xsl:template>

	<xsl:template name='itemCount'>
		<xsl:param name='numItems'/>
		<entry>
		<title><xsl:value-of select="$numItems"/> items needed.</title>
		<link href='http://www.zz9-za.com/~opus/ineed' />
		<id><xsl:value-of select="$numItems"/> items needed.</id>
		<content type='text'><xsl:value-of select="$numItems"/> items needed.</content>
		</entry>
	</xsl:template>

	<xsl:template match='item'>
		<xsl:param name="title"/>
		<xsl:if test='position() = 1'>
		<entry>
		<title><xsl:value-of select="$title"/>: <xsl:value-of select="@id"/>
		<xsl:text> added at </xsl:text>
		<xsl:apply-templates select="./player">
			<xsl:sort data-type='number' order='descending' select='./player/@added'/>
		</xsl:apply-templates>
		</title>
		<xsl:element name='link'>
			<xsl:attribute name='href'>http://www.wowhead.com/item=<xsl:value-of select="@id"/></xsl:attribute>
		</xsl:element>
		<id><xsl:value-of select="@id"/></id>
		<content type='text'><xsl:value-of select="@id"/> (<xsl:value-of select="itemLink"/>)</content>
		</entry>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match='player'>
		<xsl:if test='position() = 1'>
		<xsl:value-of select='@added'/> for <xsl:value-of select='@name'/>-<xsl:value-of select='@realm'/>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
