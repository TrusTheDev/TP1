  program TriangulosDecrecientesM;
{$mode objfpc}{$H+}

uses
  SysUtils;

const
  MAX_POR_LOTE = 5;
  MAX_DIMENSION = 5;

{-----------------------------------------------------------}
procedure ImprimirRepetido(ch: char; n: integer);
(*
  Qué hace:
    Imprime el carácter `ch` repetido `n` veces seguidas en la misma línea.
  Precondición:
    n >= 0.
  Postcondición:
    En pantalla aparecen exactamente `n` repeticiones de `ch`.
*)
var
  i: integer;
begin
  for i := 1 to n do
    write(ch);
end;

{-----------------------------------------------------------}
procedure ImprimirFilaConEspacios(ch: char; n: integer);
(*
  Qué hace:
    Imprime `n` veces el carácter `ch` separados por un espacio.
  Precondición:
    n >= 0.
  Postcondición:
    Se muestran `n` caracteres separados por espacio en la misma línea.
*)
var
  i: integer; 
begin
  for i := 1 to n do
  begin
    write(ch);
    if i < n then
      write(' ');
  end;
end;

{-----------------------------------------------------------}
procedure DibujarTrianguloRec(ch: char; fila, base, maxWidth: integer);
(*
  Qué hace:
    Dibuja un triángulo de base `base` alineado a la derecha con `maxWidth`.
  Precondición:
    1 <= fila <= base <= maxWidth.
  Postcondición:
    Se imprime el triángulo desde fila hasta base.
*)
begin
  if fila > base then
    exit;

  ImprimirRepetido(' ', maxWidth - fila);
  ImprimirFilaConEspacios(ch, fila);
  writeln;

  DibujarTrianguloRec(ch, fila + 1, base, maxWidth);
end;

{-----------------------------------------------------------}
function DibujarLoteRec(ch: char; dim, k, maxWidth: integer): integer;
(*
  Qué hace:
    Dibuja un lote de hasta `k` triángulos decrecientes desde `dim`.
  Precondición:
    dim >= 0, k >= 0, maxWidth >= dim.
  Postcondición:
    Devuelve la dimensión remanente tras dibujar el lote.
*)
begin
  if (dim <= 0) or (k <= 0) then
  begin
    Result := dim;
    exit;
  end;

  DibujarTrianguloRec(ch, 1, dim, maxWidth);
  writeln;

  Result := DibujarLoteRec(ch, dim - 1, k - 1, maxWidth);
end;

{-----------------------------------------------------------}
function LeerCaracter: char;
(*
  Qué hace:
    Solicita al usuario un carácter.
  Precondición:
    Ninguna.
  Postcondición:
    Devuelve el carácter ingresado o '*' si no se ingresó nada.
*)
var
  input: string;
begin
  write('Ingrese un caracter: ');
  readln(input);
  input := Trim(input);
  if input = '' then
    Result := '*'
  else
    Result := input[1];
end;

{-----------------------------------------------------------}
function LeerDimension: integer;
(*
  Qué hace:
    Solicita al usuario una dimensión entre 1 y MAX_DIMENSION.
  Precondición:
    Ninguna.
  Postcondición:
    Devuelve una dimensión válida en el rango.
    Si es > MAX_DIMENSION muestra "no disponible" y devuelve -1.
*)
var
  dim: integer;
begin
  write('Ingrese una dimension (1..', MAX_DIMENSION, '): ');
  readln(dim);
  if (dim < 1) then
  begin
    writeln('Dimensión inválida. Debe ser mayor a 0.');
    Result := -1;
  end
  else if (dim > MAX_DIMENSION) then
  begin
    writeln('Dimensión no disponible. Solo se permiten de 1 a ', MAX_DIMENSION, '.');
    Result := -1;
  end
  else
    Result := dim;
end;

{-----------------------------------------------------------}
function PreguntarSi(mensaje: string): boolean;
(*
  Qué hace:
    Pregunta al usuario una respuesta S/N.
  Precondición:
    Ninguna.
  Postcondición:
    Devuelve TRUE si la respuesta comienza con 'S', FALSE en otro caso.
*)
var
  respuesta: string;
begin
  write(mensaje, ' S/N: ');
  readln(respuesta);
  respuesta := Trim(respuesta);
  if (Length(respuesta) > 0) and (UpCase(respuesta[1]) = 'S') then
    Result := True
  else
    Result := False;
end;

{===========================================================}
{ PROGRAMA PRINCIPAL }
(*
  Qué hace:
    Permite al usuario dibujar triángulos decrecientes alineados.
    Solo admite dimensiones hasta MAX_DIMENSION. Maneja lotes
    de hasta MAX_POR_LOTE triángulos por vez y consulta al
    usuario si desea continuar dibujando.
  Precondición:
    Ninguna.
  Postcondición:
    El programa finaliza cuando el usuario responde 'N' en
    las consultas de continuar.
*)
var
  ch: char;
  dim, proxDim: integer;
  continuarLote, continuarPrograma: boolean;
begin
  writeln('--- Triangulos decrecientes (recursivo, lotes de hasta ', MAX_POR_LOTE, ') ---');

  continuarPrograma := True;
  while continuarPrograma do
  begin
    ch := LeerCaracter;
    dim := LeerDimension;

    if dim > 0 then
    begin
      proxDim := dim;
      continuarLote := True;
      while (proxDim >= 1) and (continuarLote) do
      begin
        proxDim := DibujarLoteRec(ch, proxDim, MAX_POR_LOTE, dim);

        if proxDim >= 1 then
          continuarLote := PreguntarSi('Quedan triángulos (hasta dimension ' + IntToStr(proxDim) + '). ¿Desea dibujar otro lote?')
        else
          writeln('Se completaron todos los triángulos de la dimensión solicitada.');
      end;
    end;

    continuarPrograma := PreguntarSi('¿Desea iniciar otro dibujo?');
  end;

  writeln('Fin. Gracias.');
end.