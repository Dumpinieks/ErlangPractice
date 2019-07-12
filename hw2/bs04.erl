-module(bs04).
-export([decode/2, decode/3, decode/4, format/2]).

decode(Bin = <<"[", _/binary>>, proplist) ->
    [<<>>, Result] = decode(Bin, list),
    Result;
decode(Bin = <<"{", _/binary>>, proplist) ->
    [_, Result] = decode(Bin, [], proplist, object),
    Result;

decode(Bin, string) ->
    decode(Bin, <<>>, string);

decode(Bin, numberOrBool) ->
    {Number, Rest} = string:to_integer(Bin),
    if
        Number =:= error ->
            decode(Bin, bool);
        true ->
            [Rest, Number]
    end;

decode(<<"false", Rest/binary>>, bool) ->
    [Rest, false];
decode(<<"true", Rest/binary>>, bool) ->
    [Rest, true];


decode(<<"[", Rest/binary>>, list) ->
    [NewRest, List] = decode(Rest, [], list),
    [NewRest, lists:reverse(List)].

decode(Bin, proplist, properties) ->
    decode(Bin, [], proplist, properties);

decode(Bin = <<"'", _/binary>>, proplist, property) ->
    [NewBin, PropertyLeft] = decode(Bin, proplist, propertyLeft),
    [NewBin2, PropertyRight] = decode(NewBin, proplist, propertyRight),
    [NewBin2, {PropertyLeft, PropertyRight}];

decode(<<"'", Rest/binary>>, proplist, propertyLeft) ->
    decode(Rest, string);

decode(<<":", Rest/binary>>, proplist, propertyRight) ->
    decode(Rest, proplist, propertyRight);
decode(<<"'", Rest/binary>>, proplist, propertyRight) ->
    decode(Rest, string);
decode(Bin = <<"[", _/binary>>, proplist, propertyRight) ->
    decode(Bin, list);
decode(Bin = <<"{", _/binary>>, proplist, propertyRight) ->
    decode(Bin, object);
decode(Bin, proplist, propertyRight) ->
    decode(Bin, numberOrBool);
        
decode(<<"'", Rest/binary>>, Acc, string) ->
    [Rest, Acc];
decode(<<X/utf8, Rest/binary>>, Acc, string) ->
    decode(Rest, <<Acc/binary, X>>, string);

decode(<<",", Rest/binary>>, Acc, list) ->
    decode(Rest, Acc, list);
decode(<<"'", Rest/binary>>, Acc, list) ->
    [NewBin, String] = decode(Rest, string),
    decode(NewBin, [String|Acc], list);
decode(Bin = <<"{", _/binary>>, Acc, list) ->
    [NewBin, Object] = decode(Bin, [], proplist, object),
    decode(NewBin, [Object|Acc], list);
decode(Bin = <<"[", _/binary>>, Acc, list) ->
    [NewBin, List] = decode(Bin, [], list),
    decode(NewBin, [List | Acc], list);
decode(<<"]", Rest/binary>>, Acc, list) ->
    [Rest, Acc];
decode(Bin, Acc, list) ->
    [NewBin, NumberOrBool] = decode(Bin, numberOrBool),
    decode(NewBin, [NumberOrBool|Acc], list).

decode(<<"{", Rest/binary>>, [], proplist, object) ->
    [NewRest, Properties] = decode(Rest, proplist, properties),
    decode(NewRest, lists:reverse(Properties), proplist, object);
decode(<<"}", Rest/binary>>, Object, proplist, object) ->
    [Rest, Object];

decode(Bin = <<"'", _/binary>>, Properties, proplist, properties) ->
    [NewBin, Property] = decode(Bin, proplist, property),
    decode(NewBin, [Property | Properties], proplist, properties);
decode(<<",", Rest/binary>>, Properties, proplist, properties) ->
    [NewRest, Property] = decode(Rest, proplist, property),
    decode(NewRest, [Property | Properties], proplist, properties);
decode(Bin = <<"}", _/binary>>, Properties, proplist, properties) ->
    [Bin, Properties].


format([Left, Right], proplist) ->
    {Left, Right};
format([Left, Right], map) ->
    #{Left => Right}.

put(Structure, Element, proplist) ->
    [Element | Structure];
put(Structure, Element, map) ->
    maps:merge(Element, Structure).