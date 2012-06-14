BASE := hanoi
LANGS := haskell perl lisp coffee python
EXES := $(addprefix $(BASE)-,$(LANGS))
SIMS := $(addsuffix -sim,$(LANGS))
TESTS := $(addsuffix -test,$(LANGS))
INSTALL := install
GHC := ghc
COFFEE := coffee

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

%-perl: %.pl
	$(INSTALL) -m 744 $< $@

%-lisp: %.lsp
	$(INSTALL) -m 744 $< $@

%-coffee: %.coffee
	echo '#!/usr/bin/env node' > $@
	$(COFFEE) -p $< >> $@
	chmod +x $@

%-haskell: %.hs
	$(GHC) --make $< -o $@
	rm $*.hi $*.o

%: $(BASE)-%
	
