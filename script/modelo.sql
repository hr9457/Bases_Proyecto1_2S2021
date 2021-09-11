-- ****************************
-- tabla pais
-- ****************************

CREATE TABLE pais (
    id_pais INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre VARCHAR2(150) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT PK_pais PRIMARY KEY (id_pais);



-- ****************************
-- tabla cuidad
-- ****************************

CREATE TABLE ciudad (
    id_ciudad INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre VARCHAR2(150) NOT NULL,
    id_pais INTEGER NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT PK_ciudad PRIMARY KEY (id_ciudad);
ALTER TABLE ciudad ADD CONSTRAINT FK1_ciudad FOREIGN KEY (id_pais) REFERENCES pais (id_pais) ON DELETE CASCADE;



-- ****************************
-- tabla direccion
-- ****************************

CREATE TABLE direccion (
    id_direccion INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    codigo_postal INTEGER,
    direccion VARCHAR2(150) NOT NULL,
    id_ciudad INTEGER NOT NULL
);

ALTER TABLE direccion ADD CONSTRAINT PK_direccion PRIMARY KEY (id_direccion);
ALTER TABLE direccion ADD CONSTRAINT FK1_direccion FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad) ON DELETE CASCADE;





-- ****************************
-- tabla estado_actividad
-- ****************************
CREATE TABLE estado_actividad (
    id_estado_actividad INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    estado VARCHAR2(150) NOT NULL
);

ALTER TABLE estado_actividad ADD CONSTRAINT PK_estado_actividad PRIMARY KEY (id_estado_actividad);





-- ****************************
-- tabla tienda
-- ****************************

CREATE TABLE tienda (
    id_tienda INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre_tienda VARCHAR2(150) NOT NULL,
    id_direccion INTEGER NOT NULL
);

ALTER TABLE tienda ADD CONSTRAINT PK_tienda PRIMARY KEY (id_tienda);
ALTER TABLE tienda ADD CONSTRAINT FK1_tienda FOREIGN KEY (id_direccion) REFERENCES direccion (id_direccion) ON DELETE CASCADE;






-- ****************************
-- tabla cliente
-- ****************************

CREATE TABLE cliente (
    id_cliente INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre_cliente VARCHAR2(150) NOT NULL,
    apellido_cliente VARCHAR2(150) NOT NULL,
    fecha_registro TIMESTAMP NOT NULL,
    correo_cliente VARCHAR2(150) NOT NULL,
    id_estado_actividad INTEGER NOT NULL,
    id_direccion INTEGER NOT NULL,
    id_tienda INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT PK_cliente PRIMARY KEY (id_cliente);
ALTER TABLE cliente ADD CONSTRAINT FK1_cliente FOREIGN KEY (id_estado_actividad) REFERENCES estado_actividad (id_estado_actividad) ON DELETE CASCADE;
ALTER TABLE cliente ADD CONSTRAINT FK2_cliente FOREIGN KEY (id_direccion) REFERENCES direccion (id_direccion) ON DELETE CASCADE;
ALTER TABLE cliente ADD CONSTRAINT FK3_cliente FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda) ON DELETE CASCADE;




-- ****************************
-- tabla tipo empleado
-- ****************************
CREATE TABLE tipo_empleado (
    id_tipo_empleado INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    tipo VARCHAR2(150) NOT NULL
);

ALTER TABLE tipo_empleado ADD CONSTRAINT PK_tipo_empleado PRIMARY KEY (id_tipo_empleado);




-- ****************************
-- tabla empleado
-- ****************************
CREATE TABLE empleado (
    id_empleado INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre_empleado VARCHAR2(150) NOT NULL,
    apellido_empleado VARCHAR2(150) NOT NULL,
    correo_empleado VARCHAR2(150) NOT NULL,
    usuario_empleado VARCHAR2(150) NOT NULL,
    contrasenia_empleado VARCHAR(200) NOT NULL,
    id_tipo_empleado INTEGER NOT NULL,
    id_tienda INTEGER NOT NULL,
    id_direccion INTEGER NOT NULL,
    id_estado_actividad INTEGER NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT PK_empleado PRIMARY KEY (id_empleado);
ALTER TABLE empleado ADD CONSTRAINT FK1_empleado FOREIGN KEY (id_tipo_empleado) REFERENCES tipo_empleado (id_tipo_empleado) ON DELETE CASCADE;
ALTER TABLE empleado ADD CONSTRAINT FK2_empleado FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda) ON DELETE CASCADE;
ALTER TABLE empleado ADD CONSTRAINT FK3_empleado FOREIGN KEY (id_direccion) REFERENCES direccion (id_direccion) ON DELETE CASCADE;
ALTER TABLE empleado ADD CONSTRAINT FK4_empleado FOREIGN KEY (id_estado_actividad) REFERENCES estado_actividad (id_estado_actividad) ON DELETE CASCADE;






----------------------------------------------

-- ****************************
-- tabla clasificacion
-- ****************************
CREATE TABLE clasificacion (
    id_clasificacion INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre_clasificaion VARCHAR2(150) NOT NULL
);

ALTER TABLE clasificacion ADD CONSTRAINT PK_clasificacion PRIMARY KEY (id_clasificacion);



-- ****************************
-- tabla categoria
-- ****************************

CREATE TABLE categoria (
    id_categoria INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre_categoria VARCHAR2(150) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT PK_categoria PRIMARY KEY (id_categoria);



-- ****************************
-- tabla actor
-- ****************************

CREATE TABLE actor (
    id_actor INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre VARCHAR2(100) NOT NULL,
    apellido VARCHAR2(150) NOT NULL
);

ALTER TABLE actor ADD CONSTRAINT PK_actor PRIMARY KEY (id_actor);



-- ****************************
-- tabla traduccion
-- ****************************

CREATE TABLE traduccion (
    id_traduccion INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    lenguaje VARCHAR2(150) NOT NULL
);

ALTER TABLE traduccion ADD CONSTRAINT PK_traduccion PRIMARY KEY (id_traduccion);



-- ****************************
-- tabla pelicula
-- ****************************
CREATE TABLE pelicula (
    id_pelicula INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    titulo_pelicula VARCHAR2(150) NOT NULL,
    descripcion_pelicula VARCHAR2(500) NOT NULL,
    anio_pelicula INTEGER NOT NULL,
    duracion_pelicula INTEGER NOT NULL,
    dias_renta INTEGER NOT NULL,
    costo_renta NUMBER(10,2) NOT NULL,
    costo_por_danio NUMBER(10,2) NOT NULL,
    id_clasificacion INTEGER NOT NULL
);

ALTER TABLE pelicula ADD CONSTRAINT PK_pelicula PRIMARY KEY (id_pelicula);
ALTER TABLE pelicula ADD CONSTRAINT FK1_pelicula FOREIGN KEY (id_clasificacion) REFERENCES clasificacion (id_clasificacion) ON DELETE CASCADE;




-- ****************************
-- tabla pelicula_categoria
-- ****************************

CREATE TABLE pelicula_categoria (
    id_categoria INTEGER NOT NULL,
    id_pelicula INTEGER NOT NULL
);

ALTER TABLE pelicula_categoria ADD CONSTRAINT FK1_pelicula_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria) ON DELETE CASCADE;
ALTER TABLE pelicula_categoria ADD CONSTRAINT FK2_pelicula_categoria FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula) ON DELETE CASCADE;



-- ****************************
-- tabla pelicula_actor
-- ****************************

CREATE TABLE pelicula_actor (
    id_actor INTEGER NOT NULL,
    id_pelicula INTEGER NOT NULL
);

ALTER TABLE pelicula_actor ADD CONSTRAINT FK1_pelicula_actor FOREIGN KEY (id_actor) REFERENCES actor (id_actor) ON DELETE CASCADE;
ALTER TABLE pelicula_actor ADD CONSTRAINT FK2_pelicula_actor FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula) ON DELETE CASCADE;



-- ****************************
-- tabla pelicula_traduccion
-- ****************************

CREATE TABLE pelicula_traduccion (
    id_traduccion INTEGER NOT NULL,
    id_pelicula INTEGER NOT NULL
);

ALTER TABLE pelicula_traduccion ADD CONSTRAINT FK1_pelicula_traduccion FOREIGN KEY (id_traduccion) REFERENCES traduccion (id_traduccion) ON DELETE CASCADE;
ALTER TABLE pelicula_traduccion ADD CONSTRAINT FK2_pelicula_traduccion FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula) ON DELETE CASCADE;




-- ****************************
-- tabla inventario
-- ****************************

CREATE TABLE inventario (
    id_inventario INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    id_tienda INTEGER NOT NULL,
    id_pelicula INTEGER NOT NULL
);

ALTER TABLE inventario ADD CONSTRAINT PK_inventario PRIMARY KEY (id_inventario);
ALTER TABLE inventario ADD CONSTRAINT FK1_inventario FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda) ON DELETE CASCADE;
ALTER TABLE inventario ADD CONSTRAINT FK2_inventario FOREIGN KEY (id_pelicula) REFERENCES pelicula (id_pelicula) ON DELETE CASCADE;




-- ****************************
-- tabla factura
-- ****************************

CREATE TABLE factura (
    id_factura INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    fecha_facturacion TIMESTAMP NOT NULL,
    monto_toal NUMBER(10,2) NOT NULL,
    id_empleado INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL
);

ALTER TABLE factura ADD CONSTRAINT PK_factura PRIMARY KEY (id_factura);
ALTER TABLE factura ADD CONSTRAINT FK1_factura FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado) ON DELETE CASCADE;
ALTER TABLE factura ADD CONSTRAINT FK2_factura FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) ON DELETE CASCADE;




-- ****************************
-- tabla detalle_factura
-- ****************************

CREATE TABLE detalle_factura(
    fecha_alquiler TIMESTAMP NOT NULL,
    fecha_retorno TIMESTAMP,
    id_inventario INTEGER NOT NULL,
    id_factura INTEGER NOT NULL
);



ALTER TABLE detalle_factura ADD CONSTRAINT FK1_detalle_factura FOREIGN KEY (id_inventario) REFERENCES inventario (id_inventario) ON DELETE CASCADE;
ALTER TABLE detalle_factura ADD CONSTRAINT FK2_detalle_factura FOREIGN KEY (id_factura) REFERENCES factura (id_factura) ON DELETE CASCADE;












---------------------------------------------------
-- ****************************
-- DROP comandos para eliminar tablas
-- ****************************

DROP TABLE pais CASCADE CONSTRAINTS;
DROP TABLE ciudad CASCADE CONSTRAINTS;
DROP TABLE direccion CASCADE CONSTRAINTS;
DROP TABLE estado_actividad CASCADE CONSTRAINTS;
DROP TABLE tienda CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE tipo_empleado CASCADE CONSTRAINTS;
DROP TABLE empleado CASCADE CONSTRAINTS;
DROP TABLE clasificacion CASCADE CONSTRAINTS;
DROP TABLE categoria CASCADE CONSTRAINTS;
DROP TABLE actor CASCADE CONSTRAINTS;
DROP TABLE traduccion CASCADE CONSTRAINTS;
DROP TABLE pelicula CASCADE CONSTRAINTS;
DROP TABLE pelicula_categoria CASCADE CONSTRAINTS;
DROP TABLE pelicula_actor CASCADE CONSTRAINTS;
DROP TABLE pelicula_traduccion CASCADE CONSTRAINTS;
DROP TABLE inventario CASCADE CONSTRAINTS;
DROP TABLE factura CASCADE CONSTRAINTS;
DROP TABLE detalle_factura CASCADE CONSTRAINTS;