<?xml version="1.0"?>

<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" omit-xml-declaration="yes"/>

<xsl:template match="osm_result">
    <xsl:call-template name="printHeader"/>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="//node">
    <xsl:value-of select="translate(./name,',','.')"/>,<xsl:value-of select="./category/type"/>,<xsl:value-of select="./category/subtype"/>,<xsl:value-of select="./phone"/>,<xsl:value-of select="./website"/>,<xsl:value-of select="./email"/>,<xsl:value-of select="./location/city"/>-<xsl:value-of select="./location/postcode"/>-<xsl:value-of select="./location/street"/><xsl:text>&#xa;</xsl:text>
</xsl:template>

<xsl:template name="printHeader">Name, Category Type, Category Subtype, Phone, Website, Email, Geographic Location
</xsl:template>

<xsl:template match="result"/>

</xsl:transform>
