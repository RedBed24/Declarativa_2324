:- discontiguous interpretacion/3. % la definición de interpretación estará separada (x-equivalente y la que introduzca el usuario)
:- multifile interpretacion/3. % multifile porque queremos mantener la interpretación x-equivalente
:- dynamic interpretacion_operadores/3. % dynamic sólo se queda con la última definición
:- dynamic dominio/1.

%% DEFINICIÓN SINTÁCTICA DE LOS OPERADORES
:-op(300, fy, [~]).
:-op(400, yfx, [^]).
:-op(450, yfx, [\/]).
:-op(700, xfy, [=>]).
:-op(700, xfy, [<=>]).

%% DEFINICIÓN SEMÁNTICA DE LOS OPERADORES
:- [semantica_operadores].

%%
interpretacion(X, 0, X). % x-equivalente

%% DEFINICIÓN DE VALORACIÓN
% - Variables
% - Constantes
% - Término general (functor)
valoracion(X, Valor) :- var(X), dominio(D), member(Valor, D).
valoracion(X, Valor) :- atomic(X), interpretacion(X, 0, Valor).
valoracion(X, Valor) :- compound(X), functor(X, Functor, NArgs), X =.. [Functor| Args],
interpretacion(Functor, NArgs, Functor_Interpretado), valoracion_lista(Args, Args_Interpretados),
Funcion =.. [Functor_Interpretado| Args_Interpretados], call(Funcion, Valor).

% valoracion_lista(+Terminos, -Terminos_Interpretados)
valoracion_lista([], []).
valoracion_lista([H|C], [H_interpretada|C_intepretados]) :- valoracion(H, H_interpretada), valoracion_lista(C, C_intepretados).


%% DEFINICIÓN EVALUACIÓN
% - Fórmulas atómicas
% - Fórmulas con operador
% - Fórmulas con "forAll"
% - Fórmulas con "exists"
evaluacion(Formula, _):- 
    ((\+compound(Formula)) -> throw(error('El termino no es compuesto: ~w',  [Formula])), true).

% - Fórmulas atómicas
evaluacion(Formula, Valor) :- functor(Formula, Relator, NArgs), Formula =.. [Relator| Args],
interpretacion(Relator, NArgs, Relator_Interpretado), valoracion_lista(Args, Args_Interpretados),
Relation =.. [Relator_Interpretado| Args_Interpretados],
((\+ground(Formula)) -> throw(error('La formula no es cerrada: ~w', [Formula])); true), 
call(Relation, Valor).

% - Fórmulas con operador
evaluacion(Formula, Valor) :- functor(Formula, Operador, NArgs), Formula =.. [Operador| Args],
interpretacion_operadores(Operador, NArgs, Operador_Interpretado), evaluacion_lista(Args, Args_Evaluados),
Relation =.. [Operador_Interpretado| Args_Evaluados],
((\+ground(Formula)) -> throw(error('La formula no es cerrada: ~w', [Formula])); true),
call(Relation, Valor).


% - Fórmulas con "forAll"
evaluacion(Formula, Valor) :- Formula =.. [forAll, Variable, Expresion],
((at_least_one(Variable, Expresion, f), Valor = f, !); Valor = v, !).

% - Fórmulas con "exists"
evaluacion(Formula, Valor) :- Formula =.. [exists, Variable, Expresion],
(at_least_one(Variable, Expresion, v), Valor = v, !; Valor = f, !).

at_least_one(Variable, Expresion, Valor) :- 
valoracion(Variable, Elemento), copy_term([Variable], Expresion, [Copied_Var], Copied_expresion), 
Copied_Var = Elemento, evaluacion(Copied_expresion, Valor), !.


% evaluacion_lista(+Terminos, -Terminos_Evaluados)
evaluacion_lista([], []).
evaluacion_lista([H|C], [H_evaluada|C_evaluados]) :- evaluacion(H, H_evaluada), evaluacion_lista(C, C_evaluados).

