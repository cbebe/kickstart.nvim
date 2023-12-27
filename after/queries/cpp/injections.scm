; extends
(((comment)
  @_c (#contains? @_c"[[[cog") (#contains? @_c "]]]"))
 @injection.content (#set! injection.language "python"))
