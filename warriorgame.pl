
%MyGame

head([H|_], H).

play      :-	retractall(health(_, _)),retractall(health1(_, _)), assertz(health(1, 100)),assertz(health1(1, 100)), how_to_play, read(X), scene(X).

healthdeduction :- findall(A, health(1, A), L), head(L, B), C is B - 20, retractall(health(_, _)), assertz(health(1, C)).

dragonhealthmajor :- findall(A, health1(1, A), L), head(L, B), C is B - 40, retractall(health1(_, _)), assertz(health1(1, C)).

dragonhealthminor :- findall(A, health1(1, A), L), head(L, B), C is B - 20, retractall(health1(_, _)), assertz(health1(1, C)).


checkhealth(B) :- (B > 0,true);
                  (B=<0,nl,write('You are out of blood'),nl,write('You sacrifice will always be remember by your princess'),nl,
		   nl,write('Do you want to play again?(y/n)'),nl,read(P),rep(P)).

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
		write('The princess is died because of you!'),nl,write('Bye Bye!'),nl,nl,
		write('Do you want to play again?(y/n)'),nl,read(P),rep(P));
		(X = 'a' -> nl,write('There are three levels that you need to pass in order to save the princess'),nl,
		write('Each level has different challenge, you may get hurt in the journey of rescuing.'),nl,
		write('Goodluck!'),nl,nl,
		lvl1, read(Y), ques1(Y)).

lvl1 :-		write('----------------------------------------------------------------------------------------------------------------'),nl,
		nl, write('LEVEL 1 - Dwarf Riddle'),nl,nl,
		write('Now you have entered the cave'),nl,
		write('You are given 100% health'),nl,nl,
		write('After a mile walking, a dwarf blocked you from going deeper into the cave.'),nl,
		write('However, he will allow you to pass if you solve a RIDDLE..'),nl,
		riddle.

riddle :-	findall(A, health(1, A), L), head(L, B),nl,checkhealth(B),nl,
	        write('The riddle goes--'),nl,nl,
		write('Health = '), write(B), nl,
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



dispa([A,B,C,D,E,F,G,H,I]) :-
	write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,	write('|'),
        write([G,H,I]),write('|'),nl,nl.


%go :- how_to_play, strt([a,a,a,a,a,a,a,a,a]).

how_to_plays :-
  findall(A, health(1, A), L), head(L, B),nl,checkhealth(B),nl, write('Health = '), write(B), nl,
  write('You are x player, enter positions followed by a period.'),
  nl,
  dispa([1,2,3,4,5,6,7,8,9]).

strt(Brd) :- win(Brd, x), write('You win!'),nl,write('You escaped the magic spell.'),nl,write('You can now head to The Chamber of Dragon to save your pricess.'),true, lvl3.
strt(Brd) :- win(Brd, o), write('Mage win!'),healthdeduction,nl,write('You are hurt by the magic spell.'),nl,write('However, the mage offers you another chance to get rid of the magic spell.'),ques2.
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
  write('Game Ended without Winner!'),true,nl,
  NewBrd = Brd, nl,
  write('Let us play another round'),nl,ques2.



lvl3 :-		nl,write('----------------------------------------------------------------------------------------------------------------'),
	        nl, write('LEVEL 3 - Killing Dragon'),nl,nl,
		write('Finally,you reached to The Chamber of Dragon!'),nl,
		write('You need to kill the dragon in order to save the princess!'),nl,
		write('The diagram below is the body parts of dragon.'),nl,
		write('You need to determine which is the crucial body part of dragon that needs to be attacked in order to defeat it!'),nl,
		write('Select the number to attack that body part of dragon.'),nl,ques3.

ques3 :-	nl,findall(A, health(1, A), L), head(L, B),nl,checkhealth(B),nl, write('Health = '), write(B),
		findall(C, health1(1, C), L2), head(L2, D),nl,write('Dragon Health = '),write(D),nl,
		nl,disp([1,2,3,4,5,6,7,8,9]),nl,
	        nl,write('1- Left Wing'),nl,
		write('2- Head'),nl,
		write('3- Right Wing'),nl,
		write('4- Left Hand'),nl,
		write('5- Heart'),nl,
		write('6- Right Hand'),nl,
		write('7- Left Leg'),nl,
		write('8- Tail'),nl,
		write('9- Right Leg'),nl,nl,
		stt([lw,hd,rw,lh,ht,rh,ll,tl,rl]).

disp([A,B,C,D,E,F,G,H,I]) :-
	nl,write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,write('|'),
	write([G,H,I]),write('|'),nl.



stt(Lst) :- write('Your move..'),nl,nl, read(Z), move(Lst, Z, Ulst), disp(Ulst), wins(Ulst) .


move([lw,B,C,D,E,F,G,H,I], 1, [xx,B,C,D,E,F,G,H,I]).
move([A,hd,C,D,E,F,G,H,I], 2, [A,xx,C,D,E,F,G,H,I]).
move([A,B,rw,D,E,F,G,H,I], 3, [A,B,xx,D,E,F,G,H,I]).
move([A,B,C,lh,E,F,G,H,I], 4, [A,B,C,xx,E,F,G,H,I]).
move([A,B,C,D,ht,F,G,H,I], 5, [A,B,C,D,kk,F,G,H,I]).
move([A,B,C,D,E,rh,G,H,I], 6, [A,B,C,D,E,xx,G,H,I]).
move([A,B,C,D,E,F,ll,H,I], 7, [A,B,C,D,E,F,xx,H,I]).
move([A,B,C,D,E,F,G,tl,I], 8, [A,B,C,D,E,F,G,xx,I]).
move([A,B,C,D,E,F,G,H,rl], 9, [A,B,C,D,E,F,G,H,xx]).


rep(P) :- (P = 'y' -> nl,play,nl);
           P = 'n' -> write('Thank you Bye bye !'),nl,sleep(2),halt.

wins(Ulst) :-	(Ulst = [_,_,_,_,kk,_,_,_,_] -> nl,write('You have hit the crucial part of the dragon.'),nl,
		 write('The dragon health is deducted'),nl,dragonhealthmajor,healthdeduction,dragon); nl,
		 write('You did not hit the crucial part'),nl,write('The dragon health is deducted'),nl,dragonhealthminor,healthdeduction,dragon.

dragon :- nl,findall(A, health1(1, A), L), head(L, B),(B > 0 -> write('The dragon attacked you back. Your health is deducted.'),ques3);
(nl,nl,write('----------------------------------------------------------------------------------------------------------------'),nl,write('You killed the dragon!'),nl,write('----------------------------------------------------------------------------------------------------------------'),nl,nl,congrat).

congrat :- write('The princess is saved'),nl,
	   write('Due to your braveness the king award you an island and allow you to marry the princess'),nl,
	   write('Since then, you have a beautiful life with princess for your entire life in that rewarded island.'),nl,nl,
	   write('THE END'),nl,nl,
	   write('Do you want to play again ? (y/n)'),nl,
	   read(P),rep(P),nl,true.

