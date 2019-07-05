-module(p09).
-export([pack/1]).

pack([]) -> 
	[];
pack(List = [Head|_]) ->
	[Rest | Group] = group(Head, List),
	[Group] ++ pack(Rest).

group(Element, [Element | Tail]) ->
	group(Element, Tail) ++ [Element];
group(_, Rest) ->
	[Rest].
