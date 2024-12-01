diff_helper([], [], Acc, Acc).
diff_helper([X|Xs], [Y|Ys], Acc, Res) :-
  Diff is abs(X - Y),
  NewAcc is Diff + Acc,
  diff_helper(Xs, Ys, NewAcc, Res).

diff(Xs, Ys, Res) :- diff_helper(Xs, Ys, 0, Res).

day1a(Res) :-
  findall(X, pair(X, _), LeftUnsorted),
  findall(Y, pair(_, Y), RightUnsorted),
  msort(LeftUnsorted, Left),
  msort(RightUnsorted, Right),
  diff(Left, Right, Res).

freq_helper([], X, Count, Acc, [p(X, Count)|Acc]).
freq_helper([X|Xs], X, Count, Acc, Res) :-
  NewCount is Count + 1,
  freq_helper(Xs, X, NewCount, Acc, Res).
freq_helper([X|Xs], Y, Count, Acc, Res) :-
  X \= Y,
  freq_helper(Xs, X, 1, [p(Y, Count)|Acc], Res).

freq([], []).
freq([X|Xs], Res) :- freq_helper(Xs, X, 1, [], Res).

freq_get(Freq, X, Res) :- member(p(X, Res), Freq), !.
freq_get(Freq, X, 0) :- \+ member(p(X, _), Freq).

wdiff_helper([], _, Acc, Acc).
wdiff_helper([X|Xs], Freq, Acc, Res) :-
  freq_get(Freq, X, Count),
  NewAcc is Acc + X*Count,
  wdiff_helper(Xs, Freq, NewAcc, Res).

wdiff(Xs, Freq, Res) :- wdiff_helper(Xs, Freq, 0, Res).

day1b(Res) :-
  findall(X, pair(X, _), LeftUnsorted),
  findall(Y, pair(_, Y), RightUnsorted),
  msort(LeftUnsorted, Left),
  msort(RightUnsorted, Right),
  freq(Right, RightFreq),
  wdiff(Left, RightFreq, Res).
