create or replace type direccion as object (
	calle varchar(25),
	ciudad varchar(20),
	codigo_post number(5)); 
/

create or replace type persona as object(
	codigo number, 
	nombre varchar2(35), 
	direc direccion, 
	fecha_nac date); 
/

DECLARE 
	dir direccion:= direccion(NULL, NULL, NULL); 
	p persona := persona (NULL, NULL, NULL, NULL);
BEGIN
	dir.calle:= 'La Mina,3'; 
	dir.ciudad:='GUADALAJARA'; 
	dir.codigo_post:=19001; 
	p.codigo:=1; 
	p.nombre:='JUAN'; 
	p.direc:=dir; 
	p.fecha_nac:='10/11/1988'; 
end; 
/

create table alumnos of persona (codigo primary key); 

insert into alumnos values(1, 'JUAN PEREZ', direccion ('C/LOS MANANTIALES', 'GUADALAJARA',19005),'18/12/1881'); 
insert into alumnos values(2, 'JULIA BRENA', direccion ('C/LOS ESPARTALES,25', 'GUADALAJARA',19005),'18/12/1891'); 

insert into alumnos values(p);

SELECT * from alumnos a where a.direc.ciudad='GUADALAJARA'; 
SELECT a.codigo, a.direc from alumnos a;
update alumnos a set a.direc.ciudad=lower(a.direc.ciudad) where a.direc.ciudad = 'GUADALAJARA';

DECLARE
	cursor c1 is select * from alumnos;
BEGIN
	for i in c1 loop 
		db,s_ouput.put_line(i.nombre||'CALLE: '||i.direc.calle);
	END LOOP;
END;
/

DELETE ALUMNOS A WHERE A.DIREC.CIUDAD='GUADALAJARA';