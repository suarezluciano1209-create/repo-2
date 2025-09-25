-- ================================================================
-- CONSULTAS DE MÉTRICAS
-- ================================================================

-- 1. Contactabilidad: % de contactos con al menos una gestión exitosa
SELECT 
  (COUNT(DISTINCT g.id_contacto) * 100.0 / (SELECT COUNT(*) FROM contactos)) 
  AS contactabilidad
FROM gestiones g
WHERE g.resultado IN ('Contactado', 'Coordinado', 'Venta cerrada');

-- 2. Penetración bruta: total de gestiones / total de contactos
SELECT 
  (COUNT(*) * 1.0 / (SELECT COUNT(*) FROM contactos)) AS penetracion_bruta
FROM gestiones;

-- 3. Penetración neta: contactos únicos con al menos una gestión / total contactos
SELECT 
  (COUNT(DISTINCT g.id_contacto) * 1.0 / (SELECT COUNT(*) FROM contactos)) 
  AS penetracion_neta
FROM gestiones g;
