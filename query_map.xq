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
<osm_result>
{
    for $n in doc("data.xml")//node
    where some $k in $n/tag/@k  satisfies (local:type_validation($k))
    return (<node lat="{$n/@lat}" lon="{$n/@lon}">
            <name>
            {
                for $tag in $n/tag
                where $tag/@k = "name"
                return $tag/@v
            }>
            </name>
            </node>)
}
</osm_result>
