:- dynamic fichero_cargado/1.

:- [evaluador].
:- initialization(main).
:- [interpretacion].
fichero_cargado("interpretacion.pl").

main :-
    menu,
    read(Opcion),
    procesar_opcion(Opcion).

menu :- 
    write('\n==================================================='),nl,
    write('== Evaluador de formulas logicas de primer orden =='), nl,
    write('==================================================='),nl,
    write('0. Cargar una interpretacion'), nl,
    write('1. Ver interpretacion cargada'), nl,
    write('2. Evaluar una formula'), nl,
    write('3. Ayuda'), nl,
    write('4. Exit'), nl,
    write('Seleccione una opcion: ').

borrar_interpretacion:- fichero_cargado(Fichero), retractall(fichero_cargado(_)), unload_file(Fichero).

mostar_error(error(Msg, Args)):-
    (Msg=existence_error(_, F) -> format('Error, no existe definicion para: ~w',[F]),nl);
    format(Msg, Args), nl.

cargar_fichero(Fichero):- exists_file(Fichero), !, borrar_interpretacion,
    consult(Fichero),
    assertz(fichero_cargado(Fichero)),
    write('Interpretacion cargada').
cargar_fichero(_):- write('El fichero no existe').

procesar_opcion(Opcion):- Opcion=0, !,
    write('\n========= INTERPRETACION ========='), nl,
    write('Introduce el nombre del fichero ("nombre.pl"):'), 
    read(Fichero), cargar_fichero(Fichero), nl,
    main.

procesar_opcion(Opcion):- Opcion = 1, !, 
    write('\n===== INTERPRETACION CARGADA ====='),nl, 
    fichero_cargado(Fichero), write('Fichero: '), write(Fichero), nl, 
    dominio(D), write('Dominio: '), write(D), nl,
    findall(X, (interpretacion(X, 0,_), nonvar(X)), Xs), write('Constantes: '), write(Xs), nl,
    findall(Y, (interpretacion(Y, N,_), N\=0), Ys), write('Simbolos de funcion y de relacion: '), write(Ys), nl,
    main.

procesar_opcion(Opcion):- Opcion=2, !, 
    write('\n============ EVALUACION ============'), nl,
    write('Introduce la formula a evaluar'), read(Formula), 
    (catch(evaluacion(Formula, V), Error, mostar_error(Error)),
        write('Resultado de la evaluacion: '), (nonvar(V), write(V) ; write('ERROR')), nl % Imprime el valor de V
    ;   
        write('Consulta no valida'), nl
    ),
    main. 

procesar_opcion(Opcion):- Opcion = 3, !, 
    write('\n============ AYUDA ============'),nl,
    write('Para introducir informacion al programa: Acabar las sentencias con "."'), nl, nl,
    write('CUANTIFICADORES:'), nl,
    tab(4),write('forAll(Variable, Formula)    --> Predicado para definir el cuantificador universal'), nl,
    tab(4),write('exists(Variable, Formula)    --> Predicado para definir el cuantificador existencial'), nl,
    write('CONECTIVAS:'), nl,
    tab(4), write('~   negacion'), nl,
    tab(4), write('^   conjuncion'), nl,
    tab(4), write('\\/  disyuncion'), nl,
    tab(4), write('=>  condicional'), nl,
    tab(4), write('<=> bicondicional'), nl,
    write('Introduce cualquier letra para volver al menu '), read(_),
    main.

procesar_opcion(Opcion):- Opcion = 4,  write('\nSaliendo...'), halt.

procesar_opcion(_):- 
    write('Opcion no valida'),nl, main.

