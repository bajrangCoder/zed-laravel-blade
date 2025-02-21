((text) @content
    (#not-has-ancestor? @content "envoy")
    (#set! "combined")
    (#set! "language" "php"))

((parameter) @content
    ; (#set! "language" "php_only"))
    (#set! "language" "php"))

((php_only) @content
    ; (#set! "language" "php_only"))
    (#set! "language" "php"))
