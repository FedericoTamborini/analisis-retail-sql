# 📊 Análisis de Ventas Retail — SQL

Proyecto de análisis exploratorio y de rentabilidad sobre el dataset **Superstore** (Kaggle), desarrollado en **PostgreSQL 18** con pgAdmin 4.

Primer proyecto de mi portfolio como analista de datos. Documentado públicamente en LinkedIn bajo la serie **#EvoluciónSQL**.

## 🎯 Objetivo

Responder preguntas de negocio reales sobre 4 años de ventas de un retail (9.994 transacciones, 2014–2017): ¿dónde gana plata la empresa, dónde la pierde, y por qué?

## 🔍 Hallazgos principales

**1. Furniture factura como las demás categorías pero casi no gana.**
Facturación de $742K (similar a Technology, $836K) pero ganancia de solo $18K — 8 veces menos que Technology.

**2. El problema no es la categoría: es Tables.**
Chairs y Furnishings son rentables (+$39.6K juntas). Tables pierde -$17.7K en 4 años y se come casi toda la ganancia del resto de la categoría.

**3. Existe un umbral de descuento clarísimo.**
Hasta 20% de descuento, cada venta deja ganancia en promedio. Del 30% en adelante, cada venta pierde plata, y la pérdida crece con el descuento (al 50%: -$310 por venta). El nivel más rentable no es 0% sino **10%** (+$96 promedio por venta).

**4. Las ventas con pérdida son 1 de cada 5.**
1.871 transacciones con profit negativo acumulan **-$156K**, más de la mitad de la ganancia total de la empresa (~$286K). Por pérdida total, Binders es la peor subcategoría (-$38.5K); por pérdida promedio por venta, Machines (-$684 por venta perdedora).

**Recomendación:** revisar la política de descuentos con tope en 20% y evaluar el pricing de Tables, deficitaria en neto desde hace 4 años.

## 🗂️ Estructura del repositorio

```
├── README.md
└── sql/
    ├── dia1_creacion_tabla.sql    # Definición de tabla y carga de datos
    ├── dia2_exploracion.sql       # Exploración: período, catálogo, geografía, facturación
    └── dia3_rentabilidad.sql      # Caso Furniture: subcategorías, descuentos, ventas con pérdida
```

Cada archivo incluye las queries comentadas y los **hallazgos documentados** junto a cada consulta.

## 📦 Dataset

[Superstore Sales Dataset — Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
9.994 filas · 21 columnas · Ventas, ganancia, descuentos, clientes, productos y geografía de un retail de EE.UU. (2014–2017).

## 🛠️ Herramientas y técnicas

- **PostgreSQL 18** + pgAdmin 4
- Definición explícita de tipos de datos (NUMERIC para montos, DATE para fechas, VARCHAR para códigos postales)
- Resolución de problemas reales de importación: encoding (WIN1252), formato de fechas (`ALTER DATABASE ... SET datestyle`), preservación del archivo fuente
- Agregaciones: `SUM`, `AVG`, `COUNT(*)` vs `COUNT(DISTINCT)`
- `GROUP BY`, `WHERE`, `ORDER BY`, `LIMIT`, `ROUND`

## 🚧 Próximos pasos

- [ ] Análisis de clientes y regiones que concentran las ventas con pérdida
- [ ] Normalización del modelo (tablas de productos, clientes y ventas)
- [ ] Réplica del análisis en Python/Pandas
- [ ] Dashboard ejecutivo en Power BI

---

*Proyecto en desarrollo — cada avance se documenta en [mi LinkedIn] https://www.linkedin.com/in/federico-tamborini-014413220/ .*
