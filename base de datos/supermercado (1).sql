/*BASE DE DATOS EN MODELO ESTRELLA:
    Se ha elegido esta base de datos debido a su gran desempeño sobre la normalización de las relaciones de esta, con el fin de
explorar nuevos métodos de implementacón de bases de datos*/


use my_bd;

drop table tickets;         /*Se debe borrar la primera porque tiene las claves foraneas, por el mismo motivo por el que se crea la ultima*/
drop table dim_empleados;
drop table dim_tiempo;
drop table dim_pagos;
drop table dim_horas;
drop table dim_centros;


create table dim_empleados
    (d_idEmpleado integer(5) primary key,
    nombre varchar(32),
    categoria varchar(64),
    constraint ck_categoria CHECK (categoria IN ('Cajero', 'Reponedor', 'Gerente'))
);

create table dim_tiempo
    (d_fecha date primary key,
    diaSemana varchar(16),
    diaMes integer(2),
    mes varchar(16),
    trimestre varchar(16),
    vacaciones varchar(2),
    finSemana varchar(2),
    constraint ck_diaSemana CHECK (diaSemana IN ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')),
    constraint ck_mes CHECK (mes IN ('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre',
        'Noviembre', 'Diciembre')),
    constraint ck_trimestre CHECK (trimestre IN ('Invierno', 'Primavera', 'Verano', 'Otono')),
    constraint ck_vacaciones CHECK (vacaciones IN ('Si', 'No')),
    constraint ck_finSemana CHECK (finSemana IN ('Si', 'No'))
);

/*Tipos de pago: 1 = en efectivo, 2 = con tarjeta*/
create table dim_pagos
    (d_idPago int(5) primary key,
    cantidad int(4),
    descrip varchar(256)
);

create table dim_horas
    (d_hora varchar(8) primary key,
    franjaHoraria varchar(16) not null,
    constraint ck_franjaHoraria CHECK (franjaHoraria IN ('Manana', 'Tarde', 'Noche'))
);

/*Numero de centros = 2*/
create table dim_centros
    (d_idCentro int(5) primary key,
    descrip varchar(256),
    direccion varchar(128),
    poblacion varchar(64),
    provincia varchar(64),
    codPostal int(5),
    mCuadrados int(5),
    descripZona varchar(256)
);

create table tickets                    /*tabla principal*/
	(idTicket int(5) primary key,
    fecha date,
    hora varchar(8),
    idCaja int(5), /*Numero cajas = 2*/
    idEmpleado int(5),
    idCentro int(5),
    idPago int(5),
    totalTicket int(10),
    constraint fk_idPago_dim_pagos foreign key (idPago) references dim_pagos (d_idPago),
    constraint fk_idCentro_dimCentros foreign key (idCentro) references dim_centros (d_idCentro),
    constraint fk_idEmpleado_dimEmpleados foreign key (idEmpleado) references dim_empleados (d_idEmpleado),
    constraint fk_hora_dimHoras foreign key (hora) references dim_horas(d_hora),
    constraint fk_fecha_dimTiempo foreign key (fecha) references dim_tiempo(d_fecha)
);


/*idEmpleado, nombre, categoría*/
insert into dim_empleados
values (1, 'Pepe', 'Gerente');
insert into dim_empleados
values (2, 'Juan', 'Cajero');
insert into dim_empleados
values (3, 'Daniel', 'Gerente');
insert into dim_empleados
values (4, 'Sergio', 'Reponedor');
insert into dim_empleados
values (5, 'Diego', 'Cajero');
insert into dim_empleados
values (6, 'Manuel', 'Reponedor');
insert into dim_empleados
values (7, 'Martin', 'Gerente');
insert into dim_empleados
values (8, 'Emilio', 'Cajero');
insert into dim_empleados
values (9, 'Juan Antonio', 'Reponedor');
insert into dim_empleados
values (10, 'Francisco', 'Cajero');
insert into dim_empleados
values (11, 'Adrian', 'Cajero');
insert into dim_empleados
values (12, 'Maria', 'Cajero');


/*fecha, dia_semana, dia_mes, mes, trimestre, vacaciones, fin_semana*/
insert into dim_tiempo 
values ('2022/01/01', 'Sabado', 1, 'Enero', 'Invierno', 'Si', 'Si');
insert into dim_tiempo
values('2022/01/02', 'Domingo', 2, 'Enero', 'Invierno', 'No', 'Si');
insert into dim_tiempo
values('2022/01/03', 'Lunes', 3, 'Enero', 'Invierno', 'No', 'No');
insert into dim_tiempo
values('2022/01/04', 'Martes', 4, 'Enero', 'Invierno', 'No', 'No');
insert into dim_tiempo
values('2022/01/05', 'Miercoles', 5, 'Enero', 'Invierno', 'No', 'No');
insert into dim_tiempo
values('2022/01/06', 'Jueves', 6, 'Enero', 'Invierno', 'Si', 'No');
insert into dim_tiempo
values('2022/01/07', 'Viernes', 7, 'Enero', 'Invierno', 'No', 'No');
insert into dim_tiempo
values('2022/01/08', 'Sabado', 8, 'Enero', 'Invierno', 'No', 'Si');
insert into dim_tiempo
values('2022/01/09', 'Domingo', 9, 'Enero', 'Invierno', 'No', 'Si');
insert into dim_tiempo
values('2022/01/10', 'Lunes', 10, 'Enero', 'Invierno', 'No', 'No');
insert into dim_tiempo
values('2022/01/11', 'Martes', 11, 'Enero', 'Invierno', 'No', 'No');


/*idPago, cantidad, descripcion*/
insert into dim_pagos
values (1, 10, 'Efectivo');
insert into dim_pagos
values(2, 20, 'Tarjeta');
insert into dim_pagos
values(3, 2, 'Efectivo');
insert into dim_pagos
values(4, 5, 'Efectivo');
insert into dim_pagos
values(5, 80, 'Tajeta');
insert into dim_pagos
values(6, 90, 'Tarjeta');
insert into dim_pagos
values(7, 20, 'Efectivo');
insert into dim_pagos
values(8, 17, 'Efectivo');
insert into dim_pagos
values(9, 64, 'Tarjeta');
insert into dim_pagos
values(10, 70, 'Efectivo');
insert into dim_pagos
values(11, 10, 'Tarjeta');
insert into dim_pagos
values(12, 70, 'Tarjeta');
insert into dim_pagos
values(13, 8, 'Efectivo');
insert into dim_pagos
values(14, 30, 'Tarjeta');
insert into dim_pagos
values(15, 15, 'Efectivo');
insert into dim_pagos
values(16, 80, 'Tarjeta');
insert into dim_pagos
values(17, 78, 'Tarjeta');
insert into dim_pagos
values(18, 20, 'Tarjeta');
insert into dim_pagos
values(19, 50, 'Tarjeta');
insert into dim_pagos
values(20, 50, 'Efectivo');
insert into dim_pagos
values(21, 45, 'Tarjeta');
insert into dim_pagos
values(22, 70, 'Tarjeta');
insert into dim_pagos
values(23, 20, 'Tarjeta');


/*Se va a tomar 7:00-12:59 -> Manana; 13:00-17:59 -> Tarde; 18:00-22:00 ->Noche*/
/*hora, franjaHoraria*/
insert into dim_horas 
values ('10:00:00', 'Manana');
insert into dim_horas 
values ('10:15:00', 'Manana');
insert into dim_horas 
values ('10:30:00', 'Manana');
insert into dim_horas 
values ('9:00:00', 'Manana');
insert into dim_horas 
values ('12:00:00', 'Manana');
insert into dim_horas 
values ('15:30:00', 'Tarde');
insert into dim_horas 
values ('11:00:00', 'Manana');
insert into dim_horas 
values ('13:30:00', 'Tarde');
insert into dim_horas 
values ('17:00:00', 'Tarde');
insert into dim_horas 
values ('17:30:00', 'Tarde');
insert into dim_horas 
values ('11:30:00', 'Manana');
insert into dim_horas 
values ('13:00:00', 'Manana');
insert into dim_horas 
values ('18:00:00', 'Noche');
insert into dim_horas 
values ('14:00:00', 'Tarde');
insert into dim_horas 
values ('16:30:00', 'Tarde');



/*idCentro, descripcion, direccion, poblacion, provincia, codigo_postal, metros_cuadrados, descripcion_zona*/
insert into dim_centros
values (1, 'Supermercado en la periferia', 'c/ Acera Fuente de la Salud', 'Cordoba', 'Cordoba', 14006, 1000, 'Zona de poligonos');
insert into dim_centros
values (2, 'Supermercado en el centro', 'Av. Isla Fuerteventura, 48','Cordoba', 'Cordoba', 14011, 500, 'Zona residencial');

/*La insercion tambien debe ser la ultima, la de cosas que se aprendenS*/
/*(idTicket, fecha, hora, idCaja, idEmpleado, idCentro, idPago, totalTicket)*/
insert into tickets
values (1, '2022/01/01', '10:00:00', 1, 2, 1, 1 ,4);
insert into tickets
values(2, '2022/01/01', '10:15:00', 2, 5, 1, 2, 5);
insert into tickets
values (3, '2022/01/01', '10:30:00', 1, 8, 1, 1, 6);
insert into tickets
values (4, '2022/01/02', '10:00:00', 2, 8, 1, 2, 7);
insert into tickets
values (5, '2022/01/02', '10:30:00', 1, 2, 1, 1, 4);
insert into tickets
values (6, '2022/01/02', '12:00:00', 1, 5, 2, 2, 2);
insert into tickets
values (7, '2022/01/03', '15:30:00', 2, 10, 2, 1, 9);
insert into tickets
values (8, '2022/01/04', '11:00:00', 1, 10, 1, 1, 5);
insert into tickets
values (9, '2022/01/04', '13:30:00', 2, 10, 1, 2, 6);
insert into tickets
values (10, '2022/01/05', '17:00:00', 1, 8, 2, 1, 7);
insert into tickets
values (11, '2022/01/05', '17:30:00', 2, 11, 1, 1, 3);
insert into tickets
values (12, '2022/01/06', '10:15:00', 1, 12, 1, 2, 1);
insert into tickets
values (13, '2022/01/06', '11:30:00', 2, 12, 1, 1, 4);
insert into tickets
values (14, '2022/01/07', '13:00:00', 1, 5, 2, 2, 5);
insert into tickets
values (15, '2022/01/07', '15:30:00', 2, 2, 2, 1, 8);
insert into tickets
values (16, '2022/01/08', '11:00:00', 1, 8, 1, 1, 8);
insert into tickets
values (17, '2022/01/08', '13:30:00', 2, 5, 1, 2, 12);
insert into tickets
values (18, '2022/01/09', '17:00:00', 1, 12, 2, 1, 11);
insert into tickets
values (19, '2022/01/09', '18:00:00', 2, 11, 1, 1, 3);
insert into tickets
values (20, '2022/01/10', '10:00:00', 1, 10, 1, 2, 18);
insert into tickets
values (21, '2022/01/10', '12:00:00', 2, 2, 1, 1, 15);
insert into tickets
values (22, '2022/01/11', '14:00:00', 1, 11, 2, 2, 4);
insert into tickets
values (23, '2022/01/11', '16:30:00', 2, 12, 2, 1, 2);