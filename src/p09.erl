-module(p09).
-export([pack/1]).

pack([]) -> 
	[];
pack(List = [Head|_]) ->
	[Rest, Group] = group(Head, List),
	[Group | pack(Rest)].

group(Element, List) ->
	group(Element, List, []).

group(Element, [Element | Rest], Group) ->
	group(Element, Rest, [Element | Group]);
group(_, Rest, Group) ->
	[Rest, Group].


