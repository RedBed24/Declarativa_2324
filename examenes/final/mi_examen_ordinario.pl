% l2c pasa de la notación de prolog de lista a notación con functores
l2c([], nil).
l2c([E|L], c(E, C)) :- l2c(L, C).

% al contrario que el anterior
c2l(nil, []).
c2l(c(E, C), [E|L]) :- c2l(C, L).

% hace lo mismo pero usando reduce
l2cr(L, C) :- reduce(r, nil, L, C).
% predicado ayudante para el reduce, es el "reductor"
% reductor(Elemento, Base, Resultado)
r(E, B, c(E, B)).

% definición de reduce
reduce(_, B, [], B).
reduce(Red, B, [E|L], Res) :- reduce(Red, B, L, Part), ToCall =.. [Red, E, Part, Res], ToCall.
% ToCall forma el predicado a llamar, debe ser algo como Red(E, Part, Res)

