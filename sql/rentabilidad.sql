-- Sospechas dentro de Furniture
SELECT sub_category,
	SUM(sales) AS ventas, 
	SUM(profit) AS ganancia,
	COUNT(*) AS ventas_totales
FROM ventas_raw
WHERE category = 'Furniture'
GROUP BY sub_category
ORDER BY ganancia ASC;

-- Hallazgo: Furniture no es deficitaria en bloque: tiene dos subcategorías
-- sanas (Chairs y Furnishings, que ganan juntas $39.600) y dos que pierden
-- dinero activamente (Tables -$17.725 y Bookcases -$3.472).
-- Tables sola pierde casi lo mismo que toda la categoría ganó en 4 años
-- ($18.451): las mesas se comen la ganancia que generan las sillas y
-- los muebles chicos.
-- Pendiente: ¿tiene relación con los descuentos aplicados a estas
-- subcategorías? (ya vimos una mesa con 45% off y profit de -$383

-- Consigna 3: Descuentos

SELECT discount AS descuento,
	SUM(profit) AS ganancia_total,
	ROUND(AVG(profit), 1) AS promedio_de_ganancias,
	COUNT(*) AS ventas_totales
FROM ventas_raw
GROUP BY discount
ORDER BY discount ASC;

SELECT discount AS descuento,
	SUM(profit) AS ganancia_total,
	ROUND(AVG(profit), 1) AS promedio_de_ganancias,
	COUNT(*) AS ventas_totales
FROM ventas_raw
WHERE category = 'Furniture'
GROUP BY discount
ORDER BY discount ASC;

-- Hallazgo: El punto de quiebre está entre el 20% y el 30% de descuento:
-- hasta 20% cada venta deja ganancia en promedio; del 30% en adelante,
-- cada venta pierde plata, y la pérdida crece con el descuento
-- (al 50%, -$310 promedio por venta). El umbral es el mismo para toda
-- la empresa y para Furniture: es un problema de política de descuentos,
-- no de una categoría.
-- Furniture además opera con margen más fino en la zona sana (+$10 promedio
-- al 20% vs +$25 general) y con mucho volumen descontado: 837 de sus
-- 2.121 ventas tienen 20% o más de descuento.
-- El nivel más rentable no es 0% sino 10% (+$96 promedio por venta).
-- Pendiente: ¿cuántas ventas tienen profit negativo y cuánta plata
-- pierden en total?


SELECT COUNT(*) AS ventas_totales,
	SUM(profit) AS perdida_total
FROM ventas_raw
WHERE profit < 0;

SELECT sub_category, 
	COUNT(*) AS ventas_totales,
	SUM (profit) AS perdida_totales
FROM ventas_raw
WHERE profit < 0
GROUP BY sub_category
ORDER BY perdida_totales ASC

-- Hallazgo: 1.871 ventas (casi 1 de cada 5) tienen profit negativo y
-- acumulan -$156.131 de pérdida, más de la mitad de la ganancia total
-- de la empresa (~$286K). Evitar solo la mitad de esas pérdidas
-- aumentaría la ganancia total en más de un 25%.
-- El ranking de pérdidas cambia según la métrica:
--   * Por pérdida TOTAL: Binders (-$38.5K en 613 ventas) supera a
--     Tables (-$32.4K en 203 ventas).
--   * Por pérdida PROMEDIO: Machines es el peor (-$684 por venta
--     perdedora, en solo 44 ventas), seguido por Tables (-$160).
-- Matiz: Binders pertenece a una categoría muy rentable y probablemente
-- compensa con sus ventas buenas; Tables ya sabemos que es negativa
-- en neto. No es lo mismo "tener ventas malas" que "ser inviable".
-- Pendiente: confirmar la ganancia neta de Binders y Machines.
