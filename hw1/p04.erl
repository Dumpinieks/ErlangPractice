-module(p04).
-export([len/1]).

len([_]) ->
	1;
len([_|Tail]) ->
	len(Tail) + 1.
