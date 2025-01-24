% A: x i y są rodzeństwem
rodzenstwo(X, Y) :-
    rodzic(Z, X), rodzic(Z, Y), X \= Y.

% B: x i y są rodzeństwem ciotecznym
rodzenstwo_cioteczne(X, Y) :-
    rodzic(A, X), rodzic(B, Y), rodzenstwo(A, B).

% C: x i y są babciami lub dziadkami
babcia_dziadek(X, Y) :-
    dziadek(X, Y);
    babcia(X, Y).

% D: y jest dla x ojczymem lub macochą
ojczym_macocha(Y, X) :-
    malzenstwo(Y, Z), rodzic(Z, X), \+ rodzic(Y, X).

% E: x i y są rodzeństwem przyszywanym
rodzenstwo_przyszywane(X, Y) :-
    malzenstwo(A, B),
    rodzic(A, X), rodzic(B, Y), X \= Y.

% F: y jest dla x szwagrem lub szwagierką
szwagier_szwagierka(Y, X) :-
    malzenstwo(Y, Z), rodzenstwo(Z, X).

% Kobieta i mężczyzna
kobieta(X) :- osoba(X), \+ mezczyzna(X).

% Ojciec
ojciec(X, Y) :- mezczyzna(X), rodzic(X, Y).

% Matka
matka(X, Y) :- kobieta(X), rodzic(X, Y).

% Córka
corka(X, Y) :- kobieta(X), rodzic(Y, X).

% Brat rodzony
brat_rodzony(X, Y) :-
    mezczyzna(X), rodzic(Z, X), rodzic(Z, Y), X \= Y.

% Brat przyrodni
brat_przyrodni(X, Y) :-
    mezczyzna(X), rodzic(Z, X), rodzic(W, Y), Z \= W, X \= Y.

% Kuzyn
kuzyn(X, Y) :-
    rodzic(Z, X), rodzic(W, Y), rodzenstwo(Z, W).

% Dziadek od strony ojca
dziadek_od_strony_ojca(X, Y) :-
    ojciec(Z, Y), ojciec(X, Z).

% Dziadek od strony matki
dziadek_od_strony_matki(X, Y) :-
    matka(Z, Y), ojciec(X, Z).

% Dziadek
dziadek(X, Y) :-
    mezczyzna(X), (dziadek_od_strony_ojca(X, Y); dziadek_od_strony_matki(X, Y)).

% Babcia
babcia(X, Y) :-
    kobieta(X), (matka(Z, Y), matka(X, Z);
                 ojciec(Z, Y), matka(X, Z)).

% Wnuczka
wnuczka(X, Y) :-
    kobieta(X), (matka(Y, Z), rodzic(Z, X)).

% Przodek do 2 pokoleń wstecz
przodek_do2pokolenia_wstecz(X, Y) :-
    rodzic(X, Z), (dziadek(Z, Y); babcia(Z, Y)).

% Przodek do 3 pokoleń wstecz
przodek_do3pokolenia_wstecz(X, Y) :-
    rodzic(Z, Y), przodek_do2pokolenia_wstecz(X, Z).

