drop database if exists deTocho1;
create database deTocho1;
use deTocho1;

create table genero(
	id_genero char(1),
    descripcion_genero varchar(20),
    primary key(id_genero)
);

create table usuario(
	id_usuario int auto_increment,
    correo_usuario varchar(200) unique,
    nombre_usuario varchar(200),
    apellido_usuario varchar(200),
    id_genero char(1),
    fecha_nac date,
    telefono_usuario varchar(10),
    password_usuario varchar(200),
    admin_usuario char(1) default 0,
    primary key(id_usuario),
    foreign key (id_genero) references genero(id_genero)
);

create table edificio(
	id_edificio int auto_increment,
    nombre_edificio varchar(100),
    avenida_edificio char(20),
    calle_edificio char(20),
    numero_edificio char(10),
    zona char(2),
    primary key(id_edificio)
);

create table categoria(
	id_categoria int auto_increment,
    descripcion_categoria varchar(50),
    primary key(id_categoria)
);

create table imagen(
	id_imagen int auto_increment,
    nombre varchar(100),
    tipo varchar(10),
    tamano BIGINT, 
    pixel LONGBLOB,
    primary key (id_imagen)
);


create table producto(
	id_producto int auto_increment,
    nombre_producto varchar(100),
    descripcion_producto varchar(200),
    precio_producto float,
    imagen_producto longtext,
    id_categoria int,
    primary key(id_producto),
    foreign key (id_categoria) references categoria(id_categoria)
);

create table direccion_usuario(
	id_direccion_usuario int auto_increment,
    id_usuario int,
    id_edificio int,
    numero_apto char(10),
    primary key (id_direccion_usuario),
    foreign key (id_usuario) references usuario(id_usuario),
    foreign key (id_edificio) references edificio(id_edificio)
);

create table pedido(
	id_pedido int auto_increment,
    id_usuario int,
    id_direccion_usuario int,
    fecha date,
    primary key(id_pedido)
);

create table pedido_producto(
	id_pedido int,
    id_producto int,
    cantidad_producto int,
    primary key(id_pedido,id_producto)
);




