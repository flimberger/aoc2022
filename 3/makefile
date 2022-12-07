.POSIX:
.SUFFIXES:	.erl .beam

MOD=rucksack

all:	$(MOD).beam
clean:	rm -f *.beam erl_crash.dump

$(MOD):	$(MOD).beam
	erl -boot start_clean -noshell -s $(MOD) run -s init stop

.erl.beam:
	erlc -W $<

.PHONY:	all clean
