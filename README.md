[![Build Status](http://travis-ci.org/burbas/MicroC.png)](http://travis-ci.org/burbas/MicroC])

Please note that this project is unstable, eg the APIs and internal logic can be changed.

# Build
In order to build MicroC please use Rebar.

    ./rebar compile

# Usage

There is tree different APIs for the lexer, parser, syntax- and semantic analyze:

     > microc:lex(Filename). %% Returns a list with tokens
     > microc:parse(Filename). %% Returns a parse tree
     > microc:analyze(Filename). %% Returns an abstract syntax tree

