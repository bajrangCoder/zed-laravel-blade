((php_only) @injection.content
  (#set! injection.language "php_only"))

((parameter) @injection.content
    (#set! injection.include-children)
    (#set! injection.language "php_only"))

; Envoy @task/@story bodies → bash.
; Use a structural (envoy (text)) match, not (#has-ancestor? …) on a
; global (text) capture — that predicate does not filter in Zed
; injection queries, so every Blade text node was treated as bash.
; Group with @injection.host (not injection.combined): combined merges
; every bash match in the file into one layer, so an unclosed quote in
; one task breaks highlighting in later tasks. Host groups per envoy
; node, while still joining {{ }} / @if gaps inside a single block.
((envoy
  (text) @injection.content) @injection.host
  (#set! injection.language "bash"))

; Livewire attributes
; <div wire:click="baz++">
(attribute
  (attribute_name) @_attr
    (#any-of? @_attr "wire:model"
      "wire:click"
      "wire:stream"
      "wire:text"
      "wire:show")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))


; AlpineJS attributes
; <div x-data="{ foo: 'bar' }" x-init="baz()">
(attribute
  (attribute_name) @_attr
    (#match? @_attr "^x-[a-z]+")
    (#not-any-of? @_attr "x-teleport" "x-ref" "x-transition")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))
; <div :foo="bar" @click="baz()">
(attribute
  (attribute_name) @_attr
    (#match? @_attr "^[:@][a-z]+")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

; Blade escaped JS attributes
; <x-foo ::bar="baz" />
(element
  (_
    (tag_name) @_tag
      (#match? @_tag "^x-[a-z]+")
  (attribute
    (attribute_name) @_attr
      (#match? @_attr "^::[a-z]+")
    (quoted_attribute_value
      (attribute_value) @injection.content)
    (#set! injection.language "javascript"))))

; Blade PHP attributes
; <x-foo :bar="$baz" />
(element
  (_
    (tag_name) @_tag
      (#match? @_tag "^x-[a-z]+")
    (attribute
      (attribute_name) @_attr
        (#match? @_attr "^:[a-z]+")
      (quoted_attribute_value
        (attribute_value) @injection.content)
      (#set! injection.language "php_only"))))


; html
(script_element
  (raw_text) @injection.content
  (#set! injection.language "javascript"))

(style_element
  (raw_text) @injection.content
  (#set! injection.language "css"))

(attribute
    (attribute_name) @_attribute_name (#match? @_attribute_name "^style$")
    (quoted_attribute_value (attribute_value) @injection.content)
    (#set! injection.language "css"))
