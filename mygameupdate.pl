%MyGame

head([H|_], H).

play      :-	retractall(health(_, _)), assertz(health(1, 100)), how_to_play, read(X), scene(X).

healthdeduction :- findall(A, health(1, A), L), head(L, B), C is B - 20,(C > 0 -> retractall(health(_, _)), assertz(health(1, C)));(false) .

how_to_play :-  write('Welcome to Warrior Adventure!'),nl,nl,
		write('Rules.'),nl,
		write('You are a knight.'),nl,
		write('Your princess was taken away by a dragon into a cave.'),nl,
		write('You are in front of the cave now.'),nl,nl,
		write('Good Luck!'),nl,nl,
		write('Are you brave enough to risk your own life to save the princess from the dragon?'),nl,
		write('Press a for YES'),nl,
		write('Press b for NO'),nl.

scene(X) :-	(X = 'b' -> nl,write('You are such a coward!'),nl,
		write('You dont deserve to be knight!'),nl,
		write('The princess is died because of you! Bye!'),false);
		(X = 'a' -> nl,write('There are three levels that you need to pass in order to save the princess'),nl,
		write('Each level has different challenge, you may get hurt in the journey of rescuing.'),nl,
		write('Goodluck!'),nl,nl,
		lvl1, read(Y), ques1(Y)).

lvl1 :-		write('--------------------------------------------------------------------------'),nl,
		nl, write('LEVEL 1 - Dwarf Riddle'),nl,nl,
		write('Now you have entered the cave'),nl,
		write('You are given 100% health'),nl,nl,
		write('After a mile walking, a dwarf blocked you from going deeper into the cave.'),nl,
		write('However, he will allow you to pass if you solve a RIDDLE..'),nl,
		riddle.

riddle :-	nl, write('The riddle goes--'),nl,nl,
		findall(A, health(1, A), L), head(L, B), write('Health = '), write(B), nl,
		write('Which dragon is used by Harry Potter during Triwizard Tournament?'),nl,
		write('a. Antipodean Opaleye'),nl,
		write('b. Norwegian Ridgeback'),nl,
		write('c. Hungarian Horntail'),nl,
		write('d. Ukrainian Ironbelly'),nl,
		write('Your move?'),nl,nl,
		read(G),ques1(G).

ques1(G) :-	(G = 'c' -> write('You are correct.'),nl,
		 write('You have acquired the ultimate weapon from the mage.'),nl,
		 write('You can procced to the next level.'),nl,nl, lvl2);
                (G \= 'c' ->
		healthdeduction,write('You have given a wrong answer.'),nl,
		write('You need to sacrifice some of your blood in order to reanswer the question.'),nl,nl,
		riddle).

lvl2 :-		nl,write('------------------------------------------------------------------------------------------------------------'),
	        nl, write('LEVEL 2 - Mage Tic Tac Toe'),nl,nl,
		write('You are now in the middle of the cave.'),nl,
		write('Suddenly, you are trapped inside a magic spell'),nl,
		write('A mage then appears.'),nl,
		write('To escape from that magic spell, you have to win a game against the mage'),nl,
		write('The Mage challenges you to a game of tictactoe.'),nl,
		write('Defeat the Mage and you can get a chance to save the princess!'),nl,nl,
		ques2,nl,nl.

%start tictactoe
ques2 :-	how_to_plays, strt([-,-,-,-,-,-,-,-,-]).

win(Brd, Plyr) :- rwin(Brd, Plyr);
                  cwin(Brd, Plyr);
                  dwin(Brd, Plyr).

%row win
rwin(Brd, Plyr) :- Brd = [Plyr,Plyr,Plyr,_,_,_,_,_,_];
                   Brd = [_,_,_,Plyr,Plyr,Plyr,_,_,_];
		   Brd = [_,_,_,_,_,_,Plyr,Plyr,Plyr].

%column win
cwin(Brd, Plyr) :- Brd = [Plyr,_,_,Plyr,_,_,Plyr,_,_];
                   Brd = [_,Plyr,_,_,Plyr,_,_,Plyr,_];
		   Brd = [_,_,Plyr,_,_,Plyr,_,_,Plyr].

%diagonal win
dwin(Brd, Plyr) :- Brd = [Plyr,_,_,_,Plyr,_,_,_,Plyr];
		   Brd = [_,_,Plyr,_,Plyr,_,Plyr,_,_].

omove([-,B,C,D,E,F,G,H,I], Plyr, [Plyr,B,C,D,E,F,G,H,I]).
omove([A,-,C,D,E,F,G,H,I], Plyr, [A,Plyr,C,D,E,F,G,H,I]).
omove([A,B,-,D,E,F,G,H,I], Plyr, [A,B,Plyr,D,E,F,G,H,I]).
omove([A,B,C,-,E,F,G,H,I], Plyr, [A,B,C,Plyr,E,F,G,H,I]).
omove([A,B,C,D,-,F,G,H,I], Plyr, [A,B,C,D,Plyr,F,G,H,I]).
omove([A,B,C,D,E,-,G,H,I], Plyr, [A,B,C,D,E,Plyr,G,H,I]).
omove([A,B,C,D,E,F,-,H,I], Plyr, [A,B,C,D,E,F,Plyr,H,I]).
omove([A,B,C,D,E,F,G,-,I], Plyr, [A,B,C,D,E,F,G,Plyr,I]).
omove([A,B,C,D,E,F,G,H,-], Plyr, [A,B,C,D,E,F,G,H,Plyr]).

xmove([-,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xmove([A,-,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xmove([A,B,-,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xmove([A,B,C,-,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xmove([A,B,C,D,-,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xmove([A,B,C,D,E,-,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xmove([A,B,C,D,E,F,-,H,I], 7, [A,B,C,D,E,F,x,H,I]).
xmove([A,B,C,D,E,F,G,-,I], 8, [A,B,C,D,E,F,G,x,I]).
xmove([A,B,C,D,E,F,G,H,-], 9, [A,B,C,D,E,F,G,H,x]).
%xmove(Brd, _, Brd) :- write('Illegal move.'), nl.


dispa([A,B,C,D,E,F,G,H,I]) :-
	write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,	write('|'),
        write([G,H,I]),write('|'),nl,nl.


%go :- how_to_play, strt([a,a,a,a,a,a,a,a,a]).

how_to_plays :-
  findall(A, health(1, A), L), head(L, B), write('Health = '), write(B), nl,
  write('You are x player, enter positions followed by a period.'),
  nl,
  dispa([1,2,3,4,5,6,7,8,9]).

strt(Brd) :- win(Brd, x), write('You win!'), lvl3.
strt(Brd) :- win(Brd, o), write('King win!'),healthdeduction, ques2.
strt(Brd) :- read(N),
  xplay(Brd, N, NewBrd),
  dispa(NewBrd),
  oplay(NewBrd, NewnewBrd),
  dispa(NewnewBrd),
  strt(NewnewBrd).

can_x_win(Brd) :- omove(Brd, x, NewBrd), win(NewBrd, x).

xplay(Brd, N, NewBrd) :- xmove(Brd, N, NewBrd).

%oplay functions

oplay(Brd,NewBrd) :-
  omove(Brd, o, NewBrd),
  win(NewBrd, o),!.

oplay(Brd,NewBrd) :-
  omove(Brd, o, NewBrd),
  not(can_x_win(NewBrd)).

oplay(Brd,NewBrd) :-
  omove(Brd, o, NewBrd).

oplay(Brd,NewBrd) :-
  not(member(a,Brd)),!,
  write('Game Ended without Winner!'), nl,
  NewBrd = Brd, nl,
  write('Let us play anothe round'),nl,ques2.



lvl3 :-		write('--------------------------------------------------------------------------'),
	        nl, write('LEVEL 3 - Killing Dragon'),nl,nl,
		write('Finally,you reached to The Chamber of Dragon!'),nl,
		write('You need to kill the dragon in order to save the princess!'),nl,
		write('The diagram below is the body parts of dragon.'),nl,
		write('You need to determine which body part of dragon that needs to be attacked in order to defeat it!'),nl,
		write('Select the number to attack that body part of dragon.'),nl,ques3.

ques3 :-	disp([1,2,3,4,5,6,7,8,9]), stt([a,a,a,a,a,a,a,a,a]).

disp([A,B,C,D,E,F,G,H,I]) :-
	nl,write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,write('|'),
	write([G,H,I]),write('|'),nl,nl,
	write('1- Left Wing'),nl,
	write('2- Head'),nl,
	write('3- Right Wing'),nl,
	write('4- Left Hand'),nl,
	write('5- Heart'),nl,
	write('6- Right Hand'),nl,
	write('7- Left Leg'),nl,
	write('8- Tail'),nl,
	write('9- Right Leg'),nl,nl.


stt(Lst) :- write('Your move..'),nl,nl, read(Z), move(Lst, Z, Ulst), disp(Ulst), wins(Ulst) .


move([a,B,C,D,E,F,G,H,I], 1, [a,B,C,D,E,F,G,H,I]).
move([A,a,C,D,E,F,G,H,I], 2, [A,a,C,D,E,F,G,H,I]).
move([A,B,a,D,E,F,G,H,I], 3, [A,B,a,D,E,F,G,H,I]).
move([A,B,C,a,E,F,G,H,I], 4, [A,B,C,a,E,F,G,H,I]).
move([A,B,C,D,a,F,G,H,I], 5, [A,B,C,D,k,F,G,H,I]).
move([A,B,C,D,E,a,G,H,I], 6, [A,B,C,D,E,a,G,H,I]).
move([A,B,C,D,E,F,a,H,I], 7, [A,B,C,D,E,F,a,H,I]).
move([A,B,C,D,E,F,G,a,I], 8, [A,B,C,D,E,F,G,a,I]).
move([A,B,C,D,E,F,G,H,a], 9, [A,B,C,D,E,F,G,H,a]).


rep(P) :- (P = 'y' -> nl,play,nl);
          (P = 'n' -> write('Thank you Bye bye !'),false).

wins(Ulst) :-	(Ulst = [_,_,_,_,k,_,_,_,_] -> write('You have killed the dragon.'),nl,congrat); write('BYE BYE!'),nl,ques3.

congrat :- write('The princess is saved'),nl,
	   write('Due to your braveness the king award you an island and allow you to marry the princess'),nl,
	   write('Since then, you have a beautiful life with princess for your entire life in that rewarded island.'),nl,nl,
	   write('Do you want to play again ? y or n'),nl,
	   read(P),rep(P).


