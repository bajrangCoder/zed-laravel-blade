; html
(tag_name) @tag
(doctype) @tag.doctype
(attribute_name) @attribute
[
  "\""
  "'"
  (attribute_value)
] @string
(comment) @comment

"=" @punctuation.delimiter.html

[
  "<"
  ">"
  "<!"
  "</"
  "/>"
] @punctuation.bracket.html

; blade
(directive) @function
(directive_start) @function
(directive_end) @function
(comment) @comment
(attribute (directive) @function)
(keyword) @function
[
  "{{"
  "}}"
  "{!!"
  "!!}"
  "("
  ")"
] @punctuation.bracket
