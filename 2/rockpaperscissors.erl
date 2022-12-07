-module(rockpaperscissors).
-export([puzzle1/0]).

puzzle1() ->
	L = read_input(),
	R = lists:sum(lists:map(fun play/1, L)),
	io:format("~w~n", [R]).

read_input() ->
	{ok, Fd} = file:open("input", read),
	read_lines(Fd, []).

read_lines(Fd, Lines) ->
	case io:get_line(Fd, '') of
		eof ->	Lines;
		Err = {error, _} ->
			Err;
		Data ->
			[A, 32, B, 10] = Data,
			read_lines(Fd, [{shape(A), shape(B)}|Lines])
	end.

shape($A) ->	rock;
shape($X) ->	rock;
shape($B) ->	paper;
shape($Y) ->	paper;
shape($C) ->	scissors;
shape($Z) ->	scissors.

play({Opponent, Player}) ->
	{_, P} = result(Opponent, Player),
	P + value(Player).

result(rock, rock) ->	{3, 3};
result(rock, paper) ->	{0, 6};
result(rock, scissors) ->	{6, 0};
result(paper, rock) ->	{6, 0};
result(paper, paper) ->	{3, 3};
result(paper, scissors) ->	{0, 6};
result(scissors, rock) ->	{0, 6};
result(scissors, paper) ->	{6, 0};
result(scissors, scissors) ->	{3, 3}.

value(rock) ->	1;
value(paper) ->	2;
value(scissors) ->	3.
