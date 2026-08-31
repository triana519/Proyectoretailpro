SELECT
    EXTRACT(MONTH FROM fecha_venta) AS Mes,
    SUM(cantidad * precio_unitario) AS Total_Facturado,
    COUNT(*) AS Cantidad_Pedidos,
    AVG(cantidad * precio_unitario) AS Ticket_Promedio
FROM VENTAS
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY Mes;
--------------------------------------------------------------
Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) 
y el total generado.
Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.
SELECT TOP(5) ID_PRODUCTO,
SUM (CANTIDAD) AS UNIDAD_VENDIDAS,
  SUM(cantidad * precio_unitario) AS Total_Facturado,
  FROM VENTAS 
  GROUP BY ID_PRODUCTO ORDER BY UNIDADES_VENDIDAS
  -----------------------------------------------------------------
Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado. 
Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.
SELECT *FROM CLIENTES
GRUOP BY ID_CLIENTES HAVING COUNT (*) > 1
-----------------------------------------------------------------
Consulta 4 — Meses por encima/por debajo del promedio Total facturado por mes, 
con una columna adicional que etiquete con CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.
SELECT
    EXTRACT(MONTH FROM fecha_venta) AS Mes,
    SUM(cantidad * precio_unitario) AS Total_Facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) > AVG(cantidad * precio_unitario)
            THEN 'Por encima del promedio'
        ELSE 'Por debajo del promedio'
    END AS Estado
FROM VENTAS
GROUP BY EXTRACT(MONTH FROM fecha_venta);
FROM  , >  
