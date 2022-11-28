all:
	rm -rf  *~ */*~ src/*.beam tests/*.beam;
	rm -rf erl_cra*;
	rm -rf ebin;
	mkdir ebin;		
	rebar3 compile;	
	cp _build/default/lib/*/ebin/* ebin;
	rm -rf _build;
	rm -rf tests_ebin;
	git add -f *;
	git commit -m $(m);
	git push;
	echo Ok there you go!
eunit:
	rm -rf  *~ */*~ src/*.beam tests/*.beam;
	rm -rf erl_cra*;
	rm -rf tests_ebin;
	rm -rf ebin;
	mkdir tests_ebin;
	erlc -I include -o tests_ebin tests/*.erl;
	mkdir ebin;
	rebar3 compile;	
	cp _build/default/lib/*/ebin/* ebin;
	rm -rf _build;
	erlc -I include -o ebin src/*.erl;
	erl -pa ebin -pa tests_ebin\
            -sname common_test -run $(m) start -setcookie cookie_test
