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