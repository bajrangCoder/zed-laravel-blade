[
  (conditional
    (directive_start) @start
    (directive_end) @end)
  (loop
    (directive_start) @start
    (directive_end) @end)
  (section
    (directive_start) @start
    (directive_end) @end)
  (stack
    (directive_start) @start
    (directive_end) @end)
  (once
    (directive_start) @start
    (directive_end) @end)
  (fragment
    (directive_start) @start
    (directive_end) @end)
  (envoy
    (directive_start) @start
    (directive_end) @end)
  (livewire
    (directive_start) @start
    (directive_end) @end)
  (switch
    (directive_start) @start
    (directive_end) @end)
  (verbatim
    (directive_start) @start
    (directive_end) @end)
  (php_statement
    (directive_start) @start
    (directive_end) @end)
] @indent

; HTML
(start_tag
  ">" @end) @indent

(self_closing_tag
  "/>" @end) @indent

(element
  (start_tag) @start
  (end_tag)? @end) @indent
