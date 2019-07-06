-module(p10).
-export([encode/1]).

encode([]) ->
	[];
encode(List = [Head | _]) -> 
	[Rest, Group] = group(Head, List),
	[Group] ++ encode(Rest).

group({Count, Element}, [Element | Tail]) ->
	group({Count + 1, Element}, Tail);
group(Result = {_, _}, Rest) ->
	[Rest, Result];
group(Element, [_|Tail]) ->
	group({1, Element}, List).
