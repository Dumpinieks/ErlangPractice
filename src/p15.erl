-module(p15).
-export([replicate/2]).

replicate([], _) ->
	[];
replicate([Head|Tail], Amount) ->
	copy(Head, Amount) ++ replicate(Tail, Amount).

copy(Element, 1) ->
	[Element];
copy(Element, Amount) ->
	[Element] ++ copy(Element, Amount - 1).
