Definitions.

Indent = \n\s*
WS     = \s
Name   = [A-Za-z][A-Za-z0-9_-]*
A      = [^\s]

Rules.

{Indent} : {token, {indent, TokenLine - 1, indent_value(TokenChars)}}.
\.{Name} : {token, {class,  TokenLine - 2, tl(TokenChars)}}.
#{Name}  : {token, {id,     TokenLine - 2, tl(TokenChars)}}.
{Name}   : {token, {tag,    TokenLine - 2, TokenChars}}.

% This rule is too greedy...
% {A}+     : {token, {text,   TokenLine - 2, TokenChars}}.

{WS}+    : skip_token.


Erlang code.

indent_value(Chars) ->
  length(tl(Chars)).
