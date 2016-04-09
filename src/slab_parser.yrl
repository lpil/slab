Nonterminals
grammar class id labels tag intented_tag element text textbit base_node.
Terminals '.' '#' nl name word s.
Rootsymbol grammar.

grammar -> base_node          : ['$1'].
grammar -> base_node grammar  : ['$1'|'$2'].

base_node -> nl      : nl.
base_node -> element : '$1'.

element -> intented_tag :
           {I, {T, L}} = '$1',
           elem(#{ type   => T,
                   labels => L,
                   indent => I
                 }).
element -> intented_tag s text :
           {I, {T, L}} = '$1',
           elem(#{ type   => T,
                   labels => L,
                   indent => I,
                   text   => with_spaces('$2','$3')
                 }).

%                       {indent_size, tag_tuple}
intented_tag ->   tag : {0,                 '$1'}.
intented_tag -> s tag : {indent_size('$1'), '$2'}.

tag -> name        : {value('$1'), ""}.
tag -> labels      : {"div",       '$1'}.
tag -> name labels : {value('$1'), '$2'}.

text -> textbit      : lists:flatten('$1').
text -> textbit text : lists:flatten(['$1'|'$2']).

textbit -> '.'         : ["."].
textbit -> '#'         : ["#"].
textbit -> s           : [value('$1')].
textbit -> name        : [value('$1')].
textbit -> word        : [value('$1')].

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

with_spaces({s, _, _, Size}, T) when Size < 2 ->
    T;
with_spaces({s, _, S, _}, T) ->
    tl(S) ++ T.

elem(Map) ->
    'Elixir.Kernel':struct('Elixir.Slab.ParserElement', Map).
