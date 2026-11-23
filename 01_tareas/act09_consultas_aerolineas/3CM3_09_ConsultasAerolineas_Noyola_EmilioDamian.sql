-- Actividad 9: Consultas a la base de datos Aerolineas
-- Alumno: Noyola Gómez Emilio Damian | Grupo: 3CM3 | Bases de Datos

-- Datos: respaldo aerolineas.bak proporcionado por la profesora, restaurado con:
-- RESTORE DATABASE Aerolineas FROM DISK = N'C:\Users\Public\documents\Aerolineas_Profesora.bak'
--   WITH MOVE 'CIC_Aerolineas' TO N'...\DATA\Aerolineas.mdf',
--        MOVE 'CIC_Aerolineas_log' TO N'...\DATA\Aerolineas_log.ldf', REPLACE

USE Aerolineas
GO

-- 0. Registros por tabla en la base restaurada
SELECT t.name AS Tabla, SUM(p.rows) AS Registros
FROM sys.tables t
JOIN sys.partitions p ON p.object_id = t.object_id AND p.index_id IN (0, 1)
WHERE t.name <> 'sysdiagrams'
GROUP BY t.name
ORDER BY t.name
GO

-- 1. Matrícula de los aviones cuyo tipo tiene más de 200 asientos
SELECT a.matricula, t.tipoAvion, t.numAsientos
FROM Avion a
JOIN TipoAvion t ON t.idTipoAvion = a.idTipoAvion
WHERE t.numAsientos > 200
GO

-- 2. Matrícula con la leyenda de capacidad en un solo campo
SELECT a.matricula,
       'El avión ' + t.tipoAvion + ' tiene una capacidad de '
       + CAST(t.numAsientos AS VARCHAR(5)) + ' asientos' AS Leyenda
FROM Avion a
JOIN TipoAvion t ON t.idTipoAvion = a.idTipoAvion
WHERE t.numAsientos > 200
GO

-- 3. Nombre y apellidos de todos los empleados de las aerolíneas
SELECT p.nombre, p.paterno, p.materno
FROM Empleado e
JOIN Persona p ON p.IdPersona = e.idPersona
ORDER BY e.idEmpleado
GO

-- 4. Pilotos que ganan más de $40,000
SELECT p.nombre, p.paterno, p.materno, e.sueldo
FROM Empleado e
JOIN Persona p ON p.IdPersona = e.idPersona
JOIN TipoEmpleado te ON te.idTipoEmpleado = e.idTipoEmpleado
WHERE te.tipoEmpleado = 'Piloto' AND e.sueldo > 40000
GO

-- 5. Leyenda de bienvenida con la fecha actual
SELECT 'bienvenido, ' + CONCAT_WS(' ', p.nombre, p.paterno, p.materno)
       + ', hoy es ' + FORMAT(GETDATE(), 'dd/MM/yyyy') AS Bienvenida
FROM Empleado e
JOIN Persona p ON p.IdPersona = e.idPersona
GO

-- 6. Personas que cumplen años de marzo a octubre de 1980
SELECT 'Felices ' + CAST(DATEDIFF(YEAR, nacimiento, GETDATE()) AS VARCHAR(3))
       + ' años ' + CONCAT_WS(' ', nombre, paterno, materno) + '!!!' AS Felicitacion,
       CAST(nacimiento AS DATE) AS nacimiento
FROM Persona
WHERE nacimiento >= '1980-03-01' AND nacimiento < '1980-11-01'
ORDER BY nacimiento
GO

-- 7. Antigüedad en años de los aviones
SELECT matricula, CAST(fechaFabricacion AS DATE) AS fechaFabricacion,
       DATEDIFF(YEAR, fechaFabricacion, GETDATE())
       - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, fechaFabricacion, GETDATE()),
                           fechaFabricacion) > GETDATE() THEN 1 ELSE 0 END AS [Antigüedad (años)]
FROM Avion
ORDER BY fechaFabricacion
GO

-- 8. Fecha exacta del siguiente mantenimiento, del más próximo a vencer
SELECT matricula, CAST(UltimoMantenimiento AS DATE) AS UltimoMantenimiento,
       mesesMantenimiento,
       CAST(DATEADD(MONTH, mesesMantenimiento, UltimoMantenimiento) AS DATE) AS SiguienteMantenimiento
FROM Avion
ORDER BY SiguienteMantenimiento
GO

-- 9. Días que faltan para el mantenimiento (sumando 10 años), del más próximo a vencer
SELECT matricula,
       CAST(DATEADD(YEAR, 10, DATEADD(MONTH, mesesMantenimiento, UltimoMantenimiento)) AS DATE)
           AS FechaMantenimiento,
       DATEDIFF(DAY, GETDATE(),
           DATEADD(YEAR, 10, DATEADD(MONTH, mesesMantenimiento, UltimoMantenimiento))) AS DiasRestantes
FROM Avion
ORDER BY DiasRestantes
GO

-- 10. Días de atraso (+) o adelanto (-) del último mantenimiento respecto a la fabricación
SELECT matricula, CAST(fechaFabricacion AS DATE) AS Fabricacion,
       CAST(DATEADD(MONTH, mesesMantenimiento, fechaFabricacion) AS DATE) AS Programado,
       CAST(UltimoMantenimiento AS DATE) AS Realizado,
       DATEDIFF(DAY, DATEADD(MONTH, mesesMantenimiento, fechaFabricacion),
                UltimoMantenimiento) AS Dias,
       CASE WHEN UltimoMantenimiento > DATEADD(MONTH, mesesMantenimiento, fechaFabricacion)
                THEN 'Atrasado'
            WHEN UltimoMantenimiento < DATEADD(MONTH, mesesMantenimiento, fechaFabricacion)
                THEN 'Adelantado'
            ELSE 'A tiempo' END AS Estado
FROM Avion
GO

-- 11. Vuelos ordenados por cercanía y lugares vacíos
SELECT v.idVuelo, CAST(v.fechaVuelo AS SMALLDATETIME) AS fechaVuelo,
       t.numAsientos AS Capacidad, ISNULL(SUM(ve.numAsientos), 0) AS Vendidos,
       t.numAsientos - ISNULL(SUM(ve.numAsientos), 0) AS LugaresVacios
FROM Vuelo v
JOIN Avion a ON a.matricula = v.matriculaAvion
JOIN TipoAvion t ON t.idTipoAvion = a.idTipoAvion
LEFT JOIN Venta ve ON ve.idVuelo = v.idVuelo
GROUP BY v.idVuelo, v.fechaVuelo, t.numAsientos
ORDER BY CASE WHEN v.fechaVuelo >= GETDATE() THEN 0 ELSE 1 END,
         ABS(DATEDIFF(MINUTE, GETDATE(), v.fechaVuelo)), LugaresVacios DESC
GO

-- 12. Vuelos con precio por asiento mayor a 1000 pesos, de menor a mayor
SELECT idVuelo, matriculaAvion, CAST(fechaVuelo AS SMALLDATETIME) AS fechaVuelo, precioPorAsiento
FROM Vuelo
WHERE precioPorAsiento > 1000
ORDER BY precioPorAsiento ASC
GO

-- 13. Empleados que no tienen jefe
SELECT e.idEmpleado, p.nombre, p.paterno, te.tipoEmpleado, a.Nombre AS Aerolinea
FROM Empleado e
JOIN Persona p ON p.IdPersona = e.idPersona
JOIN TipoEmpleado te ON te.idTipoEmpleado = e.idTipoEmpleado
LEFT JOIN Aerolinea a ON a.AerolineaId = e.AerolineaId
WHERE e.idJefe IS NULL
GO

-- 14. Día de la semana en que le toca mantenimiento a cada avión
SELECT matricula,
       CAST(DATEADD(MONTH, mesesMantenimiento, UltimoMantenimiento) AS DATE) AS SiguienteMantenimiento,
       FORMAT(DATEADD(MONTH, mesesMantenimiento, UltimoMantenimiento), 'dddd', 'es-MX') AS DiaSemana
FROM Avion
ORDER BY SiguienteMantenimiento
GO

-- 15. Aerolíneas extranjeras
SELECT 'La aerolínea ' + Nombre + ' es extranjera' AS Aerolinea
FROM Aerolinea
WHERE nacional = 0
GO

-- 16. Clientes que viven en Av. 20 de Noviembre, por nacimiento descendente
SELECT c.clienteId, CONCAT_WS(' ', p.nombre, p.paterno, p.materno) AS Cliente,
       d.calle, d.numero, CAST(p.nacimiento AS DATE) AS nacimiento
FROM Cliente c
JOIN Persona p ON p.IdPersona = c.personaId
JOIN Direccion d ON d.direccionId = p.direccionId
WHERE d.calle = 'Av. 20 de Noviembre'
ORDER BY p.nacimiento DESC
GO

-- 17. Cliente Oro con más antigüedad de registro
SELECT TOP 1 WITH TIES c.clienteId, CONCAT_WS(' ', p.nombre, p.paterno, p.materno) AS Cliente,
       CAST(c.fechaRegistro AS DATE) AS fechaRegistro
FROM Cliente c
JOIN Persona p ON p.IdPersona = c.personaId
JOIN TipoCliente tc ON tc.idTipoCliente = c.idTipoCliente
WHERE tc.tipoCliente = 'Oro'
ORDER BY c.fechaRegistro
GO

-- 18. Ventas por vendedor y comisión en pesos
SELECT vd.vendedorId AS id_vendedor,
       SUM(v.numAsientos * vu.precioPorAsiento) AS monto,
       COUNT(*) AS ventas,
       CAST(SUM(v.numAsientos * vu.precioPorAsiento) * vd.porcentajeComision / 100 AS MONEY)
           AS comision_pesos
FROM Venta v
JOIN Vuelo vu ON vu.idVuelo = v.idVuelo
JOIN Vendedor vd ON vd.vendedorId = v.idVendedor
GROUP BY vd.vendedorId, vd.porcentajeComision
ORDER BY id_vendedor
GO

-- 19. Domicilios cuyo número no es numérico
SELECT direccionId, calle, numero, colonia
FROM Direccion
WHERE numero LIKE '%[^0-9]%'
GO

-- 20. Sueldo diario de los empleados (meses de 30 días)
SELECT p.nombre, p.paterno, e.sueldo,
       CAST(e.sueldo / 30 AS DECIMAL(10, 2)) AS 'sueldo diario'
FROM Empleado e
JOIN Persona p ON p.IdPersona = e.idPersona
ORDER BY [sueldo diario] DESC
GO

-- 21. Leyenda de descuento por tipo de cliente
SELECT 'al ser cliente ' + tipoCliente + ' tienes un descuento de '
       + CAST(descuento AS VARCHAR(3)) + '%' AS Descuento
FROM TipoCliente
GO

-- 22. Vuelos de diciembre de 2014 de menos de 4000 pesos, de menor a mayor costo
SELECT idVuelo, matriculaAvion, CAST(fechaVuelo AS SMALLDATETIME) AS fechaVuelo, precioPorAsiento
FROM Vuelo
WHERE fechaVuelo >= '2014-12-01' AND fechaVuelo < '2015-01-01'
  AND precioPorAsiento < 4000
ORDER BY precioPorAsiento
GO

-- 23. Clientes Oro con menos de 5 años de antigüedad
SELECT c.clienteId, CONCAT_WS(' ', p.nombre, p.paterno, p.materno) AS Cliente,
       CAST(c.fechaRegistro AS DATE) AS fechaRegistro
FROM Cliente c
JOIN Persona p ON p.IdPersona = c.personaId
JOIN TipoCliente tc ON tc.idTipoCliente = c.idTipoCliente
WHERE tc.tipoCliente = 'Oro' AND c.fechaRegistro > DATEADD(YEAR, -5, GETDATE())
GO

-- 24. Tipos de avión por fabricante (ascendente) y asientos (descendente)
SELECT idTipoAvion, tipoAvion, LTRIM(fabricante) AS fabricante, numAsientos
FROM TipoAvion
ORDER BY LTRIM(fabricante) ASC, numAsientos DESC
GO

-- 25. Tipos de empleado de vuelo
SELECT 'el tipo de empleado ' + tipoEmpleado + ' requiere estar en vuelo' AS TipoDeVuelo
FROM TipoEmpleado
WHERE esDeVuelo = 1
GO

-- 26. Vuelos que se realizaron la última semana
SELECT idVuelo, matriculaAvion, CAST(fechaVuelo AS SMALLDATETIME) AS fechaVuelo, precioPorAsiento
FROM Vuelo
WHERE fechaVuelo >= DATEADD(DAY, -7, GETDATE()) AND fechaVuelo <= GETDATE()
GO

-- 27. Vuelos que se compraron durante el último mes
SELECT v.idVenta, CAST(v.fechaCompra AS DATE) AS fechaCompra, vu.idVuelo,
       CAST(vu.fechaVuelo AS SMALLDATETIME) AS fechaVuelo, v.numAsientos
FROM Venta v
JOIN Vuelo vu ON vu.idVuelo = v.idVuelo
WHERE v.fechaCompra >= DATEADD(MONTH, -1, CAST(GETDATE() AS DATE))
ORDER BY v.fechaCompra
GO

-- 28. Personas cuyo teléfono no tiene exactamente 8 caracteres
SELECT IdPersona, CONCAT_WS(' ', nombre, paterno, materno) AS Persona,
       telefono, LEN(telefono) AS Longitud
FROM Persona
WHERE LEN(telefono) <> 8
GO

-- 29. Clientes Plata registrados de 2010 en adelante
SELECT p.nombre, p.paterno, p.materno, CAST(c.fechaRegistro AS DATE) AS fechaRegistro
FROM Cliente c
JOIN Persona p ON p.IdPersona = c.personaId
JOIN TipoCliente tc ON tc.idTipoCliente = c.idTipoCliente
WHERE tc.tipoCliente = 'Plata' AND c.fechaRegistro >= '2010-01-01'
GO

-- 30. Día de la semana en que saldrá cada vuelo
SELECT idVuelo, CAST(fechaVuelo AS SMALLDATETIME) AS fechaVuelo,
       FORMAT(fechaVuelo, 'dddd', 'es-MX') AS DiaSemana
FROM Vuelo
ORDER BY fechaVuelo
GO

-- 31. Sueldo promedio por aerolínea y la aerolínea que más gana
SELECT a.Nombre AS Aerolinea, CAST(AVG(e.sueldo) AS DECIMAL(10, 2)) AS SueldoPromedio
FROM Empleado e
JOIN Aerolinea a ON a.AerolineaId = e.AerolineaId
GROUP BY a.Nombre
ORDER BY SueldoPromedio DESC

SELECT TOP 1 WITH TIES a.Nombre AS Aerolinea, CAST(AVG(e.sueldo) AS DECIMAL(10, 2)) AS SueldoPromedio
FROM Empleado e
JOIN Aerolinea a ON a.AerolineaId = e.AerolineaId
GROUP BY a.Nombre
ORDER BY SueldoPromedio DESC
GO

-- Respaldo completo de la base de datos Aerolineas
BACKUP DATABASE Aerolineas
TO DISK = N'C:\Users\Public\documents\aerolineas_consultas.bak'
WITH FORMAT, INIT, NAME = N'Aerolineas - Respaldo con datos', STATS = 10
GO
