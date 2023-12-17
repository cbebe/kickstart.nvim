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

.PHONY: clean all deep-clean update
clean:
	rm -rf $(LUA_OUT)

deep-clean:
	rm -rf after lua
	git restore lua

update:
	git pull
	$(MAKE) deep-clean
	$(MAKE) -j all
