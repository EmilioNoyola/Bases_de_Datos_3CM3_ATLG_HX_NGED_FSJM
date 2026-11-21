-- Actividad 8: Creación de la base de datos Aerolineas
-- Alumno: Noyola Gómez Emilio Damian | Grupo: 3CM3 | Bases de Datos

-- 1. Creación de la base de datos Aerolineas
CREATE DATABASE Aerolineas
GO
USE Aerolineas
GO
SELECT DB_NAME() AS 'Base de datos actual'
GO

-- 2. Tabla Direccion (no depende de ninguna tabla)
CREATE TABLE Direccion (
    direccionId INT NOT NULL,
    calle VARCHAR(50) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    colonia VARCHAR(50) NOT NULL,
    codigoPostal VARCHAR(5) NOT NULL,
    CONSTRAINT PK_Direccion PRIMARY KEY (direccionId)
)
GO

-- 3. Tabla TipoEmpleado (no depende de ninguna tabla)
CREATE TABLE TipoEmpleado (
    idTipoEmpleado INT NOT NULL,
    tipoEmpleado VARCHAR(50) NOT NULL,
    sueldoMaximo MONEY NOT NULL,
    esDeVuelo BIT NOT NULL,
    CONSTRAINT PK_TipoEmpleado PRIMARY KEY (idTipoEmpleado)
)
GO

-- 4. Tabla TipoAvion (no depende de ninguna tabla)
CREATE TABLE TipoAvion (
    idTipoAvion INT NOT NULL,
    tipoAvion VARCHAR(50) NOT NULL,
    fabricante VARCHAR(50) NOT NULL,
    numAsientos INT NOT NULL,
    CONSTRAINT PK_TipoAvion PRIMARY KEY (idTipoAvion)
)
GO

-- 5. Tabla TipoCliente (no depende de ninguna tabla)
CREATE TABLE TipoCliente (
    idTipoCliente INT NOT NULL,
    tipoCliente VARCHAR(50) NOT NULL,
    descuento INT NOT NULL,
    CONSTRAINT PK_TipoCliente PRIMARY KEY (idTipoCliente)
)
GO

-- 6. Tabla Persona (depende de Direccion)
CREATE TABLE Persona (
    IdPersona INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    paterno VARCHAR(50) NOT NULL,
    materno VARCHAR(50) NULL,
    direccionId INT NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    nacimiento DATETIME NOT NULL,
    sexo BIT NOT NULL,
    CONSTRAINT PK_Persona PRIMARY KEY (IdPersona),
    CONSTRAINT FK_Persona_Direccion FOREIGN KEY (direccionId)
        REFERENCES Direccion (direccionId)
)
GO

-- 7. Tabla Aerolinea (depende de Direccion)
CREATE TABLE Aerolinea (
    AerolineaId INT NOT NULL,
    nacional BIT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    direccionId INT NOT NULL,
    teléfono VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Aerolinea PRIMARY KEY (AerolineaId),
    CONSTRAINT FK_Aerolinea_Direccion FOREIGN KEY (direccionId)
        REFERENCES Direccion (direccionId)
)
GO

-- 8. Tabla Empleado (depende de Persona, TipoEmpleado, Aerolinea y de sí misma)
CREATE TABLE Empleado (
    idEmpleado INT NOT NULL,
    idPersona INT NOT NULL,
    idTipoEmpleado INT NOT NULL,
    AerolineaId INT NULL,
    fechaIngreso DATETIME NOT NULL,
    sueldo MONEY NOT NULL,
    idJefe INT NULL,
    CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado),
    CONSTRAINT FK_Empleado_Persona FOREIGN KEY (idPersona)
        REFERENCES Persona (IdPersona),
    CONSTRAINT FK_Empleado_TipoEmpleado FOREIGN KEY (idTipoEmpleado)
        REFERENCES TipoEmpleado (idTipoEmpleado),
    CONSTRAINT FK_Empleado_Aerolinea FOREIGN KEY (AerolineaId)
        REFERENCES Aerolinea (AerolineaId),
    CONSTRAINT FK_Empleado_Jefe FOREIGN KEY (idJefe)
        REFERENCES Empleado (idEmpleado)
)
GO

-- 9. Tabla Avion (depende de TipoAvion y Aerolinea)
CREATE TABLE Avion (
    matricula INT NOT NULL,
    idTipoAvion INT NOT NULL,
    fechaFabricacion DATETIME NOT NULL,
    UltimoMantenimiento DATETIME NOT NULL,
    mesesMantenimiento INT NOT NULL,
    aerolineaId INT NOT NULL,
    CONSTRAINT PK_Avion PRIMARY KEY (matricula),
    CONSTRAINT FK_Avion_TipoAvion FOREIGN KEY (idTipoAvion)
        REFERENCES TipoAvion (idTipoAvion),
    CONSTRAINT FK_Avion_Aerolinea FOREIGN KEY (aerolineaId)
        REFERENCES Aerolinea (AerolineaId)
)
GO

-- 10. Tabla Vuelo (depende de Avion)
CREATE TABLE Vuelo (
    idVuelo INT NOT NULL,
    matriculaAvion INT NOT NULL,
    precioPorAsiento MONEY NOT NULL,
    fechaVuelo DATETIME NOT NULL,
    CONSTRAINT PK_Vuelo PRIMARY KEY (idVuelo),
    CONSTRAINT FK_Vuelo_Avion FOREIGN KEY (matriculaAvion)
        REFERENCES Avion (matricula)
)
GO

-- 11. Tabla VueloEmpleado (depende de Vuelo y Empleado)
CREATE TABLE VueloEmpleado (
    idVuelo_Empleado INT NOT NULL,
    idVuelo INT NOT NULL,
    idEmpleado INT NOT NULL,
    CONSTRAINT PK_VueloEmpleado PRIMARY KEY (idVuelo_Empleado),
    CONSTRAINT FK_VueloEmpleado_Vuelo FOREIGN KEY (idVuelo)
        REFERENCES Vuelo (idVuelo),
    CONSTRAINT FK_VueloEmpleado_Empleado FOREIGN KEY (idEmpleado)
        REFERENCES Empleado (idEmpleado)
)
GO

-- 12. Tabla Cliente (depende de Persona y TipoCliente)
CREATE TABLE Cliente (
    clienteId INT NOT NULL,
    personaId INT NOT NULL,
    idTipoCliente INT NOT NULL,
    fechaRegistro DATETIME NOT NULL,
    CONSTRAINT PK_Cliente PRIMARY KEY (clienteId),
    CONSTRAINT FK_Cliente_Persona FOREIGN KEY (personaId)
        REFERENCES Persona (IdPersona),
    CONSTRAINT FK_Cliente_TipoCliente FOREIGN KEY (idTipoCliente)
        REFERENCES TipoCliente (idTipoCliente)
)
GO

-- 13. Tabla Vendedor (depende de Persona)
CREATE TABLE Vendedor (
    vendedorId INT NOT NULL,
    personaId INT NOT NULL,
    fechaIngreso DATETIME NOT NULL,
    porcentajeComision INT NOT NULL,
    CONSTRAINT PK_Vendedor PRIMARY KEY (vendedorId),
    CONSTRAINT FK_Vendedor_Persona FOREIGN KEY (personaId)
        REFERENCES Persona (IdPersona)
)
GO

-- 14. Tabla Venta (depende de Cliente, Vuelo y Vendedor)
CREATE TABLE Venta (
    idVenta INT NOT NULL,
    idCliente INT NOT NULL,
    fechaCompra DATETIME NOT NULL,
    numAsientos INT NOT NULL,
    idVuelo INT NOT NULL,
    idVendedor INT NOT NULL,
    CONSTRAINT PK_Venta PRIMARY KEY (idVenta),
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (idCliente)
        REFERENCES Cliente (clienteId),
    CONSTRAINT FK_Venta_Vuelo FOREIGN KEY (idVuelo)
        REFERENCES Vuelo (idVuelo),
    CONSTRAINT FK_Venta_Vendedor FOREIGN KEY (idVendedor)
        REFERENCES Vendedor (vendedorId)
)
GO

-- 15. Verificación: tablas creadas con su llave primaria
SELECT t.name AS Tabla, k.name AS LlavePrimaria, t.create_date AS Creada
FROM sys.tables t
JOIN sys.key_constraints k ON k.parent_object_id = t.object_id AND k.type = 'PK'
ORDER BY t.create_date
GO

-- 16. Verificación: llaves foráneas declaradas
SELECT fk.name AS LlaveForanea,
       OBJECT_NAME(fk.parent_object_id) AS Tabla,
       COL_NAME(fc.parent_object_id, fc.parent_column_id) AS Columna,
       OBJECT_NAME(fk.referenced_object_id) AS Referencia,
       COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS ColumnaRef
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fc ON fc.constraint_object_id = fk.object_id
ORDER BY fk.object_id
GO

-- 17. Respaldo completo de la base de datos Aerolineas
BACKUP DATABASE Aerolineas
TO DISK = N'C:\Users\Public\documents\aerolineas.bak'
WITH FORMAT, INIT, NAME = N'Aerolineas - Respaldo completo', STATS = 10
GO
