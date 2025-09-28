program TP_TRIANGULO;
Var
    //******VARIABLES*****//
    i, base:integer;
    car:char;

    //********************************************************************//
    //************************SUBALGORITMOS*******************************//
    //********************************************************************//

    procedure Hacer_caracter_espacio(punt: integer; caracter:char);
    (*
    QUE HACE?:
    PRE:
    POS:
    *)
    begin
        if punt >= 1 then
        begin
            write(caracter + ' ');
            Hacer_caracter_espacio(punt - 1, caracter);
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

    procedure Hacer_Triangulo(var dimension:integer ; caracter:char; i:integer);
    (*
    QUE HACE?:
    PRE: i=lineas
    POS:
    *)
    begin
        if dimension >= 1 then
        begin            
            Hacer_espacios(dimension, i);

            Hacer_caracter_espacio(i, caracter);

            writeLn(); // cambio de renglon para hacer el proximo triangulo

            dimension := dimension - 1;

            Hacer_Triangulo(dimension, caracter, i);
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
    procedure Entero_en_rango(msj:string; tope1:integer; tope2:integer; var valor:integer);
    (*
    QUE HACE?:
    PRE:
    POS:
    *)
    begin
        repeat
            writeLn(msj);
            readLn (valor);

            if (valor < tope1) or (valor > tope2) then
            writeLn('ERROR: valor incorrecto');

        until (valor in [tope1..tope2]);    
    end;

begin //****************************INICIO
    repeat
        //****************************************************//
        Entero_en_rango('Ingrese la base para la dimension que quiera para su rombo:',0, 5, base);

        writeLn('ingrese un carecter para dibujar el triangulo');
        readLn (car);
        
        i := 1;
        Hacer_Triangulo(base, car, i);
        

    until(mensaje('le gustaria ingresar otro lote?:'));
end. //******************************FIN
