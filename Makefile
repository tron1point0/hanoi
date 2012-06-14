BASE := hanoi
LANGS := haskell perl lisp coffee python c js ruby
EXES := $(addprefix $(BASE)-,$(LANGS))
SIMS := $(addsuffix -sim,$(LANGS))
TESTS := $(addsuffix -test,$(LANGS))
INSTALL := install
GHC := ghc
COFFEE := coffee
CC := cc

.PHONY: all clean test $(SIMS)
.SECONDARY: $(EXES)
all: $(LANGS) test
clean:
	-rm $(EXES)
test: $(TESTS)

%-test: $(BASE)-% t/simulate.pl t/check.pl
	$(info Testing $<)
	@./$< | t/simulate.pl | t/check.pl

%-sim: $(BASE)-% t/simulate.pl
	$(info Simulating $<)
	@./$< | t/simulate.pl

%-python: %.py
	$(INSTALL) -m 744 $< $@

%-ruby: %.rb
	$(INSTALL) -m 744 $< $@

%-perl: %.pl
	$(INSTALL) -m 744 $< $@

%-lisp: %.lsp
	$(INSTALL) -m 744 $< $@

%-js: %.js
	$(INSTALL) -m 744 $< $@

%-coffee: %.coffee
	echo '#!/usr/bin/env node' > $@
	$(COFFEE) -p $< >> $@
	chmod +x $@

%-c: %.c
	$(CC) -o $@ $<

%-haskell: %.hs
	$(GHC) --make $< -o $@
	rm $*.hi $*.o

%: $(BASE)-%
	
