% Fakty
ojciec(jan, anna).
ojciec(jan, piotr).
ojciec(tomasz, dawid).
ojciec(krzysztof, tomasz).
ojciec(krzysztof, jan).
matka(maria, anna).
matka(maria, piotr).
matka(justyna, dawid).
malzenstwo(jan, maria).
malzenstwo(tomasz, justyna).
mezczyzna(jan).
mezczyzna(piotr).
mezczyzna(tomasz).
kobieta(maria).
kobieta(anna).
kobieta(justyna).

% Reguły
przodek(X, Y) :- ojciec(X, Y).
przodek(X, Y) :- matka(X, Y).
przodek(X, Y) :- (ojciec(X, Z); matka(X, Z)), przodek(Z, Y).
rodzic(X, Y) :- ojciec(X, Y).
rodzic(X, Y) :- matka(X, Y).
brat(X, Y) :- mezczyzna(X), ojciec(Z, X), ojciec(Z, Y), X \= Y.
siostra(X, Y) :- kobieta(X), ojciec(Z, X), ojciec(Z, Y), X \= Y.
kuzyn(X, Y) :- rodzic(A, X), rodzic(B, Y), siostra(A, B).
kuzyn(X, Y) :- rodzic(A, X), rodzic(B, Y), brat(A, B).

?- przodek(jan, anna). %true
?- brat(piotr, anna). %true
?- kuzyn(X, piotr). %X = dawid
