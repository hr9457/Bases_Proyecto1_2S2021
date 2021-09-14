-- ****************************
-- 1. Mostrar cantidad de copias que existen en el 
-- inventario para la pelicula sugar wonka
-- cantidad = 2 
-- ****************************

SELECT COUNT(inventario.id_inventario) as cantidad
FROM inventario
    INNER JOIN pelicula ON pelicula.id_pelicula = inventario.id_pelicula AND pelicula.titulo_pelicula = 'SUGAR WONKA';



-- ****************************
-- 2. Mostar nombre, apellido y pago total de todos los  
-- clientes que han rentado peliculas por lo menos 40 veces
-- cantidad = 7
-- ****************************

SELECT COUNT(renta.id_cliente) as cantidad, 
        cliente.nombre_cliente as nombre,
        cliente.apellido_cliente as apellido,
        SUM(renta.pago) as pago
FROM renta
    INNER JOIN cliente ON renta.id_cliente = cliente.id_cliente
GROUP BY (renta.id_cliente), cliente.nombre_cliente, cliente.apellido_cliente
HAVING COUNT(renta.id_cliente) >= 40;



-- ****************************
-- 3. Mostar nombre, apellido y nombre de la pelicula de 
-- clientes que hayan rentado una pelicula y no hayan devuelo 
-- y donde la fecha de alquiler este mas alla de la especificada por la pelicula 
-- cantidad = 6,548
-- ****************************

SELECT 
        cliente.nombre_cliente AS nombre,
        cliente.apellido_cliente AS apellido,
        pelicula.titulo_pelicula AS titulo
FROM renta
    INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
    INNER JOIN inventario ON inventario.id_inventario = renta.id_inventario
    INNER JOIN pelicula ON inventario.id_pelicula = pelicula.id_pelicula
WHERE renta.fecha_retorno IS NULL

    UNION
    
SELECT 
        cliente.nombre_cliente AS nombre,
        cliente.apellido_cliente AS apellido,
        pelicula.titulo_pelicula AS titulo
FROM renta
    INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
    INNER JOIN inventario ON inventario.id_inventario = renta.id_inventario
    INNER JOIN pelicula ON inventario.id_pelicula = pelicula.id_pelicula
WHERE renta.fecha_retorno > (renta.fecha_alquiler + pelicula.dias_renta + 1);




-- ****************************
-- Mostar el nombre y apellid (en una sola columna) de los actores
-- que contiene la palabra SON en su apellido y ordenador por su primer nombre
-- cantidad = 9
-- ****************************

SELECT actor.nombre||' '||actor.apellido AS actor
FROM actor
WHERE INSTR( actor.apellido,'son',1,1) >= 1
ORDER BY actor.nombre ASC;





-- ****************************
-- mostrar el apellido de todos los actores y la cantidad de actores que tiene ese apellido
-- 
-- ****************************
-- apellidos 121 y nombres 51

SELECT APELLIDOS_IGUALES.APELLIDO
FROM(
    SELECT actor.apellido AS APELLIDO, 
            COUNT(actor.apellido) AS CANTIDAD
    FROM actor
    GROUP BY APELLIDO)APELLIDOS_IGUALES;

SELECT NOMBRES_IGUALES.NOMBRE
FROM(
    SELECT actor.nombre AS NOMBRE, 
            COUNT(actor.nombre) AS CANTIDAD
    FROM actor
    GROUP BY NOMBRE)NOMBRES_IGUALES
WHERE NOMBRES_IGUALES.CANTIDAD >=2;


-- 122
SELECT actor.nombre,actor.apellido, SUB1.APELLIDO AS P, SUB2.CANTIDAD
FROM actor
    INNER JOIN (

        SELECT APELLIDOS_IGUALES.APELLIDO, APELLIDOS_IGUALES.CANTIDAD
        FROM(
            SELECT actor.apellido AS APELLIDO, 
                    COUNT(actor.apellido) AS CANTIDAD
            FROM actor
            GROUP BY APELLIDO)APELLIDOS_IGUALES
            )SUB1 ON SUB1.APELLIDO = actor.apellido
    
    INNER JOIN (
        SELECT NOMBRES_IGUALES.NOMBRE, NOMBRES_IGUALES.CANTIDAD
        FROM(
            SELECT actor.nombre AS NOMBRE, 
                    COUNT(actor.nombre) AS CANTIDAD
            FROM actor
            GROUP BY NOMBRE)NOMBRES_IGUALES
        WHERE NOMBRES_IGUALES.CANTIDAD >=2  
        )SUB2 on SUB2.NOMBRE = actor.nombre
    ;








-- ****************************
-- nombre, apellido de los actores que participaron en peliculas 
-- que involucran un Cocodrilo y Tiburon junto con el año de lanzamiento, ordenados por el apellido del actor en forma ascendente 
-- cantidad = 58
-- ****************************

SELECT actor.nombre, 
        actor.apellido, 
        pelicula.anio_pelicula AS lanzamiento
FROM pelicula_actor
    INNER JOIN actor ON actor.id_actor = pelicula_actor.id_actor
    INNER JOIN pelicula ON pelicula.id_pelicula = pelicula_actor.id_pelicula
WHERE pelicula.descripcion_pelicula LIKE '%Shark%' AND pelicula.descripcion_pelicula LIKE '%Crocodile%'
ORDER BY actor.apellido ASC;





-- ****************************
-- nombre de la categoria y el numero de peliculas por categoria
-- que la cantidad este entre 55 y 65
-- 10
-- ****************************


SELECT categorias.nombre_categoria, categorias.cantidad
FROM(    
    SELECT categoria.nombre_categoria, COUNT(pelicula.id_pelicula) AS cantidad
    FROM pelicula_categoria
        INNER JOIN categoria ON categoria.id_categoria = pelicula_categoria.id_categoria
        INNER JOIN pelicula ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
    GROUP BY categoria.nombre_categoria
    )categorias
WHERE categorias.cantidad >= 55 AND categorias.cantidad <= 65
ORDER BY categorias.cantidad DESC;