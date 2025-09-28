         program TriangulosDecrecientesM;
{$mode objfpc}{$H+}

uses
  SysUtils;

const
  MAX_POR_LOTE = 5;

procedure ImprimirRepetido(ch: char; n: integer);
                        (*
  PROCEDIMIENTO ImprimirRepetido(ch: char; n: integer)

  Qué hace:
    Imprime en la salida estándar (con write) el carácter `ch` repetido `n` veces
    seguidas, sin añadir salto de línea al final.

  Precondición:
    n >= 0. (Si n = 0 no imprime nada.)

  Postcondición:
    En la salida estándar se habrán escrito exactamente `n` apariciones del
    carácter `ch` (en la misma línea). No modifica variables ni estructuras
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

  Qué hace:
    Imprime en la salida `n` veces el carácter `ch` separados por un único
    espacio entre ellos, sin salto de línea al final. Evita dejar un espacio
    adicional al final de la secuencia (si n >= 1).

  Precondición:
    n >= 0. (Si n = 0 no imprime nada; si n = 1 imprime solo `ch`.)

  Postcondición:
    En la salida estándar se habrá escrito la secuencia:
      ch[ + ' ' + ch + ... ]  (n veces ch y n-1 espacios entre ellos).
    No produce salto de línea.
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
// - base: base del triángulo (número máximo de filas para este triángulo)
// - maxWidth: dimensión máxima usada para alineación (la dimensión inicial)
procedure DibujarTrianguloRec(ch: char; fila, base, maxWidth: integer);
                 (*
  PROCEDIMIENTO DibujarTrianguloRec(ch: char; fila, base, maxWidth: integer)

  Qué hace:
    Dibuja (por salida estándar) las filas `fila, fila+1, ..., base` de un
    triángulo cuyo número de filas es `base`. Cada fila i contiene i veces
    el carácter `ch` separados por un espacio, y está alineada a la derecha
    respecto a la anchura `maxWidth`.

    Es decir, la cantidad de espacios iniciales en la fila i es (maxWidth - i).

  Precondición:
    1 <= fila <= base <= maxWidth  (en el uso correcto del programa)
    base >= 1, maxWidth >= 1, fila >= 1.

  Postcondición:
    Se imprimieron por pantalla (en orden) las filas `fila..base` del triángulo,
    cada una en su propia línea y alineadas con respecto a `maxWidth`. No
    devuelve valor; su efecto es exclusivamente la salida por consola.

  Caso base (recursión):
    Si fila > base entonces no hace nada (termina la recursión).

  Caso recursivo:
    Imprime la fila `fila` y llama a DibujarTrianguloRec(ch, fila+1, base, maxWidth).
*)

begin
  if fila > base then
    exit; // caso base

  // USAMOS maxWidth para alinear respecto al triángulo mayor
  ImprimirRepetido(' ', maxWidth - fila);

  ImprimirFilaConEspacios(ch, fila);
  writeln;

  DibujarTrianguloRec(ch, fila + 1, base, maxWidth);
end;

// DibujarLoteRec ahora recibe maxWidth para pasarla a cada triángulo
function DibujarLoteRec(ch: char; dim, k, maxWidth: integer): integer;
   (*
  FUNCIÓN DibujarLoteRec(ch: char; dim, k, maxWidth: integer): integer

  Qué hace:
    Dibuja hasta `k` triángulos decrecientes empezando por la base `dim`,
    luego `dim-1`, ..., utilizando `maxWidth` como referencia de alineación
    para cada triángulo (es decir, todos los triángulos se alinean respecto
    al pico del triángulo mayor). Llama internamente a DibujarTrianguloRec.

    Devuelve la próxima dimensión pendiente tras dibujar el lote:
      - Si k >= dim, dibuja todos los triángulos desde dim hasta 1 y devuelve 0.
      - Si k < dim, dibuja k triángulos (dim, dim-1, ..., dim-k+1) y devuelve dim - k.

  Precondición:
    dim >= 0, k >= 0, maxWidth >= dim.
    (En el uso normal del programa: 1 <= dim <= maxWidth y k >= 1.)

  Postcondición:
    - Se imprimieron por la salida hasta min(k, dim) triángulos.
    - La función retorna el entero `dim_remanente` = dim - min(k, dim)
      (es decir, la nueva dimensión pendiente).
    - No modifica variables externas salvo la salida por consola.

  Caso base (recursión):
    Si dim <= 0 o k <= 0: no dibuja nada y devuelve dim (termina la recursión).

  Caso recursivo:
    Dibuja el triángulo con base `dim`, realiza separación visual y llama a
    DibujarLoteRec(ch, dim-1, k-1, maxWidth), devolviendo su resultado.
*)
begin
  if (dim <= 0) or (k <= 0) then
  begin
    Result := dim;
    exit;
  end;

  // dibuja triángulo de dimensión 'dim', alineado según maxWidth
  DibujarTrianguloRec(ch, 1, dim, maxWidth);

  writeln; // separación visual

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
        write('Quedan triángulos (hasta dimension ', proxDim, '). ¿Desea dibujar otro lote? S/N: ');
        readln(respuesta);
        respuesta := Trim(respuesta);
        if (Length(respuesta) > 0) and (UpCase(respuesta[1]) = 'N') then
          continuarLote := False;
      end
      else
        writeln('Se completaron todos los triángulos de la dimension solicitada.');
    end;

    write('Desea iniciar otro dibujo? S/N: ');
    readln(respuesta);
    respuesta := Trim(respuesta);
  until (Length(respuesta) > 0) and (UpCase(respuesta[1]) = 'N');

  writeln('Fin. Gracias.');
end.


