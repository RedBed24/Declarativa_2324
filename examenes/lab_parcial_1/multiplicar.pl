%% multiplicar (+A,-P) A es un arbol nario de enteros. P es producto de multiplicar todos los enteros de los nodos
%% multiplicar(nodo(4,  [nodo(3, [hoja(2)]), nodo(5, [hoja(1), nil]) ]), P).

multiplicar(nil, 1).
multiplicar(hoja(X), X).
multiplicar(nodo(E, Lista), X):- multiplicarLista(Lista, XL), X is E*XL, !.
multiplicarLista([E], X):- multiplicar(E, X).
multiplicarLista([H|T], X):- multiplicar(H, XH), multiplicarLista(T, XT), X is XH*XT.