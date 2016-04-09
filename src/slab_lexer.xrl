Definitions.

Name   = [A-Za-z][A-Za-z0-9_-]*
Word   = [^\t\s\n\.#"=]+
DQuote = "
Space  = \s
Dot    = \.
Equals = =
Hash   = #
NL     = \n
WS     = [\r\t]

Rules.

{Dot}    : {token, {'.',  TokenLine}}.
{DQuote} : {token, {'"',  TokenLine}}.
{Equals} : {token, {'=',  TokenLine}}.
{Hash}   : {token, {'#',  TokenLine}}.
{NL}     : {token, {nl,   TokenLine}}.
{Name}   : {token, {name, TokenLine, TokenChars}}.
{Word}   : {token, {word, TokenLine, TokenChars}}.
{Space}+ : {token, {s,    TokenLine, TokenChars, length(TokenChars)}}.
{WS}     : skip_token.

Erlang code.

% Nothing here...
