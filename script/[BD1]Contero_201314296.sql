SELECT 'pais', COUNT(*) FROM pais -- 109
    UNION ALL      
SELECT 'ciudad', COUNT(*) FROM ciudad -- 600
    UNION ALL
SELECT 'direccion', COUNT(*) FROM direccion -- 605
    UNION ALL
SELECT 'tienda', COUNT(*) FROM tienda -- 2
    UNION ALL
SELECT 'estado_actividad', COUNT(*) FROM estado_actividad -- 2 
    UNION ALL
SELECT 'cliente', COUNT(*) FROM cliente -- 599
    UNION ALL
SELECT 'clasficacion', COUNT(*) FROM clasificacion -- 5
    UNION ALL
SELECT 'categoria', COUNT(*) FROM categoria -- 16
    UNION ALL
SELECT 'actor', COUNT(*) FROM actor -- 199
    UNION ALL
SELECT 'traduccion', COUNT(*) FROM traduccion -- 6
    UNION ALL
SELECT 'pelicula', COUNT(*) FROM pelicula -- 1000
    UNION ALL
SELECT 'pelicula_actor', COUNT(*) FROM  pelicula_actor -- 5462
    UNION ALL
SELECT 'pelicula_categoria', COUNT(*) FROM pelicula_categoria -- 1000
    UNION ALL
SELECT 'pelicula_traduccion', COUNT(*) FROM pelicula_traduccion  -- 1000
    UNION ALL
SELECT 'inventario', COUNT(*) FROM inventario -- 1521
    UNION ALL
SELECT 'tipo_empleado', COUNT(*) FROM tipo_empleado -- 2
    UNION ALL
SELECT 'empleado', COUNT(*) FROM empleado -- 2
    UNION ALL
SELECT 'renta', COUNT(*) FROM renta; -- 16044