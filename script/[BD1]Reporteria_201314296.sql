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
-- 4. Mostar el nombre y apellid (en una sola columna) de los actores
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





-- ****************************
-- mostrar todas la categorias y promedio del costo del remplazo de la pelicula
-- y precio de alquiler sea superior a 17
-- cantidad = 8
-- ****************************

SELECT 
    categorias.CATEGORIA,
    categorias.PROMEDIO
FROM (
        SELECT 
            categoria.nombre_categoria AS CATEGORIA, 
            ROUND( AVG(pelicula.costo_por_danio) - AVG(pelicula.costo_renta),2) AS PROMEDIO
        FROM pelicula_categoria
            INNER JOIN categoria ON categoria.id_categoria = pelicula_categoria.id_categoria
            INNER JOIN pelicula ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
        GROUP BY categoria.nombre_categoria
    )categorias
WHERE categorias.PROMEDIO >= 17;





-- ****************************
-- 9. nombre y apellido de actores 
-- peliculas en las que tiene dos o mas actores
-- cantidad = 5,462
-- ****************************

SELECT 
    pelicula.titulo_pelicula AS TITULO,
    actor.nombre AS NOMBRE, 
    actor.apellido AS APELLIDO    
FROM pelicula_actor
    INNER JOIN actor ON actor.id_actor = pelicula_actor.id_actor
    INNER JOIN pelicula ON pelicula.id_pelicula = pelicula_actor.id_pelicula
    INNER JOIN (
        SELECT
            pelicula_actor.id_actor,
            COUNT(pelicula_actor.id_pelicula) AS CANTIDAD
        FROM pelicula_actor
        GROUP BY pelicula_actor.id_actor
    )cantidad ON cantidad.id_actor = pelicula_actor.id_actor
WHERE cantidad.CANTIDAD >= 2
ORDER BY TITULO
;






-- ****************************
-- 10. mostara nombre y apellido (en una sola columna) de todos los actores y clientes 
-- cuyo primer nombre sea el mismo que el primer nombre del actor id=8 no se debe retorno el id 
-- cantidad = 3
-- ****************************


SELECT 
    actor.nombre ||' '||actor.apellido AS ACTOR
FROM actor
WHERE actor.nombre = (SELECT actor.nombre ACTOR
                        FROM actor
                        WHERE actor.id_actor = 8)


    UNION


SELECT 
    cliente.nombre_cliente ||' '||cliente.apellido_cliente AS CLIENTE
FROM cliente
WHERE cliente.nombre_cliente = (SELECT actor.nombre ACTOR
                                FROM actor
                                WHERE actor.id_actor = 8);






-------------------------------------
-- mostrar pais y nombre cliente que mas peliculas rento  
-- el porcentaje que representa la cantidad de peliulas que rento con resto de los demas cliente 
-- de ese pais
-- cantidad = 1
SELECT 
    pais.nombre,
    cliente.nombre_cliente,
    ((  SELECT 
            COUNT(renta.id_inventario)
        FROM renta 
            INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
            INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
            INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
            INNER JOIN pais ON pais.id_pais = ciudad.id_pais
        WHERE pais.id_pais = (
                            SELECT  
                                pais.id_pais
                            FROM cliente    
                                INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
                                INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
                                INNER JOIN pais ON pais.id_pais = ciudad.id_pais
                                INNER JOIN (
                                        SELECT
                                            renta.id_cliente AS ID_CLIENTE,
                                            COUNT(renta.id_cliente) AS CANTIDAD
                                        FROM renta
                                        GROUP BY renta.id_cliente
                                        ORDER BY CANTIDAD DESC
                                        FETCH FIRST 1 ROWS ONLY
                                )CLIENTE_CANTIDAD ON cliente_cantidad.ID_CLIENTE = cliente.id_cliente)
    )/(CLIENTE_CANTIDAD.CANTIDAD))*100 AS PORCENTAJE
FROM cliente    
    INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
    INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
    INNER JOIN pais ON pais.id_pais = ciudad.id_pais
    INNER JOIN (
            SELECT
                renta.id_cliente AS ID_CLIENTE,
                COUNT(renta.id_cliente) AS CANTIDAD
            FROM renta
            GROUP BY renta.id_cliente
            ORDER BY CANTIDAD DESC
            FETCH FIRST 1 ROWS ONLY
    )CLIENTE_CANTIDAD ON cliente_cantidad.ID_CLIENTE = cliente.id_cliente;






-------------------------------------
-- 13.
-- cantidad = 108
--- cliente y informacion de su pais
-- 113

SELECT subconsulta1.city, subconsulta2.cliente, subconsulta1.cantidad
FROM(
    SELECT 
        consulta.identificador,
        consulta.city,
        MAX(consulta.cantidad) AS cantidad
    FROM (
        SELECT 
            pais.id_pais AS identificador,
            pais.nombre AS city,
            cliente.nombre_cliente||' '||cliente.apellido_cliente AS cliente,
            COUNT(renta.id_cliente) AS cantidad        
        FROM renta 
            INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
            INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
            INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
            INNER JOIN pais ON pais.id_pais = ciudad.id_pais
        GROUP BY pais.id_pais ,pais.nombre, cliente.nombre_cliente||' '||cliente.apellido_cliente
        ORDER BY city ASC
        ) consulta
    GROUP BY consulta.identificador, consulta.city 
    ORDER BY consulta.city ASC
    )SubConsulta1
        INNER JOIN (
            SELECT 
                    pais.id_pais AS identificador,
                    pais.nombre AS city,
                    cliente.nombre_cliente||' '||cliente.apellido_cliente AS cliente,
                    COUNT(renta.id_cliente) AS cantidad        
                FROM renta 
                    INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
                    INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
                    INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
                    INNER JOIN pais ON pais.id_pais = ciudad.id_pais
                GROUP BY pais.id_pais ,pais.nombre, cliente.nombre_cliente||' '||cliente.apellido_cliente
                ORDER BY city ASC
        )SubConsulta2 ON SubConsulta2.cantidad = SubConsulta1.cantidad AND subconsulta1.city = subconsulta2.city;





-- ****************************
-- 14. tipo de pelicula mas rentadad por ciudad 
-- y que sean de tipo horror
-- cantidad = 256
-- ****************************


SELECT 
    horror.city,
    horror.country
FROM(
    SELECT 
        ciudad.id_ciudad,
        ciudad.nombre AS country,
        subConsulta1.categoria,
        pais.nombre AS city,
        COUNT(inventario.id_inventario) AS cantidad
    FROM renta
        INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
        INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
        INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
        INNER JOIN pais ON pais.id_pais = ciudad.id_pais
        INNER JOIN inventario ON inventario.id_inventario = renta.id_inventario
        INNER JOIN (
            -- peliculas de tipo horror = 56
            SELECT 
                pelicula.id_pelicula, 
                pelicula.titulo_pelicula, 
                categoria.nombre_categoria AS categoria
            FROM pelicula_categoria
                INNER JOIN  pelicula ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
                INNER JOIN  categoria ON categoria.id_categoria = pelicula_categoria.id_categoria
        )subConsulta1 ON subconsulta1.id_pelicula = inventario.id_pelicula
    GROUP BY ciudad.id_ciudad, ciudad.nombre, subConsulta1.categoria, pais.nombre
    ORDER BY ciudad.id_ciudad ASC)todas

    INNER JOIN(
        SELECT 
            ciudad.id_ciudad,
            ciudad.nombre AS country,
            pais.nombre AS city,
            COUNT(renta.id_cliente) AS cantidad
        FROM renta
            INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
            INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
            INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
            INNER JOIN pais ON pais.id_pais = ciudad.id_pais
            INNER JOIN inventario ON inventario.id_inventario = renta.id_inventario
            INNER JOIN (
                -- peliculas de tipo horror = 56
                SELECT 
                    pelicula.id_pelicula, 
                    pelicula.titulo_pelicula, 
                    categoria.nombre_categoria
                FROM pelicula_categoria
                    INNER JOIN  pelicula ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
                    INNER JOIN  categoria ON categoria.id_categoria = pelicula_categoria.id_categoria
                    WHERE categoria.nombre_categoria = 'Horror'
            )subConsulta1 ON subconsulta1.id_pelicula = inventario.id_pelicula
        GROUP BY ciudad.id_ciudad, ciudad.nombre, pais.nombre
        ORDER BY ciudad.id_ciudad ASC    
    )horror ON todas.city = horror.city AND horror.cantidad > todas.cantidad
GROUP BY horror.city, horror.country;





-- ****************************
-- 15. mostrar el nombre del pais, el promedio por pais 
-- cantidad = 101
-- ****************************

SELECT
    rentas.city,
    ROUND(rentas.cantidad/ciudades.cantidad,2) AS promedio
FROM(
    SELECT
        pais.id_pais AS identificador,
        pais.nombre AS city,
        COUNT(renta.id_cliente) AS cantidad
    FROM renta
        INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
        INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
        INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
        INNER JOIN pais ON pais.id_pais = ciudad.id_pais
    GROUP BY pais.id_pais,pais.nombre
    ORDER BY pais.nombre)rentas
,
    (
        SELECT
            pais.id_pais AS identificador,
            pais.nombre AS city,
            COUNT(ciudad.nombre) AS CANTIDAD
        FROM ciudad
            INNER JOIN pais ON pais.id_pais = ciudad.id_pais
        GROUP BY pais.id_pais,pais.nombre
        ORDER BY pais.nombre
    )ciudades
WHERE rentas.city = ciudades.city;




-- ****************************
-- 16. nombre del pais y porcentaje de rentas de peliculas de la categoria sports
-- cantidad = 101
-- ****************************

-- peliculas sports por pais = 101
SELECT 
    pais.id_pais, 
    pais.nombre,
    ROUND( sport.cantidad/cantidad.cantidad ,2)*100 AS promedio
FROM pais
    INNER JOIN(
        SELECT 
            pais.id_pais AS identificador,
            pais.nombre AS city,
            COUNT(renta.id_cliente) AS cantidad
        FROM renta
            INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
            INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
            INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
            INNER JOIN pais ON pais.id_pais = ciudad.id_pais
            INNER JOIN inventario ON inventario.id_inventario = renta.id_inventario
            INNER JOIN (
                -- peliculas de tipo horror = 56
                SELECT 
                    pelicula.id_pelicula, 
                    pelicula.titulo_pelicula, 
                    categoria.nombre_categoria
                FROM pelicula_categoria
                    INNER JOIN  pelicula ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
                    INNER JOIN  categoria ON categoria.id_categoria = pelicula_categoria.id_categoria
            )subConsulta1 ON subconsulta1.id_pelicula = inventario.id_pelicula
        GROUP BY pais.id_pais, pais.nombre
        ORDER BY city ASC
    ) cantidad ON cantidad.identificador = pais.id_pais
    INNER JOIN(
        SELECT 
            pais.id_pais AS identificador,
            pais.nombre AS city,
            COUNT(renta.id_cliente) AS cantidad
        FROM renta
            INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
            INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
            INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
            INNER JOIN pais ON pais.id_pais = ciudad.id_pais
            INNER JOIN inventario ON inventario.id_inventario = renta.id_inventario
            INNER JOIN (
                -- peliculas de tipo horror = 56
                SELECT 
                    pelicula.id_pelicula, 
                    pelicula.titulo_pelicula, 
                    categoria.nombre_categoria
                FROM pelicula_categoria
                    INNER JOIN  pelicula ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
                    INNER JOIN  categoria ON categoria.id_categoria = pelicula_categoria.id_categoria
                    WHERE categoria.nombre_categoria = 'Sports'
            )subConsulta1 ON subconsulta1.id_pelicula = inventario.id_pelicula
        GROUP BY pais.id_pais, pais.nombre
        ORDER BY city ASC      
    )sport ON sport.identificador = pais.id_pais
ORDER BY promedio;






-- ****************************
-- 17. mostrar el listado de Estados Unidos 
-- cantidad = 20
-- ****************************

SELECT ciudades.country, ciudades.cantidad
FROM(
    SELECT 
        pais.id_pais AS identificador,
        pais.nombre AS city,
        ciudad.nombre AS country,
        COUNT(renta.id_cliente) AS cantidad
    FROM renta
        INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
        INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
        INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
        INNER JOIN pais ON pais.id_pais = ciudad.id_pais
        INNER JOIN inventario ON inventario.id_inventario = renta.id_inventario
        INNER JOIN (
            -- peliculas de tipo horror = 56
            SELECT 
                pelicula.id_pelicula, 
                pelicula.titulo_pelicula, 
                categoria.nombre_categoria
            FROM pelicula_categoria
                INNER JOIN  pelicula ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
                INNER JOIN  categoria ON categoria.id_categoria = pelicula_categoria.id_categoria
        )subConsulta1 ON subconsulta1.id_pelicula = inventario.id_pelicula
    WHERE pais.nombre = 'United States'
    GROUP BY pais.id_pais, pais.nombre, ciudad.nombre
    ORDER BY city ASC)ciudades
    INNER JOIN (
        SELECT 
            pais.id_pais AS identificador,
            pais.nombre AS city,
            ciudad.nombre AS country,
            COUNT(renta.id_cliente) AS cantidad
        FROM renta
            INNER JOIN cliente ON cliente.id_cliente = renta.id_cliente
            INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion
            INNER JOIN ciudad ON ciudad.id_ciudad = direccion.id_ciudad
            INNER JOIN pais ON pais.id_pais = ciudad.id_pais
            INNER JOIN inventario ON inventario.id_inventario = renta.id_inventario
            INNER JOIN (
                -- peliculas de tipo horror = 56
                SELECT 
                    pelicula.id_pelicula, 
                    pelicula.titulo_pelicula, 
                    categoria.nombre_categoria
                FROM pelicula_categoria
                    INNER JOIN  pelicula ON pelicula.id_pelicula = pelicula_categoria.id_pelicula
                    INNER JOIN  categoria ON categoria.id_categoria = pelicula_categoria.id_categoria
            )subConsulta1 ON subconsulta1.id_pelicula = inventario.id_pelicula
        WHERE pais.nombre = 'United States' AND ciudad.nombre = 'Dayton'
        GROUP BY pais.id_pais, pais.nombre, ciudad.nombre
        ORDER BY city ASC
    )dayton ON ciudades.cantidad > dayton.cantidad;
