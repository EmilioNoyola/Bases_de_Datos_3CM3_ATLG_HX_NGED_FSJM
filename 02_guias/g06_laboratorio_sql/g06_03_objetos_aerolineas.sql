/* ============================================================
   Objetos de programación de la base AEROLINEAS
   Vistas, procedimientos, funciones, disparadores y permisos
   que se explican en los capítulos 11 a 14 de la guía.
   Requiere haber ejecutado antes g06_01_crear_aerolineas.sql
   ============================================================ */
USE Aerolineas;
GO

/* ---------- Capítulo 11: vistas ---------- */
CREATE VIEW vw_Pilotos
AS
SELECT e.idEmpleado,
       p.nombre + ' ' + p.paterno AS piloto,
       a.nombre                   AS aerolinea,
       e.sueldo
FROM Empleado e
     JOIN Persona      p ON p.idPersona      = e.idPersona
     JOIN TipoEmpleado t ON t.idTipoEmpleado = e.idTipoEmpleado
     JOIN Aerolinea    a ON a.aerolineaId    = e.aerolineaId
WHERE t.tipoEmpleado = 'Piloto';
GO

CREATE VIEW vw_VentasDetalle
AS
SELECT v.idVenta, v.fechaCompra,
       pe.nombre + ' ' + pe.paterno      AS cliente,
       vu.origen + '-' + vu.destino      AS ruta,
       v.numAsientos,
       v.numAsientos * vu.precioPorAsiento AS importe
FROM Venta v
     JOIN Cliente c  ON c.clienteId   = v.idCliente
     JOIN Persona pe ON pe.idPersona  = c.personaId
     JOIN Vuelo   vu ON vu.idVuelo    = v.idVuelo;
GO

CREATE VIEW vw_EmpleadosAeroazteca
AS
SELECT idEmpleado, idPersona, idTipoEmpleado, aerolineaId,
       fechaIngreso, sueldo, idJefe
FROM Empleado
WHERE aerolineaId = 1
WITH CHECK OPTION;
GO

/* ---------- Capítulo 13: tabla de bitácora para los disparadores ---------- */
CREATE TABLE Bitacora (
    idBitacora INT IDENTITY(1,1) PRIMARY KEY,
    usuario    SYSNAME      NOT NULL DEFAULT SUSER_SNAME(),
    fecha      DATETIME     NOT NULL DEFAULT GETDATE(),
    tabla      VARCHAR(30)  NOT NULL,
    operacion  VARCHAR(10)  NOT NULL,
    pk         INT          NULL,
    detalle    VARCHAR(200) NULL
);
GO

/* ---------- Capítulo 12: procedimientos almacenados ---------- */
CREATE PROCEDURE sp_AumentarSueldo
    @idEmpleado INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Empleado
    SET sueldo = sueldo * 1.20
    WHERE idEmpleado = @idEmpleado;
END;
GO

CREATE PROCEDURE sp_VentasCliente
    @clienteId INT,
    @total     DECIMAL(12,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT v.idVenta, v.fechaCompra, vu.origen, vu.destino, v.numAsientos
    FROM Venta v JOIN Vuelo vu ON vu.idVuelo = v.idVuelo
    WHERE v.idCliente = @clienteId
    ORDER BY v.fechaCompra;

    SELECT @total = ISNULL(SUM(v.numAsientos * vu.precioPorAsiento), 0)
    FROM Venta v JOIN Vuelo vu ON vu.idVuelo = v.idVuelo
    WHERE v.idCliente = @clienteId;
END;
GO

CREATE PROCEDURE sp_RegistrarVenta
    @idCliente   INT,
    @idVuelo     INT,
    @numAsientos INT,
    @idVendedor  INT,
    @idVenta     INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
            SELECT @idVenta = ISNULL(MAX(idVenta), 0) + 1 FROM Venta WITH (UPDLOCK);
            INSERT INTO Venta (idVenta, idCliente, fechaCompra, numAsientos, idVuelo, idVendedor)
            VALUES (@idVenta, @idCliente, CAST(GETDATE() AS DATE), @numAsientos, @idVuelo, @idVendedor);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SET @idVenta = NULL;
        THROW;
    END CATCH
END;
GO

/* ---------- Capítulo 12: funciones ---------- */
CREATE FUNCTION fn_NombreCompleto (@idPersona INT)
RETURNS VARCHAR(130)
AS
BEGIN
    DECLARE @nombre VARCHAR(130);
    SELECT @nombre = nombre + ' ' + paterno + ISNULL(' ' + materno, '')
    FROM Persona
    WHERE idPersona = @idPersona;
    RETURN @nombre;
END;
GO

CREATE FUNCTION fn_VuelosRuta (@origen CHAR(3), @destino CHAR(3))
RETURNS TABLE
AS
RETURN (
    SELECT idVuelo, matricula, fechaVuelo, precioPorAsiento
    FROM Vuelo
    WHERE origen = @origen AND destino = @destino
);
GO

/* ---------- Capítulo 13: disparadores ---------- */
CREATE TRIGGER tr_Empleado_Sueldo
ON Empleado
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(sueldo)
        INSERT INTO Bitacora (tabla, operacion, pk, detalle)
        SELECT 'Empleado', 'UPDATE', i.idEmpleado,
               'Sueldo ' + CAST(d.sueldo AS VARCHAR(20)) + ' -> ' + CAST(i.sueldo AS VARCHAR(20))
        FROM inserted i
             JOIN deleted d ON d.idEmpleado = i.idEmpleado
        WHERE i.sueldo <> d.sueldo;
END;
GO

CREATE TRIGGER tr_Empleado_Borrar
ON Empleado
FOR DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Bitacora (tabla, operacion, pk, detalle)
    SELECT 'Empleado', 'DELETE', d.idEmpleado, 'Se eliminó al empleado'
    FROM deleted d;
END;
GO

CREATE TRIGGER tr_Venta_Cupo
ON Venta
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM Vuelo vu
             JOIN Avion     a ON a.matricula   = vu.matricula
             JOIN TipoAvion t ON t.idTipoAvion = a.idTipoAvion
        WHERE vu.idVuelo IN (SELECT idVuelo FROM inserted)
          AND (SELECT SUM(v.numAsientos) FROM Venta v WHERE v.idVuelo = vu.idVuelo) > t.numAsientos
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50001, 'El vuelo no tiene asientos suficientes.', 1;
    END
END;
GO

CREATE TRIGGER tr_Avion_NoBorrar
ON Avion
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    THROW 50002, 'Los aviones no se borran: tienen vuelos e historial de mantenimiento.', 1;
END;
GO

/* ---------- Capítulo 14: permisos ---------- */
CREATE ROLE rol_ventas;
GRANT SELECT  ON vw_VentasDetalle  TO rol_ventas;
GRANT EXECUTE ON sp_RegistrarVenta TO rol_ventas;
GO
CREATE USER vendedor1 WITHOUT LOGIN;
ALTER ROLE rol_ventas ADD MEMBER vendedor1;
DENY SELECT ON Empleado TO vendedor1;
GO

SELECT 'Objetos creados' AS Mensaje;
