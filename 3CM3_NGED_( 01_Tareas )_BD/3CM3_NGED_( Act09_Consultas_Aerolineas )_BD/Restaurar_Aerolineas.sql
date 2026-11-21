-- Actividad 9: Restauración del respaldo Aerolineas.bak proporcionado por la profesora
-- Alumno: Noyola Gómez Emilio Damian | Grupo: 3CM3 | Bases de Datos
-- El respaldo se copió en C:\Users\Public\Documents\Aerolineas_Profesora.bak

USE master
GO
DECLARE @d NVARCHAR(400) = CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS NVARCHAR(400))
DECLARE @l NVARCHAR(400) = CAST(SERVERPROPERTY('InstanceDefaultLogPath') AS NVARCHAR(400))
DECLARE @m1 NVARCHAR(500) = @d + N'Aerolineas.mdf', @m2 NVARCHAR(500) = @l + N'Aerolineas_log.ldf'
IF DB_ID('Aerolineas') IS NOT NULL ALTER DATABASE Aerolineas SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE Aerolineas FROM DISK = N'C:\Users\Public\Documents\Aerolineas_Profesora.bak'
WITH MOVE 'CIC_Aerolineas' TO @m1, MOVE 'CIC_Aerolineas_log' TO @m2, REPLACE, RECOVERY
ALTER DATABASE Aerolineas SET MULTI_USER
GO
SELECT name, create_date FROM sys.databases WHERE name = 'Aerolineas'
GO
