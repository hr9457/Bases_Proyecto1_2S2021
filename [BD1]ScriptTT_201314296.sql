-- ****************************
-- tabla temporal
-- ****************************

CREATE TABLE temporal(
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
    codigo_postal_empleado NUMBER(10),
    ciudad_empleado VARCHAR2(150),
    pais_empleado VARCHAR2(150),
    nombre_tienda VARCHAR2(150),
    encargado_tienda VARCHAR2(150),
    direccion_tienda VARCHAR2(150),
    codigo_postal_tienda NUMBER(10),
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

-- eliminacion de los datos de la tabla temporal
drop table temporal;

-- eliminacion de la tabla temporal
TRUNCATE table temporal;

