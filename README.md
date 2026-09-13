/*Consulta 1 — Vista base del proyecto (INNER JOIN)

Trabajás sobre el esquema que creaste en el Checkpoint del Módulo 3. Combiná con INNER JOIN tu tabla de ventas con las tablas descriptivas
que hayas modelado (clientes, productos y cualquier otra dimensión de tu caso de negocio) para obtener en una sola fila, como mínimo: 
fecha, identificación del cliente, descripción del producto, cantidad, precio unitario y total de venta.


Sumá además las columnas descriptivas que existan en tu propio esquema (por ejemplo segmento de cliente, categoría de producto o región,
si las modelaste). No es necesario que estén todas: la consulta se evalúa sobre las tablas que vos diseñaste, no sobre una lista fija.

Si tu esquema no tiene ninguna dimensión geográfica ni de segmentación, agregala ahora al script del Módulo 3 con dos o tres registros de 
ejemplo. Esta consulta va a ser la fuente de datos principal en Power BI, así que conviene que tenga al menos una columna para agrupar 
y una para filtrar.*/

SELECT * FROM ventas 
JOIN clientes on clientes.id_cliente = ventas.id_cliente
JOIN productos on productos.id_producto =ventas.id_producto 

/*Consulta 2 — Clientes sin ventas (LEFT JOIN) Identificá clientes registrados que aún no han realizado ninguna compra. Mostrá su nombre,
email y fecha de registro. Usá WHERE ... IS NULL para aislar los casos.*/

select * from clientes
left join ventas on ventas.id_cliente = clientes.id_cliente
where ventas.id_cliente is NULL  

/*Consulta 3 — Productos sin ventas (LEFT JOIN) Identificá productos del catálogo que no tienen ninguna venta registrada. 
Mostrá nombre del producto, categoría y precio. Usá WHERE ... IS NULL.*/
select * from productos
left join ventas on productos.id_producto = ventas.id_producto 
where ventas.id_producto is null 
/*Consulta 4 — Consolidado por canal (UNION ALL)

Importante: la columna canal no se consulta, se crea. No busques ese dato en tus tablas — lo generás vos dentro de cada SELECT 
como valor literal. Ese es el punto de este ejercicio.

Escribí dos SELECT sobre tus ventas, separados por el criterio que corresponda a tu caso (por ejemplo, ventas de dos períodos, 
dos sucursales o dos orígenes distintos), y agregá en cada uno una columna de texto fija que identifique el origen.
Unilos con UNION ALL y cerrá con un GROUP BY para obtener el total por cada origen.

La estructura es esta:

SELECT fecha, total, 'Online' AS canal FROM ventas WHERE ... UNION ALL SELECT fecha, total, 'Presencial' AS canal FROM ventas WHERE ...

Las dos consultas tienen que devolver la misma cantidad de columnas, en el mismo orden y con tipos compatibles. 
Usamos UNION ALL y no UNION porque no queremos que se eliminen filas repetidas: cada venta debe contarse una sola vez, 
unque coincida con otra en todos sus valores.*/
SELECT 
    canal,
    SUM(total_venta) AS total_ventas
FROM (
    SELECT 
        fecha_venta AS fecha,
        cantidad * precio_unitario AS total_venta,
        'Primer semestre' AS canal
    FROM ventas
    WHERE MONTH(fecha_venta) <= 6

    UNION ALL

    SELECT 
        fecha_venta AS fecha,
        cantidad * precio_unitario AS total_venta,
        'Segundo semestre' AS canal
    FROM ventas
    WHERE MONTH(fecha_venta) >= 7
) AS ventas_por_canal
GROUP BY canal;
