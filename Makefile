BASE := hanoi
LANGS := haskell perl lisp
EXES := $(addprefix $(BASE)-,$(LANGS))
SIMS := $(addsuffix -sim,$(LANGS))
TESTS := $(addsuffix -test,$(LANGS))
INSTALL := install
GHC := ghc

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

%-perl: %.pl
	$(INSTALL) -m 744 $< $@

%-lisp: %.lsp
	$(INSTALL) -m 744 $< $@

%-haskell: %.hs
	$(GHC) --make $< -o $@
	rm $*.hi $*.o

%: $(BASE)-%
	
