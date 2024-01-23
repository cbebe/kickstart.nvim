(local t [:goolord/alpha-nvim])
(λ config []
  (let [alpha (require :alpha)
        dashboard (require :alpha.themes.dashboard)
        fish ["  ███████╗"
              "  ██╔════╝                                     *=#"
              "  █████╗                                       魚@.%"
              "  ██╔══╝                                      =魚.+  %#*+#"
              "  ██║                                        -魚@--:..魚魚.+"
              "  ╚═╝                                      +魚-%%##% #魚@.-*"
              "  ██╗   ██╗                             #=@.=%      =魚-#"
              "  ╚██╗ ██╔╝                            %=:=#       #:.+    %%%"
              "   ╚████╔╝                                      %%=@.==-::.魚@:+"
              "    ╚██╔╝                              *=++=--::-.魚=##%%  %.魚@."
              "     ██║                               %魚@:*#   *魚+      %魚@-%"
              "     ╚═╝                                #魚:    %+魚...-%  -魚:"
              "  ███████╗                               =魚#%=-::魚=#%   %魚@%"
              "  ██╔════╝                               .@-    %魚%     :魚="
              "  ███████╗                               =魚    #魚===-=:魚."
              "  ╚════██║                                .@:-::::---=+=魚@#"
              "  ███████║                                 *#%          %*% %%"
              "  ╚══════╝                      *:%      **%      #.:+#     #.@:+#"
              "  ██╗  ██╗                      .@:      *魚.+     *魚@.#     +魚魚-#"
              "  ██║  ██║                     *魚@%      #.魚*      +:@=       =魚魚*"
              "  ███████║                     魚魚%        ++                   %:魚:"
              "  ██╔══██║                     :魚+                                *=#"
              "  ██║  ██║                      *#"
              "  ╚═╝  ╚═╝"]]
    (set dashboard.section.header.val fish)
    (set dashboard.section.header.opts.position :left)
    (set dashboard.config.layout [dashboard.section.header])
    (alpha.setup dashboard.config)))

(set t.config config)

t