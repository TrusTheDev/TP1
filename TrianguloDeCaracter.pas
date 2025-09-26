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

procedure crearTriangulo(caracter: char; dimension,aux: integer);
(* Que hace: llama a los procedimientos necesarios para hacer una piramide.
   genera espacios, y dibuja caracteres
*)
begin
  generarEspacios(aux);
  generarCaracter(caracter, dimension);
end;

procedure generarEspaciado(cantidad: integer);
(* Que hace: genera espacios verticalmenteT para que la información sea más visible.
*)
begin
  if cantidad = 1 then
       writeln('')
  else
  begin
    writeln('');
    generarEspaciado(cantidad - 1)
  end;
end;

procedure TrianguloDeCaracterRecursivo(caracter: char; dimension,aux: integer);
(* Que hace: Dibuja un triangulo de manera recursiva
   compuesto del caracter dado y la dimension.
*)
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

procedure TriangulosRecursivos(caracter: char; dimension: integer);
begin
  (*
    Que hace: Dibuja de manera recursiva triangulos según la dimension dada
  *)
  if dimension = 1 then
       begin
       TrianguloDeCaracterRecursivo(caracter,1,1);
       generarEspaciado(1);
       end
  else
  begin
       TrianguloDeCaracterRecursivo(caracter,dimension,1);
       generarEspaciado(3);
       TriangulosRecursivos(caracter, dimension - 1);
  end;
end;


(* Solucion iterativa
procedure piramideIterativa(caracter: char, dimension: integer);
(* Que hace: crea una piramide pero de manera iterativa, notese que
la solución utiliza 3 contadores, esa fue una pista clave para utilizar
otro contador llamado aux en la solución recursiva puesto que la cantidad de
espacios no depende de la dimensión de la piramide, sino que es un contador a parte
que indica las veces que se provocó una auto-invocación.
*)
var
  i,j,k,espacios: integer;
BEGIN
  espacios := dimension;

  for i := 1 to dimension do
      begin

        for j := 1 to espacios do
            write(' ');
        for k := 1 to i do
            begin
            write(caracter);
            write(' ');
            end;
        writeln('');
        espacios := espacios - 1;
      writeln('');
      end;
END.
*)
var
   caracter: char;
   dimension: integer;
begin

  (*
    Programa principal.
  *)
  //piramideIteraiva(caracter, dimension);
  write('Ingrese un carácter: ');
  ReadLn(caracter);
  write('Ingrese la dimensión de la pirámide ');
  ReadLn(dimension);
  TriangulosRecursivos(caracter, dimension);





end.

