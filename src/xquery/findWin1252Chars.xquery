declare variable $collectionDir as xs:string external;

<result>{
(: XQuery to see if the document has any characters in the range &#128; and &#x159;.

   These are valid Unicode characters but are non printing. The character codes are
   real characters from the Windows 1252 code page that have different Unicode
   equivalents.
   
   This query takes one parameter, collectionDir, which is the directory to look into.
   
   In Oxygen you can set this up by selecting a file in the directory you want to search
   in (and under) and then set the collectionDir parameter to the Oxygen variable "${cfdu}"
   (current file directory URI). The query will look at each DITA file and report any
   that have bad characters, returning the text node with the bad character. The
   bad character will likely be shown as a numeric character reference (e.g., &#x97).
   
   See http://en.wikipedia.org/wiki/Windows-1252 for a list of the Windows 1252 characters
   and their Unicode equivalents.
   
   :)

let $collectionUri := iri-to-uri(concat($collectionDir,
                        '?recurse=yes;select=*.(dita|xml|ditamap);on-error=ignore'))
(: return $collectionUri :)
let $docs := collection($collectionUri)
for $doc in $docs
    return for $t in $doc//text()
           return if (matches($t, '[&#x0080;-&#x009F;]')) then <doc uri="{document-uri(root($t))}">{$t}</doc> else ''

}</result>