-module(p05).
-export([reverse/1]).

reverse(Last = [_]) ->
	Last;
reverse([Head|Tail]) ->
	reverse(Tail) ++ [Head].
