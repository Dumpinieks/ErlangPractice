-module(p01).
-export([last/1]).


last([Last]) ->
	Last;
last([_|Tail]) ->
	last(Tail).	
