drop type tipo_customer;
drop type tipo_person;

create or replace type tipo_address as object(
dir varchar(100),
cp number(5));
/
create or replace type tipo_contacto as object (
  telefono number,
  email varchar(100));
 /
  create type tipo_person as object
  (id varchar(20),
  nombre varchar(30),
  apellido varchar(30),
  direccion tipo_address,
  contacto tipo_contacto) 
  not final
 /
 
 create type tipo_customer under tipo_person
 (n_pedidos number)
 /

desc tipo_address;
  
create or replace type tipo_articulo as object
( idart number,
nombre varchar(30),
descripcion varchar(100),
precio number,
porct_iva number)
/
  
  create type tabla_articulos as table of tipo_articulo;
  /
 create or replace type tipo_lista_detalle as object(
 numero number,
 articulo tipo_articulo,
 cantidad number)
 /
 
 create type tab_lista_detalle as table of tipo_lista_detalle;
 /
 create type tipo_lista_compra as object(
 id number,
 fecha date,
 cli REF tipo_customer,
 detalle tab_lista_detalle,
 member function total return number)
 /
 create type body tipo_lista_compra as 
   member function total return number is
     i integer;
      tot number:=0;
      begin
        for i in 1..Detalle.count loop
          tot:=tot + (Detalle(i).cantidad * 
          Detalle(i).articulo.precio)* 
          (1+(Detalle(i).articulo.porct_iva/100));
        end loop;
        return tot;
        end;
      end;
      /
   create table customers of tipo_customer;
   
   insert into customers values(
    1, 'Pedro', 'Suarez', tipo_address(
        'Paseo del museo, 15', 28009), 
        tipo_contacto(
            938383838, 'psuarez@ono.es'), 0);
   
   insert into customers values(
        2, 'Juana', 'Gomez', 
        tipo_address('Gran Via, 15', 28005), 
        tipo_contacto(98888888, 'jgomez@ono.es'), 
        0);
   
 create table listas_de_compras of tipo_lista_compra
    nested table Detalle store as tDetalle;
             
 insert into listas_de_compras 
 select 1, current_date, ref(c), tab_lista_detalle(
    tipo_lista_detalle(
        1, tipo_articulo(1, ' barra de pan', 'tipo baguette', 1,7),4
    ),
    tipo_lista_detalle(
        2, 
        tipo_articulo(2, ' lonchas de jamon', 'tipo iberico', 6,7),
        4)
  )from customers c where c.id=1;
 
insert into listas_de_compras values (
    3, 
    sysdate, 
    (select ref(c) from customers c where c.id=1),
    tab_lista_detalle(
        tipo_lista_detalle(
            1, 
            tipo_articulo(1, ' barra de pan', 'tipo baguette', 1,7),
            4),  
        tipo_lista_detalle(
            2, 
            tipo_articulo(2, ' lonchas de jamon', 'tipo iberico', 6,7),
            4)
    )
);
 
select * from listas_de_compras;      
          
select id, fecha, deref(cli), detalle from listas_de_compras;

select id, c.total() from listas_de_compras c;