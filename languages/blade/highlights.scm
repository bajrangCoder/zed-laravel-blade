(directive) @tag
(directive_start) @tag
(directive_end) @tag
[
 (bracket_start)
 (bracket_end)
] @punctuation.bracket
(comment) @comment
(attribute (directive) @attribute)
((bracket_start) @function (#set! "priority" 120))
((bracket_end) @function (#set! "priority" 120))
(keyword) @function
