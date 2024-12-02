deltas_helper([_], Acc, Acc).
deltas_helper([X,Y|Zs], Acc, Res) :- Delta is Y - X, deltas_helper([Y|Zs], [Delta|Acc], Res).

deltas(Level, Res) :- deltas_helper(Level, [], Res).

valid(Level) :-
  deltas(Level, Deltas),
  ( forall(member(Delta, Deltas), (Delta > 0, Delta < 4))
  ; forall(member(Delta, Deltas), (Delta < 0, Delta > -4))
  ).

day02a(Res) :-
  findall(Level, level(Level), Levels),
  include(valid, Levels, ValidLevels),
  length(ValidLevels, Res).

valid2(Level) :-
  ( valid(Level)
  ; select(_, Level, NewLevel), valid(NewLevel)
  ).

day02b(Res) :-
  findall(Level, level(Level), Levels),
  include(valid2, Levels, ValidLevels),
  length(ValidLevels, Res).
