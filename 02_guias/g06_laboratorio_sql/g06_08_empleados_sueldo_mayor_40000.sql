-- G06.08 - Consulta de empleados con sueldo mayor a 40000
USE Aerolineas;
GO
SELECT p.nombre, a.nombre AS aerolinea, e.sueldo
FROM Empleado e
     JOIN Persona   p ON p.idPersona   = e.idPersona
     JOIN Aerolinea a ON a.aerolineaId = e.aerolineaId
WHERE e.sueldo > 40000;
