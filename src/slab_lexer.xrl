Definitions.

Indent = \n\s*
WS     = \s
Name   = [A-Za-z][A-Za-z0-9_-]*
Word   = \s[A-Za-z][A-Za-z0-9_-]*

Rules.

{Indent} : {token, {indent, TokenLine - 1, indent_value(TokenChars)}}.
\.{Name} : {token, {class,  TokenLine - 2, tl(TokenChars)}}.
#{Name}  : {token, {id,     TokenLine - 2, tl(TokenChars)}}.
{Name}   : {token, {tag,    TokenLine - 2, TokenChars}}.
{WS}+    : skip_token.


Erlang code.

indent_value(Chars) ->
  length(tl(Chars)).
