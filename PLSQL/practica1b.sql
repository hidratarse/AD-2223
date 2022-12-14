CREATE OR REPLACE TYPE VETERINARIO AS OBJECT(
	ID INTEGER,
	NOMBRE VARCHAR(100),
	DIRECCION VARCHAR(225));
/

CREATE OR REPLACE TYPE MASCOTA AS OBJECT (
	ID INTEGER,
	RAZA VARCHAR(100),
	NOMBRE VARCHAR(100),
	VET REF VETERINARIO);
/

CREATE TABLE VETERINARIOS OF VETERINARIO;

INSERT INTO VETERINARIOS VALUES(1, 'JESUS PEREZ','C/EL MAREO, 29');

CREATE TABLE MASCOTAS OF MASCOTA;

INSERT INTO MASCOTAS VALUES (1,'PERRO','SPROCKET',(
	SELECT REF(V) FROM VETERINARIOS V WHERE V.ID=1));

SELECT * FROM MASCOTAS;

SELECT ID, NOMBRE, DEREF(VET) FROM MASCOTAS;

SELECT NOMBRE, RAZA, DEREF(M.VET).NOMBRE FROM MASCOTAS M;

DROP TABLE MASCOTAS;
DROP TABLE VETERINARIOS;

DROP TYPE MASCOTA;
DROP TYPE VETERINARIO;