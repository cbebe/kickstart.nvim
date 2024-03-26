{1 :windwp/nvim-ts-autotag
 :ft [:html
      :javascript
      :typescript
      :javascriptreact
      :typescriptreact
      :svelte
      :vue
      :tsx
      :jsx
      :rescript
      :xml
      :php
      :markdown
      :astro
      :glimmer
      :handlebars
      :hbs]
 :config (λ []
           ((. (require :nvim-ts-autotag) :setup)))}
