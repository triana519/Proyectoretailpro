SELECT
    MONTH (fecha_venta) AS Mes,
    SUM(cantidad * precio_unitario) AS Total_Facturado,
    COUNT(*) AS Cantidad_Pedidos,
    AVG(cantidad * precio_unitario) AS Ticket_Promedio
FROM VENTAS
GROUP BY MONTH (fecha_venta) 
ORDER BY Mes;
--------------------------------------------------------------
/*Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) 
y el total generado.
Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.*/
SELECT TOP(5) ID_PRODUCTO,
SUM (CANTIDAD) AS UNIDADES_VENDIDAS,
  SUM(cantidad * precio_unitario) AS Total_Facturado
  FROM VENTAS 
  GROUP BY ID_PRODUCTO 
    ORDER BY Total_Facturado DESC
  -----------------------------------------------------------------
/*Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado. 
Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.*/
SELECT ID_CLIENTE,
    COUNT (*) AS CANTIDAD_PEDIDOS,
SUM (CANTIDAD* PRECIO_UNITARIO ) AS TOTAL_FACTURADO
    FROM VENTAS 
GROUP BY ID_CLIENTE 
    HAVING COUNT (*) > 1 ORDER BY TOTAL_FACTURADO DESC ; 
-----------------------------------------------------------------
/*Consulta 4 — Meses por encima/por debajo del promedio Total facturado por mes, 
con una columna adicional que etiquete con CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.*/
SELECT
    MONTH(fecha_venta) AS Mes,
    SUM(cantidad * precio_unitario) AS Total_Facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) >
        (
            SELECT AVG(Total_Mensual)
            FROM (
                SELECT
                    SUM(cantidad * precio_unitario) AS Total_Mensual
                FROM VENTAS
                GROUP BY MONTH(fecha_venta)
            ) AS Promedios
        )
        THEN 'Por encima del promedio'
        ELSE 'Por debajo del promedio'
    END AS Estado
FROM VENTAS
GROUP BY MONTH(fecha_venta)
ORDER BY Mes;

------------------------------------------------------------
/* 1. Los clientes recurrentes realizaron más de un pedido,
-- registrándose aproximadamente 2 pedidos por cliente,
-- con gastos que van aproximadamente desde $510 hasta $2.700.

-- 2. Los productos que integran el Top 5 del ranking
-- superan aproximadamente los $3.600 de facturación total.

-- 3. Al comparar la facturación mensual con el promedio general,
-- se observa que el total facturado se encuentra por debajo
-- del promedio mensual.*/
