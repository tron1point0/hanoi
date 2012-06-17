SIMPLE := sh js lsp pl py rb

%-c: %.c
	$(CC) -o $@ $<

%-coffee: %.coffee
	echo '#!/usr/bin/env node' > $@
	$(COFFEE) -p $< >> $@
	chmod +x $@

%-hs: %.hs
	$(GHC) --make $< -o $@
	rm $*.hi $*.o

# End recipes

INSTALL := install
GHC := ghc
COFFEE := coffee
CC := cc

BASE := $(notdir $(PWD))
LANGS := $(subst .,,$(suffix $(wildcard $(BASE).*)))
EXES := $(addprefix $(BASE)-,$(LANGS))
TESTS := $(wildcard t/*)

.PHONY: all clean test
.SECONDARY: $(EXES) $(addsuffix -test,$(LANGS))
all: $(LANGS) test ;
clean: ; -rm $(EXES)
test: $(addsuffix -test,$(LANGS)) ;
%-test: $(BASE)-% $(addprefix %-,$(TESTS)) ;

define TEST_T
.SECONDARY: $(addsuffix -$(1),$(LANGS))
%-$(1): $(BASE)-% $(1)
	$$(info Running $(1) on $(BASE)-$$*)
	@./$$< | $(1)
endef

define SIMPLE_T
%-$(1): %.$(1)
	$$(INSTALL) -m 744 $$< $$@
endef

# Tests that can be -j'd
$(foreach test,$(TESTS),$(eval $(call TEST_T,$(test))))
$(foreach lang,$(SIMPLE),$(eval $(call SIMPLE_T,$(lang))))
%: $(BASE)-% ;
