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

 %Fakty
produkty([produkt(tv, 10, sektor_a),
          produkt(pralka, 5, sektor_b),
          produkt(lodowka, 3, sektor_c)]).
%Reguły
dostepny_produkt(X) :- produkty(Produkty), member(produkt(X, Ilosc, _), Produkty), Ilosc > 0.
przenies_produkt(X, NowySektor, NowaLista) :-
    produkty(Produkty),
    delete(Produkty, produkt(X, Ilosc, _), TymczasowaLista),
    append(TymczasowaLista, [produkt(X, Ilosc, NowySektor)], NowaLista).
uzupelnij_stan(X, DodanaIlosc, NowaLista) :-
    produkty(Produkty),
    member(produkt(X, Ilosc, Sektor), Produkty),
    NowaIlosc is Ilosc + DodanaIlosc,
    delete(Produkty, produkt(X, Ilosc, Sektor), TymczasowaLista),
    append(TymczasowaLista, [produkt(X, NowaIlosc, Sektor)], NowaLista).

?- dostepny_produkt(tv). %true
?- przenies_produkt(tv, sektor_b, NowaLista). %NowaLista = [produkt(pralka,5,sektor_b), produkt(lodowka,3,sektor_c), produkt(tv,_,sektor_b)]
?- uzupelnij_stan(pralka, 3, NowaLista). %NowaLista = [produkt(tv,10,sektor_a), produkt(lodowka,3,sektor_c), produkt(pralka,8,sektor_b)]
     %Fakty:
miasto(warszawa).
miasto(krakow).
miasto(poznan).
droga(warszawa, krakow, 4).
droga(krakow, poznan, 3).
droga(warszawa, poznan, 7).

% Reguły:
droga(X, Y) :- droga(X, Y, _).
droga(X, Y) :- droga(Y, X, _).
czas_przejazdu(X, Y, T) :-
    droga(X, Y, T).
czas_przejazdu(X, Y, T) :-
    droga(X, Z, T1),
    czas_przejazdu(Z, Y, T2),
    T is T1 + T2.
najkrotsza_trasa(X, Y) :-
    findall(T, czas_przejazdu(X, Y, T), ListaCzasow),
    min_list(ListaCzasow, NajkrotszyCzas),
    format('Najkrótszy czas przejazdu: ~w', [NajkrotszyCzas]).
?- droga(warszawa, krakow). %true
?- czas_przejazdu(warszawa, poznan, T). %T = 7
?- najkrotsza_trasa(warszawa, poznan). %Najkrótszy czas przejazdu: 7 true
     % Fakty

ksiazka('W pustyni i w puszczy', sienkiewicz, przygodowa).
ksiazka('Hobbit', tolkien, fantasy).
ksiazka('Pan Tadeusz', mickiewicz, poezja).
ocena(uzytkownik1, 'W pustyni i w puszczy', 5).
ocena(uzytkownik1, 'Hobbit', 4).
ocena(uzytkownik1, 'Pan Tadeusz', 3).
preferencje(uzytkownik1, fantasy).

%Reguły
polecane_ksiazki(Uzytkownik, Gatunek) :-
    preferencje(Uzytkownik, Gatunek),
    findall(Tytul, (ksiazka(Tytul, _, Gatunek),
                    ocena(Uzytkownik, Tytul, Ocena),
                    Ocena >= 4),
            Ksiazki),
    list_to_set(Ksiazki, KsiazkiUnikalne),
    write(KsiazkiUnikalne).
?- polecane_ksiazki(uzytkownik1, fantasy). %['Hobbit'] true
     


 
