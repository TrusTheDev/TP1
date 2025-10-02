program TriangulosDecrecientesM;
procedure generarEspacios(espacios: integer);
(* Que hace: genera los espacios de la piramide
*)
begin
  if espacios = 0 then
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
    if dimension = 0 then
     write(caracter)
  else
    begin
      write(caracter);
      write(' ');
      generarCaracter(caracter, dimension - 1);
    end;
end;

procedure crearTriangulo(caracter: char; dimension,aux: integer);
(* Que hace: llama a los procedimension
ientos necesarios para hacer una piramide.
   genera espacios, y dibuja caracteres
*)
begin
  generarEspacios(aux);
  generarCaracter(caracter, dimension);
end;

{-----------------------------------------------------------}
procedure DibujarTrianguloRec(caracter: char; fila, base, MAXancho: integer);
(*
  Qué hace:
    Dibuja un triángulo de base 'base' alineado a la derecha con 'MAXancho'.
  Precondición:
    1 <= fila <= base <= MAXancho.
  Postcondición:
    Se imprime el triángulo desde fila hasta base.
*)
begin
  if fila = base then
  
else
begin
  crearTriangulo(caracter, fila, MAXancho - fila);
  writeln;

  DibujarTrianguloRec(caracter, fila + 1, base, MAXancho)
  end;
end;


function DibujarLoteRec(caracter: char; dim,k: integer): integer;
(*
  Qué hace:
    Dibuja un lote de hasta 'k' triángulos decrecientes desde 'dim'.
  Precondición:
    dim >= 0, k >= 0, MAXancho >= dim.
  Postcondición:
    Devuelve la dimensión remanente tras dibujar el lote.
*)
begin
  if (dim <= 0) or (k <= 0) then
    DibujarLoteRec := dim
else
  begin
  DibujarTrianguloRec(caracter, 0, dim, 5);
  writeln;
  DibujarLoteRec := DibujarLoteRec(caracter, dim - 1, k - 1)
  end;
end;


{-----------------------------------------------------------}
function LeerCaracter (msj:string): char;
(*
  Qué hace:
    Solicita al usuario un carácter.
  Precondición:
    msj = MENSAJE ∈ dato estructurado
  Postcondición:
    Devuelve el carácter ingresado o '*' si no se ingresó nada.
*)
var
  input: char;
begin
  write(msj);
  readln(input);
  if input = '' then
    LeerCaracter := '*'
  else
    LeerCaracter := input;
end;

{-----------------------------------------------------------}
function LeerDimension(msj:string; tope1:integer; tope2:integer): integer;
(*
  Qué hace:
    Solicita al usuario ingresar un valor
  Precondición:
    msj = MENSAJE ∈ dato estructurado; tope1 y tope2 ∈ a los parametros ingresados 
  Postcondición:
    Devuelve un valor validado.
*)
var
  dimension: integer;
begin
  repeat
    write(msj);
    readln(dimension);
    if (dimension < tope1) OR (dimension > tope2)  then
    begin
      writeln('ERROR: dimension inválida. se espera que el valor ingresado sea entre 1 y 5.');
    end;   
  until (dimension in [tope1..tope2]);
  LeerDimension := dimension  
end;

{-----------------------------------------------------------}

function Preguntar (msj:string):boolean;
(*
Qué hace: le mustra un mensaje al usuario para que esté lo responda 
PRE: ----
POS: preguntar = verdadero o preguntar = falso
*)
var
    respuesta:char;
begin
    repeat
        writeLn(msj);
        readLn(respuesta);         
    until (respuesta in ['s','n','S','N']);

    if respuesta in ['n','N'] then
      Preguntar := FALSE
    else
      Preguntar := TRUE;

end;

{===========================================================}
{ PROGRAMA PRINCIPAL }
(*
  Qué hace:
    Permite al usuario dibujar triángulos decrecientes alineados.
    Solo admite dimension
    ensiones hast. Maneja lotes
    de hasta 5 triángulos por vez y consulta al
    usuario si desea continuar dibujando.
  Precondición:
    Ninguna.
  Postcondición:
    El programa finaliza cuando el usuario responde 'N' en
    las consultas de continuar.
*)

var
  caracter: char;
  dimension: integer;
  continuarPrograma: boolean;
begin                                                                 
  writeln('--- Triangulos decrecientes (recursivo, lotes de hasta 5) ---');

  continuarPrograma := True;
  while continuarPrograma do
  begin
    caracter := LeerCaracter('Ingrese un caracter: ');
    dimension:= LeerDimension('Ingrese una dimension entre (1 y 5): ', 1,5);
    DibujarLoteRec(caracter,dimension,5);
    continuarPrograma := Preguntar('Desea iniciar otro dibujo?')
  end;

  writeln('{-----Fin del Programa-----}');
  readLn();
end.