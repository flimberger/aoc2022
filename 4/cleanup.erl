-module(cleanup).
-export([puzzle1/1, test1/0]).

puzzle1(Filename) ->
	L = read_input(Filename),
	D = lists:filter(fun({A, B}) -> fullycontains(A, B) end, L),
	io:format("~w~n", [D]),
	erlang:length(D).

test1() ->
	2 = puzzle1("testinput"),
	ok.

read_input(Filename) ->
	{ok, Fd} = file:open(Filename, read),
	read_lines(Fd, []).

read_lines(Fd, Lines) ->
	case io:get_line(Fd, '') of
		eof ->	Lines;
		Err = {error, _} ->	Err;
		Data ->
			read_lines(Fd, [parse_line(Data)|Lines])
	end.

parse_line(L) ->
	{LowerBound1, Rem1} = parse_number(L, 45, []), % read until -
	{UpperBound1, Rem2} = parse_number(Rem1, 44, []), % read until ,
	{LowerBound2, Rem3} = parse_number(Rem2, 45, []), % read until -
	{UpperBound2, _} = parse_number(Rem3, 10, []), % read until newline
	{{LowerBound1, UpperBound1}, {LowerBound2, UpperBound2}}.

parse_number([H|T], Delim, Acc) ->
	if
		H =:= Delim ->	{list_to_integer(lists:reverse(Acc)), T};
		is_integer(H) ->	parse_number(T, Delim, [H|Acc])
	end.

fullycontains(A, B) ->
	insideof(A, B) or insideof(B, A).

% guard: when L1 =< U1, L2 =< U2
insideof({L1, U1}, {L2, U2}) ->
	(L1 =< L2) and (U1 >= U2).
