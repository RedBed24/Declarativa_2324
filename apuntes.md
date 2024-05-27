---
title: Seminario Prolog
author: Samuel Espejo Gil
abstract: |
  Notas tomadas durante el seminario de prolog dado al principio de curso.
  No se debe asumir que todo lo escrito aquí es correcto, es posible que cuente con fallos.
  Cuenta tanto con teoría como con práctica.
date: Curso 23/24
lang: es-ES
---

# Prolog y Lisp

Cada uno se usa para programación Lógica y Funcional respectivamente, ambos antiguos.

Prolog usa cláusulas normales y de Horn.

> Sus instrucciones son fórmulas lógicas de primer orden.

Intérprete escrito en fortran.
Lento, poco eficiente.
Pero notable en IA.
No hay distinción entre instrucciones y datos, lo que permite que el programa mute a lo largo de su ejecución.

Se modifica el programa en tiempo de ejecución, por lo que pueden variar la forma en la que actúan, muy interesante para IA.

Interesa hacer un tratamiento del lenguaje natural.

La IA antes era simbólica.
Debido a la potencia de cálculo.
Ahora es orientación a redes neuronales.

Prolog va a lo simbólico.
Especialmente adaptado para manipular símbolos y el rápido prototipado.
Y especificación de los problemas.

> Especificación ejecutable.

Instrucciones son cláusulas de Horn, de lógica de primer órden.

La operación es mediante resolución SLD.

Para entender un imperativo, tienes que convertirte en ordenador y ejecutarlo.
En declarativa no, la semántica te permite entender sin ejecutar.

<!-- No todo es perfecto -->
Para una semántica eficiente, se hacen concesiones.

Un programa es un conjunto de premisas.

> Tú metes unas premisas, la especificación del problema y un motor de inferencia da pasos de deducción y te verifica una conclusión.

Especificas un problema y haces preguntas.
Esas preguntas son las conclusiones que quiero obtener.
Una posible conclusión, prolog, te indica si hay una deducción de las premisas a la conclusión.

*Assert* y *retract* te permiten modificar en tiempo de ejecución el programa.

## Prolog puro

Sin añadidos a la lógica.

| Símbolo | Significado | Prolog |
| :-- | :-- | :-- |
| $\land$ | Conjunción | , |
| $\lor$ | Disjunción | ; |
| $\leftarrow$ | Condicional recíproco | :- |
| $\lnot$ | Negador | \+, not |
| $\rightarrow$ | | ?- |

Cláusula de Horn:

$$P(x) \leftarrow Q(x) \land R(x)$$

> P(x) si Q(x) y R(x)

```Prolog
p(X) :- q(X),r(X)
```

- Las variables comienzan en mayúscula.
- Las relaciones comienzan con minúsculas.
- Las relaciones permiten identificadores: "[a-zA-Z0-9_]*"

Cabeza, formada por una fórmula atómica únicamente.
Cuerpo, formado por varias fórmulas atómicas.

Definición de número natural de Peano:

```Prolog
% el 0 es natural
natural(cero).
% el sucesor de N es natural si N es natural
natural(succ(N)) :- natural(N).
```

## Sintaxis

$$H \leftarrow B.$$

Donde H es Head y B, Body.
Tal que Head es una fórmula atómica y Body una conjunción de literales.

Fórmula atómica: Símbolo de relación aplicado sobre términos: ej: P(x), x es el término.
Literales: Una fórmula atómica o negación de esta.

Esto define las relaciones entre cuerpo y cabeza.

### Reglas

Cláusulas de Horn o cláusulas normales.

Horn no permiten negaciones.
Sólo un literal positivo.

Esto es porque la semántica operacional que se puede emplear es más eficiente que una general.

### Hechos

Sólo la cabeza.

## Qué es un programa prolog

Son las premisas de un argumento aquello que creo que es verdad.

Esto:

$$p \leftarrow q, r, s$$

Se puede entender como:

```Ada
procedure p
begin
 q
 r
 s
end
```

> Programar en prolog es decir qué son las cosas.

## Debuging

```Prolog
listing(regla).
```

Todo lo que no está declarado es falso.
No puedes poner explícitamente que algo es falso.

## Uso

```Prolog
hombre(X).
```

> ¿Existe algún X que es hombre?

| Sí, X = abraham o
| Sí, X = haran o
| ...

```Prolog
hemano(yo, yo).
```

Esto debe dar no, por lo que añadimos: `X \== Y`

Se sobre entiende el $\forall$ en las cláusulas.

## Principio de inducción matemática

Si se cumple para el primero, y se cumple para n y n+1, entonces, se cumple para todos.

## Peano

```Prolog
not(s(n)=cero).
```

Esto es imposible, no se pone explícitamente.

Sii, se desprecia, sólo nos quedamos con si.

La notación de peano es la siguiente:

```Prolog
% el 0 es natural
natural(cero).
% el sucesor de N es natural si N es natural
natural(s(N)) :- natural(N).
```

Se usa $s(N) = N + 1$.

Con esto podemos definir:

```Prolog
% caso base
equal(cero, cero).
equal(s(M), s(N)) :- equal(N, M).
```

= se cumple para 0, se cumple para N, se cumple para N+1.

Es una definición inductiva.

> Inductivo en matemáticas significa recursivo en programación.

1. ¿Qué significa la igualdad para el primero?
2. ¿Qué significa la igualdad para cualquiera?

Prolog puro es un lenguaje de primer orden, no se pueden hacer cuatificaciones sobre relaciones.

Prolog sólo escribe relaciones, las que son verdaderas, pero simula funciones:

$$+: \mathbb{N} \times \mathbb{N} \rightarrow \mathbb{N}$$

Pasaría a:

$$sum: \mathbb{N} \times \mathbb{N} \times \mathbb{N} \rightarrow bool$$

Donde la última n nos sirve como salida.
Como ejemplo:

$$s(n) + m = s(n + m)$$

```Prolog
sum(cero, N, N).
% la suma del sucesor(n) + M es sucesor(R) si la suma de n + m es r
sum(s(N), M, s(R)) :- sum(N, M, R).
```

ESTO ES CAPAZ DE RESTAR, EN VEZ DE PREGUNTARLE POR EL RESULTADO, LE PREGUNTAS POR N O M.

## Listas

Se crean con los constructores:

- nil
- conc/2

conc recibe 2 parámetros, un elemento y una lista.

```Prolog
is_list(nil).
is_list(conc(X, L)) :- is_list(L).
```

Al final, todos los datos son términos.

Pero esto, es un poco poco práctico, en prolog se definen:

- `[]`
- `[|]`

```Prolog
is_list([]).
is_list([X|Xs]) :- is_list(Xs).
```

Puedes crear una lista:

```Prolog
[a | []]
```

Pero tenemos *syntatic sugar*:

```Prolog
[a]
[a, b]
[X|Xs] = [a, b, c, d].
X = a,
Xs = [b, c, d].
```

```Prolog
% Qué significa concatenar una lista vacía a otra lista con Y's?
% app([], Ys, ?)
app([], Ys, Ys).
% pues concatenar una vacía a otra, da la propia
% Es cierto que concatenar una vacía a otra, da la propia

% Qué significa concatenar una lista genérica a otra lista?
% app([X|Xs], Ys, ?)
app([X|Xs], Ys, [X|Zs]) :- app(Xs, Ys, Zs).
% es cierto que concatenar una lista con cabeza X y otras Xs a otra lista Ys es la cabeza, con una lista Zs SI es verdad que esa Zs es la concatenación de el resto de elementos (Xs) con Ys
```

```Prolog
% app(Lista1, Lista2, resultado)
% Esto es un hecho, no tiene condiciones
% es cieto que la concatenación de una lista vacía a otra es la lista
app([], X, X).
% una lista con un primer elemento X seguido de otros elementos Xs
% es verdad que concatenar una lista con Xs a Y
% será una lista que tiene ese primer elemento X con otros elementos Zs
% que eventualmente serán los de Y
% siempre que sea verdad que concatenar Xs a Y es Zs
app([X | Xs], Y, [X, Zs]) :- app(Xs, Y, Zs).
% para resolver la cabeza, hay que resolver el cuerpo, hacer una llamada al cuerpo
% cada regla es un caso de un procedimiento
```

Un `=` es un *enlace*, que se debe mantener durante una computación, no puede cambiar.
No es exactamente una asignación ni una igualdad.
Es más parecido al *igual* de mates que de programación.

%% Parciales

L es una *variable*, podemos trabajar con ella como si fuese una lista:

```Prolog
append([a, b], [c|L], X).
X = [a, b, c|L]
```

```Prolog
% long(+L, -N): N es la longitud de la lista L
% + indica entrada, - salida
long([], 0).
long([X|Xs], L) :- long(Xs, L'), L is L' + 1.
% lo importante es la RELACIÓN entre L y L':
```

Este programa no es inversible ya que no es púramente lógica, tiene aritmética. `L is L' + 1`.

La inversibilidad se pierde con entraña, cortes y aritmética.

```Prolog
length(L, 4).
% Existe una lista con longitud 4?
% te devuelve una lista de 4 elementos indeterminados
% los elementos son variables, porque empiezan con _
```

Salvo que se diga explícitamente, se puede usar los predicados de una librería.
Ver swipl "library(lists)".

Reverse de lista:

```Prolog
rev([], []).
rev([X|Xs], Ys) :- rev(Xs, IXs), append(IXs, [X], I).
% pero no es eficiente, se verá en las prácticas.
```

### Miembro

Mi implementación.

```Prolog
% esto es necesario?
mem(X, [X]).
mem(X, [Y|Ys]):- X is Y; mem(X, Ys).
```

La negación no es pura lógica, se implementa con el corte.
Además, usar fail también elimina la inversibilidad.

```Prolog
% esto es para especificar que es falso, se usa para forzar el fallo.
mem(X, []) :- fail.

% es miembro de la lista si X e Y unifican
mem(X, [Y|Ys]):- X = Y.
mem(X, [Y|Ys]):- X \= Y, mem(X, Ys).
```

```Prolog
% La comprobación de la unificación es más eficiente si la hacemos en la cabeza.
% X es miembro de la lista si X está en la lista de la cabeza.
% es algo como lo he intentado hacer yo
mem(X, [X|Xs]).
mem(X, [Y|Ys]):- mem(X, Ys).
% los puedes ver como una disyunción y sale algo más parecido a lo que he hecho yo
```

```Prolog
% el elemento U es el último de una lista L si
% la Lista se obtiene de añadir (al final) una lista [U] a otra cualquiera
ultimo(U, L) :- append(_, [U], L).
```

Cuando se utiliza `_`, se usa como una variable anónima, el sistema no da información respecto a esa variable.

## Árboles

Ahora definiremos árboles binarios, con 3 constructores:

1. nil/0
2. hoja/1
3. arbol/3

1 y 2 son árboles binarios, el 3 también, si sus hijos lo son.

```Prolog
arbol_bin(nil).
arbol_bin(hoja(_)).
arbol_bin(arbol(L, _, R)) :- arbol_bin(L), arbol_bin(R).

% puedes crear un árbol como:
% nil

% hoja(_), estos dos son iguales
% arbol(nil, _, nil), estos dos son iguales, son "sinónimos"

% arbol(hoja(_), _, nil), estos igual
% arbol(arbol(nil, _, nil), _, nil)
```

### Frontera

```Prolog
% frontera(+A, -L): cierto si L es una lista que contiene las hojas de A
frontera(nil, []).
frontera(hoja(X), [X]).
frontera(arbol(L, _, R), F) :- frontera(L, Fl), frontera(R, Fr), append(Fl, Fr, F).
frontera(arbol(nil, X, nil), [X]).
```

Curiosidad, no se está usando arbol_bin en frontera.

### Peso

Es el número de nodos que tiene.

```Prolog
peso(nil, 0).
peso(hoja(_), 1).
peso(arbol(L, _, R), P) :- peso(L, Pl), peso(R, Pr), P is Pl + Pr + 1.
```

### Profundidad

```Prolog
profundidad(nil, 0).
profundidad(hoja(_), 0).
profundidad(arbol(L, _, R), P) :- profundidad(L, Pl), profundidad(R, Pr), max(Pl, Pr, M), P is M + 1.
```

Pero `max` no está definido...

### Balanceado

```Prolog
balanceado(nil).
balanceado(hoja(_)).
balanceado(arbol(L, _, R)) :- profundidad(L, Pl), profundidad(R, Pr), D = Pl - Pr, abs(D, A), A < 2.
```

Pero `abs` no está definido...

### Completo

```Prolog
completo(hoja(_)).
completo(arbol(L, _, R)) :- completo(L), completo(R).
```

### Ordenado

```Prolog
ordenado(hoja(_)).
ordenado(arbol(L, E, R)) :- ordenado()
```

### Búsqueda

```Prolog
% busqueda(+arbol, +E) true si E se encuentra en arbol
busqueda(hoja(E), E).
busqueda(arbol(_, E, _), E).
busqueda(arbol(L, A, R), E) :- E < A, busqueda(L, E).
busqueda(arbol(L, A, R), E) :- E > A, busqueda(R, E).
```

## Grafos

```Prolog
camino(X, Y) :- conexion(X, Y).
camino(X, Y) :- conexion(X, Z), camino(Z, Y).
```

Para usar esto, tendremos que especificar hechos con conexiones entre elementos.
Es importante indicar que las conexiones son dirigidas de X a Y.

Si quermos guardalo en una lista, podemos hacerlo como:

```Prolog
camino(I, F, [I|F]) :- conexion(I, F).
camino(I, F, [I|C]) :- conexion(I, Z), camino(Z, F, C).
```

Y esto sirve porque no tiene ciclos.
Porque no comprueba por los caminos que ha pasado, si queremos añadir esto, necesitamos mantener información de por dónde hemos pasado.
Para ello, se usan *parámetros acumuladores*.

```Prolog
% se introduce una regla intermedia
camino(I, F) :- camino(I, [], F).

% se define esta regla intermedia
camino(I, Visitados, F) :- conexion(I, F).
camino(I, Visitados, F) :- conexion(I, Z), \+member(Z, Visitados), camino(Z, [Z|Visitados], F).

% camino(I, Visitados, F) :- \+member(I, Visitados), conexion(I, Z), camino(Z, [I|Visitados], F). ???
% este depende de si se ha añadido antes I
```

Determinismo se dice cuando para un objetivo, hay un único resultado.

## Autómatas

```Prolog
final(s4).

% transiciónes que cambian de estado
transicion(s1, a, s2).
transicion(s2, c, s4).
transicion(s2, b, s3).
transicion(s3, c, s4).

% ciclos, se indican al final, porque el orden importa
transicion(s1, a, s1).
transicion(s1, b, s1).
transicion(s2, b, s2).

acepta(Estado, []) :- final(Estado).
acepta(Estado, [C|Resto]) :- transicion(Estado, C, Estado'), acepta(Estado', Resto).
```

## Aritmética

$$a * b mod c = a * (b mod c)$$

```Prolog
X is 10
```

El operador `is` fuerza a hacer cálculo, comparar las expresiones.
Si la expresión de la izquierda es una variable, liga/linka.

```Prolog
% A es igual a B, cuando a y b son expresiones numéricas
A =:= B
% =\=
% La negación, se especifica con `\`.

% Igualdad sintáctica, las 2 expresiones son iguales sintácticamente
A == B
% \==

% Unificar
A = B
% \=
```

Cuando se pone algo que empieza por minúscula, se entiende que es un *átomo*.

El proceso de unificar hace que las variables tomen valores.
Se busca una sustitución de valores por variables.
Estos valores deben cumplir la igualdad, para las variables dadas, si no, fallará.

La negación se define en términos del corte, sirve para eliminar computaciones que no conducen a una respuesta.

## IO

### Ficheros

Strings de chars.

1. Current Input Stream: stdin
2. Current Output Stream: stdout

Ambos se denominan "*user*"

Para nombrar los ficheros, se aplican las mismas normas que los identificadores (constantes, variables, función...).

Se puede abrir, realizar operaciones de lectura y escritura y crear un fichero.

Standar edimbourgh.
Aunque también existe el ISO.

Esto sólo permite o entrada o salida exclusivamente.
A excepción de `user`.

#### Predicados IO

1. Siempre true.
2. No se resatisfacer.

   > Una vez y ya, no puedes volver a atrás y hacer una acción diferente.

3. Efectos laterales: IO de char.

##### Lectura

- `see(Fich)`: abrir
- `seeing(Fich)`: preguntar cuáles estamos viendo
- `seen`: cerrar
- `get0(Char)`: leer un código hexchar
- `get(Char)`: sólo lee caracteres imprimibles
- `skip(X)`
- `read(Term)`: lee cualquier expresión bien formada que termina en un punto

La lectura de bajo nivel de un EOF es -1, mientras que en alto, como con read, es end_of_file.

##### Escritura

- `tell(Fich)`: abrir
- `nl`: new line
- `tab(Num)`: escribe un número de espacios

## Computación simbólica

Es capaz de evaluar:

1. variables, aunque hay que tener cuidado, las variables linkadas no cuentan, lo que verdaderamente pregunta es si está enlazada o no.
2. no variables
3. atom o átomos, es decir, constantes
4. integers
5. `atomic(X) :- constante(X); integer(X). % , not atom(X)`, puede comprobar variables, para las que dará true si están enlazadas con lo correspondiente.
6. `compound(Term)`: comprueba si es un "término general", como por ejemplo: `f(X, a)`, pero no `a` ni `A`.

Un objeto estructurado es algo como:

- `f(X, a)`
- `f(g(h(X, a)), b)`

Estos pueden jugar como registros en otros lenguajes:

- `Persona(Nombre, Dni, Edad, ...).`

> Cualquier cosa entrecomillada simple es un átomo.

Un entrecomillado doble es un string, que no cuenta como atom, pero sí como atomic.

### Construcción de términos

Permiten analizar y generar.

- `functor(?T, +F, ?N)`: dado un término, te indica cuántos parámetros usa:

   ```Prolog
   ?- T = f(a, b), functor(T, F, N).
   T = f(a, b),
   F = f,
   N = 2.
   ```

- `arg(N, T, A)`: dado un término T, con una posición especificada N, te devuelve el parámetro correspondiente a esa posición.

Juntando estos dos últimos puedo crear el término concreto que me de la gana.

- `E =.. L`: E es un término, te lo devuelve todo en una lista L siguiendo el orden:

   ```Prolog
   ?- f(g(b, X), h(a)) =.. L.
   L = [f, g(b, X), h(a)]
   ```

   Es reversible.

> Un término es una constante, una variable o es f(términos...):

#### Definición de término

t es un término sii:

1. t equivalente c donde c $\in$ constantes
2. t equivalente x donde x $\in$ variables
3. t equivalente $f^n(t_1, ..., t_2)$ si f $\in$ Functores y $\forall termino(t_n)$

#### Problema propuesto

```Prolog
% non_var_simbs(+T, -L): Verdadero si L es la lista de símbolos no variables del termino
% f(h(X, b), f(a, Y)) -> [f, h, b, f, a]
non_var_simbs(T, []) :- var(T).
non_var_simbs(T, [T]) :- atomic(T).
non_var_simbs(T, [F|L]) :- compound(T), T =.. [F|Args], non_var_simbs_args(Args, L).

% non_var_simbs_args(+Args, -L): Verdadero si L es una lista de simbolos no variables en la lista de términos Args
non_var_simbs_args([], []).
non_var_simbs_args([T|Args], L):- non_var_simbs(T, Lt), non_var_simbs_args(Args, Lr), append(Lt, Lr, L).
```

