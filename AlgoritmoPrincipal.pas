         program TriangulosDecrecientesM;
{$mode objfpc}{$H+}

uses
  SysUtils;

const
  MAX_POR_LOTE = 5;

procedure ImprimirRepetido(caracter: caracterar; n: integer);
                        (*
  PROCEdimensionIENTO ImprimirRepetido(caracter: caracterar; n: integer)

  Qu� hace:
    Imprime en la salida est�ndar (con write) el car�cter `caracter` repetido `n` veces
    seguidas, sin a�adir salto de l�nea al final.

  Precondici�n:
    n >= 0. (Si n = 0 no imprime nada.)

  Postcondici�n:
    En la salida est�ndar se habr�n escrito exactamente `n` apariciones del
    car�cter `caracter` (en la misma l�nea). No modifica variables ni estructuras
    fuera del procedimensioniento.
*)

var
  i: integer;
begin
  for i := 1 to n do
    write(caracter);
end;

procedure ImprimirFilaConEspacios(caracter: caracterar; n: integer);
                (*
  PROCEdimensionIENTO ImprimirFilaConEspacios(caracter: caracterar; n: integer)

  Qu� hace:
    Imprime en la salida `n` veces el car�cter `caracter` separados por un �nico
    espacio entre ellos, sin salto de l�nea al final. Evita dejar un espacio
    adicional al final de la secuencia (si n >= 1).

  Precondici�n:
    n >= 0. (Si n = 0 no imprime nada; si n = 1 imprime solo `caracter`.)

  Postcondici�n:
    En la salida est�ndar se habr� escrito la secuencia:
      caracter[ + ' ' + caracter + ... ]  (n veces caracter y n-1 espacios entre ellos).
    No produce salto de l�nea.
*)
var
  i: integer;
begin
  for i := 1 to n do
  begin
    write(caracter);
    if i < n then write(' ');
  end;
end;

// DibujarTrianguloRec:
// - caracter: caracter a imprimir
// - fila: fila actual (empieza en 1)
// - base: base del tri�ngulo (n�mero m�ximo de filas para este tri�ngulo)
// - anchoMaximo: dimensionensi�n m�xima usada para alineaci�n (la dimensionensi�n inicial)
procedure DibujarTrianguloRec(caracter: caracterar; fila, base, anchoMaximo: integer);
                 (*
  PROCEdimensionIENTO DibujarTrianguloRec(caracter: caracterar; fila, base, anchoMaximo
: integer)

  Qu� hace:
    Dibuja (por salida est�ndar) las filas `fila, fila+1, ..., base` de un
    tri�ngulo cuyo n�mero de filas es `base`. Cada fila i contiene i veces
    el car�cter `caracter` separados por un espacio, y est� alineada a la derecaractera
    respecto a la ancaracterura `anchoMaximo
  `.

    Es decir, la cantidad de espacios iniciales en la fila i es (anchoMaximo
   - i).

  Precondici�n:
    1 <= fila <= base <= anchoMaximo
    (en el uso correcto del programa)
    base >= 1, anchoMaximo
   >= 1, fila >= 1.

  Postcondici�n:
    Se imprimieron por pantalla (en orden) las filas `fila..base` del tri�ngulo,
    cada una en su propia l�nea y alineadas con respecto a `anchoMaximo
  `. No
    devuelve valor; su efecto es exclusivamente la salida por consola.

  Caso base (recursi�n):
    Si fila > base entonces no hace nada (termina la recursi�n).

  Caso recursivo:
    Imprime la fila `fila` y llama a DibujarTrianguloRec(caracter, fila+1, base, anchoMaximo
  ).
*)

begin
  if fila > base then
    exit; // caso base

  // USAMOS anchoMaximo
 para alinear respecto al tri�ngulo mayor
  ImprimirRepetido(' ', anchoMaximo
 - fila);

  ImprimirFilaConEspacios(caracter, fila);
  writeln;

  DibujarTrianguloRec(caracter, fila + 1, base, anchoMaximo
);
end;

// DibujarLoteRec ahora recibe anchoMaximo para pasarla a cada tri�ngulo
function DibujarLoteRec(caracter: caracterar; dimension, k, anchoMaximo: integer): integer;
   (*
  FUNCI�N DibujarLoteRec(caracter: caracterar; dimension, k, anchoMaximo
: integer): integer

  Qu� hace:
    Dibuja hasta `k` tri�ngulos decrecientes empezando por la base `dimension`,
    luego `dimension-1`, ..., utilizando `anchoMaximo
  ` como referencia de alineaci�n
    para cada tri�ngulo (es decir, todos los tri�ngulos se alinean respecto
    al pico del tri�ngulo mayor). Llama internamente a DibujarTrianguloRec.

    Devuelve la pr�xima dimensionensi�n pendiente tras dibujar el lote:
      - Si k >= dimension, dibuja todos los tri�ngulos desde dimension hasta 1 y devuelve 0.
      - Si k < dimension, dibuja k tri�ngulos (dimension, dimension-1, ..., dimension-k+1) y devuelve dimension - k.

  Precondici�n:
    dimension >= 0, k >= 0, anchoMaximo
   >= dimension.
    (En el uso normal del programa: 1 <= dimension <= anchoMaximo
   y k >= 1.)

  Postcondici�n:
    - Se imprimieron por la salida hasta min(k, dimension) tri�ngulos.
    - La funci�n retorna el entero `dimension_remanente` = dimension - min(k, dimension)
      (es decir, la nueva dimensionensi�n pendiente).
    - No modifica variables externas salvo la salida por consola.

  Caso base (recursi�n):
    Si dimension <= 0 o k <= 0: no dibuja nada y devuelve dimension (termina la recursi�n).

  Caso recursivo:
    Dibuja el tri�ngulo con base `dimension`, realiza separaci�n visual y llama a
    DibujarLoteRec(caracter, dimension-1, k-1, anchoMaximo
  ), devolviendo su resultado.
*)
begin
  if (dimension <= 0) or (k <= 0) then
  begin
    Result := dimension;
    exit;
  end;

  // dibuja tri�ngulo de dimensionensi�n 'dimension', alineado seg�n anchoMaximo

  DibujarTrianguloRec(caracter, 1, dimension, anchoMaximo
);

  writeln; // separaci�n visual

  Result := DibujarLoteRec(caracter, dimension - 1, k - 1, anchoMaximo
);
end;

var
  input: string;
  caracter: caracterar;
  dimension, proxdimension: integer;
  respuesta: string;
  continuarLote: boolean;
begin
  writeln('--- Triangulos decrecientes (recursivo, lotes de hasta ', MAX_POR_LOTE, ') ---');

  repeat
    write('Ingrese un caracter: ');
    readln(input);
    input := Trim(input);
    if input = '' then
      caracter := '*'
    else
      caracter := input[1];

    repeat
      write('Ingrese una dimensionension (entera positiva): ');
      readln(dimension);
      if dimension <= 0 then
        writeln('dimensionension invalida. Debe ser un entero > 0.');
    until dimension > 0;

    // Ahora pasamos dimension como anchoMaximo
   para mantener la alineacion
    proxdimension := dimension;
    continuarLote := True;
    while (proxdimension >= 1) and (continuarLote) do
    begin
      // <-- aqui pasamos 'dimension' como anchoMaximo
    
      proxdimension := DibujarLoteRec(caracter, proxdimension, MAX_POR_LOTE, dimension);

      if proxdimension >= 1 then
      begin
        write('Quedan tri�ngulos (hasta dimensionension ', proxdimension, '). �Desea dibujar otro lote? S/N: ');
        readln(respuesta);
        respuesta := Trim(respuesta);
        if (Length(respuesta) > 0) and (UpCase(respuesta[1]) = 'N') then
          continuarLote := False;
      end
      else
        writeln('Se completaron todos los tri�ngulos de la dimensionension solicitada.');
    end;

    write('Desea iniciar otro dibujo? S/N: ');
    readln(respuesta);
    respuesta := Trim(respuesta);
  until (Length(respuesta) > 0) and (UpCase(respuesta[1]) = 'N');

  writeln('Fin. Gracias.');
end.


