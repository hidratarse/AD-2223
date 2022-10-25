CREATE OR REPLACE TYPE TIP_TELEFONOS IS VARRAY(3) OF VARCHAR(15);
/
SHOW ERRORS;
CREATE OR REPLACE TYPE TIP_DIRECCION AS OBJECT(
    CALLE VARCHAR(50),
    POBLACION VARCHAR(50),
    CODPOST VARCHAR(20),
    PROVINCIA VARCHAR(40)
);

CREATE OR REPLACE TYPE TIP_CLIENTE AS OBJECT(
    IDCLIENTE NUMBER,
    NOMBRE VARCHAR(50),
    DIREC TIP_DIRECCION,
    NIF VARCHAR(9),
    TELEF TIP_TELEFONOS
);

CREATE TYPE TABLA_CLIENTES AS TABLE OF TIP_CLIENTE;

DROP TABLE PRODUCTOS;
CREATE TABLE PRODUCTOS(
    IDPRODUCTO NUMBER PRIMARY KEY, 
    DESCRIPCION VARCHAR2(10),
    PVP NUMBER,
    STOCKACTUAL NUMBER
);

CREATE TABLE VENTAS(
    IDVENTAS NUMBER PRIMARY KEY,
    IDCLIENTE NUMBER,
    FECHAVENTA DATE
);

DROP TABLE LINEASVENTAS;
CREATE  TABLE LINEASVENTAS(
    IDVENTA NUMBER,
    NUMEROLINEA NUMBER,
    IDPRODUCTO NUMBER,
    CANTIDAD NUMBER,
    CONSTRAINT PK_LINEASVENTAS PRIMARY KEY(IDVENTA, NUMEROLINEA)
);
