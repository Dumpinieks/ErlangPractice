-module(bs03).
-export([split/2]).

split(Bin, Splitter) ->
    BinSplitter = list_to_binary(Splitter),
    lists:reverse(split(Bin, BinSplitter, [], removeSplitters)).


split(<<>>, _, Acc, _) ->
    Acc;
split(Bin = <<X/utf8, _/binary>>, Splitter = <<X/utf8, _/binary>>, Acc, removeSplitters) ->
    FoundSplitter = is_splitter(Bin, Splitter),
    if
        FoundSplitter ->
            NewBin = removeSplitter(Bin, Splitter),
            split(NewBin, Splitter, Acc, removeSplitters);
        true ->
            split(Bin, Splitter, Acc, splittersRemoved)
    end;
split(Bin, Splitter, Acc, _) ->
    [NewBin, Word] = cut_word(Bin, Splitter),
    split(NewBin, Splitter, [Word | Acc], removeSplitters). 

is_splitter(_, <<>>) ->
    true;
is_splitter(<<X/utf8, Rest/binary>>, <<X/utf8, RestSplitter/binary>>) ->
    is_splitter(Rest, RestSplitter);
is_splitter(_, _) ->
    false.

removeSplitter(Bin, <<>>) ->
    Bin;
removeSplitter(<<X/utf8, Rest/binary>>, <<X/utf8, RestSplitter/binary>>) ->
    removeSplitter(Rest, RestSplitter);
removeSplitter(<<>>, _) ->
    <<>>.

cut_word(Bin, Splitter) ->
    cut_word(Bin, Splitter, <<>>).

cut_word(<<>>, _, Acc) ->
    [<<>>, Acc];
cut_word(Bin = <<X/utf8, Rest/binary>>, Splitter = <<X/utf8, _/binary>>, Acc) ->
    FoundSplitter = is_splitter(Bin, Splitter),
    if
        FoundSplitter ->
            [Bin, Acc];
        true ->
            cut_word(Rest, Splitter, <<Acc/binary, X>>)
    end;
cut_word(<<X/utf8, Rest/binary>>, Splitter, Acc) ->
    cut_word(Rest, Splitter, <<Acc/binary, X>>).