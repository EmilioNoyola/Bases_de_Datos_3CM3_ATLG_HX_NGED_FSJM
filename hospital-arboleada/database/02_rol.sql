-- Hospital Arboleda: tabla T01 Rol y sus cuatro perfiles iniciales.
-- Ejecutar como script administrativo con sqlcmd -b.

USE [HospitalArboleda];
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRY
    BEGIN TRANSACTION;

    IF OBJECT_ID(N'dbo.Rol', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.Rol (
            id_rol TINYINT NOT NULL,
            rol VARCHAR(15) NOT NULL,

            CONSTRAINT PK_Rol
                PRIMARY KEY (id_rol),

            CONSTRAINT UQ_Rol_rol
                UNIQUE (rol),

            CONSTRAINT CK_Rol_rol
                CHECK (rol IN (
                    'Paciente',
                    'Doctor',
                    'Recepcionista',
                    'Administrador'
                )),

            -- Refuerzo de la correspondencia fija entre identificador y perfil.
            CONSTRAINT CK_Rol_id_nombre
                CHECK (
                    (id_rol = 1 AND rol = 'Paciente')
                    OR (id_rol = 2 AND rol = 'Doctor')
                    OR (id_rol = 3 AND rol = 'Recepcionista')
                    OR (id_rol = 4 AND rol = 'Administrador')
                )
        );

        INSERT INTO dbo.Rol (id_rol, rol)
        VALUES
            (1, 'Paciente'),
            (2, 'Doctor'),
            (3, 'Recepcionista'),
            (4, 'Administrador');
    END
    ELSE
    BEGIN
        PRINT N'La tabla dbo.Rol ya existe. Se conserva sin modificaciones.';
    END;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END;

    THROW;
END CATCH;
GO

SELECT id_rol, rol
FROM dbo.Rol
ORDER BY id_rol;
GO