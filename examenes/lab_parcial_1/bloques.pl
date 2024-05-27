%% hechos
%% bloque 1
bloque(b1, forma, cuadrado).
bloque(b1, color, purpura).
bloque(b1, tamano, grande).

bloque(b2, forma, rectangulo).
bloque(b2, color, rojo).
bloque(b2, tamano, pequeno).

bloque(b3, forma, rectangulo).
bloque(b3, color, rojo).
bloque(b3, tamano, pequeno).

bloque(b4, forma, triangulo).
bloque(b4, color, azul).
bloque(b4, tamano, mediano).

bloque(b5, forma, rectangulo).
bloque(b5, color, verde).
bloque(b5, tamano, mediano).

bloque(b6, forma, rectangulo).
bloque(b6, color, purpura).
bloque(b6, tamano, grande).

bloque(b7, forma, triangulo).
bloque(b7, color, verde).
bloque(b7, tamano, grande).

bloque(b8, forma, triangulo).
bloque(b8, color, amarillo).
bloque(b8, tamano, pequeno).

bloque(b9, forma, cuadrado).
bloque(b9, color, amarillo).
bloque(b9, tamano, pequeno).

bloque(b10, forma, rectangulo).
bloque(b10, color, verde).
bloque(b10, tamano, pequeno).

bloque(b11, forma, cuadrado).
bloque(b11, color, azul).
bloque(b11, tamano, mediano).

soportado_por(b1, b2). %% b1 esta encima de b2
soportado_por(b1, b3).
soportado_por(b4, b9).
soportado_por(b7, b6).

soportado_por(b9, b5).
soportado_por(b8, b11).

soportado_por(b10, b1).
soportado_por(b11, b10).

i_a_la_izquierda_de(b1, b4). %% b1 esta a la izquierda de b4
i_a_la_izquierda_de(b1, b5).
i_a_la_izquierda_de(b1, b9).

%% 1. Completar los hechos

i_a_la_izquierda_de(b2, b3).


i_a_la_izquierda_de(b3, b4).
i_a_la_izquierda_de(b3, b5).
i_a_la_izquierda_de(b3, b9).



i_a_la_izquierda_de(b4, b6).
i_a_la_izquierda_de(b4, b7).


i_a_la_izquierda_de(b5, b6).
i_a_la_izquierda_de(b5, b7).



i_a_la_izquierda_de(b8, b4).
i_a_la_izquierda_de(b8, b5).
i_a_la_izquierda_de(b8, b9).



i_a_la_izquierda_de(b9, b6).
i_a_la_izquierda_de(b9, b7).


i_a_la_izquierda_de(b10, b4).
i_a_la_izquierda_de(b10, b5).
i_a_la_izquierda_de(b10, b9).



i_a_la_izquierda_de(b11, b4).
i_a_la_izquierda_de(b11, b5).
i_a_la_izquierda_de(b11, b9).

%% TODO:
i_a_la_derecha_de(X, Y).


%% 2. ¿de que color son los bloques que soportan al bloque b1?
% color_soportado(Arriba, Color) :- soportado_por(Arriba, Abajo), bloque(Abajo, color, Color).

%% 3. Lis_Atributos es la lista de atributos del bloque B
%atributos_bloque(B, [Forma, Color, Tamano]) :- bloque(B, forma, Forma), bloque(B, color, Color), bloque(B, tamano, Tamano).

atributos_bloque(B, [Forma, Color, Tamano]) :- setof(A:V, bloque(B, A, V), L).
                                              %setof((A, V), ...)
                                              %setof(informacion(A, V), ...)

%% 4. L es una lista de bloques que están a la derecha de B
%lista_bloques_a_la_der_de(B, [OtroB|L]) :- i_a_la_izquierda_de(B, OtroB), lista_bloques_a_la_der_de(B, L).
a_la_izquierda_de(B, OtroB) :- i_a_la_izquierda_de(B, OtroB).
a_la_izquierda_de(B, OtroB) :- i_a_la_izquierda_de(B, Z), a_la_izquierda_de(Z, OtroB).

lista_bloques_a_la_der_de(B, [OtroB|L]) :- setof(B1, a_la_izquierda_de(B, B1), L).


