-module(bs_test).

-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

-define(RAW_BINARY_JSON, <<"{'squadName':'Superherosquad','homeTown':'MetroCity','formed':2016,'secretBase':'Supertower','active':true,'members':[{'name':'MoleculeMan','age':29,'secretIdentity':'DanJukes','powers':['Radiationresistance','Turningtiny','Radiationblast']},{'name':'MadameUppercut','age':39,'secretIdentity':'JaneWilson','powers':['Milliontonnepunch','Damageresistance','Superhumanreflexes']},{'name':'EternalFlame','age':1000000,'secretIdentity':'Unknown','powers':['Immortality','HeatImmunity','Inferno','Teleportation','Interdimensionaltravel']}]}">>).
-define(PROPLIST_JSON, [{<<"squadName">>,<<"Superherosquad">>},
{<<"homeTown">>,<<"MetroCity">>},
{<<"formed">>,2016},
{<<"secretBase">>,<<"Supertower">>},
{<<"active">>,true},
{<<"members">>,
 [[{<<"name">>,<<"MoleculeMan">>},
   {<<"age">>,29},
   {<<"secretIdentity">>,<<"DanJukes">>},
   {<<"powers">>,
    [<<"Radiationresistance">>,<<"Turningtiny">>,
     <<"Radiationblast">>]}],
  [{<<"name">>,<<"MadameUppercut">>},
   {<<"age">>,39},
   {<<"secretIdentity">>,<<"JaneWilson">>},
   {<<"powers">>,
    [<<"Milliontonnepunch">>,<<"Damageresistance">>,
     <<"Superhumanreflexes">>]}],
  [{<<"name">>,<<"EternalFlame">>},
   {<<"age">>,1000000},
   {<<"secretIdentity">>,<<"Unknown">>},
   {<<"powers">>,
    [<<"Immortality">>,<<"HeatImmunity">>,<<"Inferno">>,
     <<"Teleportation">>,<<"Interdimensionaltravel">>]}]]}]).




first_word_test_() -> [
    ?_assert(bs01:first_word(<<"word1 word2">>) =:= <<"word1">>),
    ?_assert(bs01:first_word(<<"       word1 word2">>) =:= <<"word1">>),
    ?_assert(bs01:first_word(<<"    ">>) =:= <<>>)
].

words_test_() -> [
    ?_assert(bs02:words(<<"word1 word2">>) =:= [<<"word1">>, <<"word2">>]),
    ?_assert(bs02:words(<<>>) =:= []),
    ?_assert(bs02:words(<<"    ">>) =:= [])
].

split_test_() -> [
    ?_assert(bs03:split(<<"word1 word2">>, " ") =:= [<<"word1">>, <<"word2">>]),
    ?_assert(bs03:split(<<"word1 word2">>, "dsa ") =:= [<<"word1 word2">>]),
    ?_assert(bs03:split(<<"word1SomeSplitterword2">>, "SomeSplitter") =:= [<<"word1">>, <<"word2">>])
].

decode_test_() -> [
    ?_assert(bs04:decode(?RAW_BINARY_JSON, proplist) =:= ?PROPLIST_JSON)
].