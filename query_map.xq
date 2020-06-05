declare function local:type_validation($type) as xs:boolean
{
    $type = "education" or
    $type = "amenity" or
    $type = "tourism" or
    $type = "health" or
    $type = "transport" or
    $type = "historic" or
    $type = "shops" or
    $type = "buildings"
};

declare function local:name_validation($tag) as xs:boolean
{
    $tag/@k = "name" and string-length($tag/@v/string()) >= 1
};

<osm_result>
{
    for $n in doc("data.xml")//node
    where some $k in $n/tag/@k  satisfies (local:type_validation($k))
    return (<node lat="{$n/@lat}" lon="{$n/@lon}">
            <node lat="{$n/@lat}" lon="{$n/@lon}">
                <name>{$n/tag/@v[../@k/string() = "name"]/string()}</name>
                <category>
                    <type>{$n/tag/@k[(local:type_validation(../@k/string()))]/string()}</type>
                    <subtype>{$n/tag/@v[(local:type_validation(../@k/string()))]/string()}</subtype>
                </category>
            </node>
}
</osm_result>
(: Otra forma medio falopa :)
<osm_result>
{
    for $var in
    {
        for $n in doc("data.xml")//node
        where every $v in $n/tag/@v[../@k/string()="name"] satisfies string-length($v/@v/string()) >= 1
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
    where $category in $var/category satisfies (local:type_validation($category))
    return $var
}
</osm_result>
