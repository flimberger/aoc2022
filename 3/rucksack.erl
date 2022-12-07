-module(rucksack).
-export([puzzle1/1]).

puzzle1(Filename) ->
	L = read_input(Filename),
	C = lists:map(fun common_item/1, L),
	R = lists:sum(lists:map(fun priority/1, C)),
	io:format("~w~n", [R]).

read_input(Filename) ->
	{ok, Fd} = file:open(Filename, read),
	read_lines(Fd, []).

read_lines(Fd, Lines) ->
	case io:get_line(Fd, '') of
		eof ->	Lines;
		Err = {error, _} ->	Err;
		Data ->
			read_lines(Fd, [trim_newline(Data)|Lines])
	end.

trim_newline([]) -> [];
trim_newline([10]) -> [];
trim_newline([H|T]) -> [H|trim_newline(T)].

common_item(Rucksack) ->
	{A, B} = lists:split(erlang:length(Rucksack) div 2, Rucksack),
	drippleout(lists:sort(A), lists:sort(B)).

% some weird algorithm I do not have a name for
% inputs are sorted lists, and it is assumed that only one item is in common
drippleout([C|_], [C|_]) ->	C;
drippleout([A|Tail], List=[B|_]) when A < B -> drippleout(Tail, List);
drippleout(List=[A|_], [B|Tail]) when A > B -> drippleout(List, Tail);
drippleout(_, []) ->	invalid_input;
drippleout([], _) ->	invalid_input.

priority(I) when I >= $A, I =< $Z ->	I - $A + 27;
priority(I) when I >= $a, I =< $z ->	I - $a + 1.
