  program TriangulosDecrecientesM;
{$mode objfpc}{$H+}

uses
  SysUtils;

const
  MAX_POR_LOTE = 5;
  MAX_DIMENSION = 5;

procedure generarEspacios(espacios: integer);
(* Que hace: genera los espacios de la piramide
*)
begin
  if (espacios = 1) or (espacios = 0) then
     write(' ')
  else
    begin
      generarEspacios(espacios - 1);
      write(' ')
    end;
  end;

  procedure generarCaracter(caracter: char; dimension: integer);
(* Que hace: dibuja los caracteres de la piramide
*)
begin
    if dimension = 1 then
     write(caracter)
  else
    begin
      write(caracter);
      write(' ');
      generarCaracter(caracter, dimension - 1);
    end;
end;

procedure crearTriangulo(caracter: char; dimension,aux: integer);
(* Que hace: llama a los procedimientos necesarios para hacer una piramide.
   genera espacios, y dibuja caracteres
*)
begin
  generarEspacios(aux);
  generarCaracter(caracter, dimension);
end;

{-----------------------------------------------------------}
procedure ImprimirRepetido(caracter: char; n: integer);
(*
  Qué hace:
    Imprime el carácter `caracter` repetido `n` veces seguidas en la misma línea.
  Precondición:
    n >= 0.
  Postcondición:
    En pantalla aparecen exactamente `n` repeticiones de `caracter`.
*)
begin
  if n = 1 then
    begin
      write(caracter);
      exit;
    end
  else
  begin
    ImprimirRepetido(caracter, n - 1);
    write(caracter);
  end
end;

{-----------------------------------------------------------}
procedure DibujarTrianguloRec(caracter: char; fila, base, MAXancho: integer);
(*
  Qué hace:
    Dibuja un triángulo de base `base` alineado a la derecaractera con `MAXancho`.
  Precondición:
    1 <= fila <= base <= MAXancho.
  Postcondición:
    Se imprime el triángulo desde fila hasta base.
*)
begin
  if fila = base then
    exit;

  crearTriangulo(caracter, fila, MAXancho - fila);
  writeln;

  DibujarTrianguloRec(caracter, fila + 1, base, MAXancho);
end;



{-----------------------------------------------------------}
function DibujarLoteRec(caracter: char; dim, k, MAXancho: integer): integer;
(*
  Qué hace:
    Dibuja un lote de hasta `k` triángulos decrecientes desde `dim`.
  Precondición:
    dim >= 0, k >= 0, MAXancho >= dim.
  Postcondición:
    Devuelve la dimensión remanente tras dibujar el lote.
*)
begin
  if (dim <= 0) or (k <= 0) then
  begin
    Result := dim;
    exit;
  end;

  DibujarTrianguloRec(caracter, 1, dim, MAXancho);
  writeln;

  Result := DibujarLoteRec(caracter, dim - 1, k - 1, MAXancho);
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
  caracter: char;
  dim, proxDim: integer;
  continuarLote, continuarPrograma: boolean;
begin
  writeln('--- Triangulos decrecientes (recursivo, lotes de hasta ', MAX_POR_LOTE, ') ---');

  continuarPrograma := True;
  while continuarPrograma do
  begin
    caracter := LeerCaracter;
    dim := LeerDimension;

    if dim > 0 then
    begin
      proxDim := dim;
      continuarLote := True;
      while (proxDim >= 1) and (continuarLote) do
      begin
        proxDim := DibujarLoteRec(caracter, proxDim, MAX_POR_LOTE, dim);

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