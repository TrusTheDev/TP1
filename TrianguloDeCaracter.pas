(*
Ingrese un caracter: *
Ingrese una dimension: 4

    *
   * *
  * * *
 * * * *

   *
  * *
 * * *

  *
 * *

 *


*)

procedure generarCaracter(caracter: char; dimension: integer);
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

procedure generarEspacios(espacios: integer);
begin
  if (espacios = 1) or (espacios = 0) then
     write(' ')
  else
    begin
      generarEspacios(espacios - 1);
      write(' ')
    end;
  end;

procedure crearTriangulo(caracter: char; dimension,aux: integer);
begin
  generarEspacios(aux);
  generarCaracter(caracter, dimension);
end;

procedure TrianguloDeCaracterRecursivo(caracter: char; dimension,aux: integer);
  begin
    if dimension = 1 then
         crearTriangulo(caracter, dimension,aux)
    else
    begin
         TrianguloDeCaracterRecursivo(caracter,dimension - 1, aux + 1);
         writeln('');
         crearTriangulo(caracter,dimension, aux)
    end;
  end;

procedure generarEspaciado(cantidad: integer);
begin
  if cantidad = 1 then
       writeln('')
  else
  begin
    writeln('');
    generarEspaciado(cantidad - 1)
  end;
end;


procedure Tri(caracter: char; dimension: integer);
begin
  if dimension = 1 then
       begin
       TrianguloDeCaracterRecursivo(caracter,1,1);
       generarEspaciado(1);
       end
  else
  begin
       TrianguloDeCaracterRecursivo(caracter,dimension,1);
       generarEspaciado(3);
       Tri(caracter, dimension - 1);
  end;
end;


(* Solucion iterativa
var
  i,j,k,dimension,espacios: integer;
BEGIN
  dimension := 4;
  espacios := dimension;

  for i := 1 to dimension do
      begin

        for j := 1 to espacios do
            write(' ');
        for k := 1 to i do
            begin
            write('x');
            write(' ');
            end;
        writeln('');
        espacios := espacios - 1;

      end;
END.
*)

begin
  Tri('x', 5);
end.

