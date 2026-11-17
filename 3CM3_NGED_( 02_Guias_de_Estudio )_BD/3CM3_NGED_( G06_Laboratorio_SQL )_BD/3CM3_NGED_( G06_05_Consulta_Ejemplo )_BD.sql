/* Pregunta 11 del examen: nombre, aerolínea y sueldo máximo de los pilotos
   que ganan más de $40,000, de mayor a menor sueldo */
USE Aerolineas;
GO
SELECT p.nombre, p.paterno, a.nombre AS aerolinea, t.sueldoMaximo, e.sueldo
FROM Empleado e
     JOIN Persona      p ON p.idPersona      = e.idPersona
     JOIN TipoEmpleado t ON t.idTipoEmpleado = e.idTipoEmpleado
     JOIN Aerolinea    a ON a.aerolineaId    = e.aerolineaId
WHERE t.tipoEmpleado = 'Piloto'
  AND e.sueldo > 40000
ORDER BY e.sueldo DESC;
