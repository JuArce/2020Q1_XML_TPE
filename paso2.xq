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


<osm_result xsi:noNamespaceSchemaLocation="intermediate.xsd">
{
    for $var in doc("paso1.xml")//node
    where some $category in $var//category/type satisfies (local:type_validation($category))
    return $var
}
</osm_result>
