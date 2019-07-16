-module(p08).
-export([compress/1]).

compress([Head, Head | Tail]) ->
	compress([Head|Tail]);
compress(Last = [_ | []]) ->
	Last;
compress([Head | Tail]) ->
	[Head|compress(Tail)].
