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





program TrianguloDeCaracter;
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
