# Desafío Técnico – Dashboard de Gestión con Snapshots

Este repositorio contiene la solución propuesta al desafío técnico de SSG Assistance, 
donde se debe implementar un dashboard de gestión para supervisores de call center, 
incluyendo las métricas principales, filtros y snapshots.

---

## 1. Definición de Métricas

- **Contactabilidad (%)** = (Gestiones efectivas / Total de gestiones) * 100  
- **Penetración Bruta (%)** = (Gestiones exitosas / Total de gestiones) * 100  
- **Penetración Neta (%)** = (Gestiones exitosas / Gestiones efectivas) * 100  

---

## 2. Scripts de Base de Datos

En la carpeta [`sql/`](./sql/) se incluye:

- `proteus_crm.sql`: creación de la tabla `snapshots` y ejemplo de inserción.
- `queries.sql`: consultas SQL para calcular métricas de gestión.

---

## 3. Consultas SQL para Cálculo de Métricas

Las consultas se encuentran en [`sql/queries.sql`](./sql/queries.sql).  
Ejemplos:

```sql
-- Contactabilidad
SELECT 
  (SUM(CASE WHEN id_resultado IN (1,2,8) THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS contactabilidad
FROM gestiones;

-- Penetración Bruta
SELECT 
  (SUM(CASE WHEN id_resultado = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS penetracion_bruta
FROM gestiones;

-- Penetración Neta
SELECT 
  (SUM(CASE WHEN id_resultado = 1 THEN 1 ELSE 0 END) / 
   SUM(CASE WHEN id_resultado IN (1,2,8) THEN 1 ELSE 0 END)) * 100 AS penetracion_neta
FROM gestiones;

4. Manejo de Snapshots

Al generar un snapshot, se calculan los KPIs con los filtros aplicados (campaña, fechas, agente) y se insertan en la tabla snapshots.

Al consultar un snapshot, se recupera directamente la fila guardada, sin recalcular.


Ejemplo de inserción:

INSERT INTO snapshots (fecha, id_user, filtros, contactabilidad, penetracion_bruta, penetracion_neta, distribucion)
VALUES (NOW(), 4, '{"campaign":1,"fecha_inicio":"2025-01-01","fecha_fin":"2025-01-31"}',
  45.00, 12.50, 27.77, '{"Contactado":10,"No contesta":5,"Coordinado":3}');


---

5. Instrucciones

Requisitos: MySQL/MariaDB, PHP >= 8.1 o Python (Flask/Django)

Pasos de instalación:

1. Crear la base de datos e importar los scripts de tablas y datos de ejemplo.


2. Ejecutar los scripts SQL de métricas para validar resultados.


3. Implementar una interfaz simple (PHP/Python) con filtros (fecha, agente, campaña).


4. Usar Chart.js u otra librería para mostrar la distribución de resultados.


5. Probar la funcionalidad de snapshots (guardar y consultar).



Usuario Demo:

usuario: jperez

password: demo123




---

---


```sql
-- ================================================================
-- PROTEUS CRM + SNAPSHOTS
-- ================================================================

-- Tabla adicional para snapshots
CREATE TABLE snapshots (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fecha DATETIME NOT NULL,
  id_user INT NOT NULL,
  filtros JSON NOT NULL,
  contactabilidad DECIMAL(5,2),
  penetracion_bruta DECIMAL(5,2),
  penetracion_neta DECIMAL(5,2),
  distribucion JSON
);

-- Ejemplo de inserción de snapshot
INSERT INTO snapshots (fecha, id_user, filtros, contactabilidad, penetracion_bruta, penetracion_neta, distribucion)
VALUES (NOW(), 4, '{"campaign":1,"fecha_inicio":"2025-01-01","fecha_fin":"2025-01-31"}',
  45.00, 12.50, 27.77, '{"Contactado":10,"No contesta":5,"Coordinado":3}');


---


-- Contactabilidad
SELECT 
  (SUM(CASE WHEN id_resultado IN (1,2,8) THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS contactabilidad
FROM gestiones;

-- Penetración Bruta
SELECT 
  (SUM(CASE WHEN id_resultado = 1 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS penetracion_bruta
FROM gestiones;

-- Penetración Neta
SELECT 
  (SUM(CASE WHEN id_resultado = 1 THEN 1 ELSE 0 END) / 
   SUM(CASE WHEN id_resultado IN (1,2,8) THEN 1 ELSE 0 END)) * 100 AS penetracion_neta
FROM gestiones;

-- Distribución de Resultados
SELECT gr.nombre AS resultado, COUNT(*) AS cantidad
FROM gestiones g
JOIN gestiones_resultado gr ON g.id_resultado = gr.id
GROUP BY g.id_resultado;

-- Distribución de Resultados
SELECT gr.nombre AS resultado, COUNT(*) AS cantidad
FROM gestiones g
JOIN gestiones_resultado gr ON g.id_resultado = gr.id
GROUP BY g.id_resultado;# repo-2
