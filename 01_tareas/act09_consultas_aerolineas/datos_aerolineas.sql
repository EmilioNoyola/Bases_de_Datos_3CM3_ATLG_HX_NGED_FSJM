-- Actividad 9: Datos de prueba para la base de datos Aerolineas
-- Alumno: Noyola Gómez Emilio Damian | Grupo: 3CM3 | Bases de Datos
-- Requiere la estructura creada en la Actividad 8 (bd_aerolineas.sql)

USE Aerolineas
GO

-- 1. Direcciones
INSERT INTO Direccion (direccionId, calle, numero, colonia, codigoPostal) VALUES
(1,  'Av. 20 de Noviembre',     '45',        'Centro',               '06090'),
(2,  'Av. 20 de Noviembre',     '120-B',     'Centro',               '06090'),
(3,  'Av. Insurgentes Sur',     '1602',      'Crédito Constructor',  '03940'),
(4,  'Av. Juan de Dios Bátiz',  'S/N',       'Lindavista',           '07738'),
(5,  'Paseo de la Reforma',     '222',       'Juárez',               '06600'),
(6,  'Calz. de Tlalpan',        '3000',      'Santa Úrsula Coapa',   '04650'),
(7,  'Río Lerma',               '18',        'Cuauhtémoc',           '06500'),
(8,  'Av. Universidad',         '940',       'Santa Cruz Atoyac',    '03310'),
(9,  'Av. 20 de Noviembre',     '78',        'Centro',               '06090'),
(10, 'Calle Madero',            '12A',       'Centro',               '06000'),
(11, 'Av. Revolución',          'Mz 4 Lt 7', 'San Ángel',            '01000'),
(12, 'Blvd. Puerto Aéreo',      '161',       'Peñón de los Baños',   '15520'),
(13, 'Gran Vía',                '28',        'Centro',               '28013'),
(14, 'Brickell Avenue',         '1450',      'Brickell',             '33131')
GO

-- 2. Tipos de empleado
INSERT INTO TipoEmpleado (idTipoEmpleado, tipoEmpleado, sueldoMaximo, esDeVuelo) VALUES
(1, 'Piloto',                     95000, 1),
(2, 'Copiloto',                   60000, 1),
(3, 'Sobrecargo',                 28000, 1),
(4, 'Ingeniero de mantenimiento', 45000, 0),
(5, 'Gerente de operaciones',    120000, 0)
GO

-- 3. Tipos de avión
INSERT INTO TipoAvion (idTipoAvion, tipoAvion, fabricante, numAsientos) VALUES
(1, 'A320',      'Airbus',  180),
(2, 'A350-900',  'Airbus',  325),
(3, '737-800',   'Boeing',  189),
(4, '787-9',     'Boeing',  290),
(5, '777-300ER', 'Boeing',  396),
(6, 'E190',      'Embraer', 100)
GO

-- 4. Tipos de cliente
INSERT INTO TipoCliente (idTipoCliente, tipoCliente, descuento) VALUES
(1, 'Bronce',   5),
(2, 'Plata',   10),
(3, 'Oro',     15),
(4, 'Platino', 20)
GO

-- 5. Personas (sexo: 1 = masculino, 0 = femenino)
INSERT INTO Persona (IdPersona, nombre, paterno, materno, direccionId, telefono, nacimiento, sexo) VALUES
(1,  'Jorge',     'Pérez',     'Luna',    5,  '56781234',   '1972-01-20', 1),
(2,  'Carlos',    'Méndez',    'Soto',    3,  '55234567',   '1979-07-30', 1),
(3,  'Laura',     'Ríos',      'Vega',    7,  '55345678',   '1988-11-02', 0),
(4,  'Miguel',    'Cruz',      'Díaz',    4,  '55456789',   '1985-09-09', 1),
(5,  'Sofía',     'Torres',    'Gil',     8,  '55567890',   '1980-03-15', 0),
(6,  'Ricardo',   'Salinas',   'Ponce',   6,  '55678901',   '1970-04-04', 1),
(7,  'Valeria',   'Ortiz',     'Mora',    2,  '55789012',   '1994-02-25', 0),
(8,  'Diego',     'Herrera',   'Paz',     10, '5589012345', '1982-12-01', 1),
(9,  'Paola',     'Núñez',     'Lara',    5,  '55901234',   '1980-12-05', 0),
(10, 'Andrés',    'Molina',    'Ochoa',   8,  '55012345',   '1991-12-24', 1),
(11, 'James',     'Carter',    NULL,      14, '3055550147', '1976-05-11', 1),
(12, 'Lucía',     'Fernández', 'Ruiz',    13, '915550123',  '1980-01-20', 0),
(13, 'Tomás',     'Aguilar',   'Rangel',  7,  '55112233',   '1965-06-06', 1),
(14, 'Elena',     'Vargas',    'Rojas',   6,  '55223344',   '1979-09-15', 0),
(15, 'Fernanda',  'Castro',    'Ibarra',  1,  '55334455',   '2000-08-21', 0),
(16, 'Luis',      'Ramírez',   'Gómez',   1,  '55445566',   '1998-10-10', 1),
(17, 'Mariana',   'Flores',    'Reyes',   2,  '55556677',   '1980-07-02', 0),
(18, 'Hugo',      'Mendoza',   'Sierra',  9,  '55667788',   '2001-01-30', 1),
(19, 'Gabriela',  'Ruiz',      'Campos',  9,  '55778899',   '1993-04-17', 0),
(20, 'Óscar',     'Navarro',   'Peña',    11, '5512 3456',  '1987-08-08', 1),
(21, 'Daniela',   'Silva',     'Ortega',  3,  '55990011',   '1980-10-28', 0),
(22, 'Roberto',   'Jiménez',   'Cano',    10, '55001122',   '1975-02-14', 1),
(23, 'Patricia',  'León',      'Robles',  4,  '5543210',    '1969-12-12', 0),
(24, 'Alejandro', 'Vega',      'Montes',  6,  '55136724',   '1996-06-30', 1),
(25, 'Carmen',    'Domínguez', 'Lara',    5,  '55247813',   '1984-05-05', 0),
(26, 'Javier',    'Morales',   'Cruz',    3,  '55369147',   '1990-03-27', 1),
(27, 'Isabel',    'Guzmán',    'Soto',    8,  '55481526',   '1986-11-11', 0),
(28, 'Raúl',      'Castillo',  'Nava',    7,  '55592637',   '1978-08-19', 1)
GO

-- 6. Aerolíneas (nacional: 1 = nacional, 0 = extranjera)
INSERT INTO Aerolinea (AerolineaId, nacional, Nombre, direccionId, teléfono) VALUES
(1, 1, 'Aerolíneas Azteca',    12, '5551334000'),
(2, 1, 'Volamex',               3, '5552268800'),
(3, 0, 'Iberavia',             13, '915551200'),
(4, 0, 'Pacific Sky Airlines', 14, '3055550100')
GO

-- 7. Empleados (los jefes se insertan antes que sus subordinados)
INSERT INTO Empleado (idEmpleado, idPersona, idTipoEmpleado, AerolineaId, fechaIngreso, sueldo, idJefe) VALUES
(1,  1,  5, 1,    '2005-02-01', 110000, NULL),
(6,  6,  5, 2,    '2010-01-15', 105000, NULL),
(11, 11, 1, 4,    '2012-04-10',  87000, NULL),
(12, 12, 1, 3,    '2014-09-01',  79000, NULL),
(13, 13, 4, NULL, '2009-08-03',  47000, NULL),
(2,  2,  1, 1,    '2008-06-15',  92000, 1),
(3,  3,  1, 1,    '2016-03-01',  68000, 1),
(7,  7,  1, 2,    '2018-11-20',  38000, 6),
(10, 10, 4, 2,    '2015-03-16',  43000, 6),
(14, 14, 3, 3,    '2017-06-12',  26500, 12),
(4,  4,  2, 1,    '2019-09-01',  45000, 2),
(5,  5,  3, 1,    '2021-01-10',  24000, 2),
(8,  8,  2, 2,    '2020-07-01',  41000, 7),
(9,  9,  3, 2,    '2022-05-02',  22500, 7)
GO

-- 8. Aviones
INSERT INTO Avion (matricula, idTipoAvion, fechaFabricacion, UltimoMantenimiento, mesesMantenimiento, aerolineaId) VALUES
(41501, 1, '2013-04-10', '2014-04-28', 12, 1),
(41502, 4, '2014-09-22', '2016-03-05', 18, 1),
(41503, 3, '2012-11-05', '2014-12-15', 24, 1),
(52601, 3, '2013-07-18', '2014-07-18', 12, 2),
(52602, 1, '2015-02-27', '2015-08-20',  6, 2),
(52603, 6, '2012-05-30', '2013-06-25', 12, 2),
(63701, 2, '2014-06-16', '2016-06-30', 24, 3),
(74801, 5, '2014-03-03', '2015-09-30', 18, 4)
GO

-- 9. Vuelos
INSERT INTO Vuelo (idVuelo, matriculaAvion, precioPorAsiento, fechaVuelo) VALUES
(1,  41503,  3500, '2014-12-20 08:30'),
(2,  41502, 15800, '2014-12-22 23:55'),
(3,  52603,  1890, '2014-12-05 06:10'),
(4,  52603,   950, '2014-11-28 14:00'),
(5,  41501,  3200, '2014-12-12 07:45'),
(6,  52601,  4250, '2014-12-18 19:20'),
(7,  63701, 12900, '2014-12-24 21:00'),
(8,  74801,  9800, '2015-01-10 13:30'),
(9,  52601,  2990, '2014-12-30 12:00'),
(10, 41501,  1450, '2026-11-14 09:15'),
(11, 52602,   980, '2026-11-17 18:40'),
(12, 41502,  7600, '2026-11-22 22:10'),
(13, 52603,  2350, '2026-11-27 06:50'),
(14, 74801, 11200, '2026-12-05 16:00'),
(15, 41503,  4100, '2026-12-20 10:30'),
(16, 63701, 13500, '2027-01-08 23:30')
GO

-- 10. Tripulación de cada vuelo
INSERT INTO VueloEmpleado (idVuelo_Empleado, idVuelo, idEmpleado) VALUES
(1, 1, 2),   (2, 1, 4),   (3, 1, 5),
(4, 2, 3),   (5, 2, 4),   (6, 2, 5),
(7, 3, 7),   (8, 3, 8),   (9, 3, 9),
(10, 4, 7),  (11, 4, 8),  (12, 4, 9),
(13, 5, 2),  (14, 5, 4),  (15, 5, 5),
(16, 6, 7),  (17, 6, 8),  (18, 6, 9),
(19, 7, 12), (20, 7, 14),
(21, 8, 11),
(22, 9, 7),  (23, 9, 8),  (24, 9, 9),
(25, 10, 3), (26, 10, 4), (27, 10, 5),
(28, 11, 7), (29, 11, 8), (30, 11, 9),
(31, 12, 2), (32, 12, 4), (33, 12, 5),
(34, 13, 7), (35, 13, 8), (36, 13, 9),
(37, 14, 11),
(38, 15, 3), (39, 15, 4), (40, 15, 5),
(41, 16, 12), (42, 16, 14)
GO

-- 11. Clientes
INSERT INTO Cliente (clienteId, personaId, idTipoCliente, fechaRegistro) VALUES
(1,  15, 3, '2023-03-14'),
(2,  16, 2, '2012-06-01'),
(3,  17, 3, '2008-09-23'),
(4,  18, 2, '2009-04-11'),
(5,  19, 1, '2024-01-19'),
(6,  20, 2, '2016-10-05'),
(7,  21, 3, '2011-02-17'),
(8,  22, 4, '2010-07-07'),
(9,  23, 2, '2021-08-30'),
(10, 24, 3, '2025-05-02')
GO

-- 12. Vendedores
INSERT INTO Vendedor (vendedorId, personaId, fechaIngreso, porcentajeComision) VALUES
(1, 25, '2011-03-01',  5),
(2, 26, '2012-08-15',  7),
(3, 27, '2013-01-07',  4),
(4, 28, '2020-02-03', 10)
GO

-- 13. Ventas
INSERT INTO Venta (idVenta, idCliente, fechaCompra, numAsientos, idVuelo, idVendedor) VALUES
(1,  3,  '2014-11-15', 2, 1,  1),
(2,  2,  '2014-11-30', 1, 1,  2),
(3,  3,  '2014-10-01', 4, 2,  1),
(4,  4,  '2014-11-20', 3, 3,  3),
(5,  7,  '2014-11-10', 2, 4,  3),
(6,  8,  '2014-12-01', 5, 5,  1),
(7,  2,  '2014-12-02', 2, 6,  2),
(8,  4,  '2014-12-10', 1, 7,  3),
(9,  7,  '2014-12-20', 3, 8,  1),
(10, 8,  '2014-12-15', 2, 9,  2),
(11, 1,  '2026-10-25', 2, 10, 4),
(12, 6,  '2026-11-02', 1, 11, 2),
(13, 5,  '2026-10-28', 4, 12, 4),
(14, 9,  '2026-11-10', 2, 12, 1),
(15, 10, '2026-11-15', 3, 13, 4),
(16, 3,  '2026-09-20', 2, 14, 3),
(17, 1,  '2026-11-18', 1, 14, 2),
(18, 6,  '2026-08-30', 2, 15, 1),
(19, 8,  '2026-11-12', 6, 16, 4),
(20, 2,  '2026-10-05', 2, 15, 3)
GO

-- 14. Verificación: registros por tabla
SELECT t.name AS Tabla, SUM(p.rows) AS Registros
FROM sys.tables t
JOIN sys.partitions p ON p.object_id = t.object_id AND p.index_id IN (0, 1)
WHERE t.name <> 'sysdiagrams'
GROUP BY t.name, t.create_date
ORDER BY t.create_date
GO
