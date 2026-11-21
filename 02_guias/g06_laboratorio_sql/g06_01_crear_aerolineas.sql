/* ============================================================
   Base de datos AEROLINEAS  -  Guía del 2.º parcial de Bases de Datos
   Crea la base, sus 11 tablas y los datos de ejemplo.
   Ejecútalo completo (botón Ejecutar o F5). Puedes repetirlo:
   si la base ya existe, la borra y la vuelve a crear.
   ============================================================ */
USE master;
GO
IF DB_ID('Aerolineas') IS NOT NULL
BEGIN
    ALTER DATABASE Aerolineas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Aerolineas;
END
GO
CREATE DATABASE Aerolineas;
GO
USE Aerolineas;
GO
CREATE TABLE Direccion (
    direccionId   INT IDENTITY(1,1) NOT NULL,
    calle         VARCHAR(60) NOT NULL,
    numero        VARCHAR(3) NULL,
    colonia       VARCHAR(60) NULL,
    codigoPostal  CHAR(5) NULL,
    CONSTRAINT PK_Direccion PRIMARY KEY (direccionId)
);
CREATE TABLE Persona (
    idPersona    INT IDENTITY(1,1) NOT NULL,
    nombre       VARCHAR(40) NOT NULL,
    paterno      VARCHAR(40) NOT NULL,
    materno      VARCHAR(40) NULL,
    direccionId  INT NULL,
    telefono     VARCHAR(10) NULL,
    nacimiento   DATE NULL,
    sexo         CHAR(1) NULL,
    correo       VARCHAR(80) NULL,
    CONSTRAINT PK_Persona PRIMARY KEY (idPersona),
    CONSTRAINT FK_Persona_Direccion FOREIGN KEY (direccionId)
        REFERENCES Direccion (direccionId),
    CONSTRAINT CK_Persona_sexo CHECK (sexo IN ('F','M'))
);
CREATE TABLE Aerolinea (
    aerolineaId  INT IDENTITY(1,1) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Aerolinea PRIMARY KEY (aerolineaId),
    CONSTRAINT UQ_Aerolinea_nombre UNIQUE (nombre)
);
CREATE TABLE TipoEmpleado (
    idTipoEmpleado  INT NOT NULL,
    tipoEmpleado    VARCHAR(30) NOT NULL,
    sueldoMaximo    DECIMAL(10,2) NOT NULL,
    esDeVuelo       BIT NOT NULL,
    CONSTRAINT PK_TipoEmpleado PRIMARY KEY (idTipoEmpleado)
);
CREATE TABLE Empleado (
    idEmpleado      INT NOT NULL,
    idPersona       INT NOT NULL,
    idTipoEmpleado  INT NOT NULL,
    aerolineaId     INT NOT NULL,
    fechaIngreso    DATE NOT NULL,
    sueldo          DECIMAL(10,2) NOT NULL,
    idJefe          INT NULL,
    CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado),
    CONSTRAINT FK_Empleado_Persona FOREIGN KEY (idPersona)
        REFERENCES Persona (idPersona),
    CONSTRAINT FK_Empleado_TipoEmpleado FOREIGN KEY (idTipoEmpleado)
        REFERENCES TipoEmpleado (idTipoEmpleado),
    CONSTRAINT FK_Empleado_Aerolinea FOREIGN KEY (aerolineaId)
        REFERENCES Aerolinea (aerolineaId),
    CONSTRAINT FK_Empleado_Jefe FOREIGN KEY (idJefe)
        REFERENCES Empleado (idEmpleado)
);
CREATE TABLE TipoCliente (
    idTipoCliente  INT NOT NULL,
    tipoCliente    VARCHAR(20) NOT NULL,
    CONSTRAINT PK_TipoCliente PRIMARY KEY (idTipoCliente)
);
CREATE TABLE Cliente (
    clienteId      INT NOT NULL,
    personaId      INT NOT NULL,
    idTipoCliente  INT NOT NULL,
    fechaRegistro  DATE NOT NULL,
    CONSTRAINT PK_Cliente PRIMARY KEY (clienteId),
    CONSTRAINT FK_Cliente_Persona FOREIGN KEY (personaId)
        REFERENCES Persona (idPersona),
    CONSTRAINT FK_Cliente_TipoCliente FOREIGN KEY (idTipoCliente)
        REFERENCES TipoCliente (idTipoCliente)
);
CREATE TABLE TipoAvion (
    idTipoAvion  INT NOT NULL,
    tipoAvion    VARCHAR(30) NOT NULL,
    fabricante   VARCHAR(30) NOT NULL,
    numAsientos  INT NOT NULL,
    CONSTRAINT PK_TipoAvion PRIMARY KEY (idTipoAvion)
);
CREATE TABLE Avion (
    matricula            VARCHAR(10) NOT NULL,
    idTipoAvion          INT NOT NULL,
    fechaFabricacion     DATE NOT NULL,
    ultimoMantenimiento  DATE NULL,
    aerolineaId          INT NOT NULL,
    CONSTRAINT PK_Avion PRIMARY KEY (matricula),
    CONSTRAINT FK_Avion_TipoAvion FOREIGN KEY (idTipoAvion)
        REFERENCES TipoAvion (idTipoAvion),
    CONSTRAINT FK_Avion_Aerolinea FOREIGN KEY (aerolineaId)
        REFERENCES Aerolinea (aerolineaId)
);
CREATE TABLE Vuelo (
    idVuelo           INT NOT NULL,
    matricula         VARCHAR(10) NOT NULL,
    origen            CHAR(3) NOT NULL,
    destino           CHAR(3) NOT NULL,
    fechaVuelo        DATETIME NOT NULL,
    precioPorAsiento  DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Vuelo PRIMARY KEY (idVuelo),
    CONSTRAINT FK_Vuelo_Avion FOREIGN KEY (matricula)
        REFERENCES Avion (matricula)
);
CREATE TABLE Venta (
    idVenta      INT NOT NULL,
    idCliente    INT NOT NULL,
    fechaCompra  DATE NOT NULL,
    numAsientos  INT NOT NULL,
    idVuelo      INT NOT NULL,
    idVendedor   INT NOT NULL,
    CONSTRAINT PK_Venta PRIMARY KEY (idVenta),
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (idCliente)
        REFERENCES Cliente (clienteId)
        ON DELETE CASCADE,
    CONSTRAINT CK_Venta_numAsientos CHECK (numAsientos > 0),
    CONSTRAINT FK_Venta_Vuelo FOREIGN KEY (idVuelo)
        REFERENCES Vuelo (idVuelo),
    CONSTRAINT FK_Venta_Vendedor FOREIGN KEY (idVendedor)
        REFERENCES Empleado (idEmpleado)
);
GO
SET IDENTITY_INSERT Direccion ON;
INSERT INTO Direccion (direccionId, calle, numero, colonia, codigoPostal) VALUES
    (1, 'Río Tigris', '110', 'Cuauhtémoc', '06500'),
    (2, 'Río Tigris', '45', 'Cuauhtémoc', '06500'),
    (3, 'Av. Insurgentes Sur', '160', 'Crédito Constructor', '03940'),
    (4, 'Av. Juan de Dios Bátiz', 'S/N', 'Lindavista', '07738'),
    (5, 'Paseo de la Reforma', '222', 'Juárez', '06600'),
    (6, 'Calz. de Tlalpan', '300', 'Santa Úrsula Coapa', '04650'),
    (7, 'Río Lerma', '18', 'Cuauhtémoc', '06500'),
    (8, 'Av. Universidad', '940', 'Santa Cruz Atoyac', '03310');
SET IDENTITY_INSERT Direccion OFF;
SET IDENTITY_INSERT Persona ON;
INSERT INTO Persona (idPersona, nombre, paterno, materno, direccionId, telefono, nacimiento, sexo, correo) VALUES
    (1, 'Ana', 'López', 'Ruiz', 1, '5512345678', '1985-03-12', 'F', 'ana.lopez@correo.mx'),
    (2, 'Carlos', 'Méndez', 'Soto', 3, '5523456789', '1979-07-30', 'M', 'cmendez@correo.mx'),
    (3, 'Laura', 'Ríos', 'Vega', 2, '5534567890', '1990-11-02', 'F', NULL),
    (4, 'Jorge', 'Pérez', 'Luna', 5, '5545678901', '1975-01-20', 'M', 'jperez@correo.mx'),
    (5, 'Sofía', 'Torres', 'Gil', 7, NULL, '1993-05-14', 'F', 'sofia.t@correo.mx'),
    (6, 'Miguel', 'Cruz', 'Díaz', 4, '5556789012', '1988-09-09', 'M', NULL),
    (7, 'Valeria', 'Ortiz', 'Mora', 6, '5567890123', '1995-02-25', 'F', 'vortiz@correo.mx'),
    (8, 'Diego', 'Herrera', 'Paz', 8, '5578901234', '1982-12-01', 'M', 'dherrera@correo.mx'),
    (9, 'Paola', 'Núñez', 'Lara', 1, '5589012345', '1997-06-18', 'F', 'paola.n@correo.mx'),
    (10, 'Ricardo', 'Salinas', 'Ponce', 5, '5590123456', '1970-04-04', 'M', 'rsalinas@correo.mx'),
    (11, 'Fernanda', 'Castro', 'Ibarra', 3, '5501234567', '2000-08-21', 'F', 'fer.castro@correo.mx'),
    (12, 'Luis', 'Ramírez', 'Gómez', 2, NULL, '1998-10-10', 'M', NULL),
    (13, 'Mariana', 'Flores', 'Reyes', 6, '5511223344', '1986-03-03', 'F', 'mflores@correo.mx'),
    (14, 'Andrés', 'Molina', 'Ochoa', 8, '5522334455', '1991-12-24', 'M', 'amolina@correo.mx'),
    (15, 'Elena', 'Vargas', 'Rojas', 4, '5533445566', '1979-09-15', 'F', 'evargas@correo.mx'),
    (16, 'Tomás', 'Aguilar', NULL, NULL, '5544556677', '1965-06-06', 'M', NULL),
    (17, 'Hugo', 'Mendoza', 'Sierra', 7, '5555667788', '2001-01-30', 'M', 'hugo.ms@correo.mx');
SET IDENTITY_INSERT Persona OFF;
SET IDENTITY_INSERT Aerolinea ON;
INSERT INTO Aerolinea (aerolineaId, nombre) VALUES
    (1, 'Aeroazteca'),
    (2, 'Volamex'),
    (3, 'Cielo Norte');
SET IDENTITY_INSERT Aerolinea OFF;
INSERT INTO TipoEmpleado (idTipoEmpleado, tipoEmpleado, sueldoMaximo, esDeVuelo) VALUES
    (1, 'Piloto', 95000, 1),
    (2, 'Copiloto', 60000, 1),
    (3, 'Sobrecargo', 28000, 1),
    (4, 'Vendedor', 18000, 0),
    (5, 'Gerente', 120000, 0);
INSERT INTO Empleado (idEmpleado, idPersona, idTipoEmpleado, aerolineaId, fechaIngreso, sueldo, idJefe) VALUES
    (1, 4, 5, 1, '2005-02-01', 110000, NULL),
    (2, 2, 1, 1, '2008-06-15', 92000, 1),
    (3, 3, 1, 1, '2016-03-01', 68000, 1),
    (4, 6, 2, 1, '2019-09-01', 45000, 2),
    (5, 5, 3, 1, '2021-01-10', 24000, 2),
    (6, 7, 4, 1, '2022-05-02', 15000, 1),
    (7, 10, 5, 2, '2010-01-15', 105000, NULL),
    (8, 8, 1, 2, '2012-11-20', 85000, 7),
    (9, 9, 4, 2, '2023-02-01', 16500, 7),
    (10, 1, 1, 3, '2018-07-07', 39000, NULL);
INSERT INTO TipoCliente (idTipoCliente, tipoCliente) VALUES
    (1, 'Frecuente'),
    (2, 'Ocasional'),
    (3, 'Corporativo');
INSERT INTO Cliente (clienteId, personaId, idTipoCliente, fechaRegistro) VALUES
    (1, 11, 1, '2013-04-02'),
    (2, 12, 2, '2014-10-20'),
    (3, 13, 3, '2012-01-15'),
    (4, 14, 2, '2020-06-30'),
    (5, 15, 1, '2011-09-09'),
    (6, 16, 2, '2025-01-05'),
    (7, 1, 1, '2016-02-11'),
    (8, 17, 2, '2026-03-03');
INSERT INTO TipoAvion (idTipoAvion, tipoAvion, fabricante, numAsientos) VALUES
    (1, 'A320neo', 'Airbus', 186),
    (2, '737-800', 'Boeing', 189),
    (3, '787-9', 'Boeing', 274),
    (4, 'A321neo', 'Airbus', 230),
    (5, 'E190', 'Embraer', 100);
INSERT INTO Avion (matricula, idTipoAvion, fechaFabricacion, ultimoMantenimiento, aerolineaId) VALUES
    ('XA-AZA', 3, '2017-05-10', '2026-08-01', 1),
    ('XA-AZB', 2, '2012-03-22', '2026-05-15', 1),
    ('XA-AZC', 4, '2023-02-14', '2026-10-02', 1),
    ('XA-VMA', 1, '2019-11-30', '2026-09-10', 2),
    ('XA-VMB', 4, '2021-06-18', NULL, 2),
    ('XA-CNA', 5, '2010-08-05', '2025-12-01', 3);
INSERT INTO Vuelo (idVuelo, matricula, origen, destino, fechaVuelo, precioPorAsiento) VALUES
    (1, 'XA-AZB', 'MEX', 'CUN', '2014-12-20T08:30:00', 3500),
    (2, 'XA-AZA', 'MEX', 'MAD', '2014-12-22T23:55:00', 15800),
    (3, 'XA-VMA', 'GDL', 'TIJ', '2014-12-05T06:10:00', 1890),
    (4, 'XA-CNA', 'MTY', 'MEX', '2014-11-28T14:00:00', 3200),
    (5, 'XA-AZB', 'MEX', 'CUN', '2015-12-19T08:30:00', 3900),
    (6, 'XA-AZC', 'MEX', 'LAX', '2025-07-01T10:15:00', 6200),
    (7, 'XA-VMB', 'TIJ', 'MEX', '2026-12-18T17:40:00', 2750),
    (8, 'XA-VMA', 'GDL', 'CUN', '2014-12-30T12:00:00', 2990);
INSERT INTO Venta (idVenta, idCliente, fechaCompra, numAsientos, idVuelo, idVendedor) VALUES
    (1, 1, '2014-11-15', 2, 1, 6),
    (2, 2, '2014-11-30', 1, 1, 6),
    (3, 3, '2014-10-01', 4, 2, 6),
    (4, 5, '2014-11-20', 3, 3, 9),
    (5, 1, '2015-10-02', 2, 5, 6),
    (6, 4, '2025-05-20', 1, 6, 6),
    (7, 6, '2026-10-01', 2, 7, 9),
    (8, 3, '2014-12-01', 2, 8, 9),
    (9, 7, '2025-06-10', 1, 6, 6),
    (10, 5, '2013-12-20', 1, 1, 6);
GO
SELECT 'Base Aerolineas lista' AS Mensaje;
