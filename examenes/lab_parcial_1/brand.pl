%%brandN(N, Cube) :- Cube is N * N,
%%            DigitsAprx is log10(Cube),
%%            Digits is ceil(DigitsAprx), % Digits es el número de dígitos del cuadrado
%            Digits mod 2 =:= 0, % el número de dígitos es par
%            HalfDigits is Digits / 2, % HalfDigits es el número de dígitos que forma cada parte
%            Power is 10 ** HalfDigits, % Powr es la potencia de 10
%            N1 is Cube // Power,
%            N2 is Cube mod Power,
%            N is N1 + N2.

brandN(N, Cube):- Cube is N*N, number_chars(Cube, NList), length(NList, Digits), Digits mod 2 =:=0, 
            HalfDigits is Digits / 2, % HalfDigits es el número de dígitos que forma cada parte
            Power is 10 ** HalfDigits, % Powr es la potencia de 10
            N1 is Cube // Power,
            N2 is Cube mod Power,
            N is N1 + N2.

brand(Limit, L):- brand_acc(Limit, [], L).
brand_acc(0, L, L).
brand_acc(N, Acc, L):- N>0, N1 is N-1, brandN(N,_), brand_acc(N1, [N|Acc], L).

brand_acc(N, Acc, L):- N>0, N1 is N-1, \+ brandN(N,_), brand_acc(N1, Acc, L).