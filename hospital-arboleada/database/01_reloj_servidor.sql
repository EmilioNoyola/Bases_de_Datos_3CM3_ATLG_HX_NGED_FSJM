-- Hospital Arboleda: reloj del servidor en la zona horaria de CDMX.
-- Requiere haber ejecutado 00_database.sql.

USE [HospitalArboleda];
GO

SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.time_zone_info
    WHERE name = N'Central Standard Time (Mexico)'
)
BEGIN
    THROW 51001, N'La zona horaria de CDMX no esta disponible en SQL Server.', 1;
END;
GO

CREATE OR ALTER FUNCTION dbo.fn_instante_servidor()
RETURNS DATETIME2(0)
AS
BEGIN
    DECLARE @ahora_local DATETIME2(7);

    SET @ahora_local = CONVERT(
        DATETIME2(7),
        SYSUTCDATETIME()
            AT TIME ZONE 'UTC'
            AT TIME ZONE 'Central Standard Time (Mexico)'
    );

    -- Se eliminan las fracciones sin redondear al segundo siguiente.
    RETURN CONVERT(
        DATETIME2(0),
        CONVERT(CHAR(19), @ahora_local, 120),
        120
    );
END;
GO

CREATE OR ALTER FUNCTION dbo.fn_fecha_servidor()
RETURNS DATE
AS
BEGIN
    RETURN CONVERT(DATE, dbo.fn_instante_servidor());
END;
GO

CREATE OR ALTER FUNCTION dbo.fn_hora_servidor()
RETURNS TIME(0)
AS
BEGIN
    RETURN CONVERT(TIME(0), dbo.fn_instante_servidor());
END;
GO

SET NOCOUNT ON;

-- Cada llamada consulta el reloj por separado.
-- Para validar un vencimiento se debe capturar un solo instante en una variable.
SELECT
    DB_NAME() AS base_de_datos,
    dbo.fn_instante_servidor() AS fecha_hora_cdmx,
    dbo.fn_fecha_servidor() AS fecha_cdmx,
    dbo.fn_hora_servidor() AS hora_cdmx;
GO