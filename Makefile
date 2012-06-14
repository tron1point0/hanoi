BASE := hanoi
LANGS := haskell perl lisp
EXES := $(addprefix $(BASE)-,$(LANGS))
INSTALL := install
GHC := ghc

.PHONY: all clean
.SECONDARY: $(EXES)
all: $(LANGS)
clean:
	-rm $(EXES)

%-perl: %.pl
	$(INSTALL) -m 744 $< $@

%-lisp: %.lsp
	$(INSTALL) -m 744 $< $@

%-haskell: %.hs
	$(GHC) --make $< -o $@
	rm $*.hi $*.o

%: $(BASE)-%
	
