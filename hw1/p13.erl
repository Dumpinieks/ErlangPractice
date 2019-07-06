-module(p13).
-export([decode/1]).

decode([]) ->
	[];
decode([{1, Element}|Tail]) ->
	[Element] ++ decode(Tail);
decode([{Count, Element}|Tail]) ->
	[Element] ++ decode([{Count - 1, Element}] ++ Tail).
