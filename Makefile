# Crazy...
# Recursive wildcards in GNU make
# https://stackoverflow.com/a/18258352
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

FENNEL_SRC := $(call rwildcard,fnl,*.fnl)
LUA_OUT = $(patsubst fnl/%.fnl,%.lua,$(FENNEL_SRC))

all: $(LUA_OUT)

after/%.lua: fnl/after/%.fnl | after/ftplugin
	fennel --compile $< > $@

lua/%.lua: fnl/lua/%.fnl
	fennel --compile $< > $@

after/ftplugin:
	mkdir -p $@

.PHONY: clean all deep-clean update fmt install-fnlfmt
clean:
	rm -rf $(LUA_OUT)

deep-clean:
	rm -rf after lua
	git restore lua

FNL_FMT:=$(shell command -v fnlfmt 2> /dev/null)

fmt: $(patsubst %,fmt-%,$(FENNEL_SRC))

fmt-fnl/%.fnl: fnl/%.fnl go-fnlfmt
ifndef FNL_FMT
	$(error "fnlfmt is not available. pleas run `make install-fnlfmt`.")
endif
	./go-fnlfmt $<

go-fnlfmt: diff-fmt/main.go
	go build -o $@ $<

install-fnlfmt:
	git clone https://git.sr.ht/~technomancy/fnlfmt fnlfmt
	@echo 'Run `cd fnlfmt && sudo make install`'
update:
	git pull
	$(MAKE) deep-clean
	$(MAKE) -j all
