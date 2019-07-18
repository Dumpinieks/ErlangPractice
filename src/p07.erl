-module(p07).
-export([flatten/1]).

flatten([[]|Tail]) ->
	flatten(Tail);
flatten([[Element|[]] | Tail]) ->
	flatten([Element | Tail]);
flatten([[Element|Rest] | Tail]) ->
	flatten([Element, Rest |Tail]);
flatten(Last = [_]) ->
	Last;
flatten([Head | Tail]) ->
	[Head|flatten(Tail)].


