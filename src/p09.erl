-module(p09).
-export([pack/1]).

pack([]) -> 
	[];
pack(List = [Head|_]) ->
	[Rest | Group] = group(Head, List),
	[Group | pack(Rest)].

group(Element, [Element | Tail]) ->
	[Element | group(Element, Tail)];
group(_, Rest) ->
	[Rest].
