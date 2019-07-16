-module(p11).
-export([encode_modified/1]).

encode_modified([]) ->
	[];
encode_modified(List = [Head|_]) ->
	[Rest, Group] = group(Head, List),
	[Group] ++ encode_modified(Rest).

group({Count, Element}, [Element | Tail]) ->
	group({Count + 1, Element}, Tail);
group({1,Element}, Rest) ->
	[Rest, Element];
group(Result = {_,_}, Rest) ->
	[Rest, Result];
group(Element, [_|Tail]) ->
	group({1, Element}, Tail).
