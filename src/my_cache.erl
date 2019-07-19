-module(my_cache).
-export([create/1]).
-export([insert/4]).
-export([lookup/2]).
-export([delete_obsolete/1]).
-export([get_all/1]).

-define(CURRENT_TIME, calendar:datetime_to_gregorian_seconds(get_head(calendar:local_time_to_universal_time_dst(calendar:local_time())))).

create(TableName) -> 
    try ets:new(TableName, [set, protected, named_table]) of
        _ -> 
            true
    catch
        error:_ ->
            table_already_exists
    end.

insert(TableName, Key, Value, LiveTime) when is_number(LiveTime) -> 
    ets:insert(TableName, {Key, Value, LiveTime, ?CURRENT_TIME, actual}).


get_all(TableName) ->
    refresh(TableName),
    get_values(ets:match_object(TableName, {'$1', '$2', '$3', '$4', actual})).


lookup(TableName, Key) -> 
    refresh(TableName, Key),
    case ets:lookup(TableName, Key) of
        [Record] ->
            if 
                (element(5, Record) =:= deprecated) ->
                    undefined;
                true ->
                    element(2, Record)
            end;
        [] ->
            undefined;
        [_ | _] ->
            not_supported_type_of_table
    end.

delete_obsolete(TableName) -> 
    refresh(TableName),
    ets:match_delete(TableName, {'$1', '$2', '$3', '$4', deprecated}).

refresh(TableName) ->
    Records = ets:match_object(TableName, {'$1', '$2', '$3', '$4', '$5'}),
    update_each(TableName, Records).

refresh(TableName, Key) ->
    case ets:lookup(TableName, Key) of
        [] ->
            undefined;
        [Record] ->
            ets:insert(TableName, update_record(Record));
        [_ | _] ->
            not_supported_type_of_table
    end.

update_record(Record = {_, _, LiveTime, CreationTime, _}) ->
        CurrentTime = ?CURRENT_TIME,
        if 
            (LiveTime + CreationTime) < CurrentTime ->
                setelement(5, Record, deprecated);
            true ->
                Record
        end.

get_head([H|_]) ->
    H.

get_values(Records) ->
    lists:reverse(get_values(Records, [])).

get_values([{_, Value, _, _, _} | Rest], Acc) ->
    get_values(Rest, [Value | Acc]);
get_values(_, Acc) ->
    Acc.

update_each(TableName, [Record | Rest]) ->
    ets:insert(TableName, update_record(Record)),
    update_each(TableName, Rest);
update_each(_, _) ->
    undefined.