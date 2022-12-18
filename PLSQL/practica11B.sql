CREATE OR REPLACE TYPE TIP_TELEFONOS IS VARRAY(3) OF VARCHAR(15);
/

CREATE OR REPLACE TYPE TIP_DIRECCION AS OBJECT(
    CALLE VARCHAR(50),
    POBLACION VARCHAR(50),
    CODPOST VARCHAR(20),
    PROVINCIA VARCHAR(40)
); 
/

CREATE OR REPLACE TYPE TIP_CLIENTE AS OBJECT(
    IDCLIENTE NUMBER,
    NOMBRE VARCHAR(50),
    DIREC TIP_DIRECCION,
    NIF VARCHAR(9),
    TELEF TIP_TELEFONOS
);
/

CREATE OR REPLACE TYPE TIP_PRODUCTO AS OBJECT(
    IDPRODUCTO NUMBER,
    DESCRIPCION VARCHAR(80),
    PVP NUMBER,
    STOCKACTUAL NUMBER
);
/

CREATE OR REPLACE TYPE TIP_LINEA_VENTA AS OBJECT(
    NUMEROLINEA NUMBER,
    IDPRODUCTO REF TIP_PRODUCTO,
    CANTIDAD NUMBER
);
/

CREATE OR REPLACE TYPE TAB_LINEA_VENTA AS TABLE OF TIP_LINEA_VENTA;
/

CREATE OR REPLACE TYPE TIP_VENTA AS OBJECT(
    IDVENTAS NUMBER,
    IDCLIENTE REF TIP_CLIENTE,
    FECHAVENTA DATE,
    LINEAS TAB_LINEA_VENTA,
    MEMBER FUNCTION TOTAL_VENTA RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY TIP_VENTA 
    AS 
    MEMBER FUNCTION TOTAL_VENTA RETURN NUMBER 
    IS
     i integer;
    TOTAL number:=0;
    LINEA TIP_LINEA_VENTA;
    PRODUCT TIP_PRODUCTO;
    BEGIN
        for i in 1..LINEAS.count loop
            LINEA:=LINEAS(I);
            SELECT DEREF(LINEA.IDPRODUCTO) INTO PRODUCT FROM DUAL;
            TOTAL:=TOTAL+LINEA.CANTIDAD*PRODUCT.PVP;
        end loop;
        return TOTAL;
    END;
END;
/

DROP TABLE TABLA_CLIENTES;
CREATE TABLE TABLA_CLIENTES OF TIP_CLIENTE(IDCLIENTE PRIMARY KEY);

DROP TABLE TABLA_PRODUCTOS;
CREATE TABLE TABLA_PRODUCTOS OF TIP_PRODUCTO(IDPRODUCTO PRIMARY KEY);

DROP TABLE TABLA_VENTAS;
CREATE TABLE TABLA_VENTAS OF TIP_VENTA(IDVENTAS PRIMARY KEY)
NESTED TABLE LINEAS STORE AS TABLA_LINEAS;


INSERT INTO TABLA_CLIENTES VALUES(
    1,
    'Luis Garcia', 
    tip_direccion('calle Las Flores,23','Guadalajara','19003','Guadalajara'),
    '34343434L',
    tip_telefonos('949876655','949876655')
);
INSERT INTO TABLA_CLIENTES VALUES(
    2,
    'ana Serrano', 
    tip_direccion('calle Galiana 6','Guadalajara','19004','Guadalajara'),
    '76767667F',
    tip_telefonos('94980009')
);

INSERT INTO TABLA_PRODUCTOS VALUES(1, 'caja de cristal de murano',100,5);
INSERT INTO TABLA_PRODUCTOS VALUES(2, 'bicicleta city',120,15);
INSERT INTO TABLA_PRODUCTOS VALUES(3, '100 lapices de colores',20,5);
INSERT INTO TABLA_PRODUCTOS VALUES(4, 'ipad',600,5);
INSERT INTO TABLA_PRODUCTOS VALUES(5, 'ordenador portatil',400,10);

INSERT INTO TABLA_VENTAS SELECT 1, REF(C),SYSDATE, TAB_LINEA_VENTA() FROM
TABLA_CLIENTES C WHERE C.IDCLIENTE=1;

INSERT INTO TABLE (
    SELECT V.LINEAS FROM TABLA_VENTAS V WHERE V.IDVENTAS=1)(
        SELECT 1,REF(P),1 FROM TABLA_PRODUCTOS P WHERE IDPRODUCTO=1);

INSERT INTO TABLE(
    SELECT V.LINEAS FROM TABLA_VENTAS V WHERE V.IDVENTAS=1)(
        SELECT 2,REF(P),2 FROM TABLA_PRODUCTOS P WHERE IDPRODUCTO=2);

INSERT INTO TABLA_VENTAS SELECT 2, REF(C),SYSDATE, TAB_LINEA_VENTA() FROM
    TABLA_CLIENTES C WHERE C.IDCLIENTE=1;

INSERT INTO TABLE (SELECT V.LINEAS FROM TABLA_VENTAS V WHERE
    V.IDVENTAS=2)(SELECT 1,REF(P),2 FROM TABLA_PRODUCTOS P WHERE IDPRODUCTO=4);

INSERT INTO TABLE (SELECT V.LINEAS FROM TABLA_VENTAS V WHERE
    V.IDVENTAS=2)(SELECT 2,REF(P),1 FROM TABLA_PRODUCTOS P WHERE IDPRODUCTO=1);

INSERT INTO TABLE (SELECT V.LINEAS FROM TABLA_VENTAS V WHERE
    V.IDVENTAS=2)(SELECT 3,REF(P),4 FROM TABLA_PRODUCTOS P WHERE IDPRODUCTO=5);

/*6.1*/
SELECT LIN.* FROM TABLA_VENTAS TV, TABLE(TV.LINEAS) LIN WHERE TV.IDVENTAS=2;

/*6.2*/
SELECT DEREF(LIN.IDPRODUCTO) FROM TABLA_VENTAS TV, TABLE(TV.LINEAS)LIN WHERE TV.IDVENTAS=2; 

/*6.3*/
SELECT LIN.* FROM TABLA_VENTAS TV, TABLE(TV.LINEAS) LIN; 

/*6.4*/
SELECT NOMBRE FROM TABLA_CLIENTES WHERE IDCLIENTE=2; 

/*6.5*/
UPDATE TABLA_CLIENTES 
SET NOMBRE='ROSA SERRANO' 
WHERE IDCLIENTE=2;
                                                                            
/*6.6*/
SELECT DIREC FROM TABLA_CLIENTES WHERE IDCLIENTE=2;
UPDATE TABLA_CLIENTES TC 
SET  TC.DIREC.CALLE='CALLE ESTOPA 34'
WHERE IDCLIENTE=2;

/*6.7*/
SELECT TC.* FROM TABLA_CLIENTES TC WHERE IDCLIENTE=1; 
UPDATE TABLA_CLIENTES TC 
SET TC.TELEF=TIP_TELEFONOS('949876655','949876655','9999999999') WHERE TC.IDCLIENTE=1;

SELECT VALUE(TC) FROM TABLA_CLIENTES TC WHERE IDCLIENTE=1;   
/*6.8*/
SELECT TV.IDCLIENTE.NOMBRE FROM TABLA_VENTAS TV WHERE IDVENTAS=2; 
SELECT DEREF(IDCLIENTE).NOMBRE FROM TABLA_VENTAS WHERE IDVENTAS=2; 

/*6.9**/
SELECT DEREF(IDCLIENTE) FROM TABLA_VENTAS TV WHERE IDVENTAS=2; 

/*6.10*/
SELECT TV.IDVENTAS, TV.TOTAL_VENTA() FROM TABLA_VENTAS TV WHERE TV.IDCLIENTE.IDCLIENTE=1; 

/*6.11*/
SELECT TV.IDVENTAS, DEREF(IDCLIENTE).IDCLIENTE, LIN.IDPRODUCTO.DESCRIPCION, LIN.CANTIDAD 
FROM TABLA_VENTAS TV, TABLE(TV.LINEAS) LIN; 

/*6.12*/
CREATE OR REPLACE PROCEDURE VISUALIZADOR (V_IDVENTAS IN TABLA_VENTAS.IDVENTAS%TYPE)
IS
    V_VENTAS TIP_VENTA;
    V_CLIENTE TIP_CLIENTE;
    
    CURSOR C1 IS SELECT LIN.NUMEROLINEA, DEREF(LIN.IDPRODUCTO).DESCRIPCION, DEREF(LIN.IDPRODUCTO).PVP, LIN.CANTIDAD
    FROM TABLA_VENTAS T, TABLE(T.LINEAS) LIN
    WHERE IDVENTAS=V_IDVENTAS;

    V_NUMEROLINEA NUMBER;
    V_DESCRIPCION VARCHAR2(30);
    V_PVP NUMBER;
    V_CANTIDAD NUMBER;
    
BEGIN
    SELECT VALUE(TV) INTO V_VENTAS FROM TABLA_VENTAS TV WHERE IDVENTAS=V_IDVENTAS;
    SELECT DEREF(IDCLIENTE) INTO V_CLIENTE FROM TABLA_VENTAS WHERE IDVENTAS=V_IDVENTAS;


    DBMS_OUTPUT.PUT_LINE('NUMERO DE VENTA: ' || V_IDVENTAS || '  FECHA DE VENTA: ' || V_VENTAS.FECHAVENTA);
    DBMS_OUTPUT.PUT_LINE('CLIENTE: ' || V_CLIENTE.NOMBRE);
    DBMS_OUTPUT.PUT_LINE('DIRECCION: ' || V_CLIENTE.DIREC.CALLE);
    DBMS_OUTPUT.PUT_LINE('**********************************************************');

    OPEN C1;
    FETCH C1 INTO V_NUMEROLINEA, V_DESCRIPCION, V_PVP, V_CANTIDAD;

    WHILE(C1%FOUND)LOOP
        DBMS_OUTPUT.PUT_LINE(V_NUMEROLINEA||' - '||V_DESCRIPCION||' - '||V_PVP||' - '||V_CANTIDAD||' - '||V_CANTIDAD*V_PVP);
        FETCH C1 INTO V_NUMEROLINEA, V_DESCRIPCION, V_PVP, V_CANTIDAD;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('TOTAL VENTA :'||V_VENTAS.TOTAL_VENTA());
END;
/