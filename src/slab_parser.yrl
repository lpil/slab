Nonterminals class id labels element elements.
Terminals '.' '#' nl name word spaces.
Rootsymbol elements.

elements -> element             : ['$1'].
elements -> element nl elements : ['$1'|'$3'].

element -> name : elem(#{
             type => value('$1')
            }).
element -> labels : elem(#{
             labels => '$1'
            }).

labels -> class :
          [{class, '$1'}].
labels -> id :
          [{id, '$1'}].
labels -> id labels :
          [{id, '$1'}|'$2'].
labels -> class labels :
          [{class, '$1'}|'$2'].

class -> '.' name : value('$2').
id    -> '#' name : value('$2').

% predicates -> predicate : '$1'.
% predicates -> predicate union predicate : {union, '$1', '$3'}.
% predicates -> predicates union predicate : {union, '$1', '$3'}.

% predicates -> predicate intersection predicate : \
%               {intersection, '$1', '$3'}.

% predicate -> var set list : \
%             {predicate, {var, unwrap('$1')}, memberof, '$3'}.

% predicate -> var comparator element : \
%             {predicate, {var, unwrap('$1')}, unwrap('$2'), '$3'}.

% list -> '(' ')' : nil.
% list -> '(' elements ')' : {list,'$2'}.

% elements -> element : ['$1'].
% elements -> element ',' elements : ['$1'] ++ '$3'.
% element -> atom : '$1'.
% element -> var : unwrap('$1').
% element -> integer : unwrap('$1').
% element -> string : unwrap('$1').


Erlang code.

value({_, _, V}) -> V.

split_labels(labels) ->
    'Elixir.Enum':group_by(fun({Type, _}) -> Type end).

elem(Map) ->
    'Elixir.Kernel':struct('Elixir.Slab.Element', Map).
