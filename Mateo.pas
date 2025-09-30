program TP_TRIANGULO;
Var
    //******VARIABLES*****//
    base:integer;
    car:char;

    //********************************************************************//
    //************************SUBALGORITMOS*******************************//
    //********************************************************************//

    procedure Hacer_caracter_espacio(punt: integer; punt2:integer; caracter:char);
    (*
    QUE HACE?:
    PRE:
    POS:
    *)
    begin
        if punt <= punt2 then
        begin
            write(caracter + ' ');
            Hacer_caracter_espacio(punt + 1, punt2, caracter);
        end;
    end;

    //********************************************************************//

    procedure Hacer_espacios(dimension:integer ; punt: integer);
    (*
    QUE HACE?:
    PRE:
    POS:
    *)
    begin
        if punt <= dimension then
        begin
            write(' ');
            Hacer_espacios(dimension, punt + 1);
        end;
    end;

    //********************************************************************//

    procedure Hacer_Triangulo(base:integer ; dimension:integer ; caracter:char; i:integer; j:integer);
    (*
    QUE HACE?:
    PRE: i=lineas
    POS:
    *)
    begin
        if dimension >= 1 then
        begin            
            Hacer_espacios(base, i);

            Hacer_caracter_espacio(i,j, caracter);

            writeLn(); // cambio de renglon para hacer la proxima linea del triangulo

            Hacer_Triangulo( base-1, dimension - 1, caracter, i , j+1);
        end;
         
    end;

    //*************************************************************************//
    procedure hacer_lote(base:integer ; caracter:char);
    (*
    QUE HACE?:
    PRE: i=lineas
    POS:
    *)
    var
        dim, i, j:integer;
    begin
            i := 1;
            j := 1;
            
            for dim := base downto 1 do
            begin
                Hacer_Triangulo(base, dim, caracter, i, j);
                writeLn();
            end;

    end;
 

    //********************************************************************//

    function mensaje(msj:string):boolean;
    (*
    QUE HACE?:
    PRE:
    POS:
    *)
    var
        respuesta:char;
    begin
        repeat
            writeLn(msj);
            readLn(respuesta);         
        until (respuesta in ['s','n','S','N']);

        if respuesta in ['n','N'] then
        begin
            mensaje := TRUE;
        end
        else
        begin
            mensaje := FALSE;
        end;
    end;

    //*******************************************************************//
    function Entero_en_rango(msj:string; tope1:integer; tope2:integer):integer;
    (*
    QUE HACE?:
    PRE:
    POS:
    *)
    var
       valor:integer;
    begin
        repeat
            write(msj);
            readLn (valor);

            if (valor < tope1) or (valor > tope2) then
            writeLn('ERROR: valor incorrecto');

        until (valor in [tope1..tope2]);
        Entero_en_rango := valor;
    end;

begin //****************************INICIO
    repeat
        //****************************************************//
        base := Entero_en_rango('Ingrese la base para la dimension que quiera para su rombo:',0, 5);

        write('ingrese un carecter para dibujar el triangulo:');
        readLn (car);


        hacer_lote(base, car)

        

    until(mensaje('le gustaria ingresar otro lote?:'));
end. //******************************FIN
