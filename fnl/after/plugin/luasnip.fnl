(let [ls (require :luasnip)
      as (. ls :add_snippets)
      ps (. (. ls :parser) :parse_snippet)]
  (as :fysh [(ps :sub ">($1) $2\n><>\n\t$0\n<><")
             (ps :loop "><(((@> [$1]\n><>\n\t$0\n<><")
             (ps :cc "[$1] ~$0")
             (ps :id "><$1> $0")]))
