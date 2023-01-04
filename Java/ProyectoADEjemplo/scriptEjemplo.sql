create table alumnos (
	expediente int(10) primary key,
	nombre varchar(50),
	localidad varchar(50),
	fecha_nac date,
	direccion varchar(50),
	curso int(2),
	nivel varchar(10),
	faltas int(3));

insert into alumnos values(123456,'Juan Miguel Soler Bakero','Murcia','1995/10/10','Gran V’a, 2, 4A',1,'ESO',15);
insert into alumnos values(654321,'Laura G—mez Fern‡ndez','Lorca','1994/10/05','Junterones, 10, 5B',2,'ESO',25);
insert into alumnos values(765432,'Beatriz Mart’nez Hern‡ndez','Murcia','1993/05/05','Plaza Mayor, 6, 3B',3,'ESO',5);
insert into alumnos values(987654,'Diego Mar’n Llorente','Alhama de Murcia','1990/03/06','Diego de la Cierva, 5, 7A',1,'BACHILLER',34);

insert into alumnos values(445544,'Juan Francisco Cano Riquelme','Murcia','1992/01/07','Plaza de Belluga, 3, 4A',4,'ESO',13);
insert into alumnos values(223322,'Raquel Riquelme Rubio','Lorca','1990/11/23','San Juan, 14, 3B',1,'BACHILLER',7);

insert into alumnos values(9988877,'Cristina S‡nchez Bermejo','Murcia','95/03/19','Torre de Romo, 7',1,'ESO',1);
insert into alumnos values(334455,'Pedro Jesœs Rodr’guez Soler','Alhama de Murcia','94/10/03','Camino de Badel, 4',2,'ESO',11);
insert into alumnos values(334400,'Javier Ram’nez Rodr’guez','Murcia','93/05/27','Gran V’a, 4, 3A',3,'ESO',0);
insert into alumnos values(993322,'Gema Rubio Colero','Lorca','92/09/09','Plaza Fuensanta, 5, 7A',1,'BACHILLER',19);
insert into alumnos values(554411,'Joaqu’n Hern‡ndez Gonz‡lez','Lorca','91/12/12','Junterones, 4, 5A',2,'BACHILLER',14);