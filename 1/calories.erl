-module(calories).
-export([puzzle1/0, puzzle2/0]).

% An elf is a tuple of an index and the carried calories

puzzle1() ->
	{ok, Fd} = file:open("input", read),
	AllElves = read_lines(Fd, {1, 0}, []),
	[{Elf, Calories}|_] = lists:reverse(lists:sort(fun elfsort/2, AllElves)),
	io:format("Elf #~w: ~w calories~n", [Elf, Calories]).

puzzle2() ->
	{ok, Fd} = file:open("input", read),
	[{_, C1}, {_, C2}, {_, C3}|_] = lists:reverse(lists:sort(fun elfsort/2, read_lines(Fd, {1, 0}, []))),
	Sum = C1 + C2 + C3,
	io:format("Sum of the top 3 calories: ~w~n", [Sum]).

read_lines(Fd, Acc={Elf, Calories}, List) ->
	case io:get_line(Fd, '') of
		eof ->	[Acc|List];
		{error, Descr} ->	{error, Descr};
		[10] ->	read_lines(Fd, {Elf + 1, 0}, [Acc|List]);
		L ->
			N = list_to_integer(trim_newline(L)),
			read_lines(Fd, {Elf, Calories + N}, List)
	end.

trim_newline([]) -> [];
trim_newline([10]) -> [];
trim_newline([H|T]) -> [H|trim_newline(T)].

elfsort({_, Cl}, {_, Cr}) -> Cl =< Cr.
