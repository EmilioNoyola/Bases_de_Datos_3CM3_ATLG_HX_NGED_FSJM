-- Hospital Arboleda: T02 Usuario, modelo de 25 tablas.
-- Requiere 01_reloj_servidor.sql y 02_rol.sql.
-- Guardar en UTF-8 y ejecutar con sqlcmd -b -f 65001.

USE [HospitalArboleda];
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRY
    IF OBJECT_ID(N'dbo.Rol', N'U') IS NULL
        THROW 51002, N'Primero ejecuta 02_rol.sql.', 1;

    IF OBJECT_ID(N'dbo.fn_fecha_servidor', N'FN') IS NULL
        THROW 51003, N'Primero ejecuta 01_reloj_servidor.sql.', 1;

    BEGIN TRANSACTION;

    IF OBJECT_ID(N'dbo.Usuario', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Usuario (
            id_usuario INT IDENTITY(1, 1) NOT NULL,
            id_rol TINYINT NOT NULL,
            nombre NVARCHAR(60) NOT NULL,
            apellido_paterno NVARCHAR(60) NOT NULL,
            apellido_materno NVARCHAR(60) NULL,
            CURP CHAR(18) NOT NULL,
            fecha_nacimiento DATE NOT NULL,
            sexo CHAR(1) NOT NULL,
            numero_telefonico CHAR(10) NOT NULL,
            email VARCHAR(254) COLLATE Latin1_General_100_CI_AS NOT NULL,
            [contraseña] VARCHAR(255) NOT NULL,
            [contraseña_temporal] BIT NOT NULL
                CONSTRAINT DF_Usuario_contrasena_temporal DEFAULT (0),
            estado VARCHAR(6) NOT NULL
                CONSTRAINT DF_Usuario_estado DEFAULT ('Activo'),

            CONSTRAINT PK_Usuario PRIMARY KEY (id_usuario),
            CONSTRAINT FK_Usuario_id_rol
                FOREIGN KEY (id_rol) REFERENCES dbo.Rol (id_rol),
            CONSTRAINT UQ_Usuario_CURP UNIQUE (CURP),
            CONSTRAINT UQ_Usuario_email UNIQUE (email),

            CONSTRAINT CK_Usuario_nombre
                CHECK (LEN(LTRIM(RTRIM(nombre))) > 0),
            CONSTRAINT CK_Usuario_apellido_paterno
                CHECK (LEN(LTRIM(RTRIM(apellido_paterno))) > 0),
            CONSTRAINT CK_Usuario_apellido_materno
                CHECK (
                    apellido_materno IS NULL
                    OR LEN(LTRIM(RTRIM(apellido_materno))) > 0
                ),

            -- Valida la estructura; no verifica la CURP ante RENAPO.
            CONSTRAINT CK_Usuario_CURP
                CHECK (
                    LEN(CURP) = 18
                    AND CURP COLLATE Latin1_General_100_BIN2 LIKE
                        '[A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][HM][A-Z][A-Z][A-Z][A-Z][A-Z][0-9A-Z][0-9]'
                ),
            CONSTRAINT CK_Usuario_fecha_nacimiento
                CHECK (fecha_nacimiento <= dbo.fn_fecha_servidor()),
            CONSTRAINT CK_Usuario_sexo
                CHECK (sexo COLLATE Latin1_General_100_BIN2 IN ('H', 'M')),
            CONSTRAINT CK_Usuario_numero_telefonico
                CHECK (
                    LEN(numero_telefonico) = 10
                    AND numero_telefonico COLLATE Latin1_General_100_BIN2
                        NOT LIKE '%[^0-9]%'
                ),

            -- Comprobacion basica; el backend validara el correo completo.
            CONSTRAINT CK_Usuario_email
                CHECK (
                    email LIKE '%_@_%._%'
                    AND email NOT LIKE '%@%@%'
                    AND email NOT LIKE '% %'
                    AND CHARINDEX(CHAR(9), email) = 0
                    AND CHARINDEX(CHAR(10), email) = 0
                    AND CHARINDEX(CHAR(13), email) = 0
                ),

            -- El backend genera el hash; este CHECK solo revisa el prefijo.
            CONSTRAINT CK_Usuario_contrasena
                CHECK (
                    [contraseña] COLLATE Latin1_General_100_BIN2
                        LIKE '$argon2id$%'
                ),
            CONSTRAINT CK_Usuario_estado
                CHECK (
                    estado COLLATE Latin1_General_100_BIN2
                        IN ('Activo', 'Baja')
                )
        );

        PRINT N'Tabla dbo.Usuario creada correctamente.';
    END
    ELSE
    BEGIN
        PRINT N'dbo.Usuario ya existe. Se conserva; no se compara ni modifica su estructura.';
    END;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
GO

-- Comprobar las 13 columnas del modelo actual.
SELECT COLUMN_NAME AS columna, DATA_TYPE AS tipo, IS_NULLABLE AS permite_null
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'Usuario'
ORDER BY ORDINAL_POSITION;

SELECT COUNT_BIG(*) AS usuarios_registrados
FROM dbo.Usuario;
GO