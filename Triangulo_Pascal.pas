         program TriangulosDecrecientesM;
{$mode objfpc}{$H+}

uses
  SysUtils;

const
  MAX_POR_LOTE = 5;

procedure ImprimirRepetido(ch: char; n: integer);
                        (*
  PROCEDIMIENTO ImprimirRepetido(ch: char; n: integer)

  Qu� hace:
    Imprime en la salida est�ndar (con write) el car�cter `ch` repetido `n` veces
    seguidas, sin a�adir salto de l�nea al final.

  Precondici�n:
    n >= 0. (Si n = 0 no imprime nada.)

  Postcondici�n:
    En la salida est�ndar se habr�n escrito exactamente `n` apariciones del
    car�cter `ch` (en la misma l�nea). No modifica variables ni estructuras
    fuera del procedimiento.
*)

var
  i: integer;
begin
  for i := 1 to n do
    write(ch);
end;

procedure ImprimirFilaConEspacios(ch: char; n: integer);
                (*
  PROCEDIMIENTO ImprimirFilaConEspacios(ch: char; n: integer)

  Qu� hace:
    Imprime en la salida `n` veces el car�cter `ch` separados por un �nico
    espacio entre ellos, sin salto de l�nea al final. Evita dejar un espacio
    adicional al final de la secuencia (si n >= 1).

  Precondici�n:
    n >= 0. (Si n = 0 no imprime nada; si n = 1 imprime solo `ch`.)

  Postcondici�n:
    En la salida est�ndar se habr� escrito la secuencia:
      ch[ + ' ' + ch + ... ]  (n veces ch y n-1 espacios entre ellos).
    No produce salto de l�nea.
*)
var
  i: integer;
begin
  for i := 1 to n do
  begin
    write(ch);
    if i < n then write(' ');
  end;
end;

// DibujarTrianguloRec:
// - ch: caracter a imprimir
// - fila: fila actual (empieza en 1)
// - base: base del tri�ngulo (n�mero m�ximo de filas para este tri�ngulo)
// - maxWidth: dimensi�n m�xima usada para alineaci�n (la dimensi�n inicial)
procedure DibujarTrianguloRec(ch: char; fila, base, maxWidth: integer);
                 (*
  PROCEDIMIENTO DibujarTrianguloRec(ch: char; fila, base, maxWidth: integer)

  Qu� hace:
    Dibuja (por salida est�ndar) las filas `fila, fila+1, ..., base` de un
    tri�ngulo cuyo n�mero de filas es `base`. Cada fila i contiene i veces
    el car�cter `ch` separados por un espacio, y est� alineada a la derecha
    respecto a la anchura `maxWidth`.

    Es decir, la cantidad de espacios iniciales en la fila i es (maxWidth - i).

  Precondici�n:
    1 <= fila <= base <= maxWidth  (en el uso correcto del programa)
    base >= 1, maxWidth >= 1, fila >= 1.

  Postcondici�n:
    Se imprimieron por pantalla (en orden) las filas `fila..base` del tri�ngulo,
    cada una en su propia l�nea y alineadas con respecto a `maxWidth`. No
    devuelve valor; su efecto es exclusivamente la salida por consola.

  Caso base (recursi�n):
    Si fila > base entonces no hace nada (termina la recursi�n).

  Caso recursivo:
    Imprime la fila `fila` y llama a DibujarTrianguloRec(ch, fila+1, base, maxWidth).
*)

begin
  if fila > base then
    exit; // caso base

  // USAMOS maxWidth para alinear respecto al tri�ngulo mayor
  ImprimirRepetido(' ', maxWidth - fila);

  ImprimirFilaConEspacios(ch, fila);
  writeln;

  DibujarTrianguloRec(ch, fila + 1, base, maxWidth);
end;

// DibujarLoteRec ahora recibe maxWidth para pasarla a cada tri�ngulo
function DibujarLoteRec(ch: char; dim, k, maxWidth: integer): integer;
   (*
  FUNCI�N DibujarLoteRec(ch: char; dim, k, maxWidth: integer): integer

  Qu� hace:
    Dibuja hasta `k` tri�ngulos decrecientes empezando por la base `dim`,
    luego `dim-1`, ..., utilizando `maxWidth` como referencia de alineaci�n
    para cada tri�ngulo (es decir, todos los tri�ngulos se alinean respecto
    al pico del tri�ngulo mayor). Llama internamente a DibujarTrianguloRec.

    Devuelve la pr�xima dimensi�n pendiente tras dibujar el lote:
      - Si k >= dim, dibuja todos los tri�ngulos desde dim hasta 1 y devuelve 0.
      - Si k < dim, dibuja k tri�ngulos (dim, dim-1, ..., dim-k+1) y devuelve dim - k.

  Precondici�n:
    dim >= 0, k >= 0, maxWidth >= dim.
    (En el uso normal del programa: 1 <= dim <= maxWidth y k >= 1.)

  Postcondici�n:
    - Se imprimieron por la salida hasta min(k, dim) tri�ngulos.
    - La funci�n retorna el entero `dim_remanente` = dim - min(k, dim)
      (es decir, la nueva dimensi�n pendiente).
    - No modifica variables externas salvo la salida por consola.

  Caso base (recursi�n):
    Si dim <= 0 o k <= 0: no dibuja nada y devuelve dim (termina la recursi�n).

  Caso recursivo:
    Dibuja el tri�ngulo con base `dim`, realiza separaci�n visual y llama a
    DibujarLoteRec(ch, dim-1, k-1, maxWidth), devolviendo su resultado.
*)
begin
  if (dim <= 0) or (k <= 0) then
  begin
    Result := dim;
    exit;
  end;

  // dibuja tri�ngulo de dimensi�n 'dim', alineado seg�n maxWidth
  DibujarTrianguloRec(ch, 1, dim, maxWidth);

  writeln; // separaci�n visual

  Result := DibujarLoteRec(ch, dim - 1, k - 1, maxWidth);
end;

var
  input: string;
  ch: char;
  dim, proxDim: integer;
  respuesta: string;
  continuarLote: boolean;
begin
  writeln('--- Triangulos decrecientes (recursivo, lotes de hasta ', MAX_POR_LOTE, ') ---');

  repeat
    write('Ingrese un caracter: ');
    readln(input);
    input := Trim(input);
    if input = '' then
      ch := '*'
    else
      ch := input[1];

    repeat
      write('Ingrese una dimension (entera positiva): ');
      readln(dim);
      if dim <= 0 then
        writeln('Dimension invalida. Debe ser un entero > 0.');
    until dim > 0;

    // Ahora pasamos dim como maxWidth para mantener la alineacion
    proxDim := dim;
    continuarLote := True;
    while (proxDim >= 1) and (continuarLote) do
    begin
      // <-- aqui pasamos 'dim' como maxWidth
      proxDim := DibujarLoteRec(ch, proxDim, MAX_POR_LOTE, dim);

      if proxDim >= 1 then
      begin
        write('Quedan tri�ngulos (hasta dimension ', proxDim, '). �Desea dibujar otro lote? S/N: ');
        readln(respuesta);
        respuesta := Trim(respuesta);
        if (Length(respuesta) > 0) and (UpCase(respuesta[1]) = 'N') then
          continuarLote := False;
      end
      else
        writeln('Se completaron todos los tri�ngulos de la dimension solicitada.');
    end;

    write('Desea iniciar otro dibujo? S/N: ');
    readln(respuesta);
    respuesta := Trim(respuesta);
  until (Length(respuesta) > 0) and (UpCase(respuesta[1]) = 'N');

  writeln('Fin. Gracias.');
end.


