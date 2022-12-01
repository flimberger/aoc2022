.POSIX:
.SUFFIXES:	.erl .beam

all:	calories.beam
clean:	rm -f *.beam erl_crash.dump

calories:	calories.beam
	erl -boot start_clean -noshell -s calories run -s init stop

.erl.beam:
	erlc -W $<

.PHONY:	all clean