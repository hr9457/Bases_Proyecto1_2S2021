

-- consulta para insertar paises = 109
INSERT INTO pais(pais.nombre)
    select temporal.pais_cliente from temporal where temporal.pais_cliente is not null
        union 
            select temporal.pais_empleado from temporal where temporal.pais_empleado is not null
        union 
            select temporal.pais_tienda from temporal where temporal.pais_tienda is not null;





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






-- direcciones = 605
INSERT INTO direccion(direccion.codigo_postal, direccion.direccion, direccion.id_ciudad)
    SELECT DISTINCT temporal.codigo_postal_cliente, temporal.direccion_cliente, ciudad.id_ciudad 
    FROM temporal
        INNER JOIN ciudad ON temporal.ciudad_cliente = ciudad.nombre
    WHERE temporal.direccion_cliente is not null
        UNION
    SELECT DISTINCT temporal.codigo_postal_empleado, temporal.direccion_empleado, ciudad.id_ciudad
    FROM temporal
        INNER JOIN ciudad ON temporal.ciudad_empleado = ciudad.nombre
    WHERE temporal.direccion_empleado is not null AND temporal.codigo_postal_empleado is not null
        UNION
    SELECT DISTINCT temporal.codigo_postal_tienda, temporal.direccion_tienda, ciudad.id_ciudad
    FROM temporal
        INNER JOIN ciudad ON temporal.ciudad_tienda = ciudad.nombre
    WHERE temporal.direccion_tienda is not null AND temporal.codigo_postal_tienda is not null;



-- tiendas = 2
INSERT INTO tienda(tienda.nombre_tienda,tienda.id_direccion)
    SELECT DISTINCT temporal.nombre_tienda, direccion.id_ciudad
    FROM temporal
        INNER JOIN direccion ON temporal.direccion_tienda = direccion.direccion
    WHERE temporal.nombre_tienda is not null;





-- estado de actividad = 2
INSERT INTO estado_actividad(estado_actividad.estado)
    SELECT DISTINCT temporal.cliente_activo 
    FROM temporal
    WHERE temporal.cliente_activo is not null;





-- clientes = 599    
INSERT INTO cliente(cliente.nombre_cliente, cliente.apellido_cliente, cliente.fecha_registro, cliente.correo_cliente, cliente.id_estado_actividad, cliente.id_direccion, cliente.id_tienda)  
    SELECT DISTINCT SUBSTR(temporal.nombre_cliente,1,INSTR(temporal.nombre_cliente,' ')-1) as nombre,
        SUBSTR(temporal.nombre_cliente,INSTR(temporal.nombre_cliente,' ')+1) as apellido, 
        temporal.fecha_creacion as fecha, 
        temporal.correo_cliente as correo,
        estado_actividad.id_estado_actividad as estado,
        direccion.id_direccion as direccion, 
        tienda.id_tienda as tienda
    FROM temporal
        INNER JOIN estado_actividad ON estado_actividad.estado = temporal.cliente_activo
        INNER JOIN tienda ON tienda.nombre_tienda  = temporal.tienda_preferida
        INNER JOIN direccion ON direccion.direccion = temporal.direccion_cliente        
        INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
        INNER JOIN pais ON  pais.id_pais = ciudad.id_pais
    WHERE temporal.nombre_cliente is not null and pais.nombre = temporal.pais_cliente and ciudad.nombre = temporal.ciudad_cliente; 






-----------------------------------------------------------------

-- clasificacion = 5
INSERT INTO clasificacion(clasificacion.nombre_clasificaion)
    select distinct temporal.clasificacion
    from temporal
    where temporal.clasificacion is not null;



-- categorias = 16
INSERT INTO categoria(categoria.nombre_categoria)
    SELECT DISTINCT temporal.categoria_pelicula
    FROM temporal
    WHERE temporal.categoria_pelicula is not null;


-- actores = 199
INSERT INTO actor(actor.nombre,actor.apellido)
    SELECT DISTINCT SUBSTR(temporal.actor_pelicula,1,INSTR(temporal.actor_pelicula,' ')-1) AS nombre,
        SUBSTR(temporal.actor_pelicula,INSTR(temporal.actor_pelicula,' ')+1) AS apellido
            FROM temporal
                WHERE temporal.actor_pelicula is not null;


-- lenguaje = 6
INSERT INTO traduccion(traduccion.lenguaje)                
    SELECT DISTINCT temporal.lenguaje_pelicula
    FROM temporal
    WHERE temporal.lenguaje_pelicula is not null;




-- peliculas = 1000
INSERT INTO pelicula (pelicula.titulo_pelicula, pelicula.descripcion_pelicula, pelicula.anio_pelicula, pelicula.duracion_pelicula, pelicula.dias_renta, pelicula.costo_renta, pelicula.costo_por_danio, pelicula.id_clasificacion) 
    SELECT DISTINCT temporal.nombre_pelicula as titulo, temporal.descripcion_pelicula as descripcion, temporal.anio_lanzamiento as anio, 
                    temporal.duracion, temporal.dias_renta, temporal.costo_renta, temporal.costo_por_danio, clasificacion.id_clasificacion
    FROM temporal
        INNER JOIN clasificacion ON temporal.clasificacion = clasificacion.nombre_clasificaion
    WHERE temporal.nombre_pelicula is not null;



-- pelicula_actor = 5462
INSERT INTO pelicula_actor(pelicula_actor.id_actor, pelicula_actor.id_pelicula)
    SELECT DISTINCT actor.id_actor, pelicula.id_pelicula 
    FROM temporal
        INNER JOIN pelicula ON pelicula.titulo_pelicula = temporal.nombre_pelicula
        INNER JOIN actor ON actor.nombre||' '||actor.apellido = temporal.actor_pelicula;


    

-- pelicula_categoria = 1000
INSERT INTO pelicula_categoria(pelicula_categoria.id_categoria, pelicula_categoria.id_pelicula)
    SELECT DISTINCT categoria.id_categoria, pelicula.id_pelicula
    FROM temporal
        INNER JOIN pelicula ON pelicula.titulo_pelicula = temporal.nombre_pelicula
        INNER JOIN categoria ON categoria.nombre_categoria = temporal.categoria_pelicula;






-- pelicula_traduccion = 1000
INSERT INTO pelicula_traduccion(pelicula_traduccion.id_traduccion, pelicula_traduccion.id_pelicula)
    SELECT DISTINCT traduccion.id_traduccion, pelicula.id_pelicula 
    FROM temporal
        INNER JOIN pelicula ON pelicula.titulo_pelicula = temporal.nombre_pelicula
        INNER JOIN traduccion ON traduccion.lenguaje = temporal.lenguaje_pelicula;




-- inventario = 1521
INSERT INTO inventario(inventario.id_pelicula,inventario.id_tienda)
    SELECT DISTINCT pelicula.id_pelicula, tienda.id_tienda
    FROM temporal
        INNER JOIN pelicula ON pelicula.titulo_pelicula = temporal.nombre_pelicula
        INNER JOIN tienda ON tienda.nombre_tienda = temporal.tienda_pelicula; 







-- tipo de empleado = 2  (1 Encargado) (2 empleado)
INSERT INTO tipo_empleado(tipo_empleado.tipo) VALUES ('encargado');
INSERT INTO tipo_empleado(tipo_empleado.tipo) VALUES ('empleado');




-- empleados = 2
INSERT INTO empleado(empleado.nombre_empleado, empleado.apellido_empleado, empleado.correo_empleado,
                    empleado.usuario_empleado, empleado.contrasenia_empleado, empleado.id_tipo_empleado, 
                    empleado.id_tienda, empleado.id_direccion, empleado.id_estado_actividad)
    SELECT DISTINCT SUBSTR(temporal.nombre_empleado,1,INSTR(temporal.nombre_empleado,' ')-1) AS nombre,
        SUBSTR(temporal.nombre_empleado,INSTR(temporal.nombre_empleado,' ')+1) AS apellido, 
        temporal.correo_empleado AS correo,
        temporal.usuario_empleado AS usser,
        temporal.contrasenia_empleado AS pasword,
        CASE  
            WHEN temporal.nombre_empleado = temporal.encargado_tienda THEN 1 ELSE 2 END AS tipo,
        tienda.id_tienda AS tienda,
        direccion.id_direccion AS direccion,
        estado_actividad.id_estado_actividad AS estado
    FROM temporal
        INNER JOIN tienda ON tienda.nombre_tienda = temporal.tienda_empleado
        INNER JOIN direccion ON direccion.direccion = temporal.direccion_empleado
        INNER JOIN estado_actividad ON  estado_actividad.estado = temporal.empleado_activo
    WHERE temporal.nombre_empleado IS NOT NULL;







-- invetario = 16,044
INSERT INTO renta(renta.fecha_alquiler, renta.fecha_retorno, renta.fecha_facturacion, renta.pago, renta.id_cliente, renta.id_empleado, renta.id_inventario)
    SELECT sub.renta, sub.retorno, sub.facturacion, sub.costo, sub.cliente, sub.empleado, inventario.id_inventario
    FROM inventario
        INNER JOIN (
            SELECT DISTINCT temporal.fecha_renta AS renta, 
                            temporal.fecha_retorno AS retorno,
                            temporal.fecha_renta AS facturacion,
                            pelicula.id_pelicula AS pelicula,
                            pelicula.costo_renta AS costo,
                            cliente.id_cliente AS cliente,
                            empleado.id_empleado AS empleado,
                            tienda.id_tienda AS tienda
            FROM temporal
                INNER JOIN cliente ON temporal.nombre_cliente = cliente.nombre_cliente||' '||cliente.apellido_cliente
                INNER JOIN empleado ON temporal.encargado_tienda = empleado.nombre_empleado||' '||empleado.apellido_empleado
                INNER JOIN tienda ON temporal.tienda_pelicula = tienda.nombre_tienda
                INNER JOIN pelicula ON temporal.nombre_pelicula = pelicula.titulo_pelicula
                WHERE temporal.nombre_cliente IS NOT NULL) sub ON inventario.id_tienda = sub.tienda AND inventario.id_pelicula = sub.pelicula;
                
            
            

