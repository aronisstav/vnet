REBAR3_URL=https://s3.amazonaws.com/rebar3/rebar3

ifeq ($(wildcard rebar3),rebar3)
REBAR3 = $(CURDIR)/rebar3
endif

REBAR3 ?= $(shell test -e `which rebar3` 2>/dev/null && which rebar3 || echo "./rebar3")

ifeq ($(REBAR3),)
REBAR3 = $(CURDIR)/rebar3
endif

.PHONY: all
all: compile test

.PHONY: compile
compile: | $(REBAR3)
	@$(REBAR3) compile

.PHONY: test
test: | $(REBAR3)
	@$(REBAR3) eunit

$(REBAR3):
	wget $(REBAR3_URL) || curl -Lo rebar3 $(REBAR3_URL)
	@chmod a+x rebar3
