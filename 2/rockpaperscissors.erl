-module(rockpaperscissors).
-export([puzzle1/0, puzzle2/0]).

puzzle1() ->
	L = read_input(fun map1/2),
	R = lists:sum(lists:map(fun play/1, L)),
	io:format("~w~n", [R]).

read_input(Mapfun) ->
	{ok, Fd} = file:open("input", read),
	read_lines(Fd, Mapfun, []).

read_lines(Fd, Mapfun, Lines) ->
	case io:get_line(Fd, '') of
		eof ->	Lines;
		Err = {error, _} ->
			Err;
		Data ->
			[A, 32, B, 10] = Data,
			read_lines(Fd, Mapfun, [Mapfun(A, B)|Lines])
	end.

map1(A, B) ->	{shape(A), shape(B)}.

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
value(scissors) ->	3;
value(lose) ->	0;
value(draw) ->	3;
value(win) ->	6.

puzzle2() ->
	L = read_input(fun map2/2),
	lists:sum(lists:map(fun({Opponent, Outcome}) -> play2(Opponent, Outcome) end, L)).

map2(A, B) ->	{shape(A), outcome(B)}.

outcome($X) ->	lose;
outcome($Y) ->	draw;
outcome($Z) ->	win.

play2(Opponent, Outcome) ->
	value(turn(Opponent, Outcome)) + value(Outcome).

turn(rock, lose) ->	scissors;
turn(rock, draw) ->	rock;
turn(rock, win) ->	paper;
turn(paper, lose) ->	rock;
turn(paper, draw) ->	paper;
turn(paper, win) ->	scissors;
turn(scissors, lose) ->	paper;
turn(scissors, draw) ->	scissors;
turn(scissors, win) ->	rock.
