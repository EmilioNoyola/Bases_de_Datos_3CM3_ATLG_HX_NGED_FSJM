-- Hospital Arboleda: creacion y configuracion inicial de la base.
-- Ejecutar con sqlcmd -b para detenerse si ocurre un error.

USE [master];
GO

SET NOCOUNT ON;

IF DB_ID(N'HospitalArboleda') IS NULL
BEGIN
    EXEC(N'CREATE DATABASE [HospitalArboleda]
           COLLATE Latin1_General_100_CI_AS_SC;');

    PRINT N'Base HospitalArboleda creada correctamente.';
END
ELSE
BEGIN
    PRINT N'La base HospitalArboleda ya existe. Se conservan sus datos.';
END;
GO

ALTER DATABASE [HospitalArboleda]
SET COMPATIBILITY_LEVEL = 160;

ALTER DATABASE [HospitalArboleda]
SET AUTO_CLOSE OFF;

ALTER DATABASE [HospitalArboleda]
SET AUTO_SHRINK OFF;

ALTER DATABASE [HospitalArboleda]
SET PAGE_VERIFY CHECKSUM;
GO

IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = N'HospitalArboleda'
      AND is_read_committed_snapshot_on = 0
)
BEGIN
    ALTER DATABASE [HospitalArboleda]
    SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT;
END;
GO

USE [HospitalArboleda];
GO

SELECT
    name AS base_de_datos,
    state_desc AS estado,
    compatibility_level AS compatibilidad,
    collation_name AS intercalacion,
    is_read_committed_snapshot_on AS lectura_por_versiones,
    is_auto_close_on AS cierre_automatico,
    is_auto_shrink_on AS reduccion_automatica,
    page_verify_option_desc AS verificacion_paginas
FROM sys.databases
WHERE database_id = DB_ID();
GO