-- Actividad 7: Consultas básicas en SQL Server
-- Alumno: Noyola Gómez Emilio Damian | Grupo: 3CM3 | Bases de Datos

-- 1. Instrucción para crear una nueva base de datos llamada PRUEBA
CREATE DATABASE PRUEBA
GO

-- 2. Instrucción para borrar una base de datos
CREATE DATABASE PRUEBA_TEMP
GO
DROP DATABASE PRUEBA_TEMP
GO
SELECT name FROM sys.databases WHERE name LIKE 'PRUEBA%'
GO

-- 3. Instrucción para posicionarse en una bd específica
USE PRUEBA
GO
SELECT DB_NAME() AS 'Base de datos actual'
GO

-- 4. Instrucción para crear una nueva tabla (primary key en la columna)
CREATE TABLE dbo.Customers (
    CustomerId INT NOT NULL PRIMARY KEY, -- primary key
    Name NVARCHAR(50) NOT NULL,
    Location NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL
); -- El ; es opcional, si no se coloca de igual forma funciona.
GO
SP_HELP Customers
GO

-- 4. Segunda forma: primary key declarada como CONSTRAINT
DROP TABLE dbo.Customers
GO
CREATE TABLE dbo.Customers (
    CustomerId INT NOT NULL, -- se declara el campo normalmente
    Name NVARCHAR(50) NOT NULL,
    Location NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Customers PRIMARY KEY CLUSTERED (CustomerId)
)
GO
SP_HELP Customers
GO

-- 5. Instrucción para agregar llave primaria a una tabla previamente creada
DROP TABLE dbo.Customers
GO
CREATE TABLE dbo.Customers (
    CustomerId INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Location NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL
)
GO
ALTER TABLE dbo.Customers ADD PRIMARY KEY(CustomerId)
GO
EXEC sp_helpconstraint 'Customers'
GO

-- 6. Insertar registros en la tabla Customers
INSERT INTO Customers
(CustomerId,Name,Location,Email)
VALUES
(1, 'Orlando', 'Australia', ''),
(2, 'Keith', 'India', 'keith0@hotmail.com'),
(3, 'Donna', 'Alemania', 'donna0@outlook.es'),
(4, 'Janet', 'México', 'janet1@gmail.com')
GO
--Para confirmar los registros insertados
SELECT * FROM Customers
GO

-- 6.1 Insertar el siguiente registro, comentar qué sucedió (error esperado)
INSERT INTO Customers
(CustomerId,Name,Location,Email)
VALUES (2, 'Leonardo', 'México', 'escom@ipn.mx')
GO

-- 6.2 Insertar el siguiente registro, por qué este no marca error
INSERT INTO Customers
(CustomerId,Name,Location,Email)
VALUES (5, 'Mariana', 'México', 'escom@ipn.mx')
GO

-- 6.3 Insertar 10 registros más y listar los registros completos
INSERT INTO Customers
(CustomerId,Name,Location,Email)
VALUES
(6, 'Priya', 'India', 'priya.sharma@gmail.com'),
(7, 'Arjun', 'India', 'arjun.patel@hotmail.com'),
(8, 'Lukas', 'Alemania', 'lukas.weber@gmx.de'),
(9, 'Valentina', 'Colombia', 'valentina.r@gmail.com'),
(10, 'Santiago', 'Colombia', 'santiago.g@outlook.com'),
(11, 'Camila', 'Colombia', 'camila.m@hotmail.com'),
(12, 'Mateo', 'Colombia', 'mateo.l@gmail.com'),
(13, 'Lucía', 'España', 'lucia.f@outlook.es'),
(14, 'Camille', 'Francia', 'camille.d@orange.fr'),
(15, 'Mariana', 'México', 'mariana.r@gmail.com')
GO
SELECT * FROM Customers
GO

-- 7. Instrucción para declarar llave foránea en la construcción de una tabla
CREATE TABLE Aerolinea(
    AerolineaId INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- Primary key
    Nacional bit NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    DireccionId INT NOT NULL,
    Telefono VARCHAR(50),
    CONSTRAINT FK_Direccion FOREIGN KEY(DireccionId) --foreign key
    REFERENCES Direccion (DireccionId)
    ON DELETE CASCADE -- borrado en cascada
    ON UPDATE CASCADE -- actualización en cascada
)
GO

-- 7.1 Se crea primero la tabla referenciada Direccion
CREATE TABLE Direccion(
    DireccionId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Calle VARCHAR(80) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
    Pais VARCHAR(50) NOT NULL
)
GO
CREATE TABLE Aerolinea(
    AerolineaId INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- Primary key
    Nacional bit NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    DireccionId INT NOT NULL,
    Telefono VARCHAR(50),
    CONSTRAINT FK_Direccion FOREIGN KEY(DireccionId) --foreign key
    REFERENCES Direccion (DireccionId)
    ON DELETE CASCADE -- borrado en cascada
    ON UPDATE CASCADE -- actualización en cascada
)
GO
EXEC sp_helpconstraint 'Aerolinea'
GO

-- 8. Instrucción para agregar llave foránea a una tabla previamente creada
CREATE TABLE Vuelo(
    VueloId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    AerolineaId INT NOT NULL,
    Destino VARCHAR(50) NOT NULL
)
GO
ALTER TABLE Vuelo
ADD FOREIGN KEY (AerolineaId) REFERENCES Aerolinea (AerolineaId)
GO
EXEC sp_helpconstraint 'Vuelo'
GO

-- 9. Instrucción para borrar una tabla, es decir la definición de toda la tabla
CREATE TABLE TablaTemporal (Id INT)
GO
DROP TABLE TablaTemporal
GO
SELECT name AS 'Tablas existentes' FROM sys.tables
GO

-- 10. Instrucción para agregar, eliminar o modificar columnas en una tabla existente
ALTER TABLE Customers
ADD Telefono VARCHAR(15);
GO
SELECT TOP 3 * FROM Customers
GO
ALTER TABLE Customers
ALTER COLUMN Telefono VARCHAR(20);
GO
ALTER TABLE Customers
DROP COLUMN Telefono;
GO
SELECT TOP 3 * FROM Customers
GO

-- 11. Lista el conjunto de atributos del objeto indicado
SP_HELP 'Aerolinea'
GO

-- 12. Lista las tablas existentes en la base de datos
SELECT * FROM SYS.OBJECTS WHERE TYPE='U'
GO

-- 12.1 Ejecutar SELECT * FROM SYS.OBJECTS, describa cuál es la diferencia
SELECT * FROM SYS.OBJECTS
GO

-- 12.2 Diferencia de utilizar DISTINCT
SELECT DISTINCT TYPE, TYPE_DESC FROM SYS.OBJECTS
GO

-- 13. Muestra la versión de SQL Server instalada
SELECT @@VERSION
GO

-- 14. Muestra el nombre del servidor
SELECT @@SERVERNAME
GO

-- 15. Muestra la fecha del día de hoy
SELECT GETDATE()
GO

-- 16. Lista las bases de datos existentes
SELECT name, database_id, create_date
FROM sys.databases;
GO

-- 17. Eliminar filas con TRUNCATE TABLE
CREATE TABLE CustomersCopia (
    CustomerId INT NOT NULL PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Location NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL
)
GO
INSERT INTO CustomersCopia SELECT * FROM Customers
SELECT COUNT(*) AS 'Registros antes' FROM CustomersCopia
TRUNCATE TABLE CustomersCopia
SELECT COUNT(*) AS 'Registros después' FROM CustomersCopia
GO

-- 18. Lista los distintos valores que han sido tomados por un campo específico
SELECT DISTINCT NAME FROM Customers
GO

-- 19. Cuenta los registros existentes de una tabla
SELECT COUNT(*) FROM Customers
GO

-- 20. Actualiza el(los) registro(s) de acuerdo a la condición indicada
UPDATE Customers SET name='Leonardo' WHERE CustomerId='5'
SELECT * FROM Customers WHERE CustomerId='5'
GO

-- 21. Recuperar registros de una tabla llamada Customers
SELECT * FROM Customers
GO

-- 22. Recuperar únicamente los campos CustomerId y Name
SELECT CustomerId, Name FROM Customers
GO

-- 23. Recuperar los primeros 10 registros de una tabla
SELECT TOP 10 * FROM Customers
GO

-- 24. Recupera los registros que cumplan la condición
SELECT * FROM Customers WHERE Name='Janet' AND Location='México'
GO

-- 25. Renombra (temporalmente) un atributo con la palabra reservada AS
SELECT CustomerId, Name, Location, Email AS 'Correo personal' FROM Customers
GO

-- 26. Borra los registros de una tabla especificando una condición (error esperado)
DELETE * FROM Customers WHERE CustomerId = 15
GO

-- 26.1 Sintaxis correcta de DELETE en SQL Server
DELETE FROM Customers WHERE CustomerId = 15
SELECT * FROM Customers
GO

-- 27. Inserta la consulta resultante de una tabla existente en una tabla nueva
CREATE TABLE Clientes(
    CustomerId INT PRIMARY KEY NOT NULL, -- PRIMARY KEY
    Name NVARCHAR(50) NOT NULL,
    Location NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL)
GO
SELECT CustomerId,Name,Location,Email
INTO Clientes FROM Customers
GO

-- 27.1 Con la tabla ya creada se usa INSERT INTO ... SELECT
INSERT INTO Clientes (CustomerId,Name,Location,Email)
SELECT CustomerId,Name,Location,Email FROM Customers
GO
SELECT * FROM Clientes
GO

-- 27.2 SELECT ... INTO crea la tabla nueva a partir de la consulta
SELECT CustomerId,Name,Location,Email
INTO ClientesMexico FROM Customers
WHERE Location = 'México';
GO
SELECT * FROM ClientesMexico
GO

-- Respaldo completo de la base de datos PRUEBA
BACKUP DATABASE PRUEBA
TO DISK = N'C:\Users\Public\Documents\PRUEBA.bak'
WITH FORMAT, INIT, NAME = N'PRUEBA - Respaldo completo', STATS = 10
GO
