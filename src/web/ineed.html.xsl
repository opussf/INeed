<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ex="http://exslt.org/dates-and-times"
	xmlns:math="http://exslt.org/math">

<xsl:output method="html"
doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />
	
<xsl:template match="/">
	<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
	<head>
	<link rel='stylesheet' href='css/bootstrap.css'/>
	<link rel='stylesheet' href='css/ineed.css'/>
	<script src='js/bootstrap.min.js'></script>
	<meta name='viewport' content='width=device-width, initial-scale=1'/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="refresh" content="300"/>
	<link href='rss' rel='alternate' type='application/rss+xml' title='Ineed RSS Feed'/>
	<link href='atom' rel='alternate' type='application/atom+xml' title='Ineed Atom Feed'/>
	<link rel='icon' type='image/png' href='favicon.png'/>
	<title>INeed Items</title>
	</head>

	<body>
	<div class='container-fluid'>
	<div class='row ineed-title'>
	<div class='col-sm-6 col-sm-offset-3'>
	<span>Needed items by my Characters from Wow.</span>
	</div>
	</div>
	<xsl:call-template name='stats'/>
	<div class='row ineed-main'>
	<xsl:apply-templates select='/ineed/item'>
		<xsl:sort data-type='number' order='ascending' select='@id'/>
	</xsl:apply-templates>
	</div>  <!-- main -->
	</div> <!-- container-fluid -->
	</body>
	</html>
</xsl:template>

<xsl:template name='stats'>
	<div class='row ineed-stats'>
	<div class='row ineed-item-count'>
	<div class='col-sm-6 col-sm-offset-1'>
	<xsl:value-of select="count(/ineed/item)"/> items. 
	(<xsl:value-of select='sum(/ineed/item/player/@has)'/> / <xsl:value-of select='sum(/ineed/item/player/@needs)'/>)
	</div>
	</div>
	<xsl:for-each select='/ineed/item'>
		<xsl:sort data-type='number' order='ascending' select='./player/@addedTS'/>
		<xsl:if test='position() = 1'>
		<xsl:call-template name='itemStats'>
			<xsl:with-param name='title'>Oldest added item</xsl:with-param>
			<xsl:with-param name='item' select='.'/>
			<xsl:with-param name='player' select='./player'/>
			<xsl:with-param name='date' select='./player/@added'/>
		</xsl:call-template>
		</xsl:if>
	</xsl:for-each>
	<xsl:for-each select='/ineed/item'>
		<xsl:sort data-type='number' order='ascending' select='./player/@updatedTS'/>
		<xsl:if test='position()=1'>
		<xsl:call-template name='itemStats'>
			<xsl:with-param name='title'>Oldest updated item</xsl:with-param>
			<xsl:with-param name='item' select='.'/>
			<xsl:with-param name='player' select='./player'/>
			<xsl:with-param name='date' select='./player/@updated'/>
		</xsl:call-template>
		</xsl:if>
	</xsl:for-each>
	<xsl:for-each select='/ineed/item'>
		<xsl:sort data-type='number' order='descending' select='./player/@addedTS'/>
		<xsl:if test='position()=1'>
		<xsl:call-template name='itemStats'>
			<xsl:with-param name='title'>Most recently added</xsl:with-param>
			<xsl:with-param name='item' select='.'/>
			<xsl:with-param name='player' select='./player'/>
			<xsl:with-param name='date' select='./player/@added'/>
		</xsl:call-template>
		</xsl:if>
	</xsl:for-each>
	<xsl:for-each select='/ineed/item'>
		<xsl:sort data-type='number' order='descending' select='./player/@updatedTS'/>
		<xsl:if test='position()=1'>
		<xsl:call-template name='itemStats'>
			<xsl:with-param name='title'>Most recently updated</xsl:with-param>
			<xsl:with-param name='item' select='.'/>
			<xsl:with-param name='player' select='./player'/>
			<xsl:with-param name='date' select='./player/@updated'/>
		</xsl:call-template>
		</xsl:if>
	</xsl:for-each>
	</div> <!-- row ineed-stats -->
</xsl:template>

<xsl:template match='item'>
	<div class='row ineed-itemRow'>
	<div class='col-xs-12'>
	<div class='row ineed-itemLinkRow'>
	<div class='col-xs-12 ineed-itemLink'>
	<xsl:element name='a'>
		<xsl:attribute name='name'><xsl:value-of select='@id'/></xsl:attribute>
		<xsl:attribute name='target'>_blank</xsl:attribute>
		<xsl:attribute name='href'>http://www.wowhead.com/item=<xsl:value-of select='@id'/></xsl:attribute>
		<xsl:value-of select='@id'/> (<xsl:value-of select='itemName'/>)
	</xsl:element>
	</div> <!-- col -->
	</div> <!-- row -->
<!-- player list -->
	<xsl:apply-templates select='./player'>
		<xsl:sort data-type='number' order='ascending' select='@addedTS'/>
		<!-- http://stackoverflow.com/questions/18197477/xslt-sum-based-on-attribute-values -->
	</xsl:apply-templates>
	<xsl:if test='count(./player) &gt; 1'>
	<div class='row ineed-itemSum'>
	<div class='col-xs-2 col-md-1 col-xs-offset-3 col-md-offset-4'>
	(<xsl:value-of select='sum(./player/@has)'/> / <xsl:value-of select='sum(./player/@needs)'/>)
	</div>
	</div>
	</xsl:if>

	</div> <!-- col -->
	</div> <!-- row -->
</xsl:template>

<xsl:template match='player'>
	<div class='row ineed-playerInfoRow'>
	<div class='col-xs-3 col-md-offset-1'>
	<xsl:value-of select='@name'/>-<xsl:value-of select='@realm'/>
	</div>

	<div class='col-xs-2 col-md-1'>
	(<xsl:value-of select='@has'/> / <xsl:value-of select='@needs'/>)
	</div>
	<div class='col-xs-6'>
	Added:&#160;<xsl:value-of select='@added'/>
	Updated:&#160;<xsl:value-of select='@updated'/>
	</div>
	
	</div> <!-- row -->
</xsl:template>

<xsl:template name='itemStats'>
	<xsl:param name='title'/>
	<xsl:param name='item'/>
	<xsl:param name='player'/>
	<xsl:param name='date'/>
	<div class='row ineed-item-stats'>
	<div class='col-xs-3 col-md-2 col-sm-offset-1'>
	<xsl:value-of select='$title'/>:
	</div>
	<div class='col-xs-2 col-sm-1'>
	<xsl:element name='a'>
		<xsl:attribute name='href'>#<xsl:value-of select='$item/@id'/></xsl:attribute>
		<xsl:value-of select='$item/@id'/>
	</xsl:element>
	</div>
	<div class='col-xs-4 col-sm-3 col-md-2'>(<xsl:value-of select='$date'/>)</div>
	<div class='col-xs-3'>
	<xsl:value-of select='$player/@name'/> - <xsl:value-of select='$player/@realm'/>
	</div>
	</div> <!-- row -->
</xsl:template>

</xsl:stylesheet>
