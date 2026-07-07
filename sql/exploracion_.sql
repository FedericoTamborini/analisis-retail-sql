-- Exploracion del dataset Superstore

-- Consigna 1: Periodo del dataset

SELECT COUNT(*) AS total_ventas,
	MIN(order_date) AS primera_venta,
	MAX(order_date) AS ultima_venta
FROM ventas_raw;

-- hallazgo: 9994 ventas entre 2014-01-03 y 2017-12-0

-- Consigna 2: Categorias: 

SELECT DISTINCT category AS categoria,
	sub_category AS sub_categoria
FROM ventas_raw;


SELECT category, COUNT(DISTINCT(sub_category)) AS sub_categoria 
FROM ventas_raw
GROUP BY category;

-- Hallazgo: 3 categorias y 17 subcategorias en total.
-- Office Supplies es la mas diversa (9 subcategorias, mas de la mitad del catalogo)
-- Furniture y Technology tienen 4 cada una.
-- Pendiente: ver si esa diversidad se traduce en mas facturacion
-- o si vende mucho volumen de productos baratos.

-- Consigna 3: Geografia - En cueantos estados distintos se vendio?

SELECT COUNT(DISTINCT(state)) AS total_estado 
FROM ventas_raw;

SELECT state, COUNT(DISTINCT(order_id)) AS ordenes_totales
FROM ventas_raw
GROUP BY stateBilling
ORDER BY ordenes_totales DESC
LIMIT 5;

-- Hallazgo: Ventas en 49 estados, pero muy concentradas:
-- California (1.021 órdenes) casi duplica a New York (562) y
-- los 5 primeros estados acumulan ~2.600 órdenes, la mitad del total.
-- Pendiente: ¿esa concentración en órdenes se repite en facturación
-- y ganancia, o hay estados con pocas órdenes pero tickets altos?
	
--Consigna 4: Cuanto facturo la empresa?


SELECT category,
       SUM(sales)  AS facturacion,
       SUM(profit) AS ganancia,
       COUNT(*)    AS cantidad_ventas
FROM ventas_raw
GROUP BY category
ORDER BY facturacion DESC;

-- Hallazgo: Las 3 categorías facturan cifras similares (~$719K a $836K),
-- pero la ganancia es muy dispareja: Technology dejó $145K y Office
-- Supplies $122K, mientras que Furniture ganó apenas $18K — 8 veces
-- menos que Technology facturando casi lo mismo. Furniture está
-- prácticamente trabajando gratis.
-- Pendiente: ¿es toda Furniture o hay una subcategoría específica
-- que hunde el resultado? ¿Qué rol juegan los descuentos? ¿Cuántas
-- ventas con pérdida (profit negativo) hay en el dataset?
