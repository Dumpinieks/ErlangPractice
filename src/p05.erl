-module(p05).
-export([reverse/1]).

reverse([Head|Tail]) ->
	reverse([Head], Tail).

reverse(Reversed, []) ->
	Reversed;
reverse(Reversed, [Head | Rest]) ->
	NewReversed = [Head | Reversed],
	reverse(NewReversed, Rest).
	
