-module(p02).
-export([but_last/1]).

but_last(Result = [_, _]) ->
	Result;
but_last([_|Tail]) ->
	but_last(Tail).
