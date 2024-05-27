%% USUARIO

% dominio(Dominio)
dominio([0, 1, 2, 3]).

% interpretacion(Simblo, Aridad, Elemento)
interpretacion(a, 0, 1).
interpretacion(b, 0, 2).
interpretacion(doble, 1, significado_doble).
interpretacion(par, 1, significado_par).

% functores
significado_doble(0, 0).
significado_doble(1, 2).
significado_doble(2, 0).
significado_doble(3, 2).

% relatores
significado_par(0, v).
significado_par(1, f).
significado_par(2, v).
significado_par(3, f).
