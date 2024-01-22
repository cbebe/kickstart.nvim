(local t [:goolord/alpha-nvim])
(λ config []
  (let [alpha (require :alpha)
        dashboard (require :alpha.themes.dashboard)
        fish ["                      *=#"
              "                      @@@.%"
              "                     =@@.+  %#*+#"
              "                    -@@@--:..@@@@.+"
              "                  +@@-%%##% #@@@.-*"
              "               #=@.=%      =@@-#"
              "             %=:=#       #:.+    %%%"
              "                      %%=@.==-::.@@@:+"
              "             *=++=--::-.@@=##%%  %.@@@."
              "             %@@@:*#   *@@+      %@@@-%"
              "              #@@:    %+@@...-%  -@@:"
              "               =@@#%=-::@@=#%   %@@@%"
              "                .@-    %@@%     :@@="
              "                =@@    #@@===-=:@@."
              "                 .@:-::::---=+=@@@#"
              "                  *#%          %*% %%"
              "       *:%      **%      #.:+#     #.@:+#"
              "       .@:      *@@.+     *@@@.#     +@@@@-#"
              "      *@@@%      #.@@*      +:@=       =@@@@*"
              "      @@@@%        ++                   %:@@:"
              "      :@@+                                *=#"
              "       *#"]]
    (set dashboard.section.header.val fish)
    (set dashboard.section.header.opts.position :center)
    (set dashboard.config.layout
         [{:type :padding :val 1}
          dashboard.section.header
          {:type :padding :val 1}])
    (alpha.setup dashboard.config)))

(set t.config config)

t
