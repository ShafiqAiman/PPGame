%MyGame

play:- how_to_play, read(X), scene(X).

how_to_play :-  write('Welcome to Warrior Adventure!'),nl,nl, 
		write('Rules.'),nl,
		write('You are to complete the game by solving puzzles.'),nl,
		write('There are 3 levels and each level has a different puzzle.'),nl,
		write('Complete all 3 puzzles to win the game.'),nl,
		write('Good Luck!'),nl,nl,
		write('Press a to proceed'),nl.

scene(X) :-	(X \= 'a' -> write('Press a with . lah macha'),nl,nl, how_to_play, nl); 
		(X = 'a' -> satu, read(Y), ques1(Y)).

satu :-		nl, write('LEVEL 1'),nl,nl,
		write('You are stranded in an underground tunnel in the SAHARA desert.'),nl,
		write('You start walking to find an EXIT.'),nl,
		write('You stumble upon a group of men with machine GUNS.'),nl,
		write('You start running away from them.'),nl,
		write('You meet a LOCKED DOOR.'),nl,		
		write('To open the door, you have to SOLVE a RIDDLE...'),nl,
		riddle.

riddle :-	nl, write('The riddle goes--'),nl,nl,
		write('What building has the most stories?'),nl,
		write('a. The library'),nl,
		write('b. The office'),nl,
		write('c. The School'),nl,
		write('d. The Train station'),nl,
		write('Your move?'),nl,nl. 

ques1(G) :-	(G = 'a' -> write('You are correct. Please proceed.'),nl,nl, dua); (G \= 'a' -> write('WRONG ANSWER!! BYE BYE')), false.  

dua :-		nl, write('LEVEL 2'),nl,nl,
		write('You are now in a DUNGEON.'),nl,
		write('You search the dungeon for a key.'),nl,
		write('You stumble upon a treasure chest that you suspect has the key inside.'),nl,
		write('The treasure chest is locked.'),nl,
		write('You try to unlock the chest.'),nl,		
		write('To unlock the chest, you have 1 TRY to find the key in the boxes below...'),nl,nl,
		write('Find the box with the k logo.'),nl,
		write('Select the number to unlock each box'),nl,
		ques2.	

ques2 :-	disp([1,2,3,4,5,6,7,8,9]), stt([a,a,a,a,a,a,a,a,a]).

disp([A,B,C,D,E,F,G,H,I]) :-
	write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,	write('|'),
        write([G,H,I]),write('|'),nl,nl.

stt(Lst) :- write('Your move..'),nl,nl, read(Z), move(Lst, Z, Ulst), disp(Ulst), wins(Ulst) .

%ctr(R) :- (((R > 0) , (R < 4)) -> strt([a,a,a,a,a,a,a,a,a]), ctr(R-1)); (R > 4 -> tiga); (R < 1, write('OUT OF MOVES!! BYE BYE'),nl,nl), false.

move([a,B,C,D,E,F,G,H,I], 1, [a,B,C,D,E,F,G,H,I]).
move([A,a,C,D,E,F,G,H,I], 2, [A,a,C,D,E,F,G,H,I]).
move([A,B,a,D,E,F,G,H,I], 3, [A,B,a,D,E,F,G,H,I]).
move([A,B,C,a,E,F,G,H,I], 4, [A,B,C,a,E,F,G,H,I]).
move([A,B,C,D,a,F,G,H,I], 5, [A,B,C,D,k,F,G,H,I]).
move([A,B,C,D,E,a,G,H,I], 6, [A,B,C,D,E,a,G,H,I]).
move([A,B,C,D,E,F,a,H,I], 7, [A,B,C,D,E,F,a,H,I]).
move([A,B,C,D,E,F,G,a,I], 8, [A,B,C,D,E,F,G,a,I]).
move([A,B,C,D,E,F,G,H,a], 9, [A,B,C,D,E,F,G,H,a]).
%xmove(Brd, _, Brd) :- write('Illegal move.'), nl.

wins(Ulst) :- 	(Ulst = [_,_,_,_,k,_,_,_,_] -> write('You found the key! Proceed to last level.'),nl,nl, tiga); write('BYE BYE!'),false,nl,nl.

tiga :- 	nl, write('LEVEL 3'),nl,nl,
		write('You are out of the dungeon.'),nl,
		write('You are now almost out of the tunnel.'),nl,
		write('On your out of the tunnel, you encounter SKELETON KING.'),nl,
		write('To exit the tunnel, you have to win a game against the king.'),nl,
		write('The King challenges you to a game of tictactoe.'),nl,		
		write('Defeat the King and you will have FREEDOM...'),nl,nl,
		queslast,nl,nl.

%start tictactoe
queslast :-	how_to_plays, strt([a,a,a,a,a,a,a,a,a]). 	

win(Brd, Plyr) :- rwin(Brd, Plyr);
                  cwin(Brd, Plyr);
                  dwin(Brd, Plyr).

%row win
rwin(Brd, Plyr) :- Brd = [Plyr,Plyr,Plyr,_,_,_,_,_,_];
                   Brd = [_,_,_,Plyr,Plyr,Plyr,_,_,_];
		   Brd = [_,_,_,_,_,_,Plyr,Plyr,Plyr].

%column win
cwin(Brd, Plyr) :- Brd = [Plyr,_,_,Plyr,_,_,Plyr,_,_];
%                  Brd = [_,Plyr,_,_,Plyr,_,_,Plyr,_];
		   Brd = [_,_,Plyr,_,_,Plyr,_,_,Plyr].

%diagonal win
dwin(Brd, Plyr) :- Brd = [Plyr,_,_,_,Plyr,_,_,_,Plyr];
		   Brd = [_,_,Plyr,_,Plyr,_,Plyr,_,_].

omove([a,B,C,D,E,F,G,H,I], Plyr, [Plyr,B,C,D,E,F,G,H,I]).
omove([A,a,C,D,E,F,G,H,I], Plyr, [A,Plyr,C,D,E,F,G,H,I]).
omove([A,B,a,D,E,F,G,H,I], Plyr, [A,B,Plyr,D,E,F,G,H,I]).
omove([A,B,C,a,E,F,G,H,I], Plyr, [A,B,C,Plyr,E,F,G,H,I]).
omove([A,B,C,D,a,F,G,H,I], Plyr, [A,B,C,D,Plyr,F,G,H,I]).
omove([A,B,C,D,E,a,G,H,I], Plyr, [A,B,C,D,E,Plyr,G,H,I]).
omove([A,B,C,D,E,F,a,H,I], Plyr, [A,B,C,D,E,F,Plyr,H,I]).
omove([A,B,C,D,E,F,G,a,I], Plyr, [A,B,C,D,E,F,G,Plyr,I]).
omove([A,B,C,D,E,F,G,H,a], Plyr, [A,B,C,D,E,F,G,H,Plyr]).

xmove([a,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xmove([A,a,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xmove([A,B,a,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xmove([A,B,C,a,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xmove([A,B,C,D,a,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xmove([A,B,C,D,E,a,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xmove([A,B,C,D,E,F,a,H,I], 7, [A,B,C,D,E,F,x,H,I]).
xmove([A,B,C,D,E,F,G,a,I], 8, [A,B,C,D,E,F,G,x,I]).
xmove([A,B,C,D,E,F,G,H,a], 9, [A,B,C,D,E,F,G,H,x]).
%xmove(Brd, _, Brd) :- write('Illegal move.'), nl.


dispa([A,B,C,D,E,F,G,H,I]) :-
	write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,	write('|'),
        write([G,H,I]),write('|'),nl,nl.


%go :- how_to_play, strt([a,a,a,a,a,a,a,a,a]).

how_to_plays :-
  write('You are x player, enter positions followed by a period.'),
  nl,
  dispa([1,2,3,4,5,6,7,8,9]).

strt(Brd) :- win(Brd, x), write('You win!'), true.
strt(Brd) :- win(Brd, o), write('King win!'), false.
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
  NewBrd = Brd, false.

