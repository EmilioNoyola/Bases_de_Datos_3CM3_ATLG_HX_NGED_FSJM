SET NOCOUNT OFF;
USE Aerolineas;
SELECT '@@Q|7b4f5830e1' AS marca;
SELECT tipoAvion, fabricante
FROM TipoAvion
WHERE numAsientos > 200;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|147f5f3cd1' AS marca;
SELECT a.matricula, p.fabricante
FROM Avion a, TipoAvion p
WHERE a.idTipoAvion = p.idTipoAvion;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|6febf03bb3' AS marca;
SELECT c.clienteId
FROM Cliente c
WHERE NOT EXISTS (SELECT *
                  FROM Venta v
                  WHERE v.idCliente = c.clienteId);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|c6b9f3b6eb' AS marca;
SELECT c.clienteId
FROM Cliente c
WHERE NOT EXISTS (
      SELECT * FROM Vuelo u
      WHERE u.origen = 'MEX' AND u.destino = 'CUN'
        AND NOT EXISTS (SELECT * FROM Venta v
                        WHERE v.idCliente = c.clienteId
                          AND v.idVuelo = u.idVuelo));
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|7c11d6a866' AS marca;
SELECT a.matricula
FROM Avion a JOIN TipoAvion p ON a.idTipoAvion = p.idTipoAvion
WHERE a.aerolineaId = 1 AND p.fabricante = 'Airbus';
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|6d28f95004' AS marca;
SELECT * FROM TipoAvion;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|16c83299b9' AS marca;
SELECT matricula AS [Matrícula],
       fechaFabricacion AS fabricado,
       aerolineaId
FROM Avion;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|cac87c4f56' AS marca;
SELECT tipoAvion, fabricante, numAsientos
FROM TipoAvion
WHERE fabricante IN ('Boeing', 'Embraer')
  AND numAsientos < 250;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|a62e872a25' AS marca;
SELECT nombre, paterno, correo
FROM Persona
WHERE correo LIKE '%@correo.mx'
  AND paterno LIKE 'M%';
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|022f511daa' AS marca;
SELECT idEmpleado, idPersona, aerolineaId, sueldo
FROM Empleado
WHERE idJefe IS NULL;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|dd44318a50' AS marca;
SELECT colonia
FROM Direccion;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|d5c4f5c57f' AS marca;
SELECT DISTINCT colonia
FROM Direccion;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|712913673d' AS marca;
SELECT DISTINCT origen, destino
FROM Vuelo
ORDER BY origen, destino;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|09ba51577d' AS marca;
SELECT idEmpleado, aerolineaId, sueldo
FROM Empleado
ORDER BY sueldo DESC, idEmpleado ASC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|4c8204f972' AS marca;
SELECT TOP 3 idVuelo, origen, destino, precioPorAsiento
FROM Vuelo
ORDER BY precioPorAsiento DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|9064f2eb87' AS marca;
SELECT idPersona,
       nombre + ' ' + paterno + ' ' + materno      AS conMas,
       CONCAT(nombre, ' ', paterno, ' ', materno)  AS conConcat
FROM Persona
WHERE idPersona IN (1, 2, 16);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|1568b5ae63' AS marca;
SELECT 'El avión ' + a.matricula + ' (' + t.tipoAvion + ') tiene una capacidad de '
       + CAST(t.numAsientos AS VARCHAR(5)) + ' asientos' AS leyenda
FROM Avion a
     JOIN TipoAvion t ON t.idTipoAvion = a.idTipoAvion
WHERE t.numAsientos > 200;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|8a10dde784' AS marca;
SELECT direccionId, calle, numero,
       TRY_CAST(numero AS INT) AS numeroEntero
FROM Direccion;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|a97011c8ba' AS marca;
SELECT nombre, paterno,
       ISNULL(correo, 'sin correo')                    AS correo,
       COALESCE(telefono, correo, 'sin contacto')      AS contacto
FROM Persona
WHERE idPersona BETWEEN 3 AND 6;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|b452b21b01' AS marca;
SELECT tipoAvion, numAsientos,
       CASE
           WHEN numAsientos >= 250 THEN 'Fuselaje ancho'
           WHEN numAsientos >= 150 THEN 'Fuselaje angosto'
           ELSE 'Regional'
       END AS categoria
FROM TipoAvion
ORDER BY numAsientos DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|9112043db3' AS marca;
SELECT *
FROM Vuelo
WHERE DATEPART(MONTH, fechaVuelo) = 12
  AND DATEPART(YEAR, fechaVuelo) = 2014
  AND PrecioPorAsiento < 4000
ORDER BY PrecioPorAsiento ASC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|6be2b55845' AS marca;
SELECT * FROM Venta
WHERE DATEDIFF(YEAR, FechaCompra, GETDATE()) > 11;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|78458abfdb' AS marca;
SELECT e.idEmpleado, YEAR(e.fechaIngreso) AS anioIngreso,
       DATEDIFF(YEAR, e.fechaIngreso, '2026-11-06') AS antiguedad
FROM Empleado e
WHERE e.aerolineaId = 2;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|6791a2991f' AS marca;
SELECT COUNT(*)              AS personas,
       COUNT(correo)         AS conCorreo,
       COUNT(DISTINCT direccionId) AS direccionesUsadas,
       MIN(nacimiento)       AS laMayor,
       MAX(nacimiento)       AS laMenor
FROM Persona;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|6fb3c3381e' AS marca;
SELECT SUM(numAsientos)                         AS asientosVendidos,
       AVG(CAST(numAsientos AS DECIMAL(6,2)))   AS promedioPorVenta,
       COUNT(*)                                 AS ventas
FROM Venta;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|8454a0b2a6' AS marca;
SELECT aerolineaId,
       COUNT(*)     AS empleados,
       SUM(sueldo)  AS nomina,
       AVG(sueldo)  AS promedio
FROM Empleado
GROUP BY aerolineaId;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|1111d80b03' AS marca;
SELECT vu.origen, vu.destino,
       SUM(v.numAsientos)                       AS asientos,
       SUM(v.numAsientos * vu.precioPorAsiento) AS ingreso
FROM Venta v
     JOIN Vuelo vu ON vu.idVuelo = v.idVuelo
GROUP BY vu.origen, vu.destino
ORDER BY ingreso DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|1a587f9db5' AS marca;
SELECT idCliente, COUNT(*) AS compras, SUM(numAsientos) AS asientos
FROM Venta
GROUP BY idCliente
HAVING SUM(numAsientos) > 2
ORDER BY asientos DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|b9bffd0478' AS marca;
SELECT idCliente, COUNT(*) AS compras2014
FROM Venta
WHERE YEAR(fechaCompra) = 2014           -- filtra filas
GROUP BY idCliente
HAVING COUNT(*) >= 2;                    -- filtra grupos;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|d3f188aee5' AS marca;
SELECT a.nombre          AS aerolinea,
       COUNT(*)          AS cabina,
       MAX(e.sueldo)     AS sueldoMayor
FROM Empleado e
     JOIN TipoEmpleado t ON t.idTipoEmpleado = e.idTipoEmpleado
     JOIN Aerolinea    a ON a.aerolineaId    = e.aerolineaId
WHERE t.tipoEmpleado IN ('Piloto', 'Copiloto')   -- 1. solo cabina de mando
GROUP BY a.nombre                                -- 2. un grupo por aerolínea
HAVING COUNT(*) >= 2                             -- 3. al menos dos
ORDER BY sueldoMayor DESC;                       -- 4. orden final;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|35cd2b6694' AS marca;
SELECT aerolineaId,
       COUNT(*)                   AS aviones,
       COUNT(ultimoMantenimiento) AS conMantenimiento,
       MAX(ultimoMantenimiento)   AS masReciente
FROM Avion
GROUP BY aerolineaId;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|373cd8692c' AS marca;
SELECT a.matricula, t.tipoAvion
FROM Avion a, TipoAvion t
WHERE a.idTipoAvion = t.idTipoAvion
  AND a.aerolineaId = 2;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|e6f4df0656' AS marca;
SELECT a.matricula, t.tipoAvion
FROM Avion a
     JOIN TipoAvion t
       ON a.idTipoAvion = t.idTipoAvion
WHERE a.aerolineaId = 2;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|5ea767aa22' AS marca;
SELECT v.idVenta, vu.idVuelo, vu.origen, vu.destino, v.numAsientos
FROM Vuelo vu
     INNER JOIN Venta v ON v.idVuelo = vu.idVuelo
ORDER BY vu.idVuelo, v.idVenta;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|a1fc76df8b' AS marca;
SELECT vu.idVuelo, vu.origen, vu.destino, v.idVenta, v.numAsientos
FROM Vuelo vu
     LEFT JOIN Venta v ON v.idVuelo = vu.idVuelo
ORDER BY vu.idVuelo, v.idVenta;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|72ea6015bd' AS marca;
SELECT vu.idVuelo, vu.origen, vu.destino, vu.fechaVuelo
FROM Vuelo vu
     LEFT JOIN Venta v ON v.idVuelo = vu.idVuelo
WHERE v.idVenta IS NULL;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|62664d5226' AS marca;
SELECT p.idPersona, p.nombre, d.direccionId, d.calle
FROM Persona p
     FULL JOIN Direccion d ON d.direccionId = p.direccionId
WHERE p.idPersona IS NULL OR d.direccionId IS NULL;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|11dc9a1ccd' AS marca;
SELECT a.nombre, t.tipoCliente
FROM Aerolinea a CROSS JOIN TipoCliente t;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|0536db8c7d' AS marca;
SELECT p.nombre, p.paterno, a.nombre AS aerolinea, t.sueldoMaximo, e.sueldo
FROM Empleado e
     JOIN Persona      p ON p.idPersona      = e.idPersona
     JOIN TipoEmpleado t ON t.idTipoEmpleado = e.idTipoEmpleado
     JOIN Aerolinea    a ON a.aerolineaId    = e.aerolineaId
WHERE t.tipoEmpleado = 'Piloto'
  AND e.sueldo > 40000
ORDER BY e.sueldo DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|5378065cd2' AS marca;
SELECT p.nombre, p.paterno, d.calle, d.numero
FROM Empleado e
     JOIN Persona   p ON p.idPersona   = e.idPersona
     JOIN Direccion d ON d.direccionId = p.direccionId
WHERE d.calle = 'Río Tigris';
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|f6d7781187' AS marca;
SELECT e.idEmpleado,
       pe.nombre + ' ' + pe.paterno AS empleado,
       j.idEmpleado                 AS idJefe,
       pj.nombre + ' ' + pj.paterno AS jefe
FROM Empleado e
     JOIN Persona  pe ON pe.idPersona  = e.idPersona
     LEFT JOIN Empleado j  ON j.idEmpleado = e.idJefe
     LEFT JOIN Persona  pj ON pj.idPersona = j.idPersona
ORDER BY e.idEmpleado;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|da0d7aa17d' AS marca;
SELECT p.nombre, p.paterno, p.materno, d.direccionId
FROM Persona p
     JOIN Empleado e ON p.idPersona = e.idPersona
     JOIN Direccion d ON p.direccionId = d.direccionId
WHERE d.CodigoPostal = '06500';
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|44c45d7921' AS marca;
SELECT idPersona FROM Empleado
UNION
SELECT personaId FROM Cliente
ORDER BY idPersona;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|d8c2efd103' AS marca;
SELECT idPersona FROM Empleado
INTERSECT
SELECT personaId FROM Cliente;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|6d2ea234d5' AS marca;
SELECT personaId FROM Cliente
EXCEPT
SELECT idPersona FROM Empleado;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|ca05c25042' AS marca;
SELECT p.nombre, p.paterno, 'Empleado' AS rol
FROM Persona p JOIN Empleado e ON e.idPersona = p.idPersona
WHERE e.aerolineaId = 3
UNION ALL
SELECT p.nombre, p.paterno, 'Cliente'
FROM Persona p JOIN Cliente c ON c.personaId = p.idPersona
WHERE c.idTipoCliente = 3;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|1e484d8d06' AS marca;
SELECT idEmpleado, aerolineaId, sueldo
FROM Empleado
WHERE sueldo > (SELECT AVG(sueldo) FROM Empleado)
ORDER BY sueldo DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|21e0b96a28' AS marca;
SELECT tipoAvion, fabricante, numAsientos
FROM TipoAvion
WHERE numAsientos = (SELECT MAX(numAsientos) FROM TipoAvion);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|17c65acf41' AS marca;
SELECT matricula, idTipoAvion
FROM Avion
WHERE matricula IN (SELECT matricula FROM Vuelo);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|bfd83abcce' AS marca;
SELECT idPersona, nombre, paterno
FROM Persona
WHERE idPersona NOT IN (SELECT idPersona FROM Empleado)
  AND idPersona NOT IN (SELECT personaId FROM Cliente);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|82cb0ec783' AS marca;
SELECT idEmpleado
FROM Empleado
WHERE idEmpleado NOT IN (SELECT idJefe FROM Empleado);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|d064fbb173' AS marca;
SELECT idEmpleado
FROM Empleado
WHERE idEmpleado NOT IN (SELECT idJefe FROM Empleado WHERE idJefe IS NOT NULL);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|47c1914dd3' AS marca;
SELECT idEmpleado, aerolineaId, sueldo
FROM Empleado
WHERE sueldo > ALL (SELECT sueldo FROM Empleado WHERE aerolineaId = 2);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|4ceb46bae3' AS marca;
SELECT TOP 1 t.idCliente, t.asientos
FROM (SELECT idCliente, SUM(numAsientos) AS asientos
      FROM Venta
      GROUP BY idCliente) AS t
ORDER BY t.asientos DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|12550d3d5c' AS marca;
SELECT e.idEmpleado, e.aerolineaId, e.sueldo
FROM Empleado e
WHERE e.sueldo > (SELECT AVG(e2.sueldo)
                  FROM Empleado e2
                  WHERE e2.aerolineaId = e.aerolineaId)   -- e viene de afuera
ORDER BY e.aerolineaId, e.sueldo DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|b5156ecd57' AS marca;
SELECT c.clienteId, c.fechaRegistro
FROM Cliente c
WHERE EXISTS (SELECT 1 FROM Venta v WHERE v.idCliente = c.clienteId);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|507f6157b9' AS marca;
SELECT c.clienteId, c.fechaRegistro
FROM Cliente c
WHERE NOT EXISTS (SELECT 1 FROM Venta v WHERE v.idCliente = c.clienteId);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|e25fbdde0d' AS marca;
SELECT e.idEmpleado
FROM Empleado e
WHERE NOT EXISTS (SELECT 1 FROM Empleado s WHERE s.idJefe = e.idEmpleado);
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|46b26eaed8' AS marca;
SELECT a.nombre
FROM Aerolinea a
WHERE NOT EXISTS (
      SELECT DISTINCT t.fabricante                 -- un fabricante de Aeroazteca…
      FROM Avion x JOIN TipoAvion t ON t.idTipoAvion = x.idTipoAvion
      WHERE x.aerolineaId = 1
        AND NOT EXISTS (                           -- …que esta aerolínea no tenga
            SELECT 1
            FROM Avion y JOIN TipoAvion u ON u.idTipoAvion = y.idTipoAvion
            WHERE y.aerolineaId = a.aerolineaId
              AND u.fabricante = t.fabricante));
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|6029cbe9e7' AS marca;
SELECT piloto, aerolinea, sueldo
FROM vw_Pilotos
WHERE sueldo > 40000
ORDER BY sueldo DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|cb6102b949' AS marca;
SELECT idVenta, fechaCompra, cliente, ruta, numAsientos, importe
FROM vw_VentasDetalle
WHERE fechaCompra >= '2025-01-01'
ORDER BY fechaCompra;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|ffe07d3c65' AS marca;
SELECT idEmpleado, dbo.fn_NombreCompleto(idPersona) AS empleado, sueldo
FROM Empleado
WHERE aerolineaId = 1;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|b0ce0c006e' AS marca;
SELECT * FROM dbo.fn_VuelosRuta('MEX', 'CUN');
SELECT '@@END' AS marca;
USE Escuela;
SELECT '@@Q|e92103a0b1' AS marca;
SELECT a.idAlumno, a.nombre, dbo.fn_Promedio(a.idAlumno) AS promedio
FROM Alumno a
WHERE a.idAlumno = 1;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|4a718112c7' AS marca;
SELECT p.nombre, a.nombre AS aerolinea, t.sueldoMaximo
FROM Empleado e
     JOIN Persona      p ON p.idPersona      = e.idPersona
     JOIN TipoEmpleado t ON t.idTipoEmpleado = e.idTipoEmpleado
     JOIN Aerolinea    a ON a.aerolineaId    = e.aerolineaId
WHERE t.tipoEmpleado = 'Piloto'
  AND e.sueldo > 40000
ORDER BY e.sueldo DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|48e4a20627' AS marca;
SELECT 'El avión ' + t.tipoAvion + ' tiene una capacidad de '
       + CAST(t.numAsientos AS VARCHAR(5)) + ' asientos' AS leyenda
FROM Avion a
     JOIN TipoAvion t ON t.idTipoAvion = a.idTipoAvion
WHERE t.numAsientos > 200;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|58b89f5c00' AS marca;
SELECT e.idEmpleado, p.nombre, p.paterno, e.aerolineaId
FROM Empleado e
     JOIN Persona p ON p.idPersona = e.idPersona
WHERE e.idJefe IS NULL;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|4971c23de5' AS marca;
SELECT p.nombre, p.paterno, d.calle
FROM Empleado e
     JOIN Persona   p ON p.idPersona   = e.idPersona
     JOIN Direccion d ON d.direccionId = p.direccionId
WHERE d.calle = 'Río Tigris';
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|feaab79839' AS marca;
SELECT * FROM Vuelo
WHERE DATEPART(MONTH, fechaVuelo) = 12 AND DATEPART(YEAR, fechaVuelo) = 2014
  AND PrecioporAsiento < 4000
ORDER BY PrecioPorAsiento ASC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|9e2a96c130' AS marca;
SELECT ae.nombre, SUM(v.numAsientos * vu.precioPorAsiento) AS ingreso
FROM Venta v
     JOIN Vuelo     vu ON vu.idVuelo     = v.idVuelo
     JOIN Avion     av ON av.matricula   = vu.matricula
     JOIN Aerolinea ae ON ae.aerolineaId = av.aerolineaId
GROUP BY ae.nombre
HAVING SUM(v.numAsientos * vu.precioPorAsiento) > 10000
ORDER BY ingreso DESC;
SELECT '@@END' AS marca;
USE Aerolineas;
SELECT '@@Q|6ca5100352' AS marca;
SELECT a.matricula, t.tipoAvion, t.fabricante, a.ultimoMantenimiento
FROM Avion a
     JOIN TipoAvion t ON t.idTipoAvion = a.idTipoAvion
WHERE a.ultimoMantenimiento IS NULL
   OR a.ultimoMantenimiento < '2026-01-01';
SELECT '@@END' AS marca;
