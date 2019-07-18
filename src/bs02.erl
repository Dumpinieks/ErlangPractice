-module(bs02).
-export([words/1]).

words(Bin) ->
    lists:reverse(words(Bin, [])).


words(<<" ", Rest/binary>>, Acc) ->
    words(Rest, Acc);
words(<<>>, Acc) ->
    Acc;
words(Bin, Acc) ->
    [Rest, Word] = find_word(Bin),
    words(Rest, [Word| Acc]).

find_word(Bin) ->
    find_word(Bin, <<>>).

find_word(<<>>, Acc) ->
    [<<>>, Acc];
find_word(<<" ", Rest/binary>>, Acc) ->
    [Rest, Acc];
find_word(<<X/utf8, Rest/binary>>, Acc) ->
    find_word(Rest, <<Acc/binary, X>>).