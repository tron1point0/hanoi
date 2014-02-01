INSTALL := install
GHC := ghc
COFFEE := coffee
CC := cc
PROLOG := swipl
JAVAC := javac
JAVA := java
JAR := jar
SED := sed

BASE := $(notdir $(PWD))
LANGS := $(subst .,,$(suffix $(wildcard $(BASE).*)))
EXES := $(addprefix $(BASE)-,$(LANGS))
TESTS := $(wildcard t/*)

SIMPLE := sh js lsp pl py rb

.PHONY: all clean test
.SECONDARY: $(EXES) $(addsuffix -test,$(LANGS)) $(BASE).jar
all: $(LANGS) test ;
clean: ; -rm $(EXES) $(BASE).jar Move.class
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

%-c: %.c
	$(CC) -o $@ $<

%-coffee: %.coffee
	echo '#!/usr/bin/env node' > $@
	$(COFFEE) -p $< >> $@
	chmod +x $@

%-hs: %.hs
	$(GHC) --make $< -o $@
	rm $*.hi $*.o

%-pro: %.pro
	$(PROLOG) -q -l $< -t "qsave_program('$@',[toplevel(main)])"

%-java: %.jar
	echo '#!/bin/bash' > $@ && echo '$(JAVA) -jar $<' >> $@
	chmod +x $@

classes = $(BASE).class Move.class
.INTERMEDIATE: $(classes) $(BASE).mf

$(classes): $(BASE).java
	$(JAVAC) $<

%.jar: $(classes) %.mf %.java
	$(JAR) cmf $*.mf $@ $(classes) $*.java

%.mf:
	echo 'Manifest-Version: 1.0' > $@
	echo 'Main-Class: $*' >> $@

# Tests that can be -j'd
$(foreach test,$(TESTS),$(eval $(call TEST_T,$(test))))
$(foreach lang,$(SIMPLE),$(eval $(call SIMPLE_T,$(lang))))
%: $(BASE)-% ;
