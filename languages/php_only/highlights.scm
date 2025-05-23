; Keywords
[
  "and"
  "as"
  "instanceof"
  "or"
  "xor"
] @keyword.operator

[
  "fn"
  "function"
] @function

[
  "clone"
  "declare"
  "default"
  "echo"
  "enddeclare"
  "extends"
  "global"
  "goto"
  "implements"
  "insteadof"
  "print"
  "new"
  "unset"
] @keyword

[
  "enum"
  "class"
  "interface"
  "namespace"
  "trait"
] @type

[
  "abstract"
  "const"
  "final"
  "private"
  "protected"
  "public"
  "readonly"
  (static_modifier)
] @keyword.modifier

(function_static_declaration
  "static" @keyword.modifier)

[
  "return"
  "exit"
  "yield"
] @keyword.return

(yield_expression
  "from" @keyword.return)

[
  "case"
  "else"
  "elseif"
  "endif"
  "endswitch"
  "if"
  "switch"
  "match"
  "??"
] @keyword.conditional

[
  "break"
  "continue"
  "do"
  "endfor"
  "endforeach"
  "endwhile"
  "for"
  "foreach"
  "while"
] @keyword.repeat

[
  "catch"
  "finally"
  "throw"
  "try"
] @keyword.exception

[
  "include_once"
  "include"
  "require_once"
  "require"
  "use"
] @keyword.import

[
  ","
  ";"
  ":"
  "\\"
] @punctuation.delimiter

[
  (php_tag)
  "?>"
  "("
  ")"
  "["
  "]"
  "{"
  "}"
  "#["
] @punctuation.bracket

[
  "="
  "."
  "-"
  "*"
  "/"
  "+"
  "%"
  "**"
  "~"
  "|"
  "^"
  "&"
  "<<"
  ">>"
  "<<<"
  "->"
  "?->"
  "=>"
  "<"
  "<="
  ">="
  ">"
  "<>"
  "<=>"
  "=="
  "!="
  "==="
  "!=="
  "!"
  "&&"
  "||"
  ".="
  "-="
  "+="
  "*="
  "/="
  "%="
  "**="
  "&="
  "|="
  "^="
  "<<="
  ">>="
  "??="
  "--"
  "++"
  "@"
  "::"
] @operator

; Variables
(variable_name) @variable

; Constants
((name) @constant
  (#lua-match? @constant "^_?[A-Z][A-Z%d_]*$"))

((name) @constant.builtin
  (#lua-match? @constant.builtin "^__[A-Z][A-Z%d_]+__$"))

(const_declaration
  (const_element
    (name) @constant))

; Types
[
  (primitive_type)
  (cast_type)
  (bottom_type)
] @type.builtin

(named_type
  [
    (name) @type
    (qualified_name
      (name) @type)
    (relative_name
      (name) @type)
  ])

(named_type
  (name) @type.builtin
  (#any-of? @type.builtin "static" "self"))

(class_declaration
  name: (name) @type)

(base_clause
  [
    (name) @type
    (qualified_name
      (name) @type)
    (relative_name
      (name) @type)
  ])

(enum_declaration
  name: (name) @type)

(interface_declaration
  name: (name) @type)

(namespace_use_clause
  [
    (name) @type
    (qualified_name
      (name) @type)
    alias: (name) @type.definition
  ])

(namespace_use_clause
  type: "function"
  [
    (name) @function
    (qualified_name
      (name) @function)
    alias: (name) @function
  ])

(namespace_use_declaration
  type: "function"
  body: (namespace_use_group
    (namespace_use_clause
      [
        (name) @function
        (qualified_name
          (name) @function)
        alias: (name) @function
      ])))

(namespace_use_clause
  type: "const"
  [
    (name) @constant
    (qualified_name
      (name) @constant)
    alias: (name) @constant
  ])

(namespace_use_declaration
  type: "const"
  body: (namespace_use_group
    (namespace_use_clause
      [
        (name) @constant
        (qualified_name
          (name) @constant)
        alias: (name) @constant
      ])))

(class_interface_clause
  [
    (name) @type
    (qualified_name
      (name) @type)
    (relative_name
      (name) @type)
  ])

(scoped_call_expression
  scope: [
    (name) @type
    (qualified_name
      (name) @type)
    (relative_name
      (name) @type)
  ])

(class_constant_access_expression
  .
  [
    (name) @type
    (qualified_name
      (name) @type)
    (relative_name
      (name) @type)
  ]
  (name) @constant)

(scoped_property_access_expression
  scope: [
    (name) @type
    (qualified_name
      (name) @type)
    (relative_name
      (name) @type)
  ])

(scoped_property_access_expression
  name: (variable_name) @variable.member)

(trait_declaration
  name: (name) @type)

(use_declaration
  (name) @type)

(binary_expression
  operator: "instanceof"
  right: [
    (name) @type
    (qualified_name
      (name) @type)
    (relative_name
      (name) @type)
  ])

; Functions, methods, constructors
(array_creation_expression
  "array" @function.builtin)

(list_literal
  "list" @function.builtin)

(exit_statement
  "exit" @function.builtin
  "(")

(method_declaration
  name: (name) @function.method)

(function_call_expression
  function: [
    (name) @function.call
    (qualified_name
      (name) @function.call)
    (relative_name
      (name) @function.call)
  ])

(scoped_call_expression
  name: (name) @function.call)

(member_call_expression
  name: (name) @function.method.call)

(function_definition
  name: (name) @function)

(nullsafe_member_call_expression
  name: (name) @function.method)

(use_instead_of_clause
  (class_constant_access_expression
    (_)
    (name) @function.method)
  (name) @type)

(use_as_clause
  (class_constant_access_expression
    (_)
    (name) @function.method)*
  (name) @function.method)

(method_declaration
  name: (name) @constructor
  (#eq? @constructor "__construct"))

(object_creation_expression
  [
    (name) @constructor
    (qualified_name
      (name) @constructor)
    (relative_name
      (name) @constructor)
  ])

; Parameters
(variadic_parameter
  "..." @operator
  name: (variable_name) @variable.parameter)

(simple_parameter
  name: (variable_name) @variable.parameter)

(argument
  (name) @variable.parameter)

; Member
(property_element
  (variable_name) @property)

(member_access_expression
  name: (variable_name
    (name)) @variable.member)

(member_access_expression
  name: (name) @variable.member)

(nullsafe_member_access_expression
  name: (variable_name
    (name)) @variable.member)

(nullsafe_member_access_expression
  name: (name) @variable.member)

; Variables
(relative_scope) @variable.builtin

((variable_name) @variable.builtin
  (#eq? @variable.builtin "$this"))

; Namespace
(namespace_definition
  name: (namespace_name
    (name) @module))

(namespace_name
  (name) @module)

(relative_name
  "namespace" @module.builtin)

; Attributes
(attribute_list) @attribute

; Conditions ( ? : )
(conditional_expression
  "?" @keyword.conditional.ternary
  ":" @keyword.conditional.ternary)

; Directives
(declare_directive
  [
    "strict_types"
    "ticks"
    "encoding"
  ] @variable.parameter)

; Basic tokens
[
  (string)
  (encapsed_string)
  (heredoc_body)
  (nowdoc_body)
  (shell_command_expression) ; backtick operator: `ls -la`
] @string

(escape_sequence) @string.escape

[
  (heredoc_start)
  (heredoc_end)
] @label

(nowdoc
  "'" @label)

(boolean) @boolean

(null) @constant.builtin

(integer) @number

(float) @number.float

(comment) @comment @spell

(named_label_statement) @label
