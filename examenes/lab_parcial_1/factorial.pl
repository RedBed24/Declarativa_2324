%% factP1(+N, -F) que devuelva el factorial F de un numero N, ambos en notacion de Peano.

factP1(0,suc(0)).
factP1(suc(N),F) :- factP1(N,F2), multiplicacion(suc(N),F2,F).

%% multiplicacion(+N, +M, -Resultado)
multiplicacion(0, _, 0).
multiplicacion(suc(N), M, R) :- multiplicacion(N, M, RMult), suma(RMult, M, R).

%% suma(+N, +M, -Resultado)
suma(0, N, N).
suma(suc(N), M, suc(R)) :- suma(N, M, R).

%% no es inversible