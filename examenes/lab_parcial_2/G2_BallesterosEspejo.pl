%% EJERCICIO 1

%% digitos en ASCII -> [48-57]
digitos([48,49,50,51,52,53,54,55,56,57]).
extraer_numeros(NombreFichero, ListaNumeros):- see(NombreFichero), extraer(ListaNumeros), seen.

saltar_caracteres(Char):- get0(C), digitos(D),
((
    (member(C, D); C = -1), Char=C)
    ; 
    (saltar_caracteres(Char)), !).

get_numero(CharList, Num):- get0(C), digitos(D),
((member(C,D), append(CharList, [C], NC), get_numero(NC, Num), !)
; 
    number_codes(Num, CharList)
).

extraer(ListaNumeros):- acc_lista([],ListaNumeros). 
    
acc_lista(L, LN):- saltar_caracteres(Char), ((Char = -1, LN=L, !); get_numero([Char], Num), append(L,[Num], AccLista), acc_lista(AccLista, LN), !).


% tree2Term(Tree, Term) dado un arbol, lo transforma en un termino
tree2Term(nil, _) :- write("No se puede representar un arbol vacio"), !.
tree2Term(hoja(T), T) :- atomic(T); var(T).
tree2Term(nodo(F, Nodos), Term) :-
    tree2termArgs(Nodos, Args),
    Term =.. [F | Args].

% tree2termArgs(TreeList, TermList)
tree2termArgs([], []).
tree2termArgs([nil | T],  Args) :-
    tree2termArgs(T, Args), !.
tree2termArgs([H | T], [Arg | Args]) :-
    tree2Term(H, Arg),
    tree2termArgs(T, Args).
