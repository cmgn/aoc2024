:- use_module(library(dcg/basics)).

prog([]) --> [].
prog([X|Xs]) --> mul(X), prog(Xs).
prog(Xs) --> [_], prog(Xs).
mul(X*Y) --> "mul(", digits(X), ",", digits(Y), ")".

run([], Acc, Acc).
run([Xs*Ys|Zs], Acc, Res) :-
  number_codes(X, Xs), number_codes(Y, Ys),
  NewAcc is Acc + X*Y,
  run(Zs, NewAcc, Res).

day03a(Res) :-
  input(String),
  phrase(prog(Prog), String),
  run(Prog, 0, Res).

prog2([]) --> [].
prog2([X|Xs]) --> mul(X), prog2(Xs).
prog2([dont|Xs]) --> "don't", prog2(Xs).
prog2([do|Xs]) --> "do", prog2(Xs).
prog2(Xs) --> [_], prog2(Xs).

run2([], _, Acc, Acc).
run2([do|Xs], _, Acc, Res) :- run2(Xs, 1, Acc, Res).
run2([dont|Xs], _, Acc, Res) :- run2(Xs, 0, Acc, Res).
run2([Xs*Ys|Zs], Mode, Acc, Res) :-
  number_codes(X, Xs), number_codes(Y, Ys),
  NewAcc is Acc + Mode*X*Y,
  run2(Zs, Mode, NewAcc, Res).

day03b(Res) :-
  input(String),
  phrase(prog2(Prog), String),
  run2(Prog, 1, 0, Res).
