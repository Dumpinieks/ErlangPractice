-module(p07).
-export([flatten/1, findWord/1]).

flatten([[]|Tail]) ->
	flatten(Tail);
flatten([[Element|[]] | Tail]) ->
	flatten([Element | Tail]);
flatten([[Element|Rest] | Tail]) ->
	flatten([Element, Rest |Tail]);
flatten(Last = [_]) ->
	Last;
flatten([Head | Tail]) ->
	[Head|flatten(Tail)].



findWord(Bin) ->
	list_to_binary(findWord(Bin, spacesInBegin)).

findWord(<<" ", Rest/binary>>, spacesInBegin) ->
	findWord(Rest, spacesInBegin);
findWord(Bin, spacesInBegin) ->
	findWord(Bin, noMoreSpaces);
findWord(<<" ",_/binary>>, noMoreSpaces) ->
	[];
findWord(<<X, Rest/binary>>, noMoreSpaces) ->
	[X | findWord(Rest, noMoreSpaces)];
findWord(<<>>, noMoreSpaces) ->
	[].
