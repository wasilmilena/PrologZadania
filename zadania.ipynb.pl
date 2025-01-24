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


%Fakty
lotnisko(warszawa).
lotnisko(krakow).
lotnisko(gdansk).
lotnisko(poznan).
polaczenie(warszawa, krakow, 300).
polaczenie(krakow, gdansk, 200).
polaczenie(warszawa, gdansk, 500).
polaczenie(warszawa, poznan, 150).
polaczenie(poznan, gdansk, 350).
polaczenie(krakow, warszawa, 300).
polaczenie(gdansk, krakow, 200).
polaczenie(gdansk, warszawa, 500).
polaczenie(gdansk, poznan, 350).
polaczenie(poznan, warszawa, 150).

%Reguły
polaczenie(X, Y) :- polaczenie(X, Y, _).
koszt_podrozy(X, Y, C) :- polaczenie(X, Y, C).
droga(X, Y, Trasa, C) :- droga(X, Y, [X], Trasa, C).
droga(X, Y, TrasaSoFar, Trasa, C) :- polaczenie(X, Y, C), reverse([Y|TrasaSoFar], Trasa).
droga(X, Y, TrasaSoFar, Trasa, C) :-
    polaczenie(X, Z, C1),
    Z \= Y,
    \+ member(Z, TrasaSoFar),
    droga(Z, Y, [Z|TrasaSoFar], Trasa, C2),
    C is C1 + C2.
najkrotsza_droga(X, Y) :-
    setof((C, Trasa), droga(X, Y, Trasa, C), [(Koszt, NajkrotszaTrasa)|_]),
    write('Najkrótsza droga z '), write(X), write(' do '), write(Y), nl,
    write('Trasa: '), write(NajkrotszaTrasa), nl,
    write('Koszt: '), write(Koszt), write(' PLN'), nl.

?- polaczenie(warszawa, krakow). %true
?- koszt_podrozy(warszawa, gdansk, C). %C = 500
?- najkrotsza_droga(warszawa, gdansk).
%Najkrótsza droga z warszawa do gdansk
 Trasa: [warszawa, gdansk]
 Koszt: 500 PLN
 

 
