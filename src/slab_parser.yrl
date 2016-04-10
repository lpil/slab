Nonterminals
grammar base_symbol element
labels class id
tag in_tag in_tag_a in_tag_txt in_tag_a_txt
s_text text text_bit
ss
attributes attribute string string_body string_bit.
Terminals '"' '=' '.' '#' nl name word s.
Rootsymbol grammar.

grammar -> base_symbol          : ['$1'].
grammar -> base_symbol grammar  : ['$1'|'$2'].

base_symbol -> nl      : nl.
base_symbol -> element : '$1'.

element -> in_tag_a_txt :
           {I, T, L, A, Txt} = '$1',
           elem(#{ type   => T,
                   labels => L,
                   indent => I,
                   text   => Txt,
                   attributes => A
                 }).
element -> in_tag_a :
           {{I, {T, L}}, A} = '$1',
           elem(#{ type   => T,
                   labels => L,
                   indent => I,
                   attributes => A
                 }).
element -> in_tag :
           {I, {T, L}} = '$1',
           elem(#{ type   => T,
                   labels => L,
                   indent => I
                 }).
element -> in_tag_txt :
           {I, T, L, Txt} = '$1',
           elem(#{ type   => T,
                   labels => L,
                   indent => I,
                   text   => Txt
                 }).

in_tag_a_txt -> in_tag_a s_text:
                {{I, {T, L}}, A} = '$1',
                {I, T, L, A, '$2'}.

in_tag_txt -> in_tag s_text:
                {I, {T, L}} = '$1',
                {I, T, L, '$2'}.

in_tag_a -> in_tag attributes : {'$1', '$2'}.

attributes -> s attribute          : ['$2'].
attributes -> attribute attributes : ['$1'|'$2'].

ss -> s : '$1'.

attribute -> name '=' string :
             {value('$1'), '$3'}.

string -> '"' string_body '"' : '$2'.
string -> '"' '"'             : "".

string_body -> string_bit             : '$1'.
string_body -> string_bit string_body : '$1' ++ '$2'.

string_bit -> '='  : "=".
string_bit -> '#'  : "#".
string_bit -> s    : value('$1').
string_bit -> word : value('$1').
string_bit -> name : value('$1').

in_tag ->   tag : {0,                 '$1'}.
in_tag -> s tag : {indent_size('$1'), '$2'}.

tag -> name        : {value('$1'), ""}.
tag -> labels      : {"div",       '$1'}.
tag -> name labels : {value('$1'), '$2'}.

s_text ->   text : '$1'.
s_text -> s text : text_spaces('$1','$2').

text -> text_bit      : '$1'.
text -> text_bit text : '$1' ++ '$2'.

text_bit -> '.'         : ".".
text_bit -> '='         : "=".
text_bit -> '"'         : [$"].
text_bit -> '#'         : "#".
text_bit -> s           : value('$1').
text_bit -> word        : value('$1').
text_bit -> name        : value('$1').

labels -> id           : [{id,    '$1'}].
labels -> id labels    : [{id,    '$1'}|'$2'].
labels -> class        : [{class, '$1'}].
labels -> class labels : [{class, '$1'}|'$2'].

class -> '.' name : value('$2').
id    -> '#' name : value('$2').


Erlang code.

value({_, _, V})    -> V;
value({_, _, V, _}) -> V.

indent_size({_, _, _, V}) -> V.

text_spaces({s, _, _, Size}, T) when Size < 2 ->
    T;
text_spaces({s, _, S, _}, T) ->
    tl(S) ++ T.

elem(Map) ->
    'Elixir.Kernel':struct('Elixir.Slab.ParserElement', Map).
