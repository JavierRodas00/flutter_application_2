use deTocho1;

insert into genero values ('0', 'Hombre');
insert into genero values ('1', 'Mujer');

insert into categoria(descripcion_categoria) 
values ('Comida');
insert into categoria(descripcion_categoria) 
values ('Ropa');
insert into categoria(descripcion_categoria) 
values ('Accesorios');

insert into edificio(nombre_edificio, avenida_edificio, calle_edificio, numero_edificio, zona) 
values('Statera', 'Independencia', '11', '11-47', '2');
insert into edificio(nombre_edificio, avenida_edificio, calle_edificio, numero_edificio, zona) 
values('Ciudad Nueva 2', '14', '11', '11-16','2');

insert into producto(nombre_producto, descripcion_producto, precio_producto, id_categoria) 
values('Tamal', 'Tamal rico', 10.50, 1);
insert into producto(nombre_producto, descripcion_producto, precio_producto, id_categoria) 
values('Cocacola', 'Coca cola 1.5L', 17, 1);

insert into usuario(correo_usuario, nombre_usuario, apellido_usuario, telefono_usuario, password_usuario)
values ('javierrodasrojas511@gmail.com', 'Javier', 'Rodas', '31029401', md5('javier'));
insert into usuario(correo_usuario, nombre_usuario, apellido_usuario, telefono_usuario, password_usuario, admin_usuario)
values ('test', 'Test1', 'Test2', '12345678', md5('test'), 1);


select * from usuario;
select * from producto;
select * from promociones;


delete from producto where id_producto > 6;