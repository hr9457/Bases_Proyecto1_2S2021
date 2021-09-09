create table temporal(
    nombre_cliente  VARCHAR2(150),
    correo_cliente  VARCHAR2(150),
    cliente_activo  VARCHAR2(10),
    fecha_creacion TIMESTAMP,
    tienda_preferida VARCHAR2(100),
    direccion_cliente VARCHAR2(150),
    codigo_postal_cliente NUMBER(10),
    ciudad_cliente VARCHAR2(100),
    pais_cliente VARCHAR2(100),
    fecha_renta TIMESTAMP,
    fecha_retorno TIMESTAMP,
    monto_a_pagar NUMBER(5,2),
    fecha_pago TIMESTAMP,
    nombre_empleado VARCHAR2(150),
    correo_empleado VARCHAR2(150),
    empleado_activo VARCHAR2(10),
    tienda_empleado VARCHAR2(100),
    usuario_empleado VARCHAR2(150),
    contrasenia_empleado VARCHAR2(200),
    direccion_empleado VARCHAR2(150),
    codigo_postal_empleado VARCHAR2(10),
    ciudad_empleado VARCHAR2(150),
    pais_empleado VARCHAR2(150),
    nombre_tienda VARCHAR2(150),
    encargado_tienda VARCHAR2(150),
    direccion_tienda VARCHAR2(150),
    codigo_postal_tienda VARCHAR2(10),
    ciudad_tienda VARCHAR2(150),
    pais_tienda VARCHAR2(150),
    tienda_pelicula VARCHAR2(150),
    nombre_pelicula VARCHAR2(150),
    descripcion_pelicula VARCHAR2(500),
    anio_lanzamiento number(5),
    dias_renta number(5),
    costo_renta NUMBER(10,2),
    duracion NUMBER(10),
    costo_por_danio NUMBER(10,2),
    clasificacion VARCHAR2(100),
    lenguaje_pelicula VARCHAR2(100),
    categoria_pelicula VARCHAR2(100),
    actor_pelicula VARCHAR2(100)
);

select * from temporal;

drop table temporal;
TRUNCATE table temporal;



-- consulta para insertar paises = 109
INSERT INTO pais(pais.nombre)
    select temporal.pais_cliente from temporal where temporal.pais_cliente is not null
        union 
            select temporal.pais_empleado from temporal where temporal.pais_empleado is not null
        union 
            select temporal.pais_tienda from temporal where temporal.pais_tienda is not null;





-- cantidad cuidades = 600
select temporal.ciudad_cliente from temporal where temporal.ciudad_cliente is not null
    union 
        select temporal.ciudad_empleado from temporal where temporal.ciudad_empleado is not null
    union 
        select temporal.ciudad_tienda from temporal where temporal.ciudad_tienda is not null;


---- consulta para insertar cuidades = 600
INSERT INTO ciudad(ciudad.nombre,ciudad.id_pais)
    select temporal.ciudad_cliente as city, pais.id_pais as country
    from temporal 
        inner join pais on temporal.pais_cliente = pais.nombre
    where temporal.ciudad_cliente is not null
        union
    select temporal.ciudad_empleado as city, pais.id_pais as country
    from temporal 
        inner join pais on temporal.pais_empleado = pais.nombre
    where temporal.ciudad_empleado is not null
        union 
    select temporal.ciudad_tienda as city, pais.id_pais as country
    from temporal
        inner join pais on temporal.pais_tienda = pais.nombre
    where temporal.ciudad_tienda is not null;





-- direcciones = 603
SELECT temporal.codigo_postal_cliente as postal ,temporal.direccion_cliente as direccion, ciudad.id_ciudad as city 
FROM temporal
    INNER JOIN ciudad ON temporal.ciudad_cliente = ciudad.nombre
WHERE temporal.direccion_cliente is not null
    UNION
SELECT temporal.codigo_postal_empleado as postal temporal.direccion_empleado as direccion, ciudad.id_ciudad as city
FROM temporal
    INNER JOIN ciudad ON temporal.ciudad_empleado = ciudad.nombre
WHERE temporal.direccion_empleado is not null

    UNION 
SELECT temporal.direccion_tienda as direccion, ciudad.id_ciudad as city
FROM temporal
    INNER JOIN ciudad ON temporal.ciudad_tienda = ciudad.nombre
WHERE temporal.direccion_tienda is not null;



SELECT distinct temporal.codigo_postal_cliente as postal ,temporal.direccion_cliente as direccion, ciudad.id_ciudad as city 
FROM temporal, ciudad
WHERE temporal.direccion_cliente = ciudad.nombre;




-- tiendas = 2
select distinct temporal.nombre_tienda 
from temporal
where temporal.nombre_tienda is not null;





-- acotres = 199
select distinct temporal.actor_pelicula 
from temporal
where temporal.actor_pelicula is not null;



-- categorias = 16
select distinct temporal.categoria_pelicula
from temporal
where temporal.categoria_pelicula is not null;



-- clasificacion = 5
select distinct temporal.clasificacion
from temporal
where temporal.clasificacion is not null;



-- lenguaje = 6
select distinct temporal.lenguaje_pelicula
from temporal
where temporal.lenguaje_pelicula is not null;



-- estado de actividad = 2 
select DISTINCT temporal.cliente_activo
from temporal
where temporal.cliente_activo is not null;



-- peliculas = 1000
select DISTINCT temporal.nombre_pelicula
from temporal
where temporal.nombre_pelicula is not null;



-- encargados de tiendas = 2
select DISTINCT temporal.encargado_tienda
from temporal
where temporal.encargado_tienda is not null;

