((text) @content
    (#not-has-ancestor? @content "envoy")
    (#set! "language" "php")
    (#set! "combined"))
