-module(p07).
-export([flatten/1]).

flatten([Head = [_|_] | Tail]) ->
	flatten(Head ++ Tail);
flatten(Last = [_]) ->
	Last;
flatten([Head | Tail]) ->
	[Head] ++ flatten(Tail).
