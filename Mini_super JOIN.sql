USE MINI_SUPER
GO

SELECT
FORMAT(P.FechaPedido, 'MM/yyyy') MES_ANIO,
SUM (D.Cantidad*PR.Precio)TOTAL_VENTAS,
COUNT (P.IDPedido) CANTIDAD_FACTURAS,
MAX(D.Cantidad*PR.Precio) MONTO_MAS_ALTO
FROM CLIENTE C
JOIN PEDIDO P ON C.IDCliente = P.IDCliente
JOIN DETALLE D ON D.IDPedido = P.IDPedido
JOIN PRODUCTO PR ON PR.IDProducto = D.IDProducto
GROUP BY FORMAT(P.FechaPedido, 'MM/yyyy')
 
SELECT FORMAT(P.FechaPedido, 'MM/yyyy') Fecha,
C.NombreCompleto CLIENTE,
SUM(D.Cantidad*PR.Precio) TOTAL,
COUNT (P.IDPedido) FACTURAS,
MAX(P.FechaPedido) ULTIMA_COMPRA,
MIN(P.FechaPedido) PRIMERA_COMPRA,
ROW_NUMBER() OVER (PARTITION BY FORMAT(P.FechaPedido, 'MM/yyyy') ORDER BY SUM(D.Cantidad*PR.Precio) DESC) AS ORDEN
FROM CLIENTE C
JOIN PEDIDO P ON C.IDCliente = P.IDCliente
JOIN DETALLE D ON D.IDPedido = P.IDPedido
JOIN PRODUCTO PR ON PR.IDProducto = D.IDProducto
GROUP BY FORMAT(P.FechaPedido, 'MM/yyyy'),C.NombreCompleto