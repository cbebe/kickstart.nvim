# Crazy...
# Recursive wildcards in GNU make
# https://stackoverflow.com/a/18258352
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))
FENNEL_SRC := $(call rwildcard,fnl,*.fnl)
LUA_OUT = $(patsubst fnl/%.fnl,%.lua,$(FENNEL_SRC))

FNLFMT_GIT_DIR := git-fnlfmt
RM := rm -rf
MKDIR := mkdir -p

all: $(LUA_OUT)

after/%.lua: fnl/after/%.fnl | after/ftplugin after/plugin
	fennel --compile $< > $@

lua/%.lua: fnl/lua/%.fnl
	fennel --compile $< > $@

after/ftplugin:
	$(MKDIR) $@

after/plugin:
	$(MKDIR) $@

# [[[ Formatting Stuff
FNL_FMT:=$(shell command -v fnlfmt 2> /dev/null)
DIFF_FMT := diff-fnlfmt

fmt: $(patsubst %,fmt-%,$(FENNEL_SRC))

fmt-fnl/%.fnl: fnl/%.fnl $(DIFF_FMT)
ifndef FNL_FMT
	$(error "fnlfmt is not available. please run `make install-fnlfmt`.")
endif
	./$(DIFF_FMT) $<

$(DIFF_FMT): diff-fmt/main.go
	go build -o $@ $<

.PHONY: queries
queries: after/queries/fysh/highlights.scm after/queries/fysh/injections.scm

REPO := Fysh-Fyve/tree-sitter-fysh
after/queries/fysh/%.scm:
	wget -O $@ https://raw.githubusercontent.com/$(REPO)/master/queries/$(notdir $(basename $@).scm)

install-fnlfmt:
	git clone https://git.sr.ht/~technomancy/fnlfmt $(FNLFMT_GIT_DIR)
	@echo "Run \"cd" $(FNLFMT_GIT_DIR) "&& sudo make install\""
# ]]]

# [[[ Cleaning
.PHONY: clean all deep-clean update fmt install-fnlfmt
clean:
	$(RM) $(LUA_OUT) $(FNLFMT_GIT_DIR) $(DIFF_FMT)

deep-clean:
	$(RM) after lua $(FNLFMT_GIT_DIR) $(DIFF_FMT)
	git restore lua
	git restore after/queries
# ]]]

# vim:foldmethod=marker foldmarker=[[[,]]]
