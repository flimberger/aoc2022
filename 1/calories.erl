-module(calories).
-export([run/0]).

% An elf is a tuple of an index and the carried calories

run() ->
	{ok, Fd} = file:open("input", read),
	{Elf, Calories} = read_lines(Fd, {1, 0}, {0, 0}),
	io:format("Elf #~w: ~w calories~n", [Elf, Calories]).

read_lines(Fd, C = {CurElf, CurCal}, M) ->
	case io:get_line(Fd, '') of
		eof ->	elf_with_more_calories(C, M);
		{error, Descr} ->	{error, Descr};
		[10] ->
			% io:format("~w: ~w~n", [CurElf, CurCal]),
			read_lines(Fd, {CurElf + 1, 0}, elf_with_more_calories(C, M));
		L ->
			N = list_to_integer(trim_newline(L)),
			read_lines(Fd, {CurElf, CurCal + N}, M)
	end.

trim_newline([]) -> [];
trim_newline([10]) -> [];
trim_newline([H|T]) -> [H|trim_newline(T)].

elf_with_more_calories(E1 = {_, C1}, E2 = {_, C2}) ->
	if
		C1 >= C2 ->	E1;
		true ->		E2
	end.
