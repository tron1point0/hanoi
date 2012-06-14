# Hanoi

[Towers of Hanoi][wiki] solvers in various languages.

# Installation

Just run:

    $ make

It will put executables called `hanoi-$LANGUAGE` in the current directory,
where `$LANGUAGE` is the language that executable was written in. This will
also run tests.

If you want to make only a specific language, run:

    $ make $LANGUAGE

# Running

    $ ./hanoi-$LANGUAGE

# Testing

To test everything, run:

    $ make test

To test only a specific `$LANGUAGE`, run:

    $ make $LANGUAGE-test

[wiki]: http://en.wikipedia.org/wiki/Towers_of_hanoi (Towers of Hanoi)
