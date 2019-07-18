-module(p_test).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

flatten_test_() -> [
    ?_assert(p07:flatten([[],[],[], [[1, 2, [3]]]]) =:= [1, 2, 3])
].

compress_test_() -> [
    ?_assert(p08:compress([1, 1, 1, 2, 2,3 , a, a, b]) =:= [1, 2, 3, a, b])
].

pack_test_() -> [
    ?_assert(p09:pack([1, 1, 1, 2, 2,3 , a, a, b]) =:= [[1, 1, 1], [2, 2], [3], [a, a], [b]])
].