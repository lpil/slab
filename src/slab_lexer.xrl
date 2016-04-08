Definitions.

Indent = \n\s*
WS     = \s
A      = [^{WS}]

Rules.

{Indent} : {token, {indent, indent_value(TokenChars)}}.
{A}+     : {token, {word, TokenChars}}.
{WS}+    : skip_token.


Erlang code.

indent_value(Chars) ->
  length(tl(Chars)).
