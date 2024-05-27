% interpretacion_operadores(Operador, Aridad, Significado)
interpretacion_operadores(~, 1, negacion).
interpretacion_operadores(^, 2, conjuncion).
interpretacion_operadores(\/, 2, disyuncion).
interpretacion_operadores(=>, 2, condicional).
interpretacion_operadores(<=>, 2, bicondicional).

negacion(v, f).
negacion(f, v).

conjuncion(v, v, v).
conjuncion(v, f, f).
conjuncion(f, v, f).
conjuncion(f, f, f).

disyuncion(v, v, v).
disyuncion(v, f, v).
disyuncion(f, v, v).
disyuncion(f, f, f).

condicional(v, v, v).
condicional(v, f, f).
condicional(f, v, v).
condicional(f, f, v).

bicondicional(v, v, v).
bicondicional(v, f, f).
bicondicional(f, v, f).
bicondicional(f, f, v).
