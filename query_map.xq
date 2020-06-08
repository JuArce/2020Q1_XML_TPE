
declare variable $west external;
declare variable $south external;
declare variable $east external;
declare variable $north external;

declare function local:type_validation($type) as xs:boolean
{
    $type = "education" or
    $type = "amenity" or
    $type = "tourism" or
    $type = "health" or
    $type = "transport" or
    $type = "historic" or
    $type = "shop" or
    $type = "buildings"
};

declare function local:name_validation($tag) as xs:boolean
{
    $tag/@k = "name" and string-length($tag/@v/string()) >= 1
};

<osm_result xsi:noNamespaceSchemaLocation="intermediate.xsd">
{
    for $var in
    <nodes>
    {
        for $n in doc("data.xml")//node
        where some $v in $n/tag satisfies local:name_validation($v)
        return <node lat="{$n/@lat}" lon="{$n/@lon}">
                    <name>{$n/tag/@v[../@k/string() = "name"]/string()}</name>
                    <category>
                        <type>{$n/tag/@k[(local:type_validation(../@k/string()))]/string()}</type>
                        <subtype>{$n/tag/@v[(local:type_validation(../@k/string()))]/string()}</subtype>
                    </category>
                    <location>
                        <city>{$n/tag/@v[../@k/string() = "addr:city"]/string()}</city>
                        <postcode>{$n/tag/@v[../@k/string() = "addr:postcode"]/string()}</postcode>
                        <street>{$n/tag/@v[../@k/string() = "addr:street"]/string()}</street>
                    </location>
                    <phone>{$n/tag/@v[../@k/string() = "phone"]/string()}</phone>
                    <website>{$n/tag/@v[../@k/string() = "website"]/string()}</website>
                    <email>{$n/tag/@v[../@k/string() = "email"]/string()}</email>
                </node>
    }
    </nodes>/node
    where some $category in $var//category/type satisfies (local:type_validation($category))
    return $var
}
</osm_result>
