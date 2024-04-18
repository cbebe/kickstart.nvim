# Crazy...
# Recursive wildcards in GNU make
# https://stackoverflow.com/a/18258352
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))
FENNEL_SRC:=$(call rwildcard,fnl,*.fnl)
FMT_SRC:=$(call rwildcard,diff-fmt,*.go)
LUA_OUT=$(patsubst fnl/%.fnl,%.lua,$(FENNEL_SRC))

FNLFMT_GIT_DIR := git-fnlfmt
RM:=rm -rf

.PHONY: all
all: $(LUA_OUT)

after/%.lua: fnl/after/%.fnl
	fennel --compile $< > $@

lua/%.lua: fnl/lua/%.fnl
	fennel --compile $< > $@

# [[[ Formatting Stuff
ifeq ($(OS), Windows_NT)
DIFF_FMT:=diff-fmt/diff-fnlfmt.exe
fnlfmt: $(FNLFMT_GIT_DIR)
else
FNL_FMT:=$(shell command -v fnlfmt 2> /dev/null)
DIFF_FMT:=diff-fmt/diff-fnlfmt
endif


.PHONY: fmt
fmt: $(patsubst %,fmt-%,$(FENNEL_SRC))

fmt-fnl/%.fnl: fnl/%.fnl $(DIFF_FMT)
ifneq ($(OS), Windows_NT)
ifndef FNL_FMT
	$(error "fnlfmt is not available. please run `make install-fnlfmt`.")
endif
endif
	./$(DIFF_FMT) $<

$(DIFF_FMT): $(FMT_SRC)
	cd diff-fmt && go build

.PHONY: queries
queries: after/queries/fysh/highlights.scm after/queries/fysh/injections.scm

REPO := Fysh-Fyve/tree-sitter-fysh
after/queries/fysh/%.scm:
	wget -O $@ https://raw.githubusercontent.com/$(REPO)/master/queries/$(notdir $(basename $@).scm)

$(FNLFMT_GIT_DIR):
	git clone https://git.sr.ht/~technomancy/fnlfmt $@

.PHONY: install-fnlfmt
install-fnlfmt: $(FNLFMT_GIT_DIR)
	@echo "Run \"cd" $(FNLFMT_GIT_DIR) "&& sudo make install\""
# ]]]

# [[[ Cleaning
.PHONY: clean
clean:
	$(RM) $(LUA_OUT) $(FNLFMT_GIT_DIR) $(DIFF_FMT) && true

.PHONY: deep-clean
deep-clean:
	$(RM) after lua $(FNLFMT_GIT_DIR) $(DIFF_FMT) && true
	git restore lua
	git restore after/queries
# ]]]

# vim:foldmethod=marker foldmarker=[[[,]]]
