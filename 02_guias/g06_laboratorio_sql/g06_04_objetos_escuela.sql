/* Pregunta 21 del examen: función que calcula el promedio y procedimiento que la usa */
USE Escuela;
GO
CREATE FUNCTION fn_Promedio (@idAlumno INT)
RETURNS DECIMAL(4,2)
AS
BEGIN
    DECLARE @prom DECIMAL(4,2);
    SELECT @prom = AVG(calificacion)
    FROM Calificacion
    WHERE idAlumno = @idAlumno;
    RETURN @prom;
END;
GO
CREATE PROCEDURE sp_PromedioAlumno
    @idAlumno INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.idAlumno, a.nombre, dbo.fn_Promedio(a.idAlumno) AS promedio
    FROM Alumno a
    WHERE a.idAlumno = @idAlumno;
END;
GO
EXEC sp_PromedioAlumno @idAlumno = 1;
