# Crazy...
# Recursive wildcards in GNU make
# https://stackoverflow.com/a/18258352
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

FENNEL_SRC := $(call rwildcard,fnl,*.fnl)
LUA_OUT = $(patsubst fnl/%.fnl,%.lua,$(FENNEL_SRC))

all: $(LUA_OUT)

# This works
after/%.lua: fnl/after/%.fnl
	mkdir -p $(dir $@)
	fennel --compile $< > $@

# This also works
lua/%.lua: fnl/lua/%.fnl
	mkdir -p $(dir $@)
	fennel --compile $< > $@

# This doesn't
%.lua: fnl/%.fnl
	mkdir -p $(dir $@)
	fennel --compile $< > $@

.PHONY: clean
clean:
	rm -rf $(LUA_OUT)
