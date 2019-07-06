-module(p14).
-export([duplicate/1]).

duplicate([Last]) ->
	[Last, Last];
duplicate([Head | Tail]) ->
	[Head, Head] ++ duplicate(Tail).
