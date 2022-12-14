SET SERVEROUTPUT ON; 
ALTER TYPE TIPO_CUBO REPLACE AS OBJECT(
	LARGO INTEGER,
	ANCHO INTEGER,
	ALTO INTEGER,
	MEMBER FUNCTION SUPERFICIE RETURN INTEGER, 
	MEMBER FUNCTION VOLUMEN RETURN INTEGER,
	MEMBER PROCEDURE MOSTRAR,
	STATIC PROCEDURE nuevoCubo(v_largo integer, v_ancho integer, 	v_alto integer));
/

CREATE OR REPLACE TYPE BODY TIPO_CUBO 
AS
	MEMBER FUNCTION SUPERFICIE RETURN INTEGER 
	IS
	BEGIN
		RETURN 2*(LARGO*ANCHO+LARGO*ALTO+ANCHO*ALTO);
	END;

	MEMBER FUNCTION VOLUMEN RETURN INTEGER 
	IS
	BEGIN
		RETURN (LARGO*ALTO*ANCHO);
	END;

	MEMBER PROCEDURE MOSTRAR
	IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE(' LARGO: '||LARGO||' ANCHO: '||ANCHO||' ALTO: '||ALTO);
		DBMS_OUTPUT.PUT_LINE('VOLUMEN: '||VOLUMEN|| 'SUPERFICIE: '||SUPERFICIE);
	END;
	
	STATIC PROCEDURE nuevoCubo(v_largo integer, v_ancho integer, 	v_alto integer)
	IS 
	BEGIN 
		INSERT INTO CUBOS VALUES (v_largo, v_ancho, v_alto); 
	END; 
END;
/
SHOW ERRORS;