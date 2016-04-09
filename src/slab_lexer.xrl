Definitions.

Indent = \n\s*
Prefix = [\.#]
Name   = [A-Za-z][A-Za-z0-9_-]*
Word   = [^\n\t\s\.#]+
Space  = \s
WS     = [\n\t]

Rules.

{Prefix} : {token, {prefix, TokenLine - 1, TokenChars}}.
{Name}   : {token, {name,   TokenLine - 1, TokenChars}}.
{Word}   : {token, {word,   TokenLine - 1, TokenChars}}.
{Space}+ : {token, {spaces, TokenLine - 1, length(TokenChars)}}.
{WS}     : skip_token.


Erlang code.

% Nothing here...
