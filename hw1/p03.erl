-module(p03).
-export([element_at/2]).

element_at([], _) ->
	undefined;
element_at([Result|_], 1) ->
	Result;
element_at([_|Tail], Index) ->
	element_at(Tail, Index - 1).
