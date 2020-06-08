declare namespace request="http://exist-db.org/xquery/request";
let $file := request:get-parameter('file', '')
return <probando>$file</probando>
