-module(bs01).
-export([first_word/1]).

first_word(Bin) ->
    first_word(Bin, <<>>).

first_word(<<" ", Rest/binary>>, <<>>) ->
    first_word(Rest, <<>>);
    first_word(<<" ", _/binary>>, Acc) ->
    Acc;
first_word(<<X/utf8, Rest/binary>>, Acc) ->
    first_word(Rest, <<Acc/binary, X>>);
first_word(<<>>, Acc) ->
    Acc.