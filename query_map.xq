declare variable $west external;
declare variable $south external;
declare variable $east external;
declare variable $north external;

declare variable $west-empty := "The West parameter is empty.";
declare variable $south-empty := "The South parameter is empty.";
declare variable $east-empty := "The East parameter is empty.";
declare variable $north-empty := "The North parameter is empty.";

declare variable $west-invalid := "The West parameter is invalid.";
declare variable $south-invalid := "The South parameter is invalid.";
declare variable $east-invalid := "The East parameter is invalid.";
declare variable $north-invalid := "The North parameter is invalid.";

declare variable $west-not-a-number := "The West parameter is not a number.";
declare variable $south-not-a-number := "The South parameter is not a number.";
declare variable $east-not-a-number := "The East parameter is not a number.";
declare variable $north-not-a-number := "The North parameter is not a number.";

declare variable $north-south-invalid := "The North parameter must be greater than the South.";
declare variable $east-west-invalid := "The East parameter must be greater than the West.";

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

declare function local:is-a-number ( $value as xs:anyAtomicType? )  as xs:boolean
 {
  string(fn:number($value)) != 'NaN'
} ;

declare function local:name_validation($tag) as xs:boolean
{
    $tag/@k = "name" and string-length($tag/@v/string()) >= 1
};

declare function local:is_empty() as xs:boolean
{
    not($west) or not($east) or not($south) or not($north)
};
declare function local:is_invalid_long($param) as xs:boolean
{
    fn:number($param) > 180 or fn:number($param) < -180
};
declare function local:is_invalid_lat($param) as xs:boolean
{
    fn:number($param) > 90 or fn:number($param) < -90
};
declare function local:is_invalid_parameters() as xs:boolean
{
    local:is_invalid_long($east) or local:is_invalid_long($west) or local:is_invalid_lat($north) or local:is_invalid_lat($south) or
    not(local:is-a-number($east)) or not(local:is-a-number($west)) or not(local:is-a-number($north)) or not(local:is-a-number($south))
};

if(local:is_empty() or local:is_invalid_parameters() or (fn:number($east) < fn:number($west)) or (fn:number($north) < fn:number($south)))
then(
    <result>
        {if(not($west))
        then(<error>{$west-empty}</error>)
        else()}
        {if(not($east))
        then(<error>{$east-empty}</error>)
        else()}
        {if(not($south))
        then(<error>{$south-empty}</error>)
        else()}
        {if(not($north))
        then(<error>{$north-empty}</error>)
        else()}
        {if(not(local:is-a-number($west)))
        then(<error>{$west-not-a-number}</error>)
        else()}
        {if(not(local:is-a-number($east)))
        then(<error>{$east-not-a-number}</error>)
        else()}
        {if(not(local:is-a-number($south)))
        then(<error>{$south-not-a-number}</error>)
        else()}
        {if(not(local:is-a-number($north)))
        then(<error>{$north-not-a-number}</error>)
        else()}
        {if(local:is_invalid_long($west))
        then(<error>{$west-invalid}</error>)
        else()}
        {if(local:is_invalid_long($east))
        then(<error>{$east-invalid}</error>)
        else()}
        {if(local:is_invalid_lat($south))
        then(<error>{$south-invalid}</error>)
        else()}
        {if(local:is_invalid_lat($north))
        then(<error>{$north-invalid}</error>)
        else()}
        {if(fn:number($north) < fn:number($south))
        then(<error>{$north-south-invalid}</error>)
        else()}
        {if(fn:number($east) < fn:number($west))
        then(<error>{$east-west-invalid}</error>)
        else()}
    </result>
    )
else(
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
)
